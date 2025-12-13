"""Define a class to control Spot's arm using the Spot SDK."""

from __future__ import annotations

import time
from enum import IntEnum
from typing import TYPE_CHECKING

from bosdyn.client.exceptions import InvalidRequestError
from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import duration_to_seconds

from spot_skills_py.spot.spot_configuration import MAP_JOINT_NAMES_SPOT_SDK_TO_URDF
from spot_skills_py.spot.spot_force_controller import SpotForceController
from spot_skills_py.time_stamp import TimeStamp

if TYPE_CHECKING:
    from actionlib import SimpleActionServer
    from bosdyn.api.arm_command_pb2 import ArmJointTrajectory

    from spot_skills_py.joint_trajectory import JointTrajectory
    from spot_skills_py.segment_schedule import SegmentSchedule
    from spot_skills_py.spot.spot_manager import SpotManager


class ArmCommandOutcome(IntEnum):
    """Enumerates the possible outcomes from a trajectory command for Spot's arm."""

    INVALID_START = -1  # Indicates that the command didn't begin where Spot's arm is
    SUCCESS = 0  # Indicates successful trajectory execution
    PREEMPTED = 1  # Indicates that the ROS action client canceled the trajectory
    ARM_LOCKED = 2  # Indicates that the ArmController cannot yet control Spot's arm


class GripperCommandOutcome(IntEnum):
    """Enumerates the possible outcomes from a gripper command to Spot."""

    FAILURE = -1  # Indicates the command could not be completed
    REACHED_SETPOINT = 0  # Indicates that the gripper reached the commanded position
    STALLED = 1  # Indicates that the gripper is exerting max effort and not moving


class SpotArmController:
    """A wrapper for the logic used to control Spot's arm using the Spot SDK."""

    def __init__(self, spot_manager: SpotManager, max_segment_len: int = 250):
        """Initialize the controller for Spot's arm using a manager for Spot.

        :param    spot_manager        Manager of the connection to the Spot
        :param    max_segment_len     Maximum number of points in any sent trajectory
        """
        assert spot_manager.has_arm(), "Cannot control Spot's arm if Spot has no arm!"

        self._manager = spot_manager
        self.force_controller = SpotForceController(self._manager)

        # Declare member variable to store the ID of the most recent robot command
        self._command_id: int | None = None

        # Define the maximum number of points in any sent trajectory segment
        self.max_segment_len = min(max_segment_len, 250)  # Ensure limit is <= 250

        # Define angle (radians) within which two angles are considered identical
        self.angle_proximity_rad = 0.005

        # Duration (seconds) into the future by which each trajectory's start is offset
        self._future_proof_s = 1.0

        # Begin with the arm controller unable to affect Spot's arm
        self._locked = True

        self._DEBUG_MODE = False

    def unlock_arm(self) -> None:
        """Explicitly unlock Spot's arm, allowing the ArmController to control it."""
        self._locked = False

    def log_debug_info(self, schedule: SegmentSchedule, traj: ArmJointTrajectory) -> None:
        """Log debug information about the given schedule and trajectory command."""
        self._manager.log_info(f"Trajectory segment length: {len(traj.points)}")

        self._manager.log_info(
            f"Schedule local reference time: {schedule.ref_local_time_s:.3f} seconds.",
        )

        first_rel_time_s = duration_to_seconds(traj.points[0].time_since_reference)
        last_rel_time_s = duration_to_seconds(traj.points[-1].time_since_reference)

        self._manager.log_info(f"First relative time in segment: {first_rel_time_s:.3f} seconds.")
        self._manager.log_info(f"Last relative time in segment: {last_rel_time_s:.3f} seconds.")

        segment_duration_s = last_rel_time_s - first_rel_time_s
        self._manager.log_info(f"Total segment duration: {segment_duration_s:.3f} seconds.")

        self._manager.log_info(f"Local clock time: {time.time():.3f} seconds.")

    def _sleep_until(self, local_time_s: float) -> None:
        """Sleep until just before the given local time (in seconds)."""
        sleep_for_s = max(0.0, local_time_s - time.time())
        deadline_s = time.monotonic() + sleep_for_s
        while (remainder_s := deadline_s - time.monotonic()) > 0:
            time.sleep(min(remainder_s, 0.01))

    def send_segment_command(self, idx: int, schedule: SegmentSchedule, max_attempts: int) -> None:
        """Command Spot to execute the indexed trajectory segment from the given schedule.

        :param idx: Index into the schedule, corresponding to a joint trajectory segment
        :param schedule: Schedule specifying segment reference times and robot commands
        :param max_attempts: Maximum number of times to attempt (re)sending the segment
        """
        if self._locked:
            self._manager.log_info("Cannot send trajectory segment because Spot's arm is locked.")
            return

        # Validate the trajectory to be sent
        traj = schedule.commands[
            idx
        ].synchronized_command.arm_command.arm_joint_move_command.trajectory

        assert len(traj.points) > 0, "Segment has no points."
        assert len(traj.points) <= self.max_segment_len, "Segment too long!"
        assert traj.HasField("reference_time"), "Segment must have a reference_time (local time)."

        if self._DEBUG_MODE:
            self.log_debug_info(schedule, traj)

        # Wait to send the segment until close to when it starts (only on the first attempt)
        max_rtt_s = max(0.0, self._manager.time_sync.max_round_trip_s)
        cushion_s = max(0.1, 2.0 * max_rtt_s)  # Margin for network jitter
        eps_s = 0.03  # Additional margin for segment-adjusting overhead
        send_early_s = schedule.min_lead_s + cushion_s + eps_s

        if self._DEBUG_MODE:
            self._manager.log_info(f"Want to send the segment {send_early_s:.3f} seconds early...")

        send_local_s = schedule.compute_send_local_time_s(idx, send_early_s)
        self._sleep_until(send_local_s)

        # Late guard: If we're too close or late, slide the segment forward
        delta_s = schedule.slide_segment_if_late(idx, send_early_s)
        if delta_s > 0:
            self._manager.log_info(f"Late by {delta_s:.3f} seconds; shifted the schedule.")

        # Retry loop: Adjust and resend only (no sleep)
        for attempt in range(1, max_attempts + 1):
            try:
                self._command_id = self._manager.send_robot_command(schedule.commands[idx])

            except InvalidRequestError as err:  # noqa: PERF203
                attempt_num = f"{attempt}/{max_attempts}"
                self._manager.log_info(
                    f"Attempt {attempt_num} of sending a trajectory segment has failed.",
                )

                if "time point before the current robot time" not in str(err):
                    raise err

                if attempt == max_attempts:
                    self._manager.log_info("Out of attempts, exiting...")
                    raise err

                bump_s = 0.03 * (2 ** (attempt - 1))  # Minimum bump (seconds) to delay each retry

                delta_s = schedule.slide_segment_if_late(idx, send_early_s + bump_s)
                if delta_s > 0:
                    self._manager.log_info(f"Late by {delta_s:.3f} seconds; shifted the schedule.")

            else:
                self._manager.log_info("Trajectory segment sent.\n")
                return

    def command_trajectory(
        self,
        trajectory: JointTrajectory,
        action_server: SimpleActionServer | None = None,
        max_attempts: int = 5,
    ) -> ArmCommandOutcome:
        """Command Spot's arm to execute the given joint trajectory.

        We can only send a maximum of 250 points at a time (per Spot SDK). Therefore,
            we create "segments" of any trajectories longer than this limit.

        If Spot's arm is not sufficiently close to the starting configuration, the
            trajectory is considered invalid and will not be executed.

        The action server, if provided, is used to check whether the trajectory request
            has been "preempted" (i.e., canceled) by the requesting client.

        :param trajectory: Trajectory of joint (position, velocity) points
        :param action_server: Optional action server used to check for cancellation
        :param max_attempts: Maximum number of (re)send attempts per traj. segment (defaults to 5)
        :return: Enum member indicating the outcome of the command
        """
        if self._locked:
            return ArmCommandOutcome.ARM_LOCKED

        if not self._manager.has_control:
            self._manager.log_info("Cannot command Spot's arm; SpotManager doesn't control Spot.")
            return ArmCommandOutcome.INVALID_START

        # Re-sync with Spot to ensure that round-trip times are up-to-date
        self._manager.time_sync.resync()

        # SpotManager outputs joint names based on the Spot SDK's naming conventions
        arm_configuration = self._manager.get_arm_configuration()
        self._manager.log_info(f"Spot's arm state: {arm_configuration}\n")

        # Each JointTrajectory ROS message uses joint names based on Spot's URDF
        command_start_angles_rad = trajectory.points[0].positions_rad

        for sdk_joint, curr_rad in arm_configuration.items():
            urdf_joint = MAP_JOINT_NAMES_SPOT_SDK_TO_URDF[sdk_joint]
            joint_idx = trajectory.joint_names.index(urdf_joint)
            cmd_rad = command_start_angles_rad[joint_idx]

            if abs(curr_rad - cmd_rad) > self.angle_proximity_rad:
                self._manager.log_info("Commanded trajectory doesn't begin where Spot's arm is!")
                self._manager.log_info(f"Current joint angle: {curr_rad} radians.")
                self._manager.log_info(f"Command initial joint angle: {cmd_rad} radians.")
                return ArmCommandOutcome.INVALID_START

        local_start_time_s = time.time() + self._future_proof_s
        trajectory.reference_timestamp = TimeStamp.from_time_s(local_start_time_s)

        segments_schedule = trajectory.create_segment_schedule(self.max_segment_len)

        preempted = False
        if action_server is None:  # Simpler case, where ROS can't preempt the command
            for idx in range(len(segments_schedule.commands)):
                self.send_segment_command(idx, segments_schedule, max_attempts)

        else:  # Use the action server to check that the trajectory is not canceled
            for idx in range(len(segments_schedule.commands)):
                if action_server.is_preempt_requested():  # Trajectory canceled!
                    self._manager.log_info("Action has been preempted.")
                    preempted = True
                    break  # Stop sending trajectory segments

                # Otherwise, execute the next segment of the trajectory
                self.send_segment_command(idx, segments_schedule, max_attempts)

        # Wait until Spot finishes executing the last segment sent
        if self._command_id is not None:
            self._manager.block_until_arm_arrives(self._command_id)

        return ArmCommandOutcome.PREEMPTED if preempted else ArmCommandOutcome.SUCCESS

    def command_gripper(
        self,
        target_rad: float,
        max_vel_radps: float = 0.5,
    ) -> GripperCommandOutcome:
        """Command Spot's gripper to move to the specified angle (radians).

        Fully open gripper is -1.5707 radians, whereas fully closed gripper is 0 radians.

        If contact is detected while closing the gripper, the default maximum torque is 5.5 Nm.

        Reference: https://dev.bostondynamics.com/_modules/bosdyn/client/robot_command#RobotCommandBuilder.claw_gripper_open_angle_command

        :param target_rad: Target gripper angle (radians)
        :param max_vel_radps: Maximum angular velocity (radians/second) for gripper movement
        :return: Enum indicating the outcome of the gripper command sent to Spot
        """
        if self._locked:
            self._manager.log_info("Rejected gripper command; Spot's arm remains locked.\n")
            return GripperCommandOutcome.FAILURE

        if not self._manager.has_control:
            self._manager.log_info("Rejected gripper command; SpotManager doesn't control Spot.\n")
            return GripperCommandOutcome.FAILURE

        if target_rad < -1.5707 or target_rad > 0:
            self._manager.log_info(f"Rejected gripper command requesting: {target_rad} rad.\n")
            return GripperCommandOutcome.FAILURE

        robot_command = RobotCommandBuilder.claw_gripper_open_angle_command(
            target_rad,
            max_vel=max_vel_radps,
        )

        self._command_id = self._manager.send_robot_command(robot_command)
        self._manager.log_info("Gripper command sent.\n")

        if self._command_id is None:
            self._manager.log_info("Gripper command failed to produce a command ID.")
            return GripperCommandOutcome.FAILURE

        return self._manager.block_during_gripper_command(self._command_id)
