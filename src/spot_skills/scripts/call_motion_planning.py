#!/usr/bin/env python

"""Call MoveIt to compute and execute a motion plan on Spot."""

import time

import numpy as np
import rospy
from robotics_utils.kinematics import Pose3D
from robotics_utils.motion_planning import MotionPlanningQuery
from robotics_utils.robots import GripperAngleLimits
from robotics_utils.ros.moveit_motion_planner import MoveItMotionPlanner
from robotics_utils.ros.planning_scene_manager import PlanningSceneManager
from robotics_utils.ros.robots import MoveItManipulator, ROSAngularGripper
from robotics_utils.ros.transform_manager import TransformManager


def main() -> None:
    """Call MoveIt to control Spot's end-effector to reach a specific pose or configuration."""
    TransformManager.init_node("call_motion_planning")

    # max_initial_joint_noise_deg = 10
    # joint_noise_rad = np.random.random(size=(6,)) * np.deg2rad(max_initial_joint_noise_deg)

    # target_config = {
    #     "arm_el0": 1.8336877822875977 + joint_noise_rad[0],
    #     "arm_el1": 0.03147602081298828 + joint_noise_rad[1],
    #     "arm_sh0": 0.006414175033569336 + joint_noise_rad[2],
    #     "arm_sh1": -0.7490799427032471 + joint_noise_rad[3],
    #     "arm_wr0": -1.1007270812988281 + joint_noise_rad[4],
    #     "arm_wr1": -0.024648189544677734 + joint_noise_rad[5],
    # }

    # # target_config = {
    # #     "arm_el0": 1.8336877822875977,
    # #     "arm_el1": 0.03147602081298828,
    #     "arm_sh0": 0.006414175033569336,
    #     "arm_sh1": -0.7490799427032471,
    #     "arm_wr0": -1.1007270812988281,
    #     "arm_wr1": -0.024648189544677734,
    # }

    target_fc_ee = Pose3D.from_xyz_rpy(
        x=0.58,  # 0.575 can be not far enough. Originally was 0.486, moved back for safety
        z=0.505,  # 0.50 can be too low, 0.505 can be too high
        yaw_rad=3.14159,
        ref_frame="filing_cabinet1",
    )

    broadcast_for_s = 0
    rospy.loginfo(f"Broadcasting end-effector target pose for {broadcast_for_s} seconds...")
    end_time = time.time() + broadcast_for_s
    while time.time() < end_time:
        TransformManager.broadcast_transform("ee_target", target_fc_ee)
        time.sleep(TransformManager.LOOP_HZ)

    query = MotionPlanningQuery(target_fc_ee)

    # Create classes to compute motion plans on Spot
    spot_gripper = ROSAngularGripper(
        limits=GripperAngleLimits(open_rad=-1.5707, closed_rad=0.0),
        grasping_group="gripper",
        action_name="gripper_controller/gripper_action",
    )
    spot_arm = MoveItManipulator(name="arm", base_frame="body", gripper=spot_gripper)
    planning_scene = PlanningSceneManager(body_frame="body")

    planner = MoveItMotionPlanner(spot_arm, planning_scene)
    trajectory = planner.compute_motion_plan(query)
    if trajectory is not None:
        spot_arm.execute_motion_plan(trajectory)
    spot_gripper.open()

    rospy.loginfo(f"Broadcasting end-effector target pose for {broadcast_for_s} seconds...")
    end_time = time.time() + broadcast_for_s
    while time.time() < end_time:
        TransformManager.broadcast_transform("ee_target", target_fc_ee)
        time.sleep(TransformManager.LOOP_HZ)

    rospy.signal_shutdown("All done!")


if __name__ == "__main__":
    main()
