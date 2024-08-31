#!/usr/bin/env python

"""Smoke test: Can Spot's ROS 1 driver handle MoveIt-streamed joint angles?"""

import sys

import moveit_commander
import moveit_msgs.msg
import numpy as np
import rospy

from .geometry_utils import create_pose


def main():
    """Stream joint angles from MoveIt to control Spot's arm using the ROS 1 driver."""
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("spot_moveit_controller")

    # MoveGroupCommander Reference: https://tinyurl.com/move-group-commander
    group_name = "arm"
    move_group = moveit_commander.MoveGroupCommander(group_name)

    # Ensure that the move group expects poses in Spot's body frame
    body_frame = "spot_body"  # TODO: Check the name for Spot's body frame

    print(f"Move group's reference frame: {move_group.get_pose_reference_frame()}")
    move_group.set_pose_reference_frame(body_frame)  # TODO: Check name
    print(f"Updated reference frame: {move_group.get_pose_reference_frame()}")

    # Create a publisher to display trajectories in RViz
    display_trajectory_publisher = rospy.Publisher(
        "/move_group/display_planned_path",
        moveit_msgs.msg.DisplayTrajectory,
        queue_size=20,
    )

    # Describe the line we'll move Spot's end-effector back-and-forth along
    # Reference: Spot + Spot Arm Information for Use (v1.0) (pg. 17)
    forward_m = 0.9  # Distance forward (meters) in Spot's body frame
    sideways_m = 0.7  # Maximum sideways end-effector extent (meters)
    height_m = 1.1  # Height from floor (meters)

    # TODO: Verify that these parameters look reasonable in simulation

    body_frame_height_m = 0.54  # TODO: Read from real-time robot!
    z_in_body_frame = height_m - body_frame_height_m  # Line's z in Spot's body frame

    # Specify end-effector (ee) target poses in Spot's body frame, with the end-
    #   effector facing 45º "out" once moved to either end of the line.
    # Assume: Spot may begin at an arbitrary (x,y) location in the global frame
    left_ee_pose = create_pose(forward_m, sideways_m, z_in_body_frame, yaw_deg=45)
    right_ee_pose = create_pose(forward_m, -sideways_m, z_in_body_frame, yaw_deg=-45)

    print(f"Left target pose:\n{left_ee_pose}\nRight target pose:\n{right_ee_pose}")

    # Begin alternating Spot's arm between the two target poses
    while True:
        move_group.set_pose_target(left_ee_pose)
        success, trajectory, _, error_code = move_group.plan()
        move_group.clear_pose_targets()  # Clear pose targets after planning

        if not success:
            print(f"Planning to pose {left_ee_pose} failed with error {error_code}!")
            break

        # If planning succeeded, execute the planned trajectory (blocks until done)
        move_group.execute(trajectory, wait=True)
        move_group.stop()  # Ensure there's no residual movement
        rospy.sleep(5)

        # Now, plan and move Spot's arm to the right side
        move_group.set_pose_target(right_ee_pose)
        success, trajectory, _, error_code = move_group.plan()
        move_group.clear_pose_targets()  # Clear pose targets after planning

        if not success:
            print(f"Planning to pose {right_ee_pose} failed with error {error_code}!")
            break

        # If planning succeeded, execute the planned trajectory (blocks until done)
        move_group.execute(trajectory, wait=True)
        move_group.stop()  # Ensure there's no residual movement
        rospy.sleep(5)

    rospy.spin()  # Don't exit until the node is stopped


if __name__ == "__main__":
    main()
