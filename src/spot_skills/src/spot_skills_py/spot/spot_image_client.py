"""Define utility functions for working with the Spot SDK's image client."""

from __future__ import annotations

from enum import Enum
from typing import TYPE_CHECKING

import cv2
import numpy as np
import rospy
from bosdyn.api.image_pb2 import Image, ImageCapture, ImageRequest, ImageResponse
from bosdyn.client.image import ImageClient, build_image_request
from bosdyn.client.lease import LeaseWallet, add_lease_wallet_processors
from cv_bridge import CvBridge
from robotics_utils.ros import TransformManager
from robotics_utils.spatial import Pose3D
from robotics_utils.states.visual_states import ImageObservation
from robotics_utils.vision import DepthImage, RGBImage
from robotics_utils.vision.cameras import CameraIntrinsics, RGBCamera
from sensor_msgs.msg import CameraInfo
from sensor_msgs.msg import Image as ImageMsg

if TYPE_CHECKING:
    from bosdyn.client.robot import Robot


class ImageFormat(Enum):
    """Enumeration of image formats available from Spot."""

    RGB = 1
    GREYSCALE = 2
    DEPTH = 3

    def pixel_format(self) -> int:
        """Map the image format to the corresponding Spot SDK pixel format.

        Reference:
            https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#image-pixelformat

        :return: Integer corresponding to a pixel format
        """
        if self is ImageFormat.RGB:
            return Image.PIXEL_FORMAT_RGB_U8
        if self is ImageFormat.GREYSCALE:
            return Image.PIXEL_FORMAT_GREYSCALE_U8
        if self is ImageFormat.DEPTH:
            return Image.PIXEL_FORMAT_DEPTH_U16
        return Image.PIXEL_FORMAT_UNKNOWN


CAMERA_FRAMES = {
    "frontleft": "frontleft",
    "frontright": "frontright",
    "hand": "hand_color_image_sensor",
}
"""Map human-friendly camera names to their TF frame names."""


class SpotImageClient:
    """A wrapper for functions related to Spot's image client."""

    def __init__(self, robot: Robot, lease_wallet: LeaseWallet) -> None:
        """Initialize an image client using the given robot.

        :param robot: Point of access for Spot's RPC clients
        :param lease_wallet: Shared lease wallet providing a lease for the robot
        """
        self._image_client = robot.ensure_client(ImageClient.default_service_name)
        add_lease_wallet_processors(self._image_client, lease_wallet)

        # Identify the image sources available from Spot
        image_sources_proto = self._image_client.list_image_sources()
        self.image_sources = [source.name for source in image_sources_proto]
        self.camera_names = ["frontleft", "frontright", "left", "right", "back", "hand"]

        self._cv_bridge = CvBridge()
        self._debug_rgb_pub = rospy.Publisher("~debug_rgb_image", ImageMsg, queue_size=5)
        self._debug_depth_pub = rospy.Publisher("~debug_depth_image", ImageMsg, queue_size=5)

    def make_image_request(self, camera: str, image_format: ImageFormat) -> ImageRequest | None:
        """Build an image request Protobuf message to be sent to Spot.

        :param camera: Name of the camera to be used to capture the image
        :param image_format: Format of image requested (e.g., RGB or DEPTH)
        :return: Image request Protobuf message, or None if invalid inputs given
        """
        image_source = self._camera_to_image_source(camera, image_format)

        if image_source not in self.image_sources:
            rospy.logerr(f"Unrecognized image source: '{image_source}'")
            rospy.logerr(f"Available image sources: {self.image_sources}")
            return None

        return build_image_request(image_source, pixel_format=image_format.pixel_format())

    def get_images(self, requests: list[ImageRequest]) -> list[ImageResponse]:
        """Request a collection of images from the robot.

        Note: Adapted from get_images() in the spot_wrapper/spot_images.py file.

        :param requests: List of images requested from the robot
        :return: List of resulting image responses from Spot
        """
        responses = self._image_client.get_image(requests)

        if len(responses) != len(requests):
            rospy.logerr(f"Expected {len(requests)} responses, but received {len(responses)}")
            return []

        return responses

    def get_images_as_cv2(self, sources: list[str]) -> tuple[dict, dict]:
        """Request images from the robot, output in OpenCV and Protobuf formats.

        Note: Adapted directly from the open_door.py demo of the Spot SDK.

        :param sources: List of names of image sources
        :return: Dictionary from image source name to (image proto, CV2 image) pairs
        """
        image_responses = self._image_client.get_image_from_sources(sources)
        image_dict = {}

        for response in image_responses:
            # Convert image proto to CV2 image, for displaying later
            image = np.frombuffer(response.shot.image.data, dtype=np.uint8)
            image = cv2.imdecode(image, -1)
            image_dict[response.source.name] = (response, image)  # Image response and CV2 image

        rgb_requests = [
            build_image_request(source, quality_percent=100, pixel_format=Image.PIXEL_FORMAT_RGB_U8)
            for source in sources
        ]
        rgb_image_responses = self._image_client.get_image(rgb_requests)
        rgb_image_dict = {}

        for response in rgb_image_responses:
            # Convert image proto to CV2 image, for displaying later
            image = np.frombuffer(response.shot.image.data, dtype=np.uint8)
            image = cv2.imdecode(image, -1)
            rgb_image_dict[response.source.name] = (response, image)

        return image_dict, rgb_image_dict

    def get_rgb_images(self, camera_names: list[str]) -> dict[str, RGBImage]:
        """Request images from the robot, output in a NumPy-based format.

        :param camera_names: List of camera names (e.g., "hand")
        :return: Dictionary mapping camera names to the resulting RGBImage objects
        """
        sources = [self._camera_to_image_source(cn, ImageFormat.RGB) for cn in camera_names]
        image_responses = self._image_client.get_image_from_sources(sources)

        rgb_images = {}
        for camera_name, response in zip(camera_names, image_responses):
            raw_data = np.frombuffer(response.shot.image.data, dtype=np.uint8)
            bgr_data = cv2.imdecode(raw_data, cv2.IMREAD_COLOR)
            if bgr_data is None:
                raise RuntimeError(f"Unable to decode image from camera '{camera_name}'.")
            rgb_data = cv2.cvtColor(bgr_data, cv2.COLOR_BGR2RGB)
            rgb_images[camera_name] = RGBImage(rgb_data)

        return rgb_images

    def get_rgb_images_with_poses(
        self,
        camera_names: list[str],
        ref_frame: str = "body",
    ) -> dict[str, tuple[RGBImage, CameraIntrinsics, Pose3D]]:
        """Request RGB images with camera poses from the robot.

        :param camera_names: List of camera names (e.g., ["hand", "frontleft"])
        :param ref_frame: Reference frame for returned poses (defaults to "body")
        :return: Dict mapping camera names to (RGBImage, CameraIntrinsics, Pose3D) tuples
        """
        rgb_images = self.get_rgb_images(camera_names)
        results: dict[str, tuple[RGBImage, CameraIntrinsics, Pose3D]] = {}

        for camera_name, rgb_image in rgb_images.items():
            intrinsics = self.get_intrinsics(camera_name, ImageFormat.RGB)
            camera_frame = CAMERA_FRAMES.get(camera_name, camera_name)

            pose = TransformManager.lookup_transform(camera_frame, ref_frame)
            if pose is None:
                pose = Pose3D.identity(ref_frame)

            results[camera_name] = (rgb_image, intrinsics, pose)

        return results

    def get_image_observation(
        self,
        camera_name: str,
        ref_frame: str = "body",
    ) -> ImageObservation[RGBImage]:
        """Capture an RGB image observation and the camera pose at the time of capture.

        :param camera_name: Name of the camera used to capture the image (e.g., "hand")
        :param ref_frame: Reference frame to use for the camera pose (default: "body")
        :return: ImageObservation containing the RGB image and capture-time camera pose
        :raises RuntimeError: If Spot fails to capture the image
        """
        results = self.get_rgb_images_with_poses([camera_name], ref_frame=ref_frame)

        if camera_name not in results:
            raise RuntimeError(f"Failed to capture image observation from camera '{camera_name}'.")

        rgb_image, _intrinsics, pose = results[camera_name]
        return ImageObservation(image=rgb_image, pose_o_c=pose)

    def get_depth_images(self, camera_names: list[str]) -> dict[str, DepthImage]:
        """Request depth images from the robot.

        Depth values are returned in meters as float64.

        :param camera_names: List of camera names (e.g., ["hand", "frontleft"])
        :return: Dictionary mapping camera names to DepthImage objects
        """
        depth_images: dict[str, DepthImage] = {}

        for camera_name in camera_names:
            request = self.make_image_request(camera_name, ImageFormat.DEPTH)
            if request is None:
                continue

            responses = self.get_images([request])
            if not responses:
                continue

            response = responses[0]
            rows, cols = response.shot.image.rows, response.shot.image.cols

            # Spot sends DEPTH_U16 in millimeters; convert to meters as float64
            raw_depth = np.frombuffer(response.shot.image.data, dtype=np.uint16)
            raw_depth = raw_depth.reshape((rows, cols))
            depth_meters = raw_depth.astype(np.float64) / 1000.0

            depth_images[camera_name] = DepthImage(depth_meters)

        return depth_images

    def get_depth_images_with_poses(
        self,
        camera_names: list[str],
        ref_frame: str = "body",
    ) -> dict[str, tuple[DepthImage, CameraIntrinsics, Pose3D]]:
        """Request depth images with camera poses from the robot.

        Depth values are returned in meters as float64.

        :param camera_names: List of camera names (e.g., ["hand", "frontleft"])
        :param ref_frame: Reference frame for returned poses (defaults to "body")
        :return: Dict mapping camera names to (DepthImage, CameraIntrinsics, Pose3D) tuples
        """
        results: dict[str, tuple[DepthImage, CameraIntrinsics, Pose3D]] = {}

        for camera_name in camera_names:
            request = self.make_image_request(camera_name, ImageFormat.DEPTH)
            if request is None:
                continue

            responses = self.get_images([request])
            if not responses:
                continue

            response = responses[0]
            rows, cols = response.shot.image.rows, response.shot.image.cols

            # Spot sends DEPTH_U16 in millimeters; convert to meters as float64
            raw_depth = np.frombuffer(response.shot.image.data, dtype=np.uint16)
            raw_depth = raw_depth.reshape((rows, cols))
            depth_meters = raw_depth.astype(np.float64) / 1000.0

            depth_image = DepthImage(depth_meters)
            intrinsics = self.get_intrinsics(camera_name, ImageFormat.DEPTH)

            # Get camera pose via TF
            camera_frame = response.shot.frame_name_image_sensor
            pose = TransformManager.lookup_transform(camera_frame, ref_frame)
            if pose is None:
                pose = Pose3D.identity(ref_frame)

            results[camera_name] = (depth_image, intrinsics, pose)

        return results

    def _camera_to_image_source(self, camera_name: str, image_format: ImageFormat) -> str:
        """Convert a camera name and image format into the corresponding image source from Spot.

        :param camera_name: Name of a camera on Spot (e.g., "frontright" or "back")
        :param image_format: Format of image requested (e.g., RGB or DEPTH)
        :return: Name of the corresponding image source for the Spot SDK
        """
        if camera_name not in self.camera_names:
            rospy.logerr(f"Unrecognized camera name: '{camera_name}'")
            return ""

        if camera_name == "hand":
            if image_format == ImageFormat.DEPTH:
                return "hand_depth_in_hand_color_frame"
            return "hand_color_image"

        if image_format == ImageFormat.DEPTH:
            return f"{camera_name}_depth_in_visual_frame"

        return f"{camera_name}_fisheye_image"

    def get_intrinsics(self, camera_name: str, image_format: ImageFormat) -> CameraIntrinsics:
        """Retrieve the camera intrinsics of the specified camera on Spot."""
        request = self.make_image_request(camera_name, image_format)
        if request is None:
            raise RuntimeError(f"Unable to make image request for camera: '{camera_name}'.")

        response = self.get_images([request])[0]

        fx = response.source.pinhole.intrinsics.focal_length.x
        cx = response.source.pinhole.intrinsics.principal_point.x
        fy = response.source.pinhole.intrinsics.focal_length.y
        cy = response.source.pinhole.intrinsics.principal_point.y

        return CameraIntrinsics(fx=fx, fy=fy, x0=cx, y0=cy)

    def get_frame_name(self, camera_name: str) -> str:
        """Retrieve the name of the reference frame corresponding to the given camera."""
        return CAMERA_FRAMES[camera_name]

    def extract_image_msg(self, image_capture: ImageCapture, capture_time: rospy.Time) -> ImageMsg:
        """Extract a sensor_msgs/Image ROS message from the given Protobuf message.

        Note: Adapted from the Spot ROS 1 driver's ros_helpers.py file.
        Note: Adapted from the get_image.py example from the Spot SDK.

        :param image_capture: Protobuf message representing a captured image
        :param capture_time: Local timestamp at which the image was captured
        :return: Constructed sensor_msgs/Image message
        """
        rows = image_capture.image.rows
        cols = image_capture.image.cols

        # Use NumPy and OpenCV to decode the image's data into the ROS message data
        image_format = image_capture.image.format
        pixel_format = image_capture.image.pixel_format

        num_bytes = 1  # Default: Assume 1-byte encoding
        if pixel_format == Image.PIXEL_FORMAT_DEPTH_U16:
            encoding = "16UC1"
            image_np = np.frombuffer(image_capture.image.data, dtype=np.uint16)
        else:
            if pixel_format == Image.PIXEL_FORMAT_RGB_U8:
                num_bytes = 3
                encoding = "bgr8"
            elif pixel_format == Image.PIXEL_FORMAT_RGBA_U8:
                num_bytes = 4
                encoding = "bgra8"
            elif pixel_format == Image.PIXEL_FORMAT_GREYSCALE_U8:
                num_bytes = 1
                encoding = "mono8"
            elif pixel_format == Image.PIXEL_FORMAT_GREYSCALE_U16:
                num_bytes = 2
                encoding = "mono16"

            image_np = np.frombuffer(image_capture.image.data, dtype=np.uint8)

        if image_format == Image.FORMAT_RAW:
            try:  # Attempt to reshape array into an RGB rows x cols shape.
                image_np = image_np.reshape((rows, cols, num_bytes))
            except ValueError:
                rospy.logerr("[extract_image_msg] Unable to reshape image data")
                image_np = cv2.imdecode(image_np, -1)
        else:
            image_np = cv2.imdecode(image_np, -1)

        image_msg = self._cv_bridge.cv2_to_imgmsg(image_np, encoding)
        image_msg.header.stamp = capture_time
        image_msg.header.frame_id = image_capture.frame_name_image_sensor

        # Verify expected properties of the constructed Image message
        assert image_msg.height == rows
        assert image_msg.width == cols

        if pixel_format == Image.PIXEL_FORMAT_RGB_U8:
            self._debug_rgb_pub.publish(image_msg)
        elif pixel_format == Image.PIXEL_FORMAT_DEPTH_U16:
            self._debug_depth_pub.publish(image_msg)

        return image_msg

    @staticmethod
    def extract_camera_info_msg(response: ImageResponse, capture_time: rospy.Time) -> CameraInfo:
        """Extract a sensor_msgs/CameraInfo ROS message from the given Protobuf message.

        Note: Adapted from the Spot ROS 1 driver's ros_helpers.py file.

        Reference: https://docs.ros.org/en/noetic/api/sensor_msgs/html/msg/CameraInfo.html

        :param response: Protobuf message containing an image response from Spot
        :param capture_time: Local timestamp at which the image was captured
        :return: Constructed sensor_msgs/CameraInfo message
        """
        camera_info_msg = CameraInfo()
        camera_info_msg.header.stamp = capture_time
        camera_info_msg.header.frame_id = response.shot.frame_name_image_sensor

        camera_info_msg.height = response.shot.image.rows
        camera_info_msg.width = response.shot.image.cols

        camera_info_msg.distortion_model = "plumb_bob"

        camera_info_msg.D = [0, 0, 0, 0, 0]  # Distortion parameters (k1, k2, t1, t2, k3)

        fx = response.source.pinhole.intrinsics.focal_length.x
        cx = response.source.pinhole.intrinsics.principal_point.x

        fy = response.source.pinhole.intrinsics.focal_length.y
        cy = response.source.pinhole.intrinsics.principal_point.y

        camera_info_msg.K = [fx, 0, cx, 0, fy, cy, 0, 0, 1]

        camera_info_msg.R = [1, 0, 0, 0, 1, 0, 0, 0, 1]

        camera_info_msg.P = [fx, 0, cx, 0, 0, fy, cy, 0, 0, 0, 1, 0]

        return camera_info_msg


class SpotRGBCamera(RGBCamera):
    """A generic interface for one of Spot's RGB cameras."""

    def __init__(self, camera_name: str, image_client: SpotImageClient) -> None:
        """Initialize the camera interface using a client to collect images from Spot."""
        intrinsics = image_client.get_intrinsics(camera_name, ImageFormat.RGB)
        frame_name = image_client.get_frame_name(camera_name)

        super().__init__(
            name=camera_name,
            intrinsics=intrinsics,
            image_type=RGBImage,
            frame_name=frame_name,
        )

        self.image_client = image_client
        self.image_source = self.image_client.get_images

    def get_image(self) -> RGBImage:
        """Capture and return an image using the camera."""
        return self.image_client.get_rgb_images([self.name])[self.name]
