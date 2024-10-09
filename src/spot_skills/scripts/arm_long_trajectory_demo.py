#!/usr/bin/env python

"""Modified from a Spot SDK example showing how to use Spot's arm.

Copyright (c) 2023 Boston Dynamics, Inc.  All rights reserved.

Downloading, reproducing, distributing or otherwise using the SDK Software
is subject to the terms and conditions of the Boston Dynamics Software
Development Kit License (20191101-BDSDK-SL).
"""

from __future__ import annotations

import math
import sys
import time

import rospy

from spot_skills.joint_trajectory import JointsPoint, JointTrajectory
from spot_skills.spot_arm_controller import SpotArmController
from spot_skills.spot_manager import SpotManager
from spot_skills.time_stamp import TimeStamp

RUN_TIME_S = 20  # Duration (seconds) to run our trajectory for

TRAJ_APPROACH_TIME_S = 2.0  # Time (seconds) to move from "ready" to trajectory start


def query_trajectory(t_s: float) -> JointsPoint:
    """Compute the trajectory knot point for the given timestep (seconds).

    :param      t_s     Time (seconds) from the trajectory start

    :returns    JointsPoint representing the requested knot point
    """
    # Move our arm joint poses around a nominal pose
    nominal_pose = [0, -0.9, 1.8, 0, -0.9, 0]

    # Nominal oscillation period in seconds
    T = 5.0
    w = 2 * math.pi / T

    joint_positions = nominal_pose
    # Have a few of our joints oscillate
    joint_positions[0] = nominal_pose[0] + 0.8 * math.cos(w * t_s)
    joint_positions[2] = nominal_pose[2] + 0.2 * math.sin(2 * w * t_s)
    joint_positions[4] = nominal_pose[4] + 0.5 * math.sin(2 * w * t_s)
    joint_positions[5] = nominal_pose[5] + 1.0 * math.cos(4 * w * t_s)

    # Take the derivative of our position trajectory to get our velocities
    joint_velocities: list[float] = [0, 0, 0, 0, 0, 0]
    joint_velocities[0] = -0.8 * w * math.sin(w * t_s)
    joint_velocities[2] = 0.2 * 2 * w * math.cos(2 * w * t_s)
    joint_velocities[4] = 0.5 * 2 * w * math.cos(2 * w * t_s)
    joint_velocities[5] = -1.0 * 4 * w * math.sin(4 * w * t_s)

    # Return the joint positions and velocities at time t in our trajectory
    return JointsPoint(joint_positions, joint_velocities, t_s)


def main():
    """Use the Boston Dynamics API to command Spot's arm through a long trajectory."""
    rospy.init_node("arm_long_trajectory_demo")

    # Attempt to load Spot's username, password, and IP from ROS parameters
    spot_username = None
    username_param = "/spot/username"
    if rospy.has_param(username_param):
        spot_username = rospy.get_param(username_param)
    assert spot_username is not None, "Cannot connect to Spot without a username!"

    spot_password = None
    password_param = "/spot/password"
    if rospy.has_param(password_param):
        spot_password = rospy.get_param(password_param)
    assert spot_password is not None, "Cannot connect to Spot without a password!"

    spot_hostname = None
    hostname_param = "/spot/hostname"
    if rospy.has_param(hostname_param):
        spot_hostname = rospy.get_param(hostname_param)
    assert spot_hostname is not None, "Cannot connect to Spot without its hostname!"

    # Create a manager for Spot and a controller for Spot's arm
    sdk_client_name = "ArmJointLongTrajectoryClient"
    spot_manager = SpotManager(
        sdk_client_name,
        spot_hostname,
        spot_username,
        spot_password,
    )
    arm_controller = SpotArmController(spot_manager)

    # By now, Spot should be powered on and controllable
    spot_manager.stand_up(20)
    arm_controller.deploy_arm()

    # Compute the full trajectory to be executed on Spot's arm
    dt_s = 0.2  # Timestep (seconds)
    relative_t_s = 0  # Relative time (seconds) since trajectory started

    full_trajectory_times_s = []
    while relative_t_s <= RUN_TIME_S:
        full_trajectory_times_s.append(relative_t_s)
        relative_t_s += dt_s

    trajectory_points = [query_trajectory(t_s) for t_s in full_trajectory_times_s]

    # Create an "approaching" point so Spot's arm has time to reach the trajectory
    current_point: JointsPoint = spot_manager.get_arm_state()
    current_point.time_from_start_s = 0  # Begin from where we are at t = 0

    # Offset the full trajectory's relative times based on the approach duration
    for point in trajectory_points:
        point.time_from_start_s += TRAJ_APPROACH_TIME_S

    full_trajectory_points = [current_point, *trajectory_points]

    # Re-sync the local and robot time (helps us learn how long syncing takes)
    spot_manager.resync_and_log_info()

    # Set the full trajectory to begin in the future
    future_proof_s = 1.0  # Offset duration (seconds) into the future
    start_time_s = time.time() + future_proof_s
    ref_timestamp = TimeStamp.from_time_s(start_time_s)

    # Create and send the full trajectory
    full_trajectory = JointTrajectory(ref_timestamp, full_trajectory_points)
    arm_controller.command_trajectory(full_trajectory)

    # We're done executing our trajectory, so stow the arm
    arm_controller.stow_arm()

    # Send a "safe power off" command, then return Spot's lease
    spot_manager.safely_power_off()
    spot_manager.release_control()

    rospy.loginfo("Finished running the long joint trajectory.")
    rospy.spin()  # Keep the node alive for debugging purposes


if __name__ == "__main__":
    if not main():
        sys.exit(1)
