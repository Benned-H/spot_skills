"""Define a class to control Spot's arm using the Spot SDK."""

import time

from bosdyn.client import robot_command
from bosdyn.client.robot_command import RobotCommandBuilder

from spot_skills.joint_trajectory import JointTrajectory
from spot_skills.spot_manager import SpotManager


class SpotArmController:
    """A wrapper to control Spot's arm using the Spot SDK."""

    def __init__(self, spot_manager: SpotManager):
        """Initialize the controller for Spot's arm using a manager for Spot.

        :param    spot_manager    Manager of the connection to the Spot
        """
        assert spot_manager.has_arm(), "Cannot control Spot's arm if Spot has no arm!"

        # Ensure we can control Spot, and that Spot is powered on
        self._spot_manager = spot_manager
        self._spot_manager.take_control()

        # Establish member variables to store data about the most-recent trajectory
        self._last_command_id = None  # ID of the most recent robot command to Spot
        self._last_trajectory = None  # Most recent trajectory sent to Spot

        # Default: Send the maximum number of points at a time (250, per Spot SDK)
        self.max_segment_len = 250

    def send_trajectory_segment(self, segment: JointTrajectory) -> None:
        """Command Spot to execute the given trajectory segment *all at once*.

        :param      segment     Short trajectory over joint positions/velocities/times
        """
        assert len(segment) <= self.max_segment_len, "Segment too long!"

        # Wait to send the segment until within 5 seconds of its start
        wait_until_before_s = 5.0

        segment_starts_in_s = segment.reference_timestamp.to_time_s() - time.time()
        if segment_starts_in_s > wait_until_before_s:
            time.sleep(segment_starts_in_s - wait_until_before_s)

        robot_command = segment.to_robot_command()
        self._command_id = self._spot_manager.send_robot_command(robot_command)
        self._last_trajectory = segment

    def command_trajectory(self, trajectory: JointTrajectory) -> None:
        """Command Spot to execute the given joint trajectory.

        We can only send a maximum of 250 points at a time (per Spot SDK). Therefore,
            we create "segments" of any trajectories longer than this limit.

        :param    trajectory    Trajectory of joint (position, velocity) points
        """
        if len(trajectory.points) <= self.points_per_segment:  # If short enough,
            self.send_trajectory_segment(trajectory)  # send all at once
            return

        # Otherwise, we need to segment the trajectory. We'll create continuity by
        #   setting the first point of each segment to the last point of the previous

        start_idx = 0  # Both indices are inclusive
        end_idx = min(start_idx + self.max_segment_len, len(trajectory)) - 1

        sent_last_point = False  # Stop once we've sent a segment at trajectory's end

        while not sent_last_point:
            segment_points = trajectory.points[start_idx : end_idx + 1]
            segment = JointTrajectory(trajectory.reference_timestamp, segment_points)
            self.send_trajectory_segment(segment)

            if end_idx == len(trajectory) - 1:
                sent_last_point = True

            # Find indices for the next segment, which begins where the last ended
            start_idx = end_idx  # Recall: both are inclusive
            end_idx = min(start_idx + self.max_segment_len, len(trajectory)) - 1

    def block_until_arm_arrives(self) -> None:
        """Block until Spot's arm arrives at the current command ID's goal."""
        robot_command.block_until_arm_arrives(
            self._spot_manager.command_client,
            self._command_id,
        )

    def deploy_arm(self) -> None:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed."""
        arm_ready = RobotCommandBuilder.arm_ready_command()
        self._command_id = self._spot_manager.send_robot_command(arm_ready)
        self.block_until_arm_arrives()

    def stow_arm(self) -> None:
        """Stow Spot's arm and wait until the arm has finished stowing."""
        arm_stow = RobotCommandBuilder.arm_stow_command()
        self._command_id = self._spot_manager.send_robot_command(arm_stow)
        self.block_until_arm_arrives()
