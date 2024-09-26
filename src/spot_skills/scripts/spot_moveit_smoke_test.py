#!/usr/bin/env python

"""Verify that Spot's ROS 1 driver can handle joint angles streamed by MoveIt."""

import sys

import geometry_msgs.msg
import moveit_commander
import moveit_msgs.msg
import rospy

from spot_skills.geometry_utils import create_pose, stamp_pose


def main():
    """Stream joint angles from MoveIt to control Spot's arm using the ROS 1 driver."""
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("spot_moveit_controller")

    # Create a publisher to display target poses in RViz
    target_pose_publisher = rospy.Publisher(
        "/spot_arm_target_pose", geometry_msgs.msg.PoseStamped, queue_size=1
    )

    # MoveGroupCommander Reference: https://tinyurl.com/move-group-commander
    group_name = "arm"
    move_group = moveit_commander.MoveGroupCommander(group_name)

    # Ensure that the move group expects poses in Spot's body frame
    body_frame = "body"

    print(f"Move group's reference frame: {move_group.get_pose_reference_frame()}")
    move_group.set_pose_reference_frame(body_frame)
    print(f"Updated reference frame: {move_group.get_pose_reference_frame()}")

    # Describe the line we'll move Spot's end-effector back-and-forth along
    # Reference: Spot + Spot Arm Information for Use (v1.0) (pg. 17)
    forward_m = 0.5  # Distance forward (meters) in Spot's body frame
    sideways_m = 0.6  # Maximum sideways end-effector extent (meters)
    height_m = 0.9  # Height from floor (meters)

    body_frame_height_m = 0.54  # TODO: Read from real-time robot!
    z_in_body_frame = height_m - body_frame_height_m  # Line's z in Spot's body frame

    # Specify end-effector (ee) target poses in Spot's body frame
    # Assume: Spot may begin at an arbitrary (x,y) location in the global frame
    left_ee_pose = create_pose(forward_m, sideways_m, z_in_body_frame)
    center_ee_pose = create_pose(forward_m, 0, z_in_body_frame)
    right_ee_pose = create_pose(forward_m, -sideways_m, z_in_body_frame)

    target_poses = [center_ee_pose, left_ee_pose, center_ee_pose, right_ee_pose]
    target_pose_idx = 0

    print(f"Left target pose:\n{left_ee_pose}")

    # Begin alternating Spot's arm between the target poses
    freq_hz = 0.2  # Switch sides every 5 seconds
    rate = rospy.Rate(freq_hz)

    while not rospy.is_shutdown():
        # Loop to the beginning of the target poses, if necessary
        if target_pose_idx >= len(target_poses):
            target_pose_idx = 0

        curr_target_pose = target_poses[target_pose_idx]
        target_pose_publisher.publish(stamp_pose(curr_target_pose, body_frame))

        # Plan and move Spot's arm to the current target pose
        print(f"Planning to pose:\n{curr_target_pose}...")
        move_group.set_pose_target(curr_target_pose)
        success, trajectory, _, error = move_group.plan()
        move_group.clear_pose_targets()  # Clear pose targets after planning

        if not success:
            print(f"Planning failed with error {error}!")

        # If planning succeeded, execute the planned trajectory (blocks until done)
        move_group.execute(trajectory, wait=True)
        move_group.stop()  # Ensure there's no residual movement

        target_pose_idx += 1

        rate.sleep()  # Slow change of target poses to specified rate


if __name__ == "__main__":
    main()
