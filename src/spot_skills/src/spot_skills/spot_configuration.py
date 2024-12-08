"""Define objects used to specify configurations of Spot."""

from typing import Dict

Configuration = Dict[str, float]  # Maps joint names to their positions

# Names (per the Spot SDK) of the joints in Spot's arm
# Reference: https://tinyurl.com/SpotSDK-ArmJointPosition
SPOT_SDK_ARM_JOINT_NAMES = [
    "arm0.sh0",
    "arm0.sh1",
    "arm0.el0",
    "arm0.el1",
    "arm0.wr0",
    "arm0.wr1",
]

SPOT_SDK_GRIPPER_JOINT_NAME = "arm0.f1x"

SPOT_URDF_ARM_JOINT_NAMES = [
    "arm_sh0",
    "arm_sh1",
    "arm_el0",
    "arm_el1",
    "arm_wr0",
    "arm_wr1",
]

MAP_JOINT_NAME_URDF_TO_SPOT_SDK = dict(
    zip(SPOT_URDF_ARM_JOINT_NAMES, SPOT_SDK_ARM_JOINT_NAMES),
)

MAP_JOINT_NAME_SPOT_SDK_TO_URDF = dict(
    zip(SPOT_SDK_ARM_JOINT_NAMES, SPOT_URDF_ARM_JOINT_NAMES),
)
