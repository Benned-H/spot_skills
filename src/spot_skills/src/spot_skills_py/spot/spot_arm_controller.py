"""Define a class to control Spot's arm using the Spot SDK."""

from __future__ import annotations

import time
from enum import IntEnum
from typing import TYPE_CHECKING

from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import duration_to_seconds
from transform_utils.time_sync import SystemClock, Timestamp

from spot_skills_py.spot.spot_configuration import MAP_JOINT_NAMES_SPOT_SDK_TO_URDF

if TYPE_CHECKING:
    from actionlib import SimpleActionServer
    from bosdyn.api.robot_command_pb2 import RobotCommand

    from spot_skills_py.joint_trajectory import JointTrajectory
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

        # Declare member variable to store the ID of the most recent robot command
        self._command_id: int | None = None

        # Define the maximum number of points in any sent trajectory segment
        self.max_segment_len = min(max_segment_len, 250)  # Ensure limit is <= 250

        # Define angle (radians) within which two angles are considered identical
        self.angle_proximity_rad = 0.005

        # Duration (seconds) into the future by which each trajectory's start is offset

        # Begin with the arm controller unable to affect Spot's arm
        self._locked = True

    def unlock_arm(self) -> None:
        """Explicitly unlock Spot's arm, allowing the ArmController to control it."""
        self._locked = False

    def send_segment_command(self, command: RobotCommand) -> None:
        """Command Spot to execute a trajectory segment, given as a robot command.

        :param command: Robot command containing a short trajectory segment
        """
        if self._locked:
            return

        # An ArmJointTrajectory Protobuf message
        traj_proto = command.synchronized_command.arm_command.arm_joint_move_command.trajectory
        points_proto = traj_proto.points

        assert len(points_proto) <= self.max_segment_len, "Segment too long!"

        # Log useful information about the trajectory segment to be sent
        self._manager.log_info(f"Sending trajectory segment of length {len(points_proto)}...")

        first_rel_time_s = duration_to_seconds(points_proto[0].time_since_reference)
        last_rel_time_s = duration_to_seconds(points_proto[-1].time_since_reference)
        segment_duration_s = last_rel_time_s - first_rel_time_s

        self._manager.log_info(f"First relative time in segment: {first_rel_time_s:.2f} s.")
        self._manager.log_info(f"Last relative time in segment: {last_rel_time_s:.2f} s.")
        self._manager.log_info(f"Total segment duration: {segment_duration_s:.2f} s.")

        # Wait to send the segment until close to when it starts
        time_sync = self._manager.time_sync

        # This Proto is in local time because the RobotCommandClient will convert upon sending
        ref_local_ts = Timestamp.from_proto(traj_proto.reference_time)
        ref_local_ts.clock = SystemClock.LOCAL
        ref_local_time_s = ref_local_ts.to_time_s()

        send_early_s = 2.0 * time_sync.max_round_trip_s + 0.2
        self._manager.log_info(f"Want to send the segment {send_early_s:.4f} seconds early...")

        self._manager.log_info(f"Trajectory reference (local clock): {ref_local_time_s:.2f} s.")

        if time_sync.latest_sync_result is None:
            error_msg = "Time-sync is unknown; cannot send trajectory segment!"
            self._manager.log_info(error_msg)
            raise ValueError(error_msg)

        now_s = time.time()
        starts_in_s = (ref_local_time_s + first_rel_time_s) - now_s

        self._manager.log_info(
            f"Local clock now: {now_s:.2f} s; segment starts in {starts_in_s:.2f} s.",
        )

        if starts_in_s > send_early_s:
            spare_time_s = starts_in_s - send_early_s
            self._manager.log_info(f"We have {spare_time_s:.4f} spare seconds; sleeping...")
            time.sleep(spare_time_s)

        self._manager.log_info("Sending trajectory segment...")

        self._command_id = self._manager.send_robot_command(command)

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
        if self._locked:
            return ArmCommandOutcome.ARM_LOCKED

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
                self._manager.log_info(
                    "Commanded trajectory doesn't begin where Spot's arm is!",
                )
                self._manager.log_info(f"Current joint angle: {curr_rad} radians.")
                self._manager.log_info(
                    f"Command initial joint angle: {cmd_rad} radians.",
                )
                return ArmCommandOutcome.INVALID_START

        robot_commands = trajectory.segment_to_robot_commands(
            self.max_segment_len,
            self._manager.time_sync,
        )

        preempted = False
        if action_server is None:  # Simpler case, where ROS can't preempt the command
            for segment_command in robot_commands:
                self.send_segment_command(segment_command)
        else:  # Use the action server to check that the trajectory is not canceled
            for segment_command in robot_commands:
                if action_server.is_preempt_requested():  # Trajectory canceled!
                    self._manager.log_info("Action has been preempted.")
                    preempted = True
                    break  # Stop sending trajectory segments

                # Otherwise, execute the next segment of the trajectory
                self.send_segment_command(segment_command)

        # Wait until Spot finishes executing the last segment sent
        if self._command_id is not None:
            self._manager.block_until_arm_arrives(self._command_id)

        return ArmCommandOutcome.PREEMPTED if preempted else ArmCommandOutcome.SUCCESS

    def command_gripper(self, target_rad: float) -> GripperCommandOutcome:
        """Command Spot's gripper to move to the specified angle (radians).

        Fully open gripper is -1.5707 radians, whereas fully closed gripper is 0 radians.

        If contact is detected while closing the gripper, the default maximum torque is 5.5 Nm.

        Reference: https://dev.bostondynamics.com/_modules/bosdyn/client/robot_command#RobotCommandBuilder.claw_gripper_open_angle_command

        :param target_rad: Target gripper angle (radians)
        :return: Enum indicating the outcome of the gripper command sent to Spot
        """
        if self._locked:
            self._manager.log_info("Rejected gripper command; Spot's arm remains locked.\n")
            return GripperCommandOutcome.FAILURE

        if not self._manager.check_control():
            self._manager.log_info("Rejected gripper command; SpotManager doesn't control Spot.\n")
            return GripperCommandOutcome.FAILURE

        if target_rad < -1.5707 or target_rad > 0:
            self._manager.log_info(f"Rejected gripper command requesting: {target_rad} rad.\n")
            return GripperCommandOutcome.FAILURE

        robot_command = RobotCommandBuilder.claw_gripper_open_angle_command(target_rad)

        self._command_id = self._manager.send_robot_command(robot_command)
        self._manager.log_info("Gripper command sent.\n")

        if self._command_id is None:
            self._manager.log_info("Gripper command failed to produce a command ID.")
            return GripperCommandOutcome.FAILURE

        return self._manager.block_during_gripper_command(self._command_id)
