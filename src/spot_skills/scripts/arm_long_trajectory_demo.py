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

from spot_skills.joint_trajectory import (
    JointTrajectory,
    JointTrajectoryPoint,
    TimeStamp,
)
from spot_skills.spot_arm_controller import SpotArmController
from spot_skills.spot_manager import SpotManager

RUN_TIME_S = 20  # Duration (seconds) to run our trajectory for

TRAJ_APPROACH_TIME_S = 1.0  # Time (seconds) to move from "ready" to trajectory start


def query_trajectory(t_s: float) -> JointTrajectoryPoint:
    """Compute the trajectory knot point for the given timestep (seconds).

    :param      t_s     Time (seconds) from the trajectory start

    :returns    JointTrajectoryPoint representing the requested knot point
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
    return JointTrajectoryPoint(joint_positions, joint_velocities, t_s)


def main():
    """Use the Boston Dynamics API to command Spot's arm through a long trajectory."""
    rospy.init_node("arm_long_trajectory_demo")

    # Access Spot's IP from the ROS parameters
    spot_hostname = None
    if rospy.has_param("/spot/hostname"):
        spot_hostname = rospy.get_param("/spot/hostname")
    assert spot_hostname is not None, "Cannot connect to Spot without its hostname!"

    # Create a manager for Spot and a controller for Spot's arm
    sdk_client_name = "ArmJointLongTrajectoryClient"
    spot_manager = SpotManager(sdk_client_name, spot_hostname)
    arm_controller = SpotArmController(spot_manager)

    # By now, Spot should be powered on and controllable
    arm_controller.deploy_arm()

    ### Compute the full trajectory to be executed on Spot's arm ###
    dt_s = 0.2  # Timestep (seconds)
    relative_t_s = 0  # Relative time (seconds) since trajectory started

    full_trajectory_times_s = []
    while relative_t_s <= RUN_TIME_S:
        full_trajectory_times_s.append(relative_t_s)
        relative_t_s += dt_s

    trajectory_points = [query_trajectory(t_s) for t_s in full_trajectory_times_s]

    # Define the full trajectory (reference time to be set later)
    full_trajectory = JointTrajectory(None, trajectory_points)

    ### Define an approach trajectory to bring Spot's arm to the trajectory start ###
    point_0 = query_trajectory(0)
    point_0.time_from_start_s = TRAJ_APPROACH_TIME_S  # Take some time to approach

    start_time_s = time.time()
    ref_timestamp = TimeStamp.from_time_s(start_time_s)

    approach_trajectory = JointTrajectory(ref_timestamp, [point_0])
    arm_controller.command_trajectory(approach_trajectory)

    ### Update the real trajectory's start time based on the approach trajectory ###
    start_time_s = start_time_s + TRAJ_APPROACH_TIME_S  # End of last trajectory

    full_trajectory.reference_timestamp = TimeStamp.from_time_s(start_time_s)
    arm_controller.command_trajectory(full_trajectory)

    # We're done executing our trajectory, so stow the arm
    arm_controller.stow_arm()

    # Power off the robot safely using a "safe power off" command
    spot_manager.safely_power_off()

    rospy.loginfo("Finished running the long joint trajectory.")
    rospy.spin()  # Keep the node alive for debugging purposes


if __name__ == "__main__":
    if not main():
        sys.exit(1)
