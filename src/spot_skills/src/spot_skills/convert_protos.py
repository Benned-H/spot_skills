"""Define utility functions that convert Spot SDK protobuf messages into ROS messages."""

from __future__ import annotations

import rospy
from bosdyn.api import image_pb2
from sensor_msgs.msg import CameraInfo, Image


def extract_image_msg(data: image_pb2.ImageResponse, local_time: rospy.Time) -> Image:
    """Extract an Image ROS message from the given Protobuf message..

    Note: Adapted from the Spot ROS 1 repository's ros_helpers.py file.

    :param data: Protobuf message containing an image and associated data
    :param local_time: Local timestamp at which the image was captured
    :return: Constructed sensor_msgs/Image message
    """
    image_msg = Image()
    image_msg.header.stamp = local_time
    image_msg.header.frame_id = data.shot.frame_name_image_sensor
    image_msg.height = data.shot.image.rows
    image_msg.width = data.shot.image.cols

    # Color/greyscale formats.
    # JPEG format
    if data.shot.image.format == image_pb2.Image.FORMAT_JPEG:
        image_msg.encoding = "rgb8"
        image_msg.is_bigendian = True
        image_msg.step = 3 * data.shot.image.cols
        image_msg.data = data.shot.image.data

    # Uncompressed.  Requires pixel_format.
    if data.shot.image.format == image_pb2.Image.FORMAT_RAW:
        # One byte per pixel.
        if data.shot.image.pixel_format == image_pb2.Image.PIXEL_FORMAT_GREYSCALE_U8:
            image_msg.encoding = "mono8"
            image_msg.is_bigendian = True
            image_msg.step = data.shot.image.cols
            image_msg.data = data.shot.image.data

        # Three bytes per pixel.
        if data.shot.image.pixel_format == image_pb2.Image.PIXEL_FORMAT_RGB_U8:
            image_msg.encoding = "rgb8"
            image_msg.is_bigendian = True
            image_msg.step = 3 * data.shot.image.cols
            image_msg.data = data.shot.image.data

        # Four bytes per pixel.
        if data.shot.image.pixel_format == image_pb2.Image.PIXEL_FORMAT_RGBA_U8:
            image_msg.encoding = "rgba8"
            image_msg.is_bigendian = True
            image_msg.step = 4 * data.shot.image.cols
            image_msg.data = data.shot.image.data

        # Little-endian uint16 z-distance from camera (mm).
        if data.shot.image.pixel_format == image_pb2.Image.PIXEL_FORMAT_DEPTH_U16:
            image_msg.encoding = "16UC1"
            image_msg.is_bigendian = False
            image_msg.step = 2 * data.shot.image.cols
            image_msg.data = data.shot.image.data

    return image_msg


def extract_camera_info_msg(data: image_pb2.ImageResponse, local_time: rospy.Time) -> CameraInfo:
    """Convert the given Protobuf data into a CameraInfo ROS message.

    Note: Adapted from the Spot ROS 1 repository's ros_helpers.py file.

    :param data: Protobuf message containing an image and associated data
    :param local_time: Local timestamp at which the image was captured
    :return: Constructed sensor_msgs/CameraInfo message
    """
    # Reference: https://docs.ros.org/en/noetic/api/sensor_msgs/html/msg/CameraInfo.html
    camera_info_msg = CameraInfo()
    camera_info_msg.distortion_model = "plumb_bob"

    camera_info_msg.D = [0, 0, 0, 0, 0]  # Distortion parameters (k1, k2, t1, t2, k3)

    fx = data.source.pinhole.intrinsics.focal_length.x
    cx = data.source.pinhole.intrinsics.principal_point.x

    fy = data.source.pinhole.intrinsics.focal_length.y
    cy = data.source.pinhole.intrinsics.principal_point.y

    camera_info_msg.K = [fx, 0, cx, 0, fy, cy, 0, 0, 1]

    camera_info_msg.R = [1, 0, 0, 0, 1, 0, 0, 0, 1]

    camera_info_msg.P = [fx, 0, cx, 0, 0, fy, cy, 0, 0, 0, 1, 0]

    camera_info_msg.header.stamp = local_time
    camera_info_msg.header.frame_id = data.shot.frame_name_image_sensor
    camera_info_msg.height = data.shot.image.rows
    camera_info_msg.width = data.shot.image.cols

    return camera_info_msg
