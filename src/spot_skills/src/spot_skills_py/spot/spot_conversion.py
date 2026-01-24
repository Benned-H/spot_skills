"""Define utilities and constants to convert to and from Spot SDK data structures."""

from bosdyn.client.math_helpers import Quat, SE3Pose
from robotics_utils.geometry import Point3D
from robotics_utils.spatial import Pose3D, Quaternion

HAND_T_FINGERTIP = Pose3D.from_xyz_rpy(x=0.04843, z=-0.015, ref_frame="hand")
"""Relative pose of the `fingertip` frame relative to the Spot-published `hand` frame."""


NOMINAL_STAND_HEIGHT_M = 0.61
"""Default height (m) of Spot's body when walking or standing.

Reference: https://support.bostondynamics.com/s/article/Spot-Specifications-49916
"""


def quaternion_from_sdk(q: Quat) -> Quaternion:
    """Construct a Quaternion from a quaternion in the Spot SDK format."""
    return Quaternion(x=q.x, y=q.y, z=q.z, w=q.w)


def pose_from_sdk(se3_pose: SE3Pose, ref_frame: str) -> Pose3D:
    """Construct a Pose3D from an SE3 pose in the Spot SDK format."""
    return Pose3D(
        position=Point3D(se3_pose.x, se3_pose.y, se3_pose.z),
        orientation=quaternion_from_sdk(se3_pose.rotation),
        ref_frame=ref_frame,
    )
