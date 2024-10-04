"""Define a class to control Spot's arm using the Spot SDK."""

import time
from typing import TYPE_CHECKING

from bosdyn.api.robot_command_pb2 import RobotCommand
from bosdyn.client import robot_command
from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import duration_to_seconds

from spot_skills.joint_trajectory import JointTrajectory, TimeStamp
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

        # Default: Send the maximum number of points at a time (250, per Spot SDK)
        self.max_segment_len = 10  # TODO: Raise back to 250

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
        ref_time_s = TimeStamp.from_proto(trajectory_proto.reference_time).to_time_s()

        assert len(points_proto) <= self.max_segment_len, "Segment too long!"

        # TODO (DELETE ME): Length of trajectory? First time? Absolute reference?
        log_message = f"Sending trajectory segment of length {len(points_proto)}..."
        self._spot_manager.log_info(log_message)

        log_message = f"Segment reference time: {ref_time_s:.2f} seconds."
        self._spot_manager.log_info(log_message)

        first_rel_time_s = duration_to_seconds(points_proto[0].time_since_reference)
        last_rel_time_s = duration_to_seconds(points_proto[-1].time_since_reference)

        log_message = f"First relative time in segment: {first_rel_time_s} seconds."
        self._spot_manager.log_info(log_message)
        log_message = f"Last relative time in segment: {last_rel_time_s} seconds."
        self._spot_manager.log_info(log_message)

        self._spot_manager.log_info(f"time.time() check: {time.time():.2f}\n\n")

        # Wait to send the segment until close to when it starts
        round_trip_s = self._spot_manager.get_round_trip_s()

        wait_until_before_s = round_trip_s * 0.7

        segment_start_time_s = ref_time_s + first_rel_time_s

        segment_starts_in_s = segment_start_time_s - time.time()
        if segment_starts_in_s > wait_until_before_s:
            time.sleep(segment_starts_in_s - wait_until_before_s)

        self._command_id = self._spot_manager.send_robot_command(command)
        self._spot_manager.log_info("Trajectory segment sent.")

    def command_trajectory(self, trajectory: JointTrajectory) -> bool:
        """Command Spot to execute the given joint trajectory.

        We can only send a maximum of 250 points at a time (per Spot SDK). Therefore,
            we create "segments" of any trajectories longer than this limit.

        If Spot's arm is not sufficiently close to the starting configuration, the
            trajectory is considered invalid and will not be executed.

        :param    trajectory    Trajectory of joint (position, velocity) points

        :returns    Boolean: Was the trajectory executed (True) or not (False)?
        """
        spot_arm_state = self._spot_manager.get_arm_state()
        self._spot_manager.log_info(f"Spot's arm state: {spot_arm_state}")

        current_angles_rad = spot_arm_state.positions_rad
        command_start_angles_rad = trajectory.points[0].positions_rad

        for curr_rad, cmd_rad in zip(current_angles_rad, command_start_angles_rad):
            if abs(curr_rad - cmd_rad) > self.angle_proximity_rad:
                log_message = "Commanded trajectory doesn't begin where Spot's arm is!"
                self._spot_manager.log_info(log_message)
                self._spot_manager.log_info(f"Current joint angle: {curr_rad}")
                self._spot_manager.log_info(f"Command initial joint angle: {cmd_rad}")
                return False

        robot_commands = trajectory.segment_to_robot_commands(self.max_segment_len)

        for segment_command in robot_commands:
            self.send_segment_command(segment_command)

        self.block_until_arm_arrives()  # Give Spot time to finish all segments

        return True

    def block_until_arm_arrives(self) -> None:
        """Block until Spot's arm arrives at the current command ID's goal."""
        self._spot_manager.log_info("Blocking until arm arrives...")
        robot_command.block_until_arm_arrives(
            self._spot_manager.command_client,
            self._command_id,
        )
        time.sleep(0.5)
        self._spot_manager.log_info("Done blocking.")

    def deploy_arm(self) -> None:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed."""
        self._spot_manager.log_info("Deploying Spot's arm to the 'ready' position...")
        arm_ready = RobotCommandBuilder.arm_ready_command()
        self._command_id = self._spot_manager.send_robot_command(arm_ready)
        self.block_until_arm_arrives()

    def stow_arm(self) -> None:
        """Stow Spot's arm and wait until the arm has finished stowing."""
        self._spot_manager.log_info("Stowing Spot's arm...")
        arm_stow = RobotCommandBuilder.arm_stow_command()
        self._command_id = self._spot_manager.send_robot_command(arm_stow)
        self.block_until_arm_arrives()
