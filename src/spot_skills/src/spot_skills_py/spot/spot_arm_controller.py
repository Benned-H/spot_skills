"""Define a class to control Spot's arm using the Spot SDK."""

from __future__ import annotations

import time
from enum import IntEnum
from typing import TYPE_CHECKING

import numpy as np
from bosdyn.api.arm_command_pb2 import ArmJointTrajectory
from bosdyn.api.arm_surface_contact_pb2 import ArmSurfaceContact
from bosdyn.client.arm_surface_contact import ArmSurfaceContactClient
from bosdyn.client.exceptions import InvalidRequestError
from bosdyn.client.math_helpers import Quat, Vec3
from bosdyn.client.robot_command import (
    RobotCommandBuilder,
    block_until_arm_arrives,
)
from bosdyn.util import duration_to_seconds, seconds_to_duration
from transform_utils.kinematics import Pose3D

# from tenacity import retry, retry_if_exception_type, stop_after_attempt, wait_fixed
from transform_utils.time_sync import SystemClock, Timestamp

from spot_skills_py.spot.spot_configuration import MAP_JOINT_NAMES_SPOT_SDK_TO_URDF

if TYPE_CHECKING:
    from actionlib import SimpleActionServer
    from bosdyn.api.robot_command_pb2 import RobotCommand

    from spot_skills_py.joint_trajectory import JointTrajectory
    from spot_skills_py.spot.spot_manager import SpotManager

# Estimate Spot's force capacity based on 5 kg continuous lift capacity at 0.5 meter extension
# Reference: https://bostondynamics.com/wp-content/uploads/2020/10/spot-arm.pdf
GRAVITY_ACCEL_MPS2 = 9.80665
SPOT_ARM_CONTINUOUS_FORCE_CAPACITY_N = 5.0 * GRAVITY_ACCEL_MPS2


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

        self.arm_surface_contact_client: ArmSurfaceContactClient | None = None

    def unlock_arm(self) -> None:
        """Explicitly unlock Spot's arm, allowing the ArmController to control it."""
        self._locked = False

    def refresh_ref_time(self, traj_proto: ArmJointTrajectory) -> None:
        """Refresh the timestamp of the given Protobuf message.

        :param traj_proto: Protobuf message whose reference time is updated
        """
        future_margin_s = self._manager.time_sync.get_future_margin_s()
        if future_margin_s is None:
            self._manager.time_sync.resync()
            future_margin_s = self._manager.time_sync.get_future_margin_s()

            if future_margin_s is None:
                error_msg = "Time-sync unavailable; cannot refresh trajectory reference time."
                raise RuntimeError(error_msg)

        # Leave protos relative to local clock; RobotCommandClient will convert them at send-time
        ref_local_ts = Timestamp.now().add_offset_s(future_margin_s)
        ref_local_ts.clock = SystemClock.ROBOT  # Trick our code to skip converting local-to-robot
        ref_robot_proto = self._manager.time_sync.convert_to_robot_proto(ref_local_ts)
        if ref_robot_proto is None:
            error_msg = "Time-sync unavailable; cannot update reference timestamp."
            raise RuntimeError(error_msg)

        traj_proto.reference_time.CopyFrom(ref_robot_proto)

    # @retry(
    #     stop=stop_after_attempt(5),
    #     wait=wait_fixed(0.1),
    #     retry=retry_if_exception_type(InvalidRequestError),
    #     before_sleep=lambda retry_state: retry_state.args[0]._refresh_traj_ref(
    #         retry_state.args[1],
    #     ),
    # )
    # def _send_with_retry(self, command: RobotCommand) -> int:
    #     """Send the given robot command to Spot, retrying on InvalidRequestError.

    #     :param command: Robot command containing a short trajectory segment
    #     :return: Command ID of the successfully sent command
    #     """
    #     return self._manager.send_robot_command(command)

    def send_segment_command(self, command: RobotCommand) -> None:
        """Command Spot to execute a trajectory segment, retrying on InvalidRequestError.

        Due to resource constraints, RTAB-Map may take up the CPU at any time,
            so we retry a few times if a command throws an exception.

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

        # This Proto is in local time because the RobotCommandClient will convert upon sending
        ref_local_ts = Timestamp.from_proto(traj_proto.reference_time)
        ref_local_ts.clock = SystemClock.LOCAL
        ref_local_time_s = ref_local_ts.to_time_s()

        # self._manager.log_info(f"Trajectory reference (local clock): {ref_local_time_s:.2f} s.")

        # # Debug printouts to output values before SDK converts Timestamp protos
        # if time_sync.latest_sync_result is None:
        #     self._manager.log_info("TimeSync latest result is currently None.")
        # else:
        #     skew_s = time_sync.latest_sync_result.robot_clock_skew_s
        #     rtt_s = time_sync.latest_sync_result.round_trip_time_s
        #     self._manager.log_info(f"[DEBUG] Skew: {skew_s:.3f} s    RTT: {rtt_s:.3f} s")

        #     local_now_ts = Timestamp.now()
        #     robot_now_ts = time_sync.change_relative_clock(local_now_ts, SystemClock.ROBOT)
        #     local_now_s = local_now_ts.to_time_s()
        #     robot_now_s = robot_now_ts.to_time_s()

        #     self._manager.log_info(f"[DEBUG] local_now: {local_now_s:.6f}")
        #     self._manager.log_info(f"[DEBUG] robot_now: {robot_now_s:.6f}")

        time_sync = self._manager.time_sync

        if time_sync.latest_sync_result is None or time_sync.max_round_trip_s is None:
            error_msg = "Time-sync is unknown; cannot send trajectory segment!"
            self._manager.log_info(error_msg)
            raise ValueError(error_msg)

        # Wait to send the segment until close to when it starts
        send_early_s = 2.0 * time_sync.max_round_trip_s + 0.2
        self._manager.log_info(f"Want to send the segment {send_early_s:.4f} seconds early...")

        now_s = time.time()
        starts_in_s = (ref_local_time_s + first_rel_time_s) - now_s

        self._manager.log_info(
            f"Local clock now: {now_s:.2f} s; segment starts in {starts_in_s:.2f} s.",
        )

        if starts_in_s > send_early_s:
            spare_time_s = starts_in_s - send_early_s
            self._manager.log_info(f"We have {spare_time_s:.4f} spare seconds; sleeping...")

            # Before sleep
            t1 = time.time()
            self._manager.log_info(f"[DEBUG] Pre-sleep local_now: {t1:.6f} s")

            time.sleep(spare_time_s)

            t2 = time.time()
            self._manager.log_info(f"[DEBUG] Post-sleep local_now: {t2:.6f}; Δ={t2 - t1:.3f} s")

        starts_in_s = (ref_local_time_s + first_rel_time_s) - time.time()
        self._manager.log_info(f"Segment now starts in {starts_in_s:.2f} s.")

        t3 = time.time()
        self._manager.log_info(f"[DEBUG] Pre-RPC local_now: {t3:.6f}")

        # self._command_id = self._manager.send_robot_command(command)
        # block_until_arm_arrives(self._manager.command_client, self._command_id)

        max_attempts = 5
        for attempt in range(1, max_attempts + 1):
            self.refresh_ref_time(traj_proto)
            try:
                command_id = self._manager.send_robot_command(command)
                self._command_id = command_id

                # def _arm_done(response: RobotCommandResponse) -> bool:
                # return (
                #     response.feedback.synchronized_feedback.arm_command_feedback.status
                #     == RobotCommandResponse.STATUS_TRAJECTORY_COMPLETE
                # )

                # Block until the segment finishes, renewing the lease while waiting
                try:
                    block_until_arm_arrives(self._manager.command_client, command_id)
                except Exception as e:
                    self._manager.log_info(f"Error during blocking_command: {e}")
                    raise
                else:
                    return

            except InvalidRequestError as exc:
                self._manager.log_info(f"Attempt {attempt}/{max_attempts} failed due to: {exc}.")
                if attempt == max_attempts:
                    self._manager.log_info("Failed to send segment after retries.")
                    raise

        # # Retry loop on stale-timestamp errors
        # max_attempts = 3
        # for attempt in range(1, max_attempts + 1):
        #     # Refresh reference before each try
        #     self.refresh_traj_ref(traj_proto)
        #     try:
        #         cmd_id = self._manager.send_robot_command(command)
        #         self._command_id = cmd_id
        #         return
        #     except InvalidRequestError:
        #         self._manager.log_warn(
        #             f"Attempt {attempt}/{max_attempts} failed due to stale timestamp; retrying.",
        #         )
        #         if attempt == max_attempts:
        #             self._manager.log_error("Failed to send segment after retries.")
        #             raise

        # try:
        #     command_id = self._send_with_retry(command)
        # except InvalidRequestError:
        #     self._manager.log_info("Failed to send segment after retries.")
        #     raise

        # self._command_id = command_id

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

        commands = trajectory.segment_to_robot_commands(
            self.max_segment_len,
            self._manager.time_sync,
        )

        preempted = False
        if action_server is None:  # Simpler case, where ROS can't preempt the command
            for segment_command in commands:
                self.send_segment_command(segment_command)
        else:  # Use the action server to check that the trajectory is not canceled
            for segment_command in commands:
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

    def touch_surface(
        self,
        target_pose: Pose3D,
        force_axis: str,
        force_n: float,
        duration_s: float = 1.0,
        max_pos_tracking_error_m: float = 0.005,
    ) -> bool:
        """Approach an end-effector pose, then apply a specified force along an axis until contact.

        :param target_pose: Desired end-effector pose approached in a straight line
        :param force_axis: Axis of force control (one of "x", "y", or "z")
        :param force_n: Force (Newtons) along the specified axis (negative pushes in - direction)
        :param duration_s: Duration (seconds) over which to execute the approach and force control
        :param max_pos_tracking_error_m: Positional error (meters) at which arm stalls and stops
        :return: True if contact was detected, otherwise False
        """
        assert force_axis in {"x", "y", "z"}, f"Unrecognized force axis: {force_axis}."

        if self.arm_surface_contact_client is None:  # Lazily initialize the low-level client
            self.arm_surface_contact_client: ArmSurfaceContactClient = self._manager.get_client(
                ArmSurfaceContactClient.default_service_name,
            )

        # Build a request for the ArmSurfaceContactClient. Reference:
        # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#armsurfacecontact-request
        request = ArmSurfaceContact.Request()
        request.root_frame_name = target_pose.ref_frame  # TODO: What are the valid frames?

        # TODO: How would we use wrist_tform_tool?

        # Define a trajectory with zero displacement
        point = request.pose_trajectory_in_task.points.add()
        proto_position = Vec3.from_numpy(target_pose.position.to_array()).to_proto()
        point.pose.position.CopyFrom(proto_position)

        q = target_pose.orientation
        proto_quaternion = Quat(w=q.w, x=q.x, y=q.y, z=q.z).to_proto()
        point.pose.rotation.CopyFrom(proto_quaternion)

        point.time_since_reference.CopyFrom(seconds_to_duration(duration_s))

        # Convert the force (in Newtons) into Spot's native fraction of force capacity (~49 N)
        force_capacity_fraction = force_n / SPOT_ARM_CONTINUOUS_FORCE_CAPACITY_N
        force_capacity_fraction = np.clip(force_capacity_fraction, -1.0, 1.0)

        request.press_force_percentage.CopyFrom(Vec3.from_numpy(np.zeros(3)))
        setattr(request.press_force_percentage, force_axis, force_capacity_fraction)

        # Each axis can be controlled in either position or force mode
        axes_fields = {"x": "x_axis", "y": "y_axis", "z": "z_axis"}
        for axis, mode_field in axes_fields.items():
            mode = (
                ArmSurfaceContact.Request.AxisMode.AXIS_MODE_FORCE
                if axis == force_axis
                else ArmSurfaceContact.Request.AxisMode.AXIS_MODE_POSITION
            )
            setattr(request, mode_field, mode)

        # Stop the trajectory once the tracking error exceeds this value
        request.max_pos_tracking_error.value = max_pos_tracking_error_m

        response = self.arm_surface_contact_client.arm_surface_contact_command(request)
        return response.status == ArmSurfaceContact.Response.STATUS_TRAJECTORY_STALLED
