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

# Amount of time in seconds to take to move from the "POSITIONS_READY"
# pose to the start of our trajectory
TRAJ_APPROACH_TIME_S = 1.0


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

    # Define the reference start time for the initial trajectory
    start_time_s = time.time()
    ref_timestamp = TimeStamp.from_time_s(start_time_s)

    # To ensure the trajectory runs smoothly, move to its initial position and velocity
    point_0 = query_trajectory(0)
    point_0.time_from_start_s = TRAJ_APPROACH_TIME_S  # Take some time to reach start

    joint_names = ["sh0", "sh1", "el0", "el1", "wr0", "wr1"]
    go_to_point_0 = JointTrajectory(joint_names, ref_timestamp, [point_0])

    arm_controller.command_trajectory(go_to_point_0)

    # Update the real trajectory's start time using TRAJ_APPROACH_TIME_S
    start_time_s = start_time_s + TRAJ_APPROACH_TIME_S
    ref_timestamp = TimeStamp.from_time_s(start_time_s)

    # We'll send 250 points at a time (the maximum allowed value)
    points_per_segment = 250

    # We'll create seamless continuity by setting the first point of each next message
    #   equal to the last point in the previous message. General idea will scale!
    segment_start_s = 0  # Segment's start time (seconds relative to ref_timestamp)
    dt_s = 0.2  # Timestep size (seconds)

    # Every trajectory segment will have the same relative timesteps (in seconds)
    relative_segment_t_s = [step * dt_s for step in range(points_per_segment)]

    # Run until we've completed the desired duration of movement
    while time.time() - start_time_s < RUN_TIME_S:
        # Compute the knot points for this segment of trajectory
        knot_points = [
            query_trajectory(segment_start_s + t_s) for t_s in relative_segment_t_s
        ]

        # Convert the points into a JointTrajectory
        trajectory_segment = JointTrajectory(joint_names, ref_timestamp, knot_points)

        # Wait until a bit before the previous segment is going to expire, then send
        segment_starts_in_s = start_time_s + segment_start_s - time.time()
        sleep_time_s = segment_starts_in_s - (0.75 * dt_s)  # "a bit before"
        if sleep_time_s > 0:
            time.sleep(sleep_time_s)

        arm_controller.command_trajectory(trajectory_segment)

        # Start the next segment at the same point where the last segment ended
        segment_start_s = segment_start_s + dt_s * (points_per_segment - 1)

    # We're done executing our trajectory, so stow the arm
    arm_controller.stow_arm()

    # Power off the robot safely using a "safe power off" command
    spot_manager.safely_power_off()

    rospy.loginfo("Finished running the long joint trajectory.")
    rospy.spin()  # Keep the node alive for debugging purposes


if __name__ == "__main__":
    if not main():
        sys.exit(1)
