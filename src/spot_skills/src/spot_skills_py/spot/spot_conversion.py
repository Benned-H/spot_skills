"""Define utilities and constants to convert to and from Spot SDK data structures."""

from bosdyn.client.math_helpers import Quat as QuatSDK
from bosdyn.client.math_helpers import SE3Pose
from robotics_utils.geometry import Point3D
from robotics_utils.kinematics import Configuration
from robotics_utils.motion_planning import RectangularFootprint
from robotics_utils.spatial import Pose3D, Quaternion

HAND_T_FINGERTIP = Pose3D.from_xyz_rpy(x=0.04843, z=-0.015, ref_frame="hand")
"""Relative pose of the `fingertip` frame relative to the Spot-published `hand` frame."""

SPOT_GRIPPER_OPEN_RAD = -1.5707
SPOT_GRIPPER_CLOSED_RAD = 0.0

NOMINAL_STAND_HEIGHT_M = 0.61
"""Default height (m) of Spot's body when walking or standing.

Reference: https://support.bostondynamics.com/s/article/Spot-Specifications-49916
"""

STOW_CONFIGURATION: Configuration = {
    "arm_el0": 3.1415,
    "arm_el1": 0,
    "arm_sh0": 0,
    "arm_sh1": -3.1415,
    "arm_wr0": 0,
    "arm_wr1": 0,
}


def quaternion_from_sdk(q: QuatSDK) -> Quaternion:
    """Construct a Quaternion from a quaternion in the Spot SDK format."""
    return Quaternion(x=q.x, y=q.y, z=q.z, w=q.w)


def quaternion_to_sdk(q: Quaternion) -> QuatSDK:
    """Convert a Quaternion to the Spot SDK Quat format."""
    return QuatSDK(w=q.w, x=q.x, y=q.y, z=q.z)


def pose_from_sdk(se3_pose: SE3Pose, ref_frame: str) -> Pose3D:
    """Construct a Pose3D from an SE3 pose in the Spot SDK format."""
    return Pose3D(
        position=Point3D(se3_pose.x, se3_pose.y, se3_pose.z),
        orientation=quaternion_from_sdk(se3_pose.rotation),
        ref_frame=ref_frame,
    )


def pose_to_sdk(pose: Pose3D) -> SE3Pose:
    """Convert a Pose3D to the Spot SDK SE3Pose format.

    Note: The reference frame is NOT encoded in SE3Pose; the caller must
    ensure the pose is expressed in the intended frame before conversion.

    :param pose: Pose3D with position and orientation
    :return: Spot SDK SE3Pose object (math_helpers version, not proto)
    """
    return SE3Pose(
        x=pose.position.x,
        y=pose.position.y,
        z=pose.position.z,
        rot=quaternion_to_sdk(pose.orientation),
    )


_FRONT_BACK_PADDING_M = 0.05  # Extra clearance for conservative planning
_SIDE_PADDING_M = 0.1  # Try to discourage corner-cutting

SPOT_FOOTPRINT = RectangularFootprint(
    max_x_m=0.63 + _FRONT_BACK_PADDING_M,
    min_x_m=-0.49 - _FRONT_BACK_PADDING_M,
    half_length_y_m=0.25 + _SIDE_PADDING_M,
)
"""Rectangular footprint in Spot's body frame (includes the stowed arm)."""
