"""Define a class implementing ROS services that control Spot's gripper and arm."""

from __future__ import annotations

import time
from enum import IntEnum
from typing import TYPE_CHECKING

import numpy as np
import rospy
from actionlib import SimpleActionServer
from bosdyn.api.gripper_command_pb2 import ClawGripperCommand
from bosdyn.client.exceptions import InvalidRequestError
from bosdyn.client.frame_helpers import BODY_FRAME_NAME
from bosdyn.client.robot_command import RobotCommandBuilder
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryGoal,
    FollowJointTrajectoryResult,
    GripperCommandAction,
    GripperCommandGoal,
    GripperCommandResult,
)
from geometry_msgs.msg import PoseStamped
from robotics_utils.robots import GripperAngleLimits
from robotics_utils.ros import TransformManager
from robotics_utils.ros.msg_conversion import (
    point_from_vector3_msg,
    pose_from_msg,
    pose_to_stamped_msg,
)
from robotics_utils.ros.robots import MoveItManipulator, ROSAngularGripper
from robotics_utils.spatial import DEFAULT_FRAME, Pose3D
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse

from spot_skills.srv import (
    GraspObject,
    GraspObjectRequest,
    GraspObjectResponse,
    ProbeSurface,
    ProbeSurfaceRequest,
    ProbeSurfaceResponse,
    ReleaseObject,
    ReleaseObjectRequest,
    ReleaseObjectResponse,
)
from spot_skills_py.joint_trajectory import JointTrajectory
from spot_skills_py.spot.spot_configuration import MAP_JOINT_NAMES_SPOT_SDK_TO_URDF
from spot_skills_py.spot.spot_conversion import (
    SPOT_GRIPPER_CLOSED_RAD,
    SPOT_GRIPPER_OPEN_RAD,
    pose_from_sdk,
    pose_to_sdk,
)
from spot_skills_py.spot.spot_force_controller import SpotForceController
from spot_skills_py.time_stamp import TimeStamp

if TYPE_CHECKING:
    from robotics_utils.parallelism import ResourceManager
    from robotics_utils.spatial import Pose3D

    from spot_skills_py.segment_schedule import SegmentSchedule
    from spot_skills_py.spot.spot_manager import SpotManager


class GripperCommandOutcome(IntEnum):
    """Enumeration of possible outcomes from a gripper command for Spot."""

    FAILURE = -1  # Indicates that the command could not be completed
    REACHED_SETPOINT = 0  # Indicates that the gripper reached the commanded position
    STALLED = 1  # Indicates that the gripper is exerting maximum effort and not moving

    @classmethod
    def from_sdk_status(cls, status: ClawGripperCommand.Feedback) -> cls | None:
        """Construct a GripperCommandOutcome from a ClawGripperCommand feedback message.

        :return: Equivalent gripper command outcome, if applicable, else None
        """
        if status == ClawGripperCommand.Feedback.STATUS_AT_GOAL:
            return GripperCommandOutcome.REACHED_SETPOINT
        if status == ClawGripperCommand.Feedback.STATUS_APPLYING_FORCE:
            return GripperCommandOutcome.STALLED
        if status == ClawGripperCommand.Feedback.STATUS_UNKNOWN:
            return GripperCommandOutcome.FAILURE
        return None


class ArmCommandOutcome(IntEnum):
    """Enumeration of possible outcomes from a trajectory command for Spot's arm."""

    INVALID_START = -1  # Indicates mismatch between trajectory start and Spot's arm configuration
    SUCCESS = 0  # Indicates successful trajectory execution
    PREEMPTED = 1  # Indicates that the ROS action client canceled the trajectory
    ARM_LOCKED = 2  # Indicates that Spot's arm remains locked
    NO_CONTROL = 3  # Indicates that the SpotManager doesn't control Spot


class SpotManipulationInterface:
    """A class providing general-purpose ROS services for controlling Spot's arm and gripper.

    By default, Spot's arm begins locked, and must be explicitly unlocked before use.
    """

    def __init__(
        self,
        manager: SpotManager,
        robot_rpc_manager: ResourceManager,
        max_segment_len: int = 250,
        base_frame: str = "body",
        gripper_action_name: str = "gripper_controller/gripper_action",
        arm_action_name: str = "arm_controller/follow_joint_trajectory",
    ) -> None:
        """Initialize the ROS services provided by the interface.

        :param manager: Spot-SDK-based interface for Spot
        :param robot_rpc_manager: Manages priority access to Spot's RPC client
        :param max_segment_len: Maximum number of points in sent trajectory segments (default: 250)
        :param base_frame: Name of the base frame of Spot's arm
        :param gripper_action_name: Name of the gripper command ROS action
        :param arm_action_name: Name of the arm trajectory command ROS action
        """
        self._arm_locked = True

        self._manager = manager
        self.force_controller = SpotForceController(self._manager)

        self._robot_rpc_manager = robot_rpc_manager
        self._max_segment_len = max_segment_len
        self._base_frame = base_frame
        self._arm_action_name = arm_action_name
        self._gripper_action_name = gripper_action_name

        self._arm_command_id: int | None = None
        """ID of the latest command sent to Spot's arm."""

        # Initialize actions before all services
        self._gripper_action_srv = SimpleActionServer(
            name=self._gripper_action_name,
            ActionSpec=GripperCommandAction,
            execute_cb=self._gripper_action_cb,
            auto_start=False,
        )
        self._gripper_action_srv.start()
        rospy.loginfo(f"[{self._gripper_action_name}] Action server has started.")

        self._arm_action_srv = SimpleActionServer(
            name=self._arm_action_name,
            ActionSpec=FollowJointTrajectoryAction,
            execute_cb=self._arm_action_cb,
            auto_start=False,
        )
        self._arm_action_srv.start()
        rospy.loginfo(f"[{self._arm_action_name}] Action server has started.")

        self._grasp_srv = rospy.Service("spot/grasp_object", GraspObject, self._grasp_cb)
        self._release_srv = rospy.Service("spot/release_object", ReleaseObject, self._release_cb)

        self._unlock_arm_srv = rospy.Service("spot/unlock_arm", Trigger, self._unlock_arm_cb)
        self._stow_arm_srv = rospy.Service("spot/stow_arm", Trigger, self._stow_arm_cb)
        self._deploy_arm_srv = rospy.Service("spot/deploy_arm", Trigger, self._deploy_arm_cb)
        self._probe_srv = rospy.Service("spot/probe_surface", ProbeSurface, self._probe_cb)

        self._ee_pose_max_vel_mps = 0.4  # Max EE speed for /spot/ee_pose commands (m/s)
        self._ee_pose_min_duration_s = 0.5  # Minimum command duration regardless of distance (s)
        self._ee_velocity_cmd_duration_s = 0.5  # Duration per ee_cmd_vel command (s)
        self._ee_pose_sub = rospy.Subscriber(
            "/spot/ee_pose",
            PoseStamped,
            self._ee_pose_cb,
            queue_size=1,
        )

        self.gripper = ROSAngularGripper(
            GripperAngleLimits(open_rad=SPOT_GRIPPER_OPEN_RAD, closed_rad=SPOT_GRIPPER_CLOSED_RAD),
            grasping_group="gripper",
            action_name=self._gripper_action_name,
        )
        self.manipulator = MoveItManipulator(
            name="arm",
            robot_name="spot",
            base_frame=self._base_frame,
            planning_frame=DEFAULT_FRAME,
            gripper=self.gripper,
        )

    def _unlock_arm_cb(self, _: TriggerRequest) -> TriggerResponse:
        """Unlock Spot's arm, allowing it to be controlled via ROS.

        If the SpotManager doesn't yet control Spot, control will be forcibly taken.
        """
        if self._manager.ensure_control(take_by_force=True):
            self._arm_locked = False
            return TriggerResponse(success=True, message="Successfully unlocked Spot's arm.")

        return TriggerResponse(
            success=False,
            message="Could not gain control of Spot; its arm remains locked.",
        )

    def _stow_arm_cb(self, _: TriggerRequest) -> TriggerResponse:
        """Attempt to stow Spot's arm."""
        if self._arm_locked:
            return TriggerResponse(
                success=False,
                message="Spot's arm is locked; could not stow arm.",
            )
        if not self._manager.has_control:
            return TriggerResponse(
                success=False,
                message="SpotManager doesn't control Spot; could not stow arm.",
            )

        arm_stowed = self._manager.stow_arm()
        message = "Spot's arm has been stowed." if arm_stowed else "Could not stow Spot's arm."
        return TriggerResponse(success=arm_stowed, message=message)

    def _deploy_arm_cb(self, _: TriggerRequest) -> TriggerResponse:
        """Attempt to deploy Spot's arm to the "ready" position."""
        if self._arm_locked:
            message = "Spot's arm was not deployed because Spot's arm is locked."
            return TriggerResponse(success=False, message=message)

        deployed = False
        if self._manager.ensure_control(take_by_force=False):
            deployed = self._manager.deploy_arm()

        return TriggerResponse(
            success=deployed,
            message=(
                "Spot's arm has been deployed." if deployed else "Could not deploy Spot's arm."
            ),
        )

    def _probe_cb(self, request: ProbeSurfaceRequest) -> ProbeSurfaceResponse:
        """Probe for a surface using Spot's gripper."""
        if not self._manager.has_control:
            return ProbeSurfaceResponse(
                success=False,
                message="Cannot probe for surface; SpotManager doesn't control Spot.",
            )

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                return ProbeSurfaceResponse(
                    success=False,
                    message="Could not obtain RPC priority before probing.",
                )

            plane_result = self.force_controller.probe_surface(
                direction=point_from_vector3_msg(request.direction),
                max_distance_m=request.max_distance_m,
                velocity_mps=request.velocity_mps,
                force_threshold_n=request.force_threshold_n,
                force_check_hz=request.force_check_hz,
                num_probes=request.num_probes,
                probe_interval_s=request.probe_interval_s,
            )

            success = plane_result is not None
            message = (
                f"Found surface: {plane_result}"
                if success
                else "Probed for surface but no surface was found."
            )

            return ProbeSurfaceResponse(success, message)

    def _grasp_cb(self, request: GraspObjectRequest) -> GraspObjectResponse:
        """Grasp the named object using Spot's gripper."""
        outcome = self.manipulator.grasp(object_name=request.object_name)
        if outcome.output is None:
            return GraspObjectResponse(
                success=False,
                message=f"Pose output from grasping '{request.object_name}' was None.",
                new_pose=PoseStamped(),
            )

        grasp_pose_msg = pose_to_stamped_msg(outcome.output.pose_ee_o)
        return GraspObjectResponse(outcome.success, outcome.message, grasp_pose_msg)

    def _release_cb(self, request: ReleaseObjectRequest) -> ReleaseObjectResponse:
        """Release an object held by Spot into the specified frame."""
        object_name = request.object_name
        parent_frame = request.new_parent_frame

        if self._arm_locked:
            return ReleaseObjectResponse(
                success=False,
                message=f"Spot's arm is locked; could not release '{object_name}'.",
            )
        if not self._manager.has_control:
            return ReleaseObjectResponse(
                success=False,
                message=f"SpotManager doesn't control Spot; could not release '{object_name}'.",
            )

        # Otherwise, release the object by 1) opening Spot's gripper and 2) updating its frame
        if not self.open_gripper():
            return ReleaseObjectResponse(success=False, message="Failed to open Spot's gripper.")

        object_wrt_parent = TransformManager.lookup_transform(
            child_frame=object_name,
            parent_frame=parent_frame,
        )
        if object_wrt_parent is None:
            return ReleaseObjectResponse(
                success=False,
                message=f"Failed to look up pose of '{object_name}' w.r.t. '{parent_frame}'.",
            )

        return ReleaseObjectResponse(
            success=True,
            message=f"Released object '{object_name}'.",
            new_pose=pose_to_stamped_msg(object_wrt_parent),
        )

    def _gripper_action_cb(self, goal: GripperCommandGoal, post_pause_s: float = 0.25) -> None:
        """Move Spot's gripper to the commanded angle.

        Reference: https://docs.ros.org/en/noetic/api/control_msgs/html/action/GripperCommand.html

        :param goal: Gripper command specifying a target position and maximum effort
        :param post_pause_s: Delay (seconds) to pause after executing the command (default: 0.25 s)
        """
        goal_position_rad = goal.command.position  # TODO: Handle maximum effort from command

        outcome = GripperCommandOutcome.FAILURE
        if self._manager.ensure_control(take_by_force=False):
            outcome = self.command_gripper(target_rad=goal_position_rad)
            rospy.sleep(post_pause_s)

        result = GripperCommandResult()
        if outcome == GripperCommandOutcome.FAILURE:
            result.reached_goal = False
            self._gripper_action_srv.set_aborted(result)
        else:
            result.reached_goal = outcome == GripperCommandOutcome.REACHED_SETPOINT
            result.stalled = outcome == GripperCommandOutcome.STALLED
            self._gripper_action_srv.set_succeeded(result)

    def _sleep_until(self, local_time_s: float) -> None:
        """Sleep until just before the given local time (in seconds)."""
        sleep_for_s = max(0.0, local_time_s - time.time())
        deadline_s = time.monotonic() + sleep_for_s
        while (remainder_s := deadline_s - time.monotonic()) > 0:
            time.sleep(min(remainder_s, 0.01))

    @property
    def locked(self) -> bool:
        """Retrieve whether Spot's arm remains locked."""
        return self._arm_locked

    def command_gripper(
        self,
        target_rad: float,
        max_vel_radps: float = 0.5,
        timeout_s: float = 5.0,
    ) -> GripperCommandOutcome:
        """Command Spot's gripper to move to the specified angle (in radians).

        Fully open gripper: -1.5708 radians
        Fully closed gripper: 0.0 radians

        If contact is detected, the default maximum torque is 5.5 Nm.

        Reference: https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command.html#bosdyn.client.robot_command.RobotCommandBuilder.claw_gripper_open_angle_command

        :param target_rad: Target gripper angle (radians)
        :param max_vel_radps: Maximum angular velocity (radians/second) for gripper movement
        :param timeout_s: Duration (seconds) after which the command is considered failed
        :return: Enum indicating command outcome (success, failure, or gripper stalled)
        """
        if self._arm_locked:
            self._manager.log_info("Rejected gripper command because Spot's arm is locked.")
            return GripperCommandOutcome.FAILURE

        if not self._manager.has_control:
            self._manager.log_info("Rejected gripped command; SpotManager doesn't control Spot.")
            return GripperCommandOutcome.FAILURE

        if not (SPOT_GRIPPER_OPEN_RAD <= target_rad <= SPOT_GRIPPER_CLOSED_RAD):
            self._manager.log_info(f"Rejected out-of-range gripper command: {target_rad} radians.")
            return GripperCommandOutcome.FAILURE

        robot_command = RobotCommandBuilder.claw_gripper_open_angle_command(
            target_rad,
            max_vel=max_vel_radps,
        )

        command_id = self._manager.send_robot_command(robot_command)
        self._manager.log_info("Gripper command sent.")

        if command_id is None:
            self._manager.log_info("Gripper command failed to produce a command ID.")
            return GripperCommandOutcome.FAILURE

        # Block until Spot's gripper completes the command or times out
        end_time = time.time() + timeout_s

        while time.time() < end_time:
            response = self._manager.command_client.robot_command_feedback(command_id)
            gripper_feedback = response.feedback.synchronized_feedback.gripper_command_feedback
            gripper_status = gripper_feedback.claw_gripper_feedback.status

            outcome = GripperCommandOutcome.from_sdk_status(gripper_status)
            if outcome is not None:
                return outcome

            time.sleep(0.1)

        return GripperCommandOutcome.FAILURE

    def open_gripper(self) -> bool:
        """Attempt to open Spot's gripper.

        :return: True if opening the gripper succeeded, else False
        """
        outcome = self.command_gripper(target_rad=SPOT_GRIPPER_OPEN_RAD)  # Checks for locked arm
        return outcome == GripperCommandOutcome.REACHED_SETPOINT

    def close_gripper(self) -> bool:
        """Attempt to close Spot's gripper.

        :return: True if closing the gripper succeeded, else False
        """
        outcome = self.command_gripper(target_rad=SPOT_GRIPPER_CLOSED_RAD)  # Checks for locked arm
        return outcome == GripperCommandOutcome.REACHED_SETPOINT

    def command_ee_pose(self, pose_b_ee: Pose3D, duration_s: float = 1.0) -> bool:
        """Command Spot's end-effector to move toward a target pose in Spot's body frame.

        :param pose_b_ee: Target end-effector pose in Spot's body frame
        :param duration_s: Duration (seconds) of the end-effector command (default: 1 second)
        :return: True if the command was successfully sent, else False
        """
        if self._arm_locked:
            self._manager.log_info(
                "Rejected end-effector pose command because Spot's arm is locked.",
            )
            return False

        if not self._manager.has_control:
            self._manager.log_info(
                "Rejected end-effector pose command because SpotManager doesn't control Spot.",
            )
            return False

        if duration_s <= 0.0:
            self._manager.log_info("Rejected end-effector pose command with non-positive duration.")
            return False

        if pose_b_ee.ref_frame != BODY_FRAME_NAME:
            self._manager.log_info(
                f"Rejected end-effector pose command in frame '{pose_b_ee.ref_frame}'. "
                f"Expected frame '{BODY_FRAME_NAME}'.",
            )
            return False

        command = RobotCommandBuilder.arm_pose_command_from_pose(
            hand_pose=pose_to_sdk(pose_b_ee),
            frame_name=BODY_FRAME_NAME,
            seconds=duration_s,
        )
        command_id = self._manager.send_robot_command(command)

        if command_id is None:
            self._manager.log_info("End-effector pose command failed to produce a command ID.")
            return False

        return True

    def _arm_action_cb(self, goal: FollowJointTrajectoryGoal, post_pause_s: float = 0.5) -> None:
        """Execute the given joint trajectory on Spot's arm.

        :param goal: Joint trajectory to be followed
        :param post_pause_s: Delay (seconds) to wait after finishing the trajectory
        """
        result = FollowJointTrajectoryResult()
        result.error_code = -1  # Default error code: INVALID_GOAL

        trajectory = JointTrajectory.from_ros_msg(goal.trajectory)

        # TODO: Could use the joint tolerances to enforce within-bounds trajectory
        #   execution. Similar logic would allow the action server to publish feedback.
        # Currently, we're ignoring these variables in the received trajectory:
        #   path_tolerance, goal_tolerance, goal_time_tolerance

        # Log information about the received trajectory
        first_rel_time_s = trajectory.points[0].time_from_start_s
        last_rel_time_s = trajectory.points[-1].time_from_start_s
        traj_duration_s = last_rel_time_s - first_rel_time_s

        rospy.loginfo(
            f"[{self._arm_action_name}] Received trajectory of length "
            f"{len(trajectory.points)}, lasting {traj_duration_s} seconds.",
        )

        if self._arm_locked or (not self._manager.ensure_control(take_by_force=False)):
            result.error_string = "Unable to follow trajectory without control of Spot's arm."
            rospy.loginfo(f"[{self._arm_action_name}] {result.error_string}")
            self._arm_action_srv.set_aborted(result)
            return

        if not self._manager.ensure_control(take_by_force=False):
            result.error_string = "Could not obtain control of Spot."
            self._arm_action_srv.set_aborted(result)
            return

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                result.error_string = "Could not obtain RPC priority; other threads still active."
                self._arm_action_srv.set_aborted(result)
                return

            outcome = self.command_trajectory(trajectory)  # Attempt to send the trajectory

            # Update the ROS action server based on the outcome of the trajectory
            if outcome == ArmCommandOutcome.SUCCESS:
                rospy.sleep(post_pause_s)  # Delay after the end of any successful trajectory

                result.error_code = int(outcome)
                result.error_string = "Success!"
                self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")
                self._arm_action_srv.set_succeeded(result)

            elif outcome == ArmCommandOutcome.INVALID_START:
                result.error_string = (
                    "Could not follow trajectory because it did not begin "
                    "from the current configuration of Spot's arm."
                )

                self._arm_action_srv.set_aborted(result)

            elif outcome == ArmCommandOutcome.ARM_LOCKED:
                result.error_string = "Could not follow trajectory because Spot's arm is locked."
                self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")

                self._arm_action_srv.set_aborted(result)

            elif outcome == ArmCommandOutcome.PREEMPTED:
                self._arm_action_srv.set_preempted()

    def _ee_pose_cb(self, msg: PoseStamped) -> None:
        """Command Spot's end-effector to move to a given pose."""
        if self._arm_locked:
            return

        if not self._manager.has_control:
            rospy.logwarn("Ignoring /spot/ee_pose because Spot control is unavailable.")
            return

        if not msg.header.frame_id:
            rospy.logwarn("Ignoring /spot/ee_pose because PoseStamped frame_id is empty.")
            return

        target_pose = pose_from_msg(msg)
        try:
            target_pose_b_ee = TransformManager.convert_to_frame(target_pose, self._base_frame)
        except RuntimeError as err:
            rospy.logwarn(
                f"Ignoring /spot/ee_pose; failed frame conversion to '{self._base_frame}': {err}",
            )
            return

        try:
            curr_ee_pose_sdk = self._manager.get_hand_pose(ref_frame=BODY_FRAME_NAME)
            current_pose_b_ee = pose_from_sdk(curr_ee_pose_sdk, ref_frame=BODY_FRAME_NAME)
            diff = target_pose_b_ee.position.to_array() - current_pose_b_ee.position.to_array()
            distance_m = float(np.linalg.norm(diff))
            duration_s = max(distance_m / self._ee_pose_max_vel_mps, self._ee_pose_min_duration_s)
        except TypeError as err:
            rospy.logwarn(f"Skipping /spot/ee_pose; failed to read hand pose: {err}")
            return

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                rospy.logwarn("Skipping /spot/ee_pose command because RPC priority is unavailable.")
                return

            success = self.command_ee_pose(pose_b_ee=target_pose_b_ee, duration_s=duration_s)

        if not success:
            rospy.logwarn("Failed to command /spot/ee_pose target pose.")

    def command_trajectory(
        self,
        trajectory: JointTrajectory,
        angle_proximity_rad: float = 0.005,
        future_proof_s: float = 1.0,
        max_attempts: int = 5,
    ) -> ArmCommandOutcome:
        """Command Spot's arm to execute the given joint trajectory.

        We can only send a maximum of 250 points at a time (per Spot SDK). Therefore,
        we create "segments" of any trajectories longer than this limit.

        If Spot's arm is not sufficiently close to the starting configuration, the
        trajectory is considered invalid and will not be executed.

        :param trajectory: Trajectory of time-stamped (position, velocity) joint points
        :param angle_proximity_rad: Angle (radians) within which two angles are considered equal
        :param future_proof_s: Duration (seconds) into the future by which trajectories are offset
        :param max_attempts: Maximum number of (re)send attempts per segment (default: 5)
        :return: Enum member indicating the command outcome
        """
        if self._arm_locked:
            return ArmCommandOutcome.ARM_LOCKED

        if not self._manager.has_control:
            return ArmCommandOutcome.NO_CONTROL

        # Build a robot command to prevent Spot from moving its body during the trajectory
        body_command = self._manager.build_hold_body_pose_command()

        # Re-sync with Spot to ensure that round-trip times are up-to-date
        self._manager.time_sync.resync()

        # SpotManager outputs joint names based on the Spot SDK's naming convention
        arm_configuration = self._manager.get_arm_configuration()
        self._manager.log_info(f"Spot's arm state: {arm_configuration}")

        # Each JointTrajectory ROS message uses joint names based on Spot's URDF
        command_start_angles_rad = trajectory.points[0].positions_rad
        for sdk_joint, curr_rad in arm_configuration.items():
            urdf_joint = MAP_JOINT_NAMES_SPOT_SDK_TO_URDF[sdk_joint]
            joint_idx = trajectory.joint_names.index(urdf_joint)
            command_rad = command_start_angles_rad[joint_idx]

            if abs(curr_rad - command_rad) > angle_proximity_rad:
                self._manager.log_info(
                    "Commanded trajectory doesn't start at Spot's current arm configuration.",
                )
                self._manager.log_info(f"\tCurrent joint angle: {curr_rad} radians.")
                self._manager.log_info(f"\tCommand initial joint angle: {command_rad} radians.")
                return ArmCommandOutcome.INVALID_START

        local_start_time_s = time.time() + future_proof_s
        trajectory.reference_timestamp = TimeStamp.from_time_s(local_start_time_s)

        segments_schedule = trajectory.create_segment_schedule(self._max_segment_len, body_command)

        preempted = False  # Use the action server to check that the trajectory isn't canceled
        for idx in range(len(segments_schedule.commands)):
            if self._arm_action_srv.is_preempt_requested():
                self._manager.log_info("Action has been preempted.")
                preempted = True
                break

            # Otherwise, execute the next segment of the trajectory
            self.send_segment_command(idx, segments_schedule, max_attempts)

        # Wait until Spot finishes executing the last segment sent
        if self._arm_command_id is not None:
            self._manager.block_until_arm_arrives(self._arm_command_id)

        return ArmCommandOutcome.PREEMPTED if preempted else ArmCommandOutcome.SUCCESS

    def send_segment_command(self, idx: int, schedule: SegmentSchedule, max_attempts: int) -> None:
        """Command Spot to execute the indexed trajectory segment from the given schedule.

        :param idx: Index into the schedule, corresponding to a joint trajectory segment
        :param schedule: Schedule specifying segment reference times and robot commands
        :param max_attempts: Maximum number of times to attempt (re)sending the segment
        """
        if self._arm_locked:
            self._manager.log_info("Cannot send trajectory segment because Spot's arm is locked.")
            return

        # Validate the trajectory to be sent
        traj = schedule.commands[
            idx
        ].synchronized_command.arm_command.arm_joint_move_command.trajectory

        if not len(traj.points):
            raise RuntimeError("Segment has no points.")
        if len(traj.points) > self._max_segment_len:
            raise RuntimeError(
                f"Segment contains {len(traj.points)} points; maximum is {self._max_segment_len}.",
            )
        if not traj.HasField("reference_time"):
            raise RuntimeError("Segment must have a reference_time (local time).")

        # Wait to send the segment until close to when it starts (only on the first attempt)
        max_rtt_s = max(0.0, self._manager.time_sync.max_round_trip_s)
        cushion_s = max(0.1, 2.0 * max_rtt_s)  # Margin for network jitter
        eps_s = 0.03  # Additional margin for segment-adjusting overhead
        send_early_s = schedule.min_lead_s + cushion_s + eps_s

        send_local_s = schedule.compute_send_local_time_s(idx, send_early_s)
        self._sleep_until(send_local_s)

        # Late guard: If we're too close or late, slide the segment forward
        delta_s = schedule.slide_segment_if_late(idx, send_early_s)
        if delta_s > 0:
            self._manager.log_info(f"Late by {delta_s:.3f} seconds; shifted the schedule.")

        # Retry loop: Adjust and resend only (no sleep)
        cumulative_bump_s = 0.0  # Cumulative bump (seconds) to delay each retry
        for attempt in range(1, max_attempts + 1):
            try:
                self._arm_command_id = self._manager.send_robot_command(schedule.commands[idx])

            except InvalidRequestError as err:  # noqa: PERF203
                attempt_num = f"{attempt}/{max_attempts}"
                self._manager.log_info(
                    f"Attempt {attempt_num}: Sending trajectory segment has failed.",
                )

                if "time point before the current robot time" not in str(err):
                    raise

                if attempt == max_attempts:
                    self._manager.log_info("Out of attempts, exiting...")
                    raise

                # Use previously observed lateness to inform retry (delay by cumulative_bump_s)
                delta_s = schedule.slide_segment_if_late(idx, send_early_s + cumulative_bump_s)
                if delta_s > 0:
                    self._manager.log_info(f"Late by {delta_s:.3f} seconds; shifted the schedule.")
                    cumulative_bump_s += delta_s + 0.05  # Build on observed lateness

            else:
                self._manager.log_info("Trajectory segment sent.\n")
                return


# def handle_place_object(self, request: PlaceObjectRequest) -> PlaceObjectResponse:
#         """Handle a request to place an object onto a surface."""
#         failure_message = None

#         if request.object_name not in self._env_state.object_names:
#             failure_message = f"Cannot place unknown object: '{request.object_name}'."
#         elif request.surface_name not in self._env_state.object_names:
#             failure_message = f"Cannot place onto unknown surface: '{request.surface_name}'."
#         elif self._curr_grasp is None:
#             failure_message = "Cannot place; must pick first."

#         if failure_message:
#             return PlaceObjectResponse(success=False, message=failure_message)

#         placed_obj = self._env_state.get_object_kinematic_state(request.object_name)
#         if placed_obj is None:
#             return PlaceObjectResponse(
#                 success=False,
#                 message=f"Unable to retrieve kinematic state of '{request.object_name}'.",
#             )

#         surface_obj = self._env_state.get_object_kinematic_state(request.surface_name)
#         if surface_obj is None:
#             return PlaceObjectResponse(
#                 success=False,
#                 message=f"Unable to retrieve kinematic state of '{request.surface_name}'.",
#             )

#         surface = PlacementSurface.from_object_aabb(surface_obj)
#         pose_ee_o = self._curr_grasp.pose_ee_o
#         place_pose_args = PlacePosesArgs(
#             surface,
#             placed_obj,
#             pose_ee_o,
#             self._arm_interface.manipulator,
#         )
#         generator = PlacePosesGenerator(place_pose_args)

#         for place_poses in generator:
#             rospy.loginfo(f"Attempting to motion plan for generator sample {generator.count}...")

#             pre_query = MotionPlanningQuery(ee_target=place_poses.preplace_pose)
#             place_query = MotionPlanningQuery(ee_target=place_poses.place_pose)
#             post_query = MotionPlanningQuery(ee_target=place_poses.postplace_pose)

#             with self._planning_scene_lock:
#                 pre_plan_msg = self._arm_interface.manipulator.planner.compute_motion_plan(
#                     pre_query,
#                 )
#             if pre_plan_msg is None:
#                 continue
#             pre_place_success = self._arm_interface.manipulator.execute_trajectory_msg(pre_plan_msg)
#             if not pre_place_success:
#                 message = "Failed to execute pre-place trajectory."
#                 return PlaceObjectResponse(success=False, message=message)

#             with self._planning_scene_lock:
#                 plan_msg = self._arm_interface.manipulator.planner.compute_motion_plan(place_query)
#             if plan_msg is None:
#                 continue
#             place_success = self._arm_interface.manipulator.execute_trajectory_msg(plan_msg)
#             if not place_success:
#                 message = "Failed to execute place trajectory."
#                 return PlaceObjectResponse(success=False, message=message)

#             with self._planning_scene_lock:
#                 post_plan_msg = self._arm_interface.manipulator.planner.compute_motion_plan(
#                     post_query,
#                 )
#             if post_plan_msg is None:
#                 continue
#             post_place_success = self._arm_interface.manipulator.execute_trajectory_msg(
#                 post_plan_msg,
#             )
#             if not post_place_success:
#                 message = "Failed to execute post-place trajectory."
#                 return PlaceObjectResponse(success=False, message=message)

#             return PlaceObjectResponse(success=True, message="Object has been placed.")

#         return PlaceObjectResponse(success=False, message="Unexpectedly exited loop???")
