"""Define functions to convert 3D transform representations into ROS messages."""

import geometry_msgs.msg

from .transforms_3d import Point3D, Pose3D, Quaternion


def point_to_msg(point: Point3D) -> geometry_msgs.msg.Point:
    """Convert the given point into an equivalent ROS message."""
    return geometry_msgs.msg.Point(point.x, point.y, point.z)


def quaternion_to_msg(q: Quaternion) -> geometry_msgs.msg.Quaternion:
    """Convert the given quaternion into an equivalent ROS message."""
    return geometry_msgs.msg.Quaternion(q.x, q.y, q.z, q.w)


def pose_to_msg(pose: Pose3D) -> geometry_msgs.msg.Pose:
    """Convert the given pose into an equivalent ROS message."""
    return geometry_msgs.msg.Pose(
        point_to_msg(pose.position),
        quaternion_to_msg(pose.orientation),
    )
