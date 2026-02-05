"""Define a class to manage a sustained connection to a Spot robot."""

from __future__ import annotations

import contextlib
import time
from dataclasses import dataclass
from typing import TYPE_CHECKING

from bosdyn.api.basic_command_pb2 import StandCommand
from bosdyn.api.docking.docking_pb2 import DockState
from bosdyn.api.estop_pb2 import ESTOP_LEVEL_NONE
from bosdyn.api.gripper_command_pb2 import ClawGripperCommand
from bosdyn.api.spot.robot_command_pb2 import BodyControlParams, MobilityParams
from bosdyn.client import create_standard_sdk
from bosdyn.client.docking import DockingClient, blocking_dock_robot, blocking_undock
from bosdyn.client.door import DoorClient
from bosdyn.client.estop import EstopClient
from bosdyn.client.exceptions import Error as SDKError
from bosdyn.client.frame_helpers import (
    BODY_FRAME_NAME,
    GRAV_ALIGNED_BODY_FRAME_NAME,
    HAND_FRAME_NAME,
    ODOM_FRAME_NAME,
    VISION_FRAME_NAME,
    get_a_tform_b,
)
from bosdyn.client.lease import (
    LeaseClient,
    LeaseKeepAlive,
    LeaseState,
    ResourceAlreadyClaimedError,
    add_lease_wallet_processors,
)
from bosdyn.client.manipulation_api_client import ManipulationApiClient
from bosdyn.client.math_helpers import SE3Pose
from bosdyn.client.robot_command import (
    CommandFailedError,
    RobotCommandBuilder,
    RobotCommandClient,
    block_for_trajectory_cmd,
    blocking_sit,
    blocking_stand,
)
from bosdyn.client.robot_command import block_until_arm_arrives as bd_block_arm_command
from bosdyn.client.robot_state import RobotStateClient
from bosdyn.client.util import setup_logging
from bosdyn.geometry import EulerZXY
from robotics_utils.motion_planning.navigation_goal import NavigationGoal
from robotics_utils.ros.transform_manager import TransformManager
from robotics_utils.skills import Outcome
from rospy import loginfo as ros_loginfo

from spot_skills_py.spot.spot_arm_controller import GripperCommandOutcome
from spot_skills_py.spot.spot_configuration import SPOT_SDK_ARM_JOINT_NAMES
from spot_skills_py.spot.spot_conversion import NOMINAL_STAND_HEIGHT_M
from spot_skills_py.spot.spot_image_client import SpotImageClient
from spot_skills_py.spot.spot_lidar import SpotLiDAR
from spot_skills_py.spot.spot_sync import SpotTimeSync

if TYPE_CHECKING:
    from bosdyn.api.robot_command_pb2 import RobotCommand
    from bosdyn.api.robot_state_pb2 import RobotState
    from robotics_utils.kinematics import Configuration
    from robotics_utils.robots import MobileRobot
    from robotics_utils.spatial import Pose2D


@dataclass(frozen=True)
class SpotControlStatus:
    """A lightweight snapshot of the control state for a Spot."""

    has_lease: bool
    powered_on: bool
    lease_resource: str
    lease_owner: str | None  # Name of the client application
    last_checked_s: float

    @property
    def ok(self) -> bool:
        """True if and only if we hold a live lease and the robot is powered on."""
        return self.has_lease and self.powered_on


class SpotManager:
    """A wrapper to ensure that Spot is safely connected and controllable."""

    def __init__(
        self,
        client_name: str,
        hostname: str,
        username: str,
        password: str,
        resource: str = "body",
        debug_mode: bool = False,
    ) -> None:
        """Initialize the Spot manager by connecting to Spot.

        The robot's hostname can be:
            - A DNS name (e.g., spot.intranet.example.com)
            - An IP literal (e.g., 10.0.63.1)

        :param client_name: Name to use for the created Spot SDK client
        :param hostname: Network address of the robot to connect to
        :param username: Username used to authenticate with Spot
        :param password: Password used to authenticate with Spot

        Reference: spot-sdk/python/examples/hello_spot/hello_spot.py
        """
        self._created_time_s = time.time()  # Record when the SpotManager was created
        self._resource = resource
        self.username = username
        self.debug_mode = debug_mode

        setup_logging(verbose=True)  # Use verbose logging for the Spot SDK

        # Create one robot object, although the SDK client can manage more than one
        self._sdk = create_standard_sdk(client_name)
        self._robot = self._sdk.create_robot(hostname)
        self._robot.authenticate(username=username, password=password)

        if self.debug_mode:
            # Check whether the Spot SDK and robot are using the same client name
            self.log_info(f"DEBUG: SDK client name: {self._sdk.client_name}")
            self.log_info(f"DEBUG: Robot client name: {self._robot.client_name}")

        # Establish a time-sync with Spot, which enables local-robot time conversion
        self.time_sync = SpotTimeSync(self._robot)
        self.log_info("Time sync has been established with Spot.")
        for _ in range(5):  # Repeatedly re-sync to hopefully better model network variance
            self.resync_and_log()

        # Define thresholds for 'close enough' during locomotion
        self.goal_reached_m = 0.2
        """Distance (meters) within which Spot is considered to have reached a goal base pose."""

        self.goal_yaw_tolerance_rad = 0.3
        """Angle (abs. radians) within which Spot's yaw is considered 'close enough' to a goal."""

        self.lease_wallet = self._robot.lease_wallet

        # Define a client to later obtain control of Spot (i.e., Spot's "lease")
        self._lease_client: LeaseClient = self._robot.ensure_client(
            LeaseClient.default_service_name,
        )
        add_lease_wallet_processors(self._lease_client, self.lease_wallet)

        # Define a client that can command Spot to move
        self.command_client = self._robot.ensure_client(RobotCommandClient.default_service_name)
        add_lease_wallet_processors(self.command_client, self.lease_wallet)

        # Define a client to query the state of the robot
        self._state_client = self._robot.ensure_client(RobotStateClient.default_service_name)
        add_lease_wallet_processors(self._state_client, self.lease_wallet)

        # Define a client to query Spot's e-stop status
        self._estop_client = self._robot.ensure_client(EstopClient.default_service_name)
        add_lease_wallet_processors(self._estop_client, self.lease_wallet)

        # Define an image client to interface with Spot's cameras
        self.image_client = SpotImageClient(self._robot, self.lease_wallet)

        # Define an interface for Spot's LiDAR sensor
        self.lidar_interface = SpotLiDAR(self)

        # Define clients used to control Spot to open doors
        self.manip_client = self._robot.ensure_client(ManipulationApiClient.default_service_name)
        add_lease_wallet_processors(self.manip_client, self.lease_wallet)

        self.door_client = self._robot.ensure_client(DoorClient.default_service_name)
        add_lease_wallet_processors(self.door_client, self.lease_wallet)

        # Define a client to allow Spot to dock or undock
        self._docking_client: DockingClient = self._robot.ensure_client(
            DockingClient.default_service_name,
        )
        add_lease_wallet_processors(self._docking_client, self.lease_wallet)

        # Stores a lease and keeps it alive once obtained
        self._lease_keeper: LeaseKeepAlive | None = None

        self._mobility_params = RobotCommandBuilder.mobility_params()

        assert self.wait_while_estopped()  # Wait until Spot isn't e-stopped

        # Initialize the control status for the SpotManager
        self._control_status: SpotControlStatus = self._compute_status()

        # Create reusable mobility params to prevent body compensation during arm motion
        body_control = BodyControlParams(
            body_assist_for_manipulation=BodyControlParams.BodyAssistForManipulation(
                enable_body_yaw_assist=False,
                enable_hip_height_assist=False,
            ),
        )
        self._no_body_assist_params = MobilityParams(body_control=body_control)

    def wait_while_estopped(self, timeout_s: int = 30) -> bool:
        """Notify the user if Spot is e-stopped by spamming the ROS and Spot logs.

        :param timeout_s: Time (seconds) after which the method gives up
        :return: True if Spot "e-started" (un-e-stopped) in time, else False
        """
        estop_level = self._estop_client.get_status().stop_level

        start_t = time.time()

        while (time.time() - start_t) < timeout_s:
            if estop_level == ESTOP_LEVEL_NONE:
                self.log_info("Spot is not e-stopped, continuing on...")
                return True

            self.log_info("Spot is currently e-stopped!")

            time.sleep(0.5)
            estop_level = self._estop_client.get_status().stop_level

        self.log_info(f"Spot remained e-stopped after {timeout_s} seconds.")
        return False

    def log_lease_info(self) -> None:
        """Log information regarding all leases the SpotManager may have acquired."""
        self.log_info("Logging current lease information...")

        list_leases = self._lease_client.list_leases()
        self.log_info(f"List of SpotManager's leases: {list_leases}")

    def take_control(self, force: bool = False, power_on: bool = True) -> bool:
        """Request control of a resource from Spot and ensure Spot is powered on.

        In detail, this method performs these steps:
            1. Attempt to acquire the resource's lease and then keep it alive
            2. Attempt to power on Spot, if necessary

        :param force: Whether the lease should be taken forcefully from any other owner
        :param power_on: If True, ensure the robot is powered on
        :return: Boolean indicating if all attempted operations were successful
        """
        self._control_status = self._compute_status()

        if self.has_control:
            self.log_info("SpotManager already has control of Spot.")
            return True

        if self._lease_keeper is not None:  # Always clear any stale KeepAlive first
            with contextlib.suppress(Exception):
                self._lease_keeper.shutdown()
            self._lease_keeper = None

        self.log_info(f"Acquiring resource '{self._resource}' (force={force})...")
        try:
            lease = (
                self._lease_client.take(resource=self._resource)
                if force
                else self._lease_client.acquire(resource=self._resource)
            )
        except ResourceAlreadyClaimedError as claimed_err:
            if not force:
                self.log_info(f"Failed to take lease because force wasn't used: {claimed_err!r}")
                return False

            raise RuntimeError(f"ResourceAlreadyClaimedError when force={force}.") from claimed_err

        except SDKError as sdk_err:
            self.log_info(f"Lease acquire/take failed: {sdk_err!r}")
            self._control_status = self._compute_status()
            return False

        if self.debug_mode:
            self.log_info(f"DEBUG: Acquired lease owner: {lease.lease_proto.client_names}")

        # Add the lease to the wallet (allows future RPCs to auto-attach)
        self.lease_wallet.add(lease)

        # Start background keepalive using the WALLET (not a lease)
        self._lease_keeper = LeaseKeepAlive(
            lease_client=self._lease_client,
            lease_wallet=self.lease_wallet,
            resource=self._resource,
            must_acquire=False,  # Because we've just acquired above
            return_at_exit=True,  # If True, returns the lease upon shutdown
        )

        # 2. If requested and needed, attempt to power on Spot
        if power_on and not self._robot.is_powered_on():
            self.log_info("Powering on Spot... This may take several seconds.")
            try:  # Try to power on the robot
                self._robot.power_on(timeout_sec=20)
            except Exception as exc:
                self.log_info(f"Power on failed: {exc}, releasing lease...")
                self.release_control()

        self._control_status = self._compute_status()
        not_msg = "" if self._control_status.ok else "not "
        self.log_info(f"Resource '{self._resource}' was {not_msg}acquired.")

        return self._control_status.ok if power_on else self._control_status.has_lease

    def _holds_live_lease(self) -> bool:
        """Check that we have a LeaseKeepAlive and that it's alive."""
        return (self._lease_keeper is not None) and self._lease_keeper.is_alive()

    def ensure_control(self, *, take_by_force: bool = True) -> bool:
        """Idempotent method to guarantee that the SpotManager has control of Spot."""
        self._control_status = self._compute_status()

        if self._control_status.ok:
            return True

        return self.take_control(force=take_by_force, power_on=True)

    def release_control(self) -> None:
        """Return the lease and stop the LeaseKeepAlive."""
        self.log_info("Releasing control of Spot...")
        try:
            if self._lease_keeper:
                self._lease_keeper.shutdown()  # Blocks and returns lease due to return_at_exit
                self._lease_keeper = None

        finally:
            self._control_status = self._compute_status()

    @property
    def has_control(self) -> bool:
        """Check whether the SpotManager has control of Spot right now."""
        self._control_status = self._compute_status()
        return self._control_status.ok

    def _compute_status(self) -> SpotControlStatus:
        """Compute the current control status of the SpotManager."""
        powered_on = False
        try:
            powered_on = self._robot.is_powered_on()
        except Exception:
            powered_on = False

        has_lease = False
        lease_owner = None

        try:  # Prefer the wallet as the ground truth for leases
            state: LeaseState = self.lease_wallet.get_lease_state(self._resource)

            if self.debug_mode:
                self.log_info(
                    f"DEBUG: lease_status={state.lease_status}, "
                    f"SELF_OWNER={LeaseState.Status.SELF_OWNER}",
                )
                self.log_info(f"DEBUG: _holds_live_lease={self._holds_live_lease()}")

            has_lease = state.lease_status == LeaseState.Status.SELF_OWNER
            # Double-check that the KeepAlive thread is up
            has_lease = has_lease and self._holds_live_lease()

            lease_owner = state.lease_owner.client_name if state.lease_owner else None

            if self.debug_mode:
                self.log_info(
                    f"DEBUG: lease_owner={lease_owner} SDK client name: {self._sdk.client_name}",
                )

        except Exception as exc:
            self.log_info(f"Exception while checking control status of SpotManager: {exc}")
            has_lease = self._holds_live_lease()

        if self.debug_mode:
            self.log_info(f"DEBUG: has_lease={has_lease}, powered_on={powered_on}")

        return SpotControlStatus(
            has_lease=bool(has_lease),
            powered_on=bool(powered_on),
            lease_resource=self._resource,
            lease_owner=lease_owner,
            last_checked_s=time.time(),
        )

    def log_info(self, message: str) -> None:
        """Log the given message to the Spot and ROS information logs.

        :param      message     String to be logged via Spot SDK and ROS
        """
        manager_age_s = time.time() - self._created_time_s

        formatted_message = f"[SpotManager at {manager_age_s:.3f} s] {message}"

        self._robot.logger.info(formatted_message)
        ros_loginfo(formatted_message)

    def resync_and_log(self) -> None:
        """Resync with Spot and log information describing the resulting time sync."""
        self.time_sync.resync()

        round_trip_s = self.time_sync.get_round_trip_s()
        self.log_info(f"Current round trip time: {round_trip_s} seconds.")

        max_round_trip_s = self.time_sync.max_round_trip_s
        self.log_info(f"Maximum observed round trip time: {max_round_trip_s} seconds.")

        clock_skew_s = self.time_sync.get_robot_clock_skew_s()
        self.log_info(f"Current robot clock skew from local: {clock_skew_s} seconds.")

        max_sync_time_s = self.time_sync.max_sync_time_s
        self.log_info(
            f"Maximum duration any time-sync has taken: {max_sync_time_s} seconds.",
        )

        avg_sync_time_s = self.time_sync.get_avg_sync_time_s()
        self.log_info(
            f"Average duration per resync with Spot: {avg_sync_time_s} seconds.",
        )

    def has_arm(self) -> bool:
        """Check whether the Spot robot has an arm connected."""
        return self._robot.has_arm()

    def get_arm_configuration(self) -> Configuration:
        """Query and return the current configuration of Spot's arm.

        Note: Ignores the velocities and accelerations of Spot's arm joints.

        :returns: Configuration mapping joint names (per Spot SDK) to their positions
        """
        robot_state = self._state_client.get_robot_state()
        sdk_joint_states = robot_state.kinematic_state.joint_states

        # Use the joint names as sent from Spot directly (differs from URDF names)
        # See Lines 81-87 of spot_ros/spot_driver/src/spot_driver/ros_helpers.py

        return {
            joint.name: joint.position.value
            for joint in sdk_joint_states
            if joint.name in SPOT_SDK_ARM_JOINT_NAMES
        }

    def get_robot_state(self) -> RobotState:
        """Query and return the current state of Spot.

        :return: Protobuf message representing the current state of the robot
        """
        return self._state_client.get_robot_state()

    def get_hand_pose(self, *, ref_frame: str = ODOM_FRAME_NAME) -> SE3Pose:
        """Query and return the pose of Spot's hand in the specified Spot SDK frame."""
        robot_state = self.get_robot_state()
        pose = get_a_tform_b(
            robot_state.kinematic_state.transforms_snapshot,
            ref_frame,
            HAND_FRAME_NAME,
        )
        assert isinstance(pose, SE3Pose)
        return pose

    def send_robot_command(
        self,
        command: RobotCommand,
        duration_s: float | None = None,
    ) -> int | None:
        """Command Spot to execute the given robot command.

        Note: The RobotCommandClient.robot_command() method will automatically update
            all timestamps in the command from local time to robot time.

        :param command: Robot command for Spot to execute
        :param duration_s: Duration (seconds) after which to end the command
        :return: ID (integer) of the issued robot command, or None if manager doesn't control Spot
        """
        if not self.has_control:
            return None

        # Issue a command to the robot synchronously (blocks until done sending)
        if duration_s is None:
            command_id: int = self.command_client.robot_command(
                command,
                timesync_endpoint=self.time_sync.endpoint,
            )
        else:  # Cut off the command after the given duration
            command_id: int = self.command_client.robot_command(
                command,
                end_time_secs=time.time() + duration_s,
                timesync_endpoint=self.time_sync.endpoint,
            )

        self.log_info(f"Issued robot command with ID: {command_id}")

        return command_id

    def stand_up(self, timeout_s: float, control_params: BodyControlParams | None = None) -> bool:
        """Tell Spot to stand up within the given timeout (in seconds).

        :param timeout_s: Timeout (seconds) for the blocking stand command
        :param control_params: Parameters modifying Spot's standing body pose (defaults to None)
        :return: True if Spot stood up, otherwise False
        """
        if not self.has_control:
            return False

        if control_params is None:
            blocking_stand(self.command_client, timeout_sec=timeout_s)
        else:
            blocking_stand(
                self.command_client,
                timeout_sec=timeout_s,
                params=MobilityParams(body_control=control_params),
            )

        self.log_info("Robot standing.")
        return True

    def sit_down(self, timeout_s: float) -> bool:
        """Tell Spot to sit down within the given timeout (in seconds).

        :param timeout_s: Timeout (seconds) for the sit command
        :return: True if Spot sat down, otherwise False
        """
        if not self.has_control:
            return False

        blocking_sit(self.command_client, timeout_sec=timeout_s)
        self.log_info("Robot sitting.")
        return True

    def pitch_up(self, pitch_rad: float, timeout_s: float = 60.0) -> bool:
        """Pitch the robot body up to allow looking upwards with the body cameras.

        :param pitch_rad: Pitch angle (radians) used in the command
        :param timeout_s: Timeout (seconds) for the pitch up command (defaults to one minute)
        :return: True if the body was successfully pitched, else False
        """
        if not self.has_control:
            return False

        body_euler_zxy = EulerZXY(0.0, 0.0, pitch_rad)
        pitch_command = RobotCommandBuilder.synchro_stand_command(footprint_R_body=body_euler_zxy)
        command_id = self.send_robot_command(pitch_command)

        if command_id is None:
            self.log_info("Could not pitch Spot's body.")
            return False

        end_time = time.time() + timeout_s
        while time.time() < end_time:
            command_feedback = self.command_client.robot_command_feedback(command_id)
            synchronized_feedback = command_feedback.feedback.synchronized_feedback
            status = synchronized_feedback.mobility_command_feedback.stand_feedback.status

            if status == StandCommand.Feedback.STATUS_IS_STANDING:
                self.log_info("Robot pitched.")
                return True

            time.sleep(0.25)

        return False

    def build_hold_body_pose_command(self) -> RobotCommand:
        """Build a stand command that holds Spot's current body pose.

        If we don't explicitly command Spot to maintain its body pose when executing
        ArmJointMoveCommands, it will reset to its default body pose.

        :return: A RobotCommand that holds the current body pose without body assist
        """
        robot_state = self.get_robot_state()
        transforms = robot_state.kinematic_state.transforms_snapshot

        footprint_t_body = get_a_tform_b(transforms, GRAV_ALIGNED_BODY_FRAME_NAME, BODY_FRAME_NAME)
        if not footprint_t_body:
            raise RuntimeError("Unable to retrieve footprint-to-body transform from Spot.")

        # For some reason, body height is specified relative to a "nominal stand height"
        body_height_offset_m = footprint_t_body.z - NOMINAL_STAND_HEIGHT_M

        quat = footprint_t_body.rot
        body_orientation = EulerZXY(yaw=quat.to_yaw(), roll=quat.to_roll(), pitch=quat.to_pitch())

        return RobotCommandBuilder.synchro_stand_command(
            params=self._no_body_assist_params,
            body_height=body_height_offset_m,
            footprint_R_body=body_orientation,
        )

    def block_until_standing(self, command_id: int, timeout_s: float = 10.0) -> bool:
        """Block until Spot achieves the specified stand command's target pose.

        :param command_id: ID of an already-issued stand command
        :param timeout_s: Timeout (seconds) for blocking (default: 10)
        :return: True if the command completed, else False on timeout
        """
        end_time = time.time() + timeout_s
        while time.time() < end_time:
            response = self.command_client.robot_command_feedback(command_id)
            sync_feedback = response.feedback.synchronized_feedback
            status = sync_feedback.mobility_command_feedback.stand_feedback.status
            standing_state = sync_feedback.mobility_command_feedback.stand_feedback.standing_state

            if standing_state == StandCommand.Feedback.STANDING_FROZEN:
                self.log_info("Spot is standing with its body frozen in place (STANDING_FROZEN).")

            if status == StandCommand.Feedback.STATUS_IS_STANDING:
                return True

            time.sleep(0.25)

        return False

    def block_until_arm_arrives(self, command_id: int) -> None:
        """Block until Spot's arm arrives at the identified command's goal.

        :param command_id: ID of a robot command for Spot's arm
        """
        self.log_info("Blocking until arm arrives...")
        bd_block_arm_command(self.command_client, command_id)
        time.sleep(0.5)
        self.log_info("Done blocking.\n")

    def block_during_gripper_command(
        self,
        command_id: int,
        timeout_s: float = 5.0,
    ) -> GripperCommandOutcome:
        """Block until Spot's gripper completes the identified command (or time runs out).

        :param command_id: ID of a robot command for Spot's gripper
        :param timeout_s: Timeout (seconds) after which the command is considered failed
        :return: Enum member indicating the outcome of the gripper command
        """
        end_time = time.time() + timeout_s

        while time.time() < end_time:
            response = self.command_client.robot_command_feedback(command_id)
            if response.feedback.HasField("synchronized_feedback"):
                sync_fb = response.feedback.synchronized_feedback

                if sync_fb.HasField("gripper_command_feedback"):
                    gripper_status = sync_fb.gripper_command_feedback.claw_gripper_feedback.status

                    # If gripper has reached its goal, or entered force control mode, success!
                    if gripper_status == ClawGripperCommand.Feedback.STATUS_AT_GOAL:
                        return GripperCommandOutcome.REACHED_SETPOINT

                    if gripper_status == ClawGripperCommand.Feedback.STATUS_APPLYING_FORCE:
                        return GripperCommandOutcome.STALLED

                    if gripper_status == ClawGripperCommand.Feedback.STATUS_UNKNOWN:
                        return GripperCommandOutcome.FAILURE

            time.sleep(0.25)

        return GripperCommandOutcome.FAILURE

    def deploy_arm(self) -> bool:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed.

        :returns: True if Spot's arm was deployed, otherwise False
        """
        if not self.has_control:
            return False

        self.log_info("Deploying Spot's arm to the 'ready' position...")
        arm_ready = RobotCommandBuilder.arm_ready_command()
        command_id = self.send_robot_command(arm_ready)
        if command_id is None:
            self.log_info("Could not deploy Spot's arm.")
            return False

        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now ready.")
        return True

    def stow_arm(self) -> bool:
        """Stow Spot's arm and wait until the arm has finished stowing.

        :returns: True if Spot's arm was stowed, otherwise False
        """
        if not self.has_control:
            return False

        self.log_info("Stowing Spot's arm...")
        arm_stow = RobotCommandBuilder.arm_stow_command()
        command_id = self.send_robot_command(arm_stow)  # No timeout
        if command_id is None:
            self.log_info("Could not stow Spot's arm.")
            return False

        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now stowed.")
        return True

    def _make_trajectory_command(self, base_pose: Pose2D) -> RobotCommand:
        """Construct a trajectory command to move Spot toward the given base pose.

        :param base_pose: Target base pose for the trajectory
        :return: RobotCommand Protobuf message containing the trajectory
        """
        target_pose_v_b = TransformManager.convert_to_frame(base_pose, VISION_FRAME_NAME)

        return RobotCommandBuilder.synchro_se2_trajectory_point_command(
            goal_x=target_pose_v_b.x,
            goal_y=target_pose_v_b.y,
            goal_heading=target_pose_v_b.yaw_rad,
            frame_name=VISION_FRAME_NAME,
            params=self._mobility_params,
        )

    def send_trajectory_command(self, pose: Pose2D, duration_s: float) -> bool:
        """Send a single trajectory command to move toward a base pose (non-blocking).

        Use this for ongoing path following where the caller handles goal checking.

        :param pose: Target base pose for the trajectory
        :param duration_s: Duration (seconds) for the command
        :return: True if command was successfully sent, else False
        """
        if not self.has_control:
            self.log_info("Can't send trajectory command; SpotManager doesn't control Spot.")
            return False

        trajectory_command = self._make_trajectory_command(base_pose=pose)
        command_id = self.send_robot_command(trajectory_command, duration_s=duration_s)

        return command_id is not None

    def move_to_base_pose(self, pose: Pose2D, spot_base: MobileRobot, timeout_s: float) -> bool:
        """Move to a base pose, polling until the goal is reached, then stop the robot.

        :param pose: Target base pose of the movement
        :param spot_base: General-purpose interface for Spot's mobile base
        :param timeout_s: Duration (seconds) after which the command times out
        :return: True if Spot reaches the goal, else False
        """
        if not self.has_control:
            self.log_info("Can't move to base pose because SpotManager doesn't control Spot.")
            return False

        trajectory_command = self._make_trajectory_command(base_pose=pose)

        nav_goal = NavigationGoal(pose, self.goal_reached_m, self.goal_yaw_tolerance_rad)
        end_time_s = time.time() + timeout_s

        # Repeatedly send the trajectory command to Spot until timeout or the goal is reached
        reached_goal = spot_base.goal_reached(nav_goal, change_frames=True)
        while not reached_goal and time.time() < end_time_s:
            command_id = self.send_robot_command(trajectory_command, duration_s=5)
            if command_id is None:
                self.log_info("Locomotion attempt returned None instead of a command ID.")
                continue

            reached_goal = spot_base.goal_reached(nav_goal, change_frames=True)
            time.sleep(0.2)

        self.stop_walking()
        return spot_base.goal_reached(nav_goal, change_frames=True)

    def stop_walking(self) -> int | None:
        """Command Spot to stop locomotion and stand in place.

        :return: Command ID of the stop command
        """
        stop_command = RobotCommandBuilder.stop_command()
        return self.send_robot_command(stop_command)

    def send_velocity_command_nonblocking(
        self,
        linear_x_mps: float,
        linear_y_mps: float,
        angular_z_radps: float,
        duration_s: float,
    ) -> int | None:
        """Send a velocity command to Spot without blocking.

        :param linear_x_mps: Linear velocity in the X direction (m/s)
        :param linear_y_mps: Linear velocity in the Y direction (m/s)
        :param angular_z_radps: Angular velocity about the Z axis (rad/s)
        :param duration_s: Duration (seconds) of the sent command
        :return: Command ID if command was successfully sent, else None
        """
        if not self.has_control:
            return False

        velocity_cmd = RobotCommandBuilder.synchro_velocity_command(
            v_x=linear_x_mps,
            v_y=linear_y_mps,
            v_rot=angular_z_radps,
            params=self._mobility_params,
        )

        self.log_info(f"Sending velocity command to Spot with duration of {duration_s} seconds...")
        return self.send_robot_command(velocity_cmd, duration_s)

    def send_velocity_command(
        self,
        linear_x_mps: float,
        linear_y_mps: float,
        angular_z_radps: float,
        duration_s: float,
    ) -> bool:
        """Send a velocity command to Spot and block until it finishes.

        :param linear_x_mps: Linear velocity in the X direction (m/s)
        :param linear_y_mps: Linear velocity in the Y direction (m/s)
        :param angular_z_radps: Angular velocity about the Z axis (rad/s)
        :param duration_s: Duration (seconds) of the sent command
        :return: Boolean indicating if the command was successfully sent
        """
        command_id = self.send_velocity_command_nonblocking(
            linear_x_mps=linear_x_mps,
            linear_y_mps=linear_y_mps,
            angular_z_radps=angular_z_radps,
            duration_s=duration_s,
        )

        if command_id is None:
            self.log_info("Velocity command returned None instead of a command ID.")
            return False

        self.log_info("Now blocking until the velocity command finishes...")
        return block_for_trajectory_cmd(self.command_client, command_id, timeout_sec=duration_s)

    def dock(self, dock_id: int, timeout_s: int = 60) -> bool:
        """Send a docking command to Spot with the given dock ID and block until it finishes.

        :param dock_id: Dock ID number to attempt docking at
        :param timeout_s: Maximum duration (seconds) to wait for docking (defaults to 60)
        :return: True if Spot successfully docked, else False
        """
        if not self.has_control:
            self.log_info("Cannot dock Spot because SpotManager doesn't control Spot.")
            return False

        try:
            blocking_dock_robot(self._robot, dock_id=dock_id, timeout=timeout_s)
        except CommandFailedError as dock_err:
            self.log_info(f"Docking failed for dock #{dock_id}: {dock_err}")
            return False
        else:
            self.log_info(f"Docking succeeded at dock #{dock_id}.")
            return True

    def undock(self, timeout_s: int = 20) -> Outcome:
        """Send an undocking command to Spot and block until it finishes.

        :param timeout_s: Maximum duration (seconds) to wait for undocking (defaults to 60)
        :return: Boolean success indicator and outcome message
        """
        if not self.has_control:
            return Outcome(
                success=False,
                message="Cannot undock because SpotManager doesn't control Spot.",
            )

        docking_status = self._docking_client.get_docking_state().status
        if docking_status == DockState.DockedStatus.DOCK_STATUS_UNKNOWN:
            return Outcome(
                success=False,
                message="Spot's docking status is unknown; cannot undock.",
            )
        if docking_status == DockState.DockedStatus.DOCK_STATUS_DOCKING:
            return Outcome(
                success=False,
                message="Spot is in the process of docking; cannot undock.",
            )
        if docking_status == DockState.DockedStatus.DOCK_STATUS_UNDOCKED:
            return Outcome(success=True, message="Spot is already undocked.")
        if docking_status == DockState.DockedStatus.DOCK_STATUS_UNDOCKING:
            return Outcome(
                success=False,
                message="Spot is in the process of undocking; cannot undock.",
            )

        if docking_status != DockState.DockedStatus.DOCK_STATUS_DOCKED:
            raise RuntimeError(f"Unknown Spot SDK DockState.DockedStatus: {docking_status}.")

        try:
            blocking_undock(self._robot, timeout=timeout_s)
        except CommandFailedError as undock_err:
            return Outcome(success=False, message=f"Undocking failed: {undock_err}")

        return Outcome(success=True, message="Successfully undocked Spot.")

    def stop_robot(self, *, stow_arm: bool) -> None:
        """Issue a stop command to gently halt Spot's current motion.

        :param stow_arm: Boolean indicating if Spot's arm should also be stowed
        """
        stop_cmd = RobotCommandBuilder.stop_command()
        self.send_robot_command(stop_cmd)
        self.log_info("Sent stop command to halt robot motion.")

        if stow_arm and self.has_arm():
            self.stow_arm()

    def safely_power_off(self) -> None:
        """Power Spot off by issuing a "safe power off" command."""
        self._robot.power_off(cut_immediately=False, timeout_sec=20)
        assert not self._robot.is_powered_on(), "Robot power off failed."
        self.log_info("Robot safely powered off.")

    def shutdown(self) -> None:
        """Shut-down by stowing the arm, sitting, powering off, and releasing Spot."""
        if self.has_control:
            self.log_info("Shutting down Spot using the controlling SpotManager...")

            self.stow_arm()
            self.sit_down(timeout_s=10.0)
            self.safely_power_off()  # Send a "safe power off" command
            self.release_control()  # Return Spot's lease
