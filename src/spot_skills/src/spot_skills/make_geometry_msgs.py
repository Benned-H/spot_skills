"""Define utility functions for creating geometry-related ROS 1 messages."""

from math import pi

import geometry_msgs.msg
import rospy
from std_msgs.msg import Header
from tf.transformations import quaternion_from_euler

DEG_TO_RAD = pi / 180  # Constant multiplier to convert degrees into radians
RAD_TO_DEG = 180 / pi  # Constant multiplier to convert radians into degrees


def create_pose(
    xyz_position: tuple[float, float, float] = (0, 0, 0),
    roll_rad: float = 0,
    pitch_rad: float = 0,
    yaw_rad: float = 0,
    **kwargs: float,
) -> geometry_msgs.msg.Pose:
    """Construct a pose message from the given coordinates and angles (in radians).

    The roll, pitch, and yaw describe sequential counterclockwise rotations around the
        x, y, and z axes, respectively. The rotations are applied in a static frame.

    Reference: Chapter 3.2.3 (pg. 98) of the Planning Algorithms book (LaValle 2006).

    :param      xyz_position    Position specified as (x,y,z) coordinates
    :param      roll_rad        Roll angle (radians) about the x-axis
    :param      pitch_rad       Pitch angle (radians) about the y-axis
    :param      yaw_rad         Yaw angle (radians) about the z-axis

    To specify angles in degrees, use the following alternative keyword arguments:

    :param      **roll_deg      Roll angle (degrees) about the x-axis
    :param      **pitch_deg     Pitch angle (degrees) about the y-axis
    :param      **yaw_deg       Yaw angle (degrees) about the z-axis

    :returns    Pose message with the specified position and orientation
    """
    x, y, z = xyz_position

    pose = geometry_msgs.msg.Pose()
    pose.position.x = x
    pose.position.y = y
    pose.position.z = z

    # Check for any rotation-overriding keyword arguments
    if "roll_deg" in kwargs:
        roll_rad = kwargs["roll_deg"] * DEG_TO_RAD
    if "pitch_deg" in kwargs:
        pitch_rad = kwargs["pitch_deg"] * DEG_TO_RAD
    if "yaw_deg" in kwargs:
        yaw_rad = kwargs["yaw_deg"] * DEG_TO_RAD

    # Compute the quaternion corresponding to the RPY angles
    quaternion = quaternion_from_euler(roll_rad, pitch_rad, yaw_rad)
    pose.orientation.x = quaternion[0]
    pose.orientation.y = quaternion[1]
    pose.orientation.z = quaternion[2]
    pose.orientation.w = quaternion[3]

    return pose


def stamp_pose(
    pose: geometry_msgs.msg.Pose,
    frame_id: str,
) -> geometry_msgs.msg.PoseStamped:
    """Convert the given Pose message into a PoseStamped message.

    :param      pose        Message representing a pose in 3D space
    :param      frame_id    Name of the reference frame for the pose

    :returns    PoseStamped message with a header specifying the given frame
    """
    header = Header()
    header.stamp = rospy.Time.now()
    header.frame_id = frame_id

    return geometry_msgs.msg.PoseStamped(header, pose)
