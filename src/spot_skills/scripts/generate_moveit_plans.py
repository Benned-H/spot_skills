#!/usr/bin/env python

"""Generate motion plans for Spot's arm using MoveIt."""

import sys

import geometry_msgs.msg
import numpy as np
import rospy
from actionlib.simple_action_client import SimpleActionClient
from control_msgs.msg import GripperCommandAction, GripperCommandGoal
from moveit_commander import MoveGroupCommander, roscpp_initialize

from spot_skills.make_geometry_msgs import create_pose, stamp_pose


def main() -> None:
    """Use MoveIt to generate motion plans to be executed on Spot's arm."""
    ### Set up MoveIt and the 'arm' move group used to control Spot's arm ###
    roscpp_initialize(sys.argv)
    rospy.init_node("moveit_plan_generator")

    # Create a publisher to display target poses in RViz
    target_pose_publisher = rospy.Publisher(
        "end_effector_target_pose",
        geometry_msgs.msg.PoseStamped,
        queue_size=1,
    )

    # MoveGroupCommander Reference: https://tinyurl.com/move-group-commander
    group_name = "arm"
    move_group = MoveGroupCommander(group_name, wait_for_servers=180)

    use_gripper = True

    if use_gripper:
        gripper_action_name = "gripper_controller/gripper_action"
        gripper_client = SimpleActionClient(gripper_action_name, GripperCommandAction)
        if not gripper_client.wait_for_server(timeout=rospy.Duration.from_sec(60.0)):
            rospy.logerr(f"Couldn't find ROS action server '{gripper_action_name}' in time!")
            sys.exit(1)

    # Ensure that the move group expects poses in Spot's body frame
    ref_frame_before = move_group.get_pose_reference_frame()
    rospy.loginfo(f"Move group '{group_name}' has reference frame: {ref_frame_before}")

    body_frame_name = "body"
    move_group.set_pose_reference_frame(body_frame_name)

    ref_frame_after = move_group.get_pose_reference_frame()

    rospy.loginfo(f"Move group '{group_name}' has reference frame: {ref_frame_after}")

    ### Define the path we'll move Spot's end-effector back-and-forth along ###

    # Reference: Spot + Spot Arm Information for Use (v1.0) (pg. 17-18)
    forward_m = 0.5  # Average distance forward (meters) in Spot's body frame
    x_variation_m = 0.05  # Offset (m) forward/backward the path varies over

    # Set path's center as farther forward than its endpoints (so it's non-linear)
    center_x_m = forward_m + x_variation_m  # Push "forward" along x
    endpoint_x_m = forward_m - x_variation_m  # Pull "back" along x

    to_side_m = 0.6  # Maximum extent of the end-effector to the side (meters)

    z_in_body_frame = 0.35  # Path's z in body frame (meters)

    # Specify end-effector (ee) target poses in Spot's body frame
    # Assume: Spot may begin at an arbitrary (x,y) location in the global frame
    left_ee_pose = create_pose((endpoint_x_m, to_side_m, z_in_body_frame))
    center_ee_pose = create_pose((center_x_m, 0, z_in_body_frame))
    right_ee_pose = create_pose((endpoint_x_m, -to_side_m, z_in_body_frame))

    cycle_target_poses = [center_ee_pose, left_ee_pose, center_ee_pose, right_ee_pose]
    cycle_gripper_angles = [-np.pi / 2.0, -np.pi / 4.0, -np.pi / 8.0, 0]
    target_idx = 0

    rospy.loginfo(f"List of target poses to cycle through: {cycle_target_poses}")

    ### Begin alternating Spot's arm between the target poses ###

    switch_hz = 0.2  # Shift end-effector pose every 5 seconds
    rate = rospy.Rate(switch_hz)

    while not rospy.is_shutdown():
        curr_target_pose = cycle_target_poses[target_idx]
        stamped_target_pose = stamp_pose(curr_target_pose, body_frame_name)
        target_pose_publisher.publish(stamped_target_pose)

        rospy.loginfo(f"Planning to pose:\n{stamped_target_pose}...")

        # Plan and move Spot's arm to the current target pose
        move_group.set_pose_target(curr_target_pose)
        success, trajectory, _, error = move_group.plan()
        move_group.clear_pose_targets()  # Clear pose targets after planning

        if success:  # If planning succeeded, execute the planned trajectory
            move_group.execute(trajectory, wait=True)  # Blocks until done
            move_group.stop()  # Ensure there's no residual movement
        else:
            rospy.loginfo(f"Planning failed with error {error}!")

        if use_gripper:
            # Cycle Spot's gripper to the next target position in the list
            gripper_goal_msg = GripperCommandGoal()
            gripper_goal_msg.command.position = cycle_gripper_angles[target_idx]

            goal_state = gripper_client.send_goal_and_wait(
                gripper_goal_msg,
                execute_timeout=rospy.Duration.from_sec(10.0),
            )
            rospy.loginfo(f"Type of goal_state: {type(goal_state)}")

        target_idx = (target_idx + 1) % len(cycle_target_poses)

        rate.sleep()  # Wait long enough to produce the specified rate (0.2 Hz)


if __name__ == "__main__":
    main()
