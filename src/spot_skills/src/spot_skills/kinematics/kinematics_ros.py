"""Define functions to convert 3D transform representations into ROS messages."""

from __future__ import annotations

from geometry_msgs.msg import Point, Pose, PoseStamped, Transform, TransformStamped, Vector3
from geometry_msgs.msg import Quaternion as QuaternionMsg

from spot_skills.kinematics.kinematics import DEFAULT_FRAME, Point3D, Pose3D, Quaternion


def get_pose_frame(pose_msg: Pose | PoseStamped) -> tuple[Pose, str]:
    """Convert Pose and PoseStamped messages into a consistent format.

    :param pose_msg: ROS message representing a pose w.r.t. some frame
    :returns: Tuple containing the corresponding (Pose, frame ID)
    """
    frame_id = DEFAULT_FRAME  # Default frame (if given a Pose message)
    pose = pose_msg
    if isinstance(pose_msg, PoseStamped):
        frame_id = pose_msg.header.frame_id
        pose = pose_msg.pose  # Extract just the Pose from the PoseStamped

    return (pose, frame_id)


def point_to_msg(point: Point3D) -> Point:
    """Convert the given point into an equivalent ROS message."""
    return Point(point.x, point.y, point.z)


def point_to_vector3_msg(point: Point3D) -> Vector3:
    """Convert the given point into a geometry_msgs/Vector3 message."""
    return Vector3(point.x, point.y, point.z)


def point_from_vector3_msg(v_msg: Vector3) -> Point3D:
    """Construct a Point3D from a geometry_msgs/Vector3 message."""
    return Point3D(v_msg.x, v_msg.y, v_msg.z)


def quaternion_to_msg(q: Quaternion) -> QuaternionMsg:
    """Convert the given quaternion into an equivalent ROS message."""
    return QuaternionMsg(q.x, q.y, q.z, q.w)


def pose_to_msg(pose: Pose3D) -> Pose:
    """Convert the given pose into an equivalent ROS message."""
    return Pose(
        point_to_msg(pose.position),
        quaternion_to_msg(pose.orientation),
    )


def pose_to_stamped_msg(pose: Pose3D) -> PoseStamped:
    """Convert the given pose into a geometry_msgs/PoseStamped message."""
    msg = PoseStamped()
    msg.header.frame_id = pose.frame
    msg.pose = pose_to_msg(pose)
    return msg


def pose_to_transform_msg(pose: Pose3D) -> Transform:
    """Convert the given pose into a geometry_msgs/Transform message."""
    translation = point_to_vector3_msg(pose.position)
    rotation = quaternion_to_msg(pose.orientation)
    return Transform(translation, rotation)


def tf_msg_to_pose(tf_msg: Transform, frame_id: str) -> Pose3D:
    """Convert the given geometry_msgs/Transform message into a Pose3D."""
    position = Point3D(tf_msg.translation.x, tf_msg.translation.y, tf_msg.translation.z)
    orientation = quaternion_from_msg(tf_msg.rotation)
    return Pose3D(position, orientation, frame_id)


def point_from_msg(point_msg: Point) -> Point3D:
    """Convert a geometry_msgs/Point message into a Point3D.

    :param point_msg: ROS message representing a 3D point
    """
    return Point3D(point_msg.x, point_msg.y, point_msg.z)


def quaternion_from_msg(q_msg: QuaternionMsg) -> Quaternion:
    """Convert a geometry_msgs/Quaternion message into a quaternion.

    :param q_msg: ROS message representing an orientation as a unit quaternion
    """
    return Quaternion(q_msg.x, q_msg.y, q_msg.z, q_msg.w)


def pose_from_msg(pose_msg: Pose | PoseStamped) -> Pose3D:
    """Convert a pose message into a Pose3D.

    :param pose_msg: ROS message representing a 3D pose
    """
    pose, frame_id = get_pose_frame(pose_msg)

    return Pose3D(
        point_from_msg(pose.position),
        quaternion_from_msg(pose.orientation),
        frame=frame_id,
    )


def pose_msg_to_tf_msg(pose_msg: Pose) -> Transform:
    """Convert a geometry_msgs/Pose to a geometry_msgs/Transform."""
    translation = Vector3(pose_msg.position.x, pose_msg.position.y, pose_msg.position.z)
    return Transform(translation, pose_msg.orientation)


def pose_from_tf_stamped_msg(tf_msg: TransformStamped) -> Pose3D:
    """Construct a Pose3D from a geometry_msgs/TransformStamped message."""
    position = point_from_vector3_msg(tf_msg.transform.translation)
    orientation = quaternion_from_msg(tf_msg.transform.rotation)

    return Pose3D(position, orientation, tf_msg.header.frame_id)
