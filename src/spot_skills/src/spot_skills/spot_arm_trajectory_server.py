"""Define an action server to control Spot's arm to follow a trajectory.

This server provides the control_msgs/FollowJointTrajectory Action for Spot's arm.
"""

import time

from actionlib import SimpleActionServer
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryActionGoal,
)
from rospy import loginfo

from spot_skills.spot_arm_controller import SpotArmController


class SpotArmTrajectoryServer:
    """An action server that controls Spot's arm to follow a trajectory."""

    def __init__(
        self, action_name: str, hostname: str, max_command_duration_s: float
    ) -> None:
        """Initialize the FollowJointTrajectory server for Spot's arm.

        We specify max_command_duration_s for safety purposes, so that long-lived
            trajectories won't continue should the client side go down.

        :param      action_name                 Name of the action server
        :param      hostname                    DNS name or IP literal of the Spot
        :param      max_command_duration_s      Maximum duration (sec) of Spot commands
        """
        self._action_name = action_name
        self._action_server = SimpleActionServer(
            self._action_name,
            FollowJointTrajectoryAction,
            execute_cb=self.execute_callback,
            auto_start=False,
        )
        self._action_server.start()
        loginfo(f"{self._action_name}: Action server has started")

        hostname = "123.12345"  # TODO - Pass in an actual hostname for Spot!
        self._arm_controller = SpotArmController(hostname)

        self._max_command_duration_s = max_command_duration_s

        # TODO - Do we need a self._result or self._feedback?

    def execute_callback(self, goal: FollowJointTrajectoryActionGoal) -> None:
        """Execute the action, given a new trajectory goal.

        :param      goal        Joint trajectory to be followed
        """
        num_points = len(goal.trajectory.points)
        first_timestep = goal.trajectory.points[0].time_from_start
        last_timestep = goal.trajectory.points[-1].time_from_start

        loginfo(
            f"{self._action_name}: Received trajectory with {num_points} points, "
            + f"lasting {last_timestep - first_timestep} seconds in total."
        )

        with self._arm_controller.get_lease_keeper():
            # TODO - Assumes the robot is powered on, standing, with arm deployed
            # TODO - Should we verify that the arm began nearby the first point?

            reference_time = self._arm_controller.reset_reference_time()
            goal_reached = False  # TODO - Evaluate here!
            canceled = False  # Has the client preempted this trajectory goal?

            # We'll publish segments of the trajectory, starting from the initial point
            #   and on subsequent loops starting from the next future point
            start_idx = 0  # Index of the first point in the next segment

            while not goal_reached and not canceled:
                # Check that the client hasn't preempted (i.e., canceled) the goal
                if self._action_server.is_preempt_requested():
                    loginfo(f"{self._action_name}: Preempted")
                    self._action_server.set_preempted()
                    canceled = True
                    break

                # Find the last point in the trajectory segment within the max duration
                start_point = goal.trajectory.points[start_idx]
                start_time = start_point.time_from_start  # Relative w/in trajectory
                end_time = start_time + self._max_command_duration_s  # Relative

                curr_end_idx = start_idx  # We'll increment this along the trajectory

                while (
                    goal.trajectory.points[curr_end_idx].time_from_start < end_time
                    and curr_end_idx < num_points
                ):
                    curr_end_idx += 1
                real_end_idx = max(curr_end_idx - 1, start_idx)
                real_end_time = goal.trajectory.points[real_end_idx].time_from_start

                trajectory_segment = goal.trajectory.points[
                    start_idx : real_end_idx + 1
                ]

                loginfo(
                    f"{self._action_name}: Executing trajectory segment of length "
                    + f"{len(trajectory_segment)} between {start_time} and "
                    + f"{real_end_time} seconds into the overall trajectory."
                )

                self._arm_controller.command_trajectory(trajectory_segment)

                # Wait until a bit before the sent trajectory is set to expire
                before_expire_s = 1.5
                segment_expires = reference_time + real_end_time - before_expire_s
                sleep_duration_s = segment_expires - time.time()
                if sleep_duration_s > 0:
                    time.sleep(sleep_duration_s)

                # Begin the next trajectory from the last point in this one
                start_idx = real_end_idx

            # TODO - We don't stow the arm or power off the robot
