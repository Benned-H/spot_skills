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
from spot_skills_py.joint_trajectory import JointsPoint, JointTrajectory
from spot_skills_py.ros_utilities import get_ros_param
from spot_skills_py.spot_arm_controller import SpotArmController
from spot_skills_py.spot_manager import SpotManager
from spot_skills_py.time_stamp import TimeStamp

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


def main() -> None:
    """Use the Boston Dynamics API to command Spot's arm through a long trajectory."""
    rospy.init_node("arm_long_trajectory_demo")

    # Attempt to load Spot's username, password, and IP from ROS parameters
    spot_rosparams = ["/spot/username", "/spot/password", "/spot/hostname"]
    spot_rosparam_values = [get_ros_param(param) for param in spot_rosparams]
    spot_username, spot_password, spot_hostname = spot_rosparam_values

    # Create a manager for Spot and a controller for Spot's arm
    sdk_client_name = "ArmJointLongTrajectoryClient"
    spot_manager = SpotManager(
        sdk_client_name,
        spot_hostname,
        spot_username,
        spot_password,
    )
    arm_controller = SpotArmController(spot_manager, 30)  # Limit to 30 points/segment

    # By now, Spot should be powered on and controllable
    spot_manager.take_control()
    assert spot_manager.stand_up(20)
    assert spot_manager.deploy_arm()

    # Compute the full trajectory to be executed on Spot's arm
    dt_s = 0.2  # Timestep (seconds)
    relative_t_s = 0.0  # Relative time (seconds) since trajectory started

    full_trajectory_times_s = []
    while relative_t_s <= RUN_TIME_S:
        full_trajectory_times_s.append(relative_t_s)
        relative_t_s += dt_s

    trajectory_points = [query_trajectory(t_s) for t_s in full_trajectory_times_s]

    # Create an "approaching" point to bring Spot's arm to the trajectory's start
    current_arm_config = spot_manager.get_arm_configuration()
    current_arm_state = JointsPoint.from_configuration(current_arm_config)
    current_arm_state.time_from_start_s = 0  # Begin approach (t = 0) from where arm is

    # Offset the full trajectory's relative times based on the approach duration
    for point in trajectory_points:
        point.time_from_start_s += TRAJ_APPROACH_TIME_S

    full_trajectory_points = [current_arm_state, *trajectory_points]

    # Re-sync the local/robot time (provides initial estimate of time-sync duration)
    spot_manager.resync_and_log()

    # Set the full trajectory to begin in the future
    future_proof_s = 1.0  # Offset duration (seconds) into the future
    start_time_s = time.time() + future_proof_s
    ref_timestamp = TimeStamp.from_time_s(start_time_s)

    # Create and send the full trajectory
    full_trajectory = JointTrajectory(ref_timestamp, full_trajectory_points)
    arm_controller.unlock_arm()
    arm_controller.command_trajectory(full_trajectory)

    spot_manager.shutdown()  # We're done executing our trajectory, so we can shut down Spot

    rospy.loginfo("Finished running the long joint trajectory.")
    rospy.spin()  # Keep the node alive for debugging purposes


if __name__ == "__main__":
    main()
