"""Define a class providing utility function access to the Spot SDK image client."""

from __future__ import annotations

import threading
from dataclasses import dataclass
from datetime import datetime
from enum import Enum
from pathlib import Path
from typing import TYPE_CHECKING

import cv2
import numpy as np
import rospy
from bosdyn.api.image_pb2 import Image, ImageRequest, ImageResponse
from bosdyn.client.image import ImageClient, build_image_request
from cv_bridge import CvBridge
from sensor_msgs.msg import CameraInfo
from sensor_msgs.msg import Image as ImageMsg
from transform_utils.logging import log_error, log_info

from spot_skills_py.spot.spot_sync import SpotTimeSync

if TYPE_CHECKING:
    from bosdyn.client.robot import Robot


@dataclass(frozen=True)
class PixelFormatSpec:
    """Static mapping from Spot SDK pixel formats to sensor_msgs/Image specifications.

    Reference: https://docs.ros.org/en/noetic/api/sensor_msgs/html/msg/Image.html
    """

    encoding: str  # ROS image encoding string (see image_encodings.h)
    dtype: type[np.generic]  # NumPy datatype used when reshaping raw pixel data
    channels: int  # Number of channels in the raw buffer (e.g., 3 for RGB)


PIXEL_FORMAT_SPECS: dict[int, PixelFormatSpec] = {
    Image.PIXEL_FORMAT_RGB_U8: PixelFormatSpec("bgr8", np.uint8, 3),  # cv_bridge expects BGR
    Image.PIXEL_FORMAT_RGBA_U8: PixelFormatSpec("bgra8", np.uint8, 4),
    Image.PIXEL_FORMAT_GREYSCALE_U8: PixelFormatSpec("mono8", np.uint8, 1),
    Image.PIXEL_FORMAT_GREYSCALE_U16: PixelFormatSpec("mono16", np.uint16, 1),
    Image.PIXEL_FORMAT_DEPTH_U16: PixelFormatSpec("16UC1", np.uint16, 1),
}
DEFAULT_PIXEL_SPEC = PixelFormatSpec("mono8", np.uint8, 1)


class ImageFormat(Enum):
    """Subset of pixel formats available from Spot that map cleanly to ROS encodings.

    Reference:
        https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#image-pixelformat
    """

    RGB = 1
    GREYSCALE = 2
    DEPTH = 3

    def pixel_format(self) -> int:
        """Return the corresponding Spot SDK pixel format constant."""
        return {
            ImageFormat.RGB: Image.PIXEL_FORMAT_RGB_U8,  # Three bytes per pixel
            ImageFormat.GREYSCALE: Image.PIXEL_FORMAT_GREYSCALE_U8,  # One byte per pixel
            ImageFormat.DEPTH: Image.PIXEL_FORMAT_DEPTH_U16,  # z-distance from camera (mm)
        }[self]


CAMERA_TO_OPERATING_RANGE_MM = {
    "body": (300, 4000),  # 0.3 m up to 2-4 meters
    "hand": (400, 6000),  # 0.4 m up to at least 6 meters
}


class SpotImageClient:
    """A wrapper providing utility function access to Spot's image client."""

    def __init__(self, robot: Robot, time_sync: SpotTimeSync, debug_mode: bool) -> None:
        """Initialize an image client using the given robot.

        :param robot: Point of access for Spot's RPC clients
        :param time_sync: A wrapper to manage time synchronization with Spot
        :param debug_mode: True if debug messages and images should be published, else False
        """
        self._image_client = robot.ensure_client(ImageClient.default_service_name)
        self._time_sync = time_sync
        self.debug_mode = debug_mode

        # Identify the image sources available from Spot
        image_sources_proto = self._image_client.list_image_sources()
        self.image_sources = [source.name for source in image_sources_proto]
        self.camera_names = ["frontleft", "frontright", "left", "right", "back", "hand"]

        self._cv_bridge = CvBridge()

        if self.debug_mode:
            self._debug_rgb_pub = rospy.Publisher("~debug_rgb_image", ImageMsg, queue_size=5)
            self._debug_depth_pub = rospy.Publisher("~debug_depth_image", ImageMsg, queue_size=5)

        self.publish_loop_cameras = ["frontleft", "frontright", "hand"]
        self._image_pubs: dict[str, rospy.Publisher] = {}  # Maps camera names to image publishers
        self._info_pubs: dict[str, rospy.Publisher] = {}  # Maps camera names to info publishers

        for camera_name in self.publish_loop_cameras:
            image_topic = f"/spot/camera/{camera_name}/image"
            info_topic = f"/spot/camera/{camera_name}/camera_info"

            self._image_pubs[camera_name] = rospy.Publisher(image_topic, ImageMsg, queue_size=10)
            self._info_pubs[camera_name] = rospy.Publisher(info_topic, CameraInfo, queue_size=10)

        if debug_mode:
            self.run_diagnostics()

        # Create a thread to continually re-publish the requested cameras' images and info
        self._publisher_thread = threading.Thread(target=self._publish_loop, daemon=True)
        self._publisher_thread.start()

    def make_image_request(self, camera: str, image_format: ImageFormat) -> ImageRequest | None:
        """Build an image request Protobuf message to be sent to Spot.

        :param camera: Name of the camera to be used to capture the image
        :param image_format: Format of image requested (e.g., RGB or DEPTH)
        :return: Image request Protobuf message, or None if invalid inputs given
        """
        source = self._camera_to_image_source(camera, image_format)

        if source not in self.image_sources:
            log_error(f"Unrecognized image source: '{source}'")
            return None

        return build_image_request(source, pixel_format=image_format.pixel_format())

    def get_images(self, requests: list[ImageRequest]) -> list[ImageResponse]:
        """Request a collection of images from the robot.

        Reference: https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/image.html

        :param requests: List of images requested from the robot
        :return: List of resulting image responses from Spot
        """
        responses = self._image_client.get_image(requests)

        if len(responses) != len(requests):
            log_error(f"Expected {len(requests)} responses, but received {len(responses)}.")
            return []

        return responses

    def proto_to_image_msg(self, response: ImageResponse) -> ImageMsg:
        """Convert an ImageResponse Protobuf message into a sensor_msgs/Image ROS message.

        :param response: Protobuf message containing an image response from Spot
        :return: Constructed sensor_msgs/Image message
        """
        np_data = self.proto_to_np(response)
        pixel_format = response.shot.image.pixel_format
        spec = PIXEL_FORMAT_SPECS.get(pixel_format, DEFAULT_PIXEL_SPEC)

        time_proto = response.shot.acquisition_time
        timestamp = self._time_sync.local_timestamp_from_proto(time_proto)

        image_msg = self._cv_bridge.cv2_to_imgmsg(np_data, spec.encoding)
        image_msg.header.stamp = rospy.Time.from_sec(timestamp.to_time_s())
        image_msg.header.frame_id = response.shot.frame_name_image_sensor

        if self.debug_mode:
            if pixel_format == Image.PIXEL_FORMAT_RGB_U8:
                self._debug_rgb_pub.publish(image_msg)
            elif pixel_format == Image.PIXEL_FORMAT_DEPTH_U16:
                self._debug_depth_pub.publish(image_msg)

        return image_msg

    def save_image_to_file(
        self,
        image: ImageResponse | ImageMsg | np.ndarray,
        output_path: str | Path,
        depth_range_mm: tuple[int, int],
        colormap: int | None = cv2.COLORMAP_MAGMA,
    ) -> None:
        """Save the given image (response, message, or data) to the file system.

        :param image: Image response/message/data to be exported to file
        :param output_path: Output path for the image (.png is appended if missing)
        :param depth_range_mm: Range of depths (in mm) output from Spot's depth cameras
        :param colormap: Colormap used to visualize depth frames (None means no colorization)
        """
        outfile = Path(output_path).with_suffix(".png")
        outfile.parent.mkdir(parents=True, exist_ok=True)

        if isinstance(image, ImageResponse):
            np_data = self.proto_to_np(image)
            is_depth = image.shot.image.pixel_format == Image.PIXEL_FORMAT_DEPTH_U16
        elif isinstance(image, ImageMsg):
            np_data = self._cv_bridge.imgmsg_to_cv2(image, desired_encoding="passthrough")
            is_depth = image.encoding == "16UC1"
        elif isinstance(image, np.ndarray):
            np_data = image
            is_depth = image.dtype == np.uint16
        else:
            log_error(f"[save_image_to_file] Unsupported image type: {type(image).__name__}")
            return

        # Colorize depth images, if requested
        if colormap is not None and is_depth:
            np_data = np.squeeze(np_data)  # Ensure 2D before masking

            valid = np_data > 0  # Ignore invalid pixels when scaling
            if np.any(valid):
                near_mm, far_mm = depth_range_mm
                image8 = np.zeros_like(np_data, dtype=np.uint8)

                clipped = np.clip(np_data[valid], near_mm, far_mm)
                scaled = cv2.normalize(clipped, None, 0, 255, cv2.NORM_MINMAX)
                scaled_flat = scaled.astype(np.uint8).ravel()

                image8[valid] = scaled_flat
                np_data = cv2.applyColorMap(image8, colormap)

        # Write the image to file
        success = cv2.imwrite(str(outfile), np_data)
        if success and outfile.exists():
            log_info(f"[SpotImageClient] Wrote image to {outfile}")
        else:
            log_error(f"cv2.imwrite failed for {outfile}")

    def run_diagnostics(
        self,
        repub_hz: float = 2.0,
        duration_s: float = 15.0,
        out_dir: str | Path | None = None,
    ) -> None:
        """Stream every image source, check image shape math, re-publish images, and save PNGs.

        :param repub_hz: Frequency (Hz) of image republishing
        :param duration_s: Duration (seconds) to run diagnostics
        :param out_dir: Output directory for exported PNGs (if None, defaults to ~/spot_images)
        """
        out_dir = Path.home() / "spot_images" if out_dir is None else Path(out_dir)
        out_dir.mkdir(parents=True, exist_ok=True)

        # Create one publisher per (source, format) pair - Topic: /spot/images/{src}/{fmt}
        pubs: dict[tuple[str, str], rospy.Publisher] = {}
        formats = {
            "rgb": ImageFormat.RGB,
            "greyscale": ImageFormat.GREYSCALE,
            "depth": ImageFormat.DEPTH,
        }

        for source in self.image_sources:
            for fmt in formats:
                topic = f"/spot/images/{source}/{fmt}"
                pubs[(source, fmt)] = rospy.Publisher(topic, ImageMsg, queue_size=1, latch=True)

        requests: list[ImageRequest] = [
            build_image_request(source, pixel_format=f.pixel_format())
            for source in self.image_sources
            for f in formats.values()
        ]
        labels: list[tuple[str, str]] = [
            (source, format_str) for source in self.image_sources for format_str in formats
        ]

        start = rospy.Time.now()
        rate_hz = rospy.Rate(repub_hz)

        saved_pairs: set[tuple[str, str]] = set()  # Remember which PNGs we're written

        while not rospy.is_shutdown() and (rospy.Time.now() - start).to_sec() < duration_s:
            for request, (source, fmt) in zip(requests, labels):
                try:
                    response = self.get_images([request])[0]
                    image_msg = self.proto_to_image_msg(response)
                    pubs[(source, fmt)].publish(image_msg)

                    # Sanity check identical to the cv_bridge C++ guard used in ar_track_alvar
                    mismatch = image_msg.height * image_msg.step != len(image_msg.data)
                    status = "❌" if mismatch else "✅"
                    rospy.loginfo(
                        f"{status} {source}/{fmt}: {image_msg.height}x{image_msg.width}"
                        f", step={image_msg.step}, len={len(image_msg.data)}",
                    )

                    # Save the first PNG for each (source, format) pair
                    key = (source, fmt)
                    if key not in saved_pairs:
                        now_str = datetime.now().strftime("%Y%m%d_%H%M%S")
                        outfile = out_dir / f"{source}_{fmt}_{now_str}.png"

                        if "hand" in source:
                            depth_range_mm = CAMERA_TO_OPERATING_RANGE_MM["hand"]
                        else:
                            depth_range_mm = CAMERA_TO_OPERATING_RANGE_MM["body"]

                        self.save_image_to_file(response, outfile, depth_range_mm)
                        saved_pairs.add(key)

                except Exception as exc:
                    log_error(
                        f"[SpotImageClient] Exception for format {fmt} from {source}: \n\t{exc}",
                    )

            rate_hz.sleep()

        log_info(f"[SpotImageClient] Diagnostics complete - Files saved in {out_dir}")

    @staticmethod
    def proto_to_np(response: ImageResponse) -> np.ndarray:
        """Convert an ImageResponse Protobuf message into a NumPy array of image data.

        :param response: Protobuf message containing an image response from Spot
        :return: NumPy array containing converted image data
        """
        image = response.shot.image
        rows, cols = image.rows, image.cols
        spec = PIXEL_FORMAT_SPECS.get(image.pixel_format, DEFAULT_PIXEL_SPEC)
        buffer = np.frombuffer(image.data, dtype=spec.dtype)

        if image.format == Image.FORMAT_RAW:
            try:
                shape = (rows, cols) if spec.channels == 1 else (rows, cols, spec.channels)
                arr = buffer.reshape(shape)
            except ValueError:
                # Typically caused by JPEG data being sent as RAW - let OpenCV handle it
                log_error("Raw reshape failed - falling back to cv2.imdecode")
                arr = cv2.imdecode(buffer, cv2.IMREAD_UNCHANGED)
        else:
            arr = cv2.imdecode(buffer, cv2.IMREAD_UNCHANGED)

        return np.squeeze(arr)

    @staticmethod
    def extract_camera_info_msg(response: ImageResponse, capture_time: rospy.Time) -> CameraInfo:
        """Populate a sensor_msgs/CameraInfo message from an ImageResponse Protobuf message.

        Adapted from the Spot ROS 1 driver's ros_helpers.py file.

        Reference: https://docs.ros.org/en/noetic/api/sensor_msgs/html/msg/CameraInfo.html

        :param response: Protobuf message containing an image response from Spot
        :param capture_time: Local timestamp at which the image was captured
        :return: Constructed sensor_msgs/CameraInfo message
        """
        msg = CameraInfo()
        msg.header.stamp = capture_time
        msg.header.frame_id = response.shot.frame_name_image_sensor

        msg.height, msg.width = response.shot.image.rows, response.shot.image.cols
        msg.distortion_model = "plumb_bob"
        msg.D = [0, 0, 0, 0, 0]  # Distortion parameters (k1, k2, t1, t2, k3)

        fx = response.source.pinhole.intrinsics.focal_length.x
        fy = response.source.pinhole.intrinsics.focal_length.y
        cx = response.source.pinhole.intrinsics.principal_point.x
        cy = response.source.pinhole.intrinsics.principal_point.y

        msg.K = [fx, 0, cx, 0, fy, cy, 0, 0, 1]
        msg.R = [1, 0, 0, 0, 1, 0, 0, 0, 1]
        msg.P = [fx, 0, cx, 0, 0, fy, cy, 0, 0, 0, 1, 0]

        return msg

    def _camera_to_image_source(self, camera_name: str, image_format: ImageFormat) -> str:
        """Translate a human-friendly camera name to a Spot SDK image source.

        :param camera_name: Name of a camera on Spot (e.g., "frontright" or "back")
        :param image_format: Format of image requested (e.g., RGB or DEPTH)
        :return: Name of the corresponding Spot SDK image source
        """
        if camera_name not in self.camera_names:
            log_error(f"Unrecognized camera name: '{camera_name}'.")
            return ""

        if camera_name == "hand":
            return (
                "hand_depth_in_hand_color_frame"
                if image_format == ImageFormat.DEPTH
                else "hand_color_image"
            )

        suffix = "depth_in_visual_frame" if image_format == ImageFormat.DEPTH else "fisheye_image"
        return f"{camera_name}_{suffix}"

    def _publish_loop(self) -> None:
        """Publish camera images and info in a loop."""
        requests = [self.make_image_request(c, ImageFormat.RGB) for c in self.publish_loop_cameras]
        requests = [r for r in requests if r is not None]
        rate_hz = rospy.Rate(10.0)
        while not rospy.is_shutdown():
            responses = self.get_images(requests)
            assert len(requests) == len(responses) == len(self.publish_loop_cameras)

            for camera_name, response in zip(self.publish_loop_cameras, responses):
                image_msg = self.proto_to_image_msg(response)
                self._image_pubs[camera_name].publish(image_msg)

                time_proto = response.shot.acquisition_time
                timestamp = self._time_sync.local_timestamp_from_proto(time_proto)
                ros_time = rospy.Time.from_sec(timestamp.to_time_s())

                info_msg = self.extract_camera_info_msg(response, ros_time)
                self._info_pubs[camera_name].publish(info_msg)

            rate_hz.sleep()
