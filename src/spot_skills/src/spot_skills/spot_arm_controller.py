"""Define a class to control Spot's arm using the Spot SDK."""

from __future__ import annotations

import time
from enum import Enum
from typing import TYPE_CHECKING

from bosdyn.client import robot_command
from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import duration_to_seconds

from spot_skills.time_stamp import TimeStamp

if TYPE_CHECKING:
    from actionlib import SimpleActionServer
    from bosdyn.api.robot_command_pb2 import RobotCommand

    from spot_skills.joint_trajectory import JointTrajectory
    from spot_skills.spot_manager import SpotManager


class ArmCommandOutcome(Enum):
    """Enumerates the possible outcomes from a trajectory command for Spot's arm."""

    INVALID_START = -1  # Indicates that the command didn't begin where Spot's arm is
    SUCCESS = 0  # Indicates successful trajectory execution
    PREEMPTED = 1  # Indicates that the ROS action client canceled the trajectory


class SpotArmController:
    """A wrapper to control Spot's arm using the Spot SDK."""

    def __init__(self, spot_manager: SpotManager, max_segment_len: int = 250):
        """Initialize the controller for Spot's arm using a manager for Spot.

        :param    spot_manager        Manager of the connection to the Spot
        :param    max_segment_len     Maximum number of points in any sent trajectory
        """
        assert spot_manager.has_arm(), "Cannot control Spot's arm if Spot has no arm!"

        # Ensure we can control Spot, and that Spot is powered on
        self._manager = spot_manager
        self._manager.take_control()

        # Declare member variable to store the ID of the most recent robot command
        self._command_id: int | None = None

        # Define the maximum number of points in any sent trajectory segment
        self.max_segment_len = min(max_segment_len, 250)  # Ensure limit is <= 250

        # Define angle (radians) within which two angles are considered identical
        self.angle_proximity_rad = 0.005

    def send_segment_command(self, command: RobotCommand) -> None:
        """Command Spot to execute a trajectory segment, given as a robot command.

        :param      command     Robot command containing a short trajectory segment
        """
        trajectory_proto = (
            command.synchronized_command.arm_command.arm_joint_move_command.trajectory
        )  # An ArmJointTrajectory

        points_proto = trajectory_proto.points
        len_points = len(points_proto)

        assert len_points <= self.max_segment_len, "Segment too long!"

        # Log useful information about the trajectory segment to be sent

        self._manager.log_info(f"Sending trajectory segment of length {len_points}...")

        # Find the reference time (seconds) for the trajectory
        ref_timestamp = TimeStamp.from_proto(trajectory_proto.reference_time)

        ref_time_s = ref_timestamp.to_time_s()
        self._manager.log_info(f"Segment reference time: {ref_time_s:.2f} seconds.")

        first_rel_time_s = duration_to_seconds(points_proto[0].time_since_reference)
        last_rel_time_s = duration_to_seconds(points_proto[-1].time_since_reference)

        self._manager.log_info(
            f"First relative time in segment: {first_rel_time_s:.2f} seconds.",
        )
        self._manager.log_info(
            f"Last relative time in segment: {last_rel_time_s:.2f} seconds.",
        )

        duration_s = last_rel_time_s - first_rel_time_s
        self._manager.log_info(f"Total segment duration: {duration_s:.2f} seconds.")

        self._manager.log_info(f"Local clock time: {time.time():.2f} seconds.")

        # Wait to send the segment until close to when it starts
        send_early_s = 5 * self._manager.time_sync.max_round_trip_s + 0.5

        self._manager.log_info(
            f"Want to send the segment {send_early_s:.4f} seconds early...",
        )

        segment_start_time_s = ref_time_s + first_rel_time_s
        self._manager.log_info(
            f"Segment start time: {segment_start_time_s:.2f} seconds.",
        )

        self._manager.log_info(f"Local clock time: {time.time():.2f} seconds.")

        segment_starts_in_s = segment_start_time_s - time.time()
        self._manager.log_info(f"Segment starts in: {segment_starts_in_s:.2f} seconds.")

        if segment_starts_in_s > send_early_s:
            spare_time_s = segment_starts_in_s - send_early_s
            self._manager.log_info(f"We have {spare_time_s:.4f} spare seconds...")

            # Re-sync with Spot, if there's time to spare
            if spare_time_s > 2 * self._manager.time_sync.max_sync_time_s:
                self._manager.log_info("Re-time-syncing with Spot...")
                self._manager.resync_and_log()

            # Sleep for any remaining time, if necessary
            self._manager.log_info(f"Local clock time: {time.time():.2f} seconds.")

            segment_starts_in_s = segment_start_time_s - time.time()

            self._manager.log_info(
                f"Segment starts in: {segment_starts_in_s:.2f} seconds.",
            )

            if segment_starts_in_s > send_early_s:
                spare_time_s = segment_starts_in_s - send_early_s
                self._manager.log_info(f"Sleeping for {spare_time_s:.4f} seconds...")

                time.sleep(spare_time_s)

        self._manager.log_info("Done waiting to send this trajectory segment.")
        self._manager.log_info(f"Local clock time: {time.time():.2f} seconds.")

        self._command_id = self._manager.send_robot_command(command)
        self._manager.log_info("Trajectory segment sent.\n")

    def command_trajectory(
        self,
        trajectory: JointTrajectory,
        action_server: SimpleActionServer | None = None,
    ) -> ArmCommandOutcome:
        """Command Spot's arm to execute the given joint trajectory.

        We can only send a maximum of 250 points at a time (per Spot SDK). Therefore,
            we create "segments" of any trajectories longer than this limit.

        If Spot's arm is not sufficiently close to the starting configuration, the
            trajectory is considered invalid and will not be executed.

        The action server, if provided, is used to check whether the trajectory request
            has been "preempted" (i.e., canceled) by the requesting client.

        :param   trajectory      Trajectory of joint (position, velocity) points
        :param   action_server   Optional action server used to check for cancellation

        :returns    Enum member indicating the outcome of the command
        """
        spot_arm_state = self._manager.get_arm_state()
        self._manager.log_info(f"Spot's arm state: {spot_arm_state}\n")

        current_angles_rad = spot_arm_state.positions_rad
        command_start_angles_rad = trajectory.points[0].positions_rad

        for curr_rad, cmd_rad in zip(current_angles_rad, command_start_angles_rad):
            if abs(curr_rad - cmd_rad) > self.angle_proximity_rad:
                self._manager.log_info(
                    "Commanded trajectory doesn't begin where Spot's arm is!",
                )
                self._manager.log_info(f"Current joint angle: {curr_rad} radians.")
                self._manager.log_info(
                    f"Command initial joint angle: {cmd_rad} radians.",
                )
                return ArmCommandOutcome.INVALID_START

        robot_commands = trajectory.segment_to_robot_commands(self.max_segment_len)

        if action_server is None:  # Simpler case, where ROS can't preempt the command
            for segment_command in robot_commands:
                self.send_segment_command(segment_command)
        else:  # Use the action server to check that the trajectory is not canceled
            for segment_command in robot_commands:
                if action_server.is_preempt_requested():  # Trajectory canceled!
                    self._manager.log_info("Action has been preempted.")
                    self.block_until_arm_arrives()  # Finish the current segment
                    return ArmCommandOutcome.PREEMPTED

                # Otherwise, execute the next segment of the trajectory
                self.send_segment_command(segment_command)

        self.block_until_arm_arrives()  # Give Spot time to finish all segments

        return ArmCommandOutcome.SUCCESS

    def block_until_arm_arrives(self) -> None:
        """Block until Spot's arm arrives at the current command ID's goal."""
        self._manager.log_info("Blocking until arm arrives...")
        robot_command.block_until_arm_arrives(
            self._manager.command_client,
            self._command_id,
        )
        time.sleep(0.5)
        self._manager.log_info("Done blocking.\n")

    def deploy_arm(self) -> None:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed."""
        self._manager.log_info("Deploying Spot's arm to the 'ready' position...")
        arm_ready = RobotCommandBuilder.arm_ready_command()
        self._command_id = self._manager.send_robot_command(arm_ready)
        self.block_until_arm_arrives()
        self._manager.log_info("Arm is now ready.")

    def stow_arm(self) -> None:
        """Stow Spot's arm and wait until the arm has finished stowing."""
        self._manager.log_info("Stowing Spot's arm...")
        arm_stow = RobotCommandBuilder.arm_stow_command()
        self._command_id = self._manager.send_robot_command(arm_stow)
        self.block_until_arm_arrives()
        self._manager.log_info("Arm is now stowed.")
