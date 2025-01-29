"""Define utility functions for working with the Spot SDK's image client."""

from __future__ import annotations

from enum import Enum
from typing import TYPE_CHECKING

import cv2
import numpy as np
import rospy
from bosdyn.api.image_pb2 import Image, ImageCapture, ImageRequest, ImageResponse
from bosdyn.client.image import ImageClient, build_image_request
from cv_bridge import CvBridge
from sensor_msgs.msg import CameraInfo
from sensor_msgs.msg import Image as ImageMsg

if TYPE_CHECKING:
    from bosdyn.client.robot import Robot


class ImageFormat(Enum):
    """Enumeration of image format available from Spot."""

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


class SpotImageClient:
    """A wrapper for functions related to Spot's image client."""

    def __init__(self, robot: Robot) -> None:
        """Initialize an image client using the given robot.

        :param robot: Point of access for Spot's RPC clients
        """
        self._image_client = robot.ensure_client(ImageClient.default_service_name)

        # Identify the image sources available from Spot
        image_sources_proto = self._image_client.list_image_sources()
        self.image_sources = [source.name for source in image_sources_proto]

        self._cv_bridge = CvBridge()
        self._debug_rgb_pub = rospy.Publisher("~debug_rgb_image", ImageMsg, queue_size=5)
        self._debug_depth_pub = rospy.Publisher("~debug_depth_image", ImageMsg, queue_size=5)

    def make_image_request(self, camera_name: str, format: ImageFormat) -> ImageRequest | None:
        """Build an image request Protobuf message to be sent to Spot.

        :param camera_name: Name of the camera to be used to capture the image
        :param format: Format of image requested (e.g., RGB or DEPTH)
        :return: Image request Protobuf message, or None if invalid inputs given
        """
        image_source = SpotImageClient.camera_to_image_source(camera_name, format)

        if image_source not in self.image_sources:
            rospy.logerr(f"Unrecognized image source: '{image_source}'")
            return None

        return build_image_request(image_source, pixel_format=format.pixel_format())

    def get_images(self, requests: list[ImageRequest]) -> list[ImageResponse]:
        """Request a collection of images from the robot.

        Note: Adapted from get_images() in the spot_wrapper/spot_images.py file.

        :param requests: List of images requested from the robot
        :return: List of resulting image responses from Spot
        """
        responses = self._image_client.get_image(requests)

        if len(responses) != len(requests):
            rospy.logerr(f"Expected {len(requests)} responses; received {len(responses)} instead")
            return []

        return responses

    @staticmethod
    def camera_to_image_source(camera_name: str, format: ImageFormat) -> str:
        """Convert a camera name and image format into the corresponding image source from Spot.

        :param camera_name: Name of a camera on Spot (e.g., "frontright" or "back")
        :param format: Format of image requested (e.g., RGB or DEPTH)
        :return: Name of the corresponding image source for the Spot SDK
        """
        if camera_name not in ["frontleft", "frontright", "left", "right", "back", "hand"]:
            rospy.logerr(f"Unrecognized camera name: '{camera_name}'")
            return ""

        if camera_name == "hand":
            if format == ImageFormat.DEPTH:
                return "hand_depth_in_hand_color_frame"
            return "hand_color_image"

        if format == ImageFormat.DEPTH:
            return f"{camera_name}_depth_in_visual_frame"

        return f"{camera_name}_fisheye_image"

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
        dtype = np.uint8
        if pixel_format == Image.PIXEL_FORMAT_DEPTH_U16:
            dtype = np.uint16
            encoding = "16UC1"
        elif pixel_format == Image.PIXEL_FORMAT_RGB_U8:
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

        image_np = np.frombuffer(image_capture.image.data, dtype=dtype)
        if image_format == Image.FORMAT_RAW:
            try:
                # Attempt to reshape array into an RGB rows X cols shape.
                image_np = image_np.reshape((rows, cols, num_bytes))
            except ValueError:
                rospy.logerr("[extract_image_msg] Unable to reshape image data")
                image_np = cv2.imdecode(image_np, -1)
        else:
            image_np = cv2.imdecode(image_np, -1)

        image_msg = self._cv_bridge.cv2_to_imgmsg(image_np, encoding)
        image_msg.header.stamp = capture_time
        image_msg.header.frame_id = image_capture.frame_name_image_sensor

        # Verify other expected properties of the constructed Image message
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

        :param response: Protobuf message containing an image response from Spot
        :param capture_time: Local timestamp at which the image was captured
        :return: Constructed sensor_msgs/CameraInfo message
        """
        # Reference: https://docs.ros.org/en/noetic/api/sensor_msgs/html/msg/CameraInfo.html
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
