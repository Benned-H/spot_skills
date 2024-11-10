#!/usr/bin/env python

"""Generate motion plans for Spot's arm using MoveIt."""

import sys

import geometry_msgs.msg
import moveit_commander
import moveit_msgs.msg
import rospy

from spot_skills.make_geometry_msgs import create_pose, stamp_pose


def main() -> None:
    """Use MoveIt to generate motion plans to be executed on Spot's arm."""
    ### Set up MoveIt and the 'arm' move group used to control Spot's arm ###
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("moveit_plan_generator")

    # RobotCommander Reference: https://tinyurl.com/noetic-robot-commander
    robot = moveit_commander.RobotCommander()
    curr_state = robot.get_current_state()
    rospy.loginfo(f"Current robot state: {curr_state}")

    scene = moveit_commander.PlanningSceneInterface()

    # Create a publisher to display target poses in RViz
    target_pose_publisher = rospy.Publisher(
        "end_effector_target_pose",
        geometry_msgs.msg.PoseStamped,
        queue_size=1,
    )

    # MoveGroupCommander Reference: https://tinyurl.com/move-group-commander
    group_name = "arm"
    move_group = moveit_commander.MoveGroupCommander(group_name, wait_for_servers=180)

    # Ensure that the move group expects poses in Spot's body frame
    ref_frame_before = move_group.get_pose_reference_frame()
    rospy.loginfo(f"Move group '{group_name}' has reference frame: {ref_frame_before}")

    body_frame_name = "body"
    move_group.set_pose_reference_frame(body_frame_name)

    ref_frame_after = move_group.get_pose_reference_frame()

    rospy.loginfo(f"Move group '{group_name}' has reference frame: {ref_frame_after}")

    display_trajectory_publisher = rospy.Publisher(
        "/move_group/display_planned_path",
        moveit_msgs.msg.DisplayTrajectory,
        queue_size=20,
    )

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
    target_pose_idx = 0

    rospy.loginfo(f"List of target poses to cycle through: {cycle_target_poses}")

    ### Begin alternating Spot's arm between the target poses ###

    switch_hz = 0.1  # Shift end-effector pose every 10 seconds
    rate = rospy.Rate(switch_hz)

    while not rospy.is_shutdown():
        curr_target_pose = cycle_target_poses[target_pose_idx]
        stamped_target_pose = stamp_pose(curr_target_pose, body_frame_name)
        target_pose_publisher.publish(stamped_target_pose)

        rospy.loginfo(f"Planning to pose:\n{stamped_target_pose}...")

        # Plan and move Spot's arm to the current target pose
        move_group.set_pose_target(curr_target_pose)
        success, trajectory, _, error = move_group.plan()
        move_group.clear_pose_targets()  # Clear pose targets after planning

        display_trajectory = moveit_msgs.msg.DisplayTrajectory()
        display_trajectory.trajectory_start = robot.get_current_state()
        display_trajectory.trajectory.append(trajectory)
        display_trajectory_publisher.publish(display_trajectory)

        if success:  # If planning succeeded, execute the planned trajectory
            move_group.execute(trajectory, wait=True)  # Blocks until done
            move_group.stop()  # Ensure there's no residual movement
        else:
            rospy.loginfo(f"Planning failed with error {error}!")

        target_pose_idx = (target_pose_idx + 1) % len(cycle_target_poses)

        rate.sleep()  # Wait long enough to produce the specified rate


if __name__ == "__main__":
    main()
