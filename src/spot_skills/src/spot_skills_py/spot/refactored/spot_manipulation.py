"""Define a class implementing ROS services that control Spot's gripper and arm."""

from __future__ import annotations

import time
from enum import IntEnum

import rospy
from actionlib import SimpleActionServer
from bosdyn.api.gripper_command_pb2 import ClawGripperCommand
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
from robotics_utils.parallelism import ResourceManager
from robotics_utils.ros import TransformManager
from robotics_utils.spatial import Pose3D
from robotics_utils.states import ObjectCentricState
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse

from spot_skills.srv import ReleaseObject, ReleaseObjectRequest, ReleaseObjectResponse
from spot_skills_py.joint_trajectory import JointTrajectory
from spot_skills_py.spot.spot_configuration import MAP_JOINT_NAMES_SPOT_SDK_TO_URDF
from spot_skills_py.spot.spot_conversion import (
    SPOT_GRIPPER_CLOSED_RAD,
    SPOT_GRIPPER_OPEN_RAD,
    pose_to_sdk,
)
from spot_skills_py.spot.spot_manager import SpotManager
from spot_skills_py.time_stamp import TimeStamp


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
        env_state: ObjectCentricState,
        max_segment_len: int = 250,
        gripper_action_name: str = "gripper_controller/gripper_action",
        arm_action_name: str = "arm_controller/follow_joint_trajectory",
    ) -> None:
        """Initialize the ROS services provided by the interface.

        :param manager: Spot-SDK-based interface for Spot
        :param robot_rpc_manager: Manages priority access to Spot's RPC client
        :param env_state: State of the environment around Spot
        :param max_segment_len: Maximum number of points in sent trajectory segments (default: 250)
        :param gripper_action_name: Name of the gripper command ROS action
        :param arm_action_name: Name of the arm trajectory command ROS action
        """
        self._arm_locked = True

        self._manager = manager
        self._robot_rpc_manager = robot_rpc_manager
        self._env_state = env_state
        self._max_segment_len = max_segment_len
        self._arm_action_name = arm_action_name

        # Gripper-related actions and services
        self._gripper_action_srv = SimpleActionServer(
            name=gripper_action_name,
            ActionSpec=GripperCommandAction,
            execute_cb=self._gripper_action_cb,
            auto_start=False,
        )
        self._gripper_action_srv.start()
        rospy.loginfo(f"[{gripper_action_name}] Action server has started.")

        self._release_srv = rospy.Service("spot/release_object", ReleaseObject, self._release_cb)

        # Arm-related services
        self._unlock_arm_srv = rospy.Service("spot/unlock_arm", Trigger, self._unlock_arm_cb)
        self._stow_arm_srv = rospy.Service("spot/stow_arm", Trigger, self._stow_arm_cb)

        self._arm_action_srv = SimpleActionServer(
            name=self._arm_action_name,
            ActionSpec=FollowJointTrajectoryAction,
            execute_cb=self._arm_action_cb,
            auto_start=False,
        )
        self._arm_action_srv.start()
        rospy.loginfo(f"[{arm_action_name}] Action server has started.")

        self._arm_command_id: int | None = None
        """ID of the latest command sent to Spot's arm."""

    def _unlock_arm_cb(self, _: TriggerRequest) -> TriggerResponse:
        """Unlock Spot's arm, allowing it to be controlled via ROS.

        If the SpotManager doesn't yet control Spot, control will be forcibly taken.
        """
        if self._manager.ensure_control(take_by_force=True):
            self._arm_locked = False
            # TODO: Unlock arm controller too?
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
        self._env_state.set_known_object_pose(obj_name=object_name, pose=object_wrt_parent)

        return ReleaseObjectResponse(success=True, message=f"Released object '{object_name}'.")

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
        outcome = self.command_gripper(target_rad=SPOT_GRIPPER_OPEN_RAD)  # Checks if arm locked
        return outcome == GripperCommandOutcome.REACHED_SETPOINT

    def close_gripper(self) -> bool:
        """Attempt to close Spot's gripper.

        :return: True if closing the gripper succeeded, else False
        """
        outcome = self.command_gripper(target_rad=SPOT_GRIPPER_CLOSED_RAD)  # Checks if arm locked
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

            if abs(curr_rad - command_rad) < angle_proximity_rad:
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
