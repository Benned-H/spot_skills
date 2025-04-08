"""Define a class to manage a sustained connection to a Spot robot."""

from __future__ import annotations

import time

import numpy as np
from bosdyn.api.basic_command_pb2 import StandCommand
from bosdyn.api.estop_pb2 import ESTOP_LEVEL_NONE
from bosdyn.api.gripper_command_pb2 import ClawGripperCommand
from bosdyn.api.robot_command_pb2 import RobotCommand
from bosdyn.api.spot.robot_command_pb2 import BodyControlParams, MobilityParams
from bosdyn.client import create_standard_sdk, frame_helpers
from bosdyn.client.door import DoorClient
from bosdyn.client.estop import EstopClient
from bosdyn.client.lease import LeaseClient, LeaseKeepAlive
from bosdyn.client.manipulation_api_client import ManipulationApiClient
from bosdyn.client.robot_command import (
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
from rospy import loginfo as ros_loginfo
from transform_utils.kinematics import Configuration, Pose2D
from transform_utils.transform_manager import TransformManager

from spot_skills_py.spot.spot_arm_controller import GripperCommandOutcome
from spot_skills_py.spot.spot_configuration import SPOT_SDK_ARM_JOINT_NAMES
from spot_skills_py.spot.spot_image_client import SpotImageClient
from spot_skills_py.spot.spot_sync import SpotTimeSync


class SpotManager:
    """A wrapper to ensure that Spot is safely connected and controllable."""

    def __init__(
        self,
        client_name: str,
        hostname: str,
        username: str,
        password: str,
    ) -> None:
        """Initialize the Spot manager by connecting to Spot.

        The robot's hostname can be:
            - A DNS name (e.g., spot.intranet.example.com)
            - An IP literal (e.g., 10.0.63.1)

        :param      client_name     Name to use for the created Spot SDK client
        :param      hostname        Network address of the robot to connect to
        :param      username        Username used to authenticate with Spot
        :param      password        Password used to authenticate with Spot

        Reference: spot-sdk/python/examples/hello_spot/hello_spot.py
        """
        self._created_time_s = time.time()  # Record when the SpotManager was created

        setup_logging(verbose=True)  # Use verbose logging for the Spot SDK

        # Create one robot object, although the SDK client can manage more than one
        self._sdk = create_standard_sdk(client_name)
        self._robot = self._sdk.create_robot(hostname)

        # We need to authenticate with Spot before using it
        self._robot.authenticate(username=username, password=password)

        # Establish a time-sync with Spot, which enables local-robot time conversion
        self.time_sync = SpotTimeSync(self._robot)

        self.log_info("Time sync has been established with Spot.")
        self.resync_and_log()

        # Define a client that can command Spot to move
        self.command_client = self._robot.ensure_client(RobotCommandClient.default_service_name)

        # Define a client to query the state of the robot
        self._state_client = self._robot.ensure_client(RobotStateClient.default_service_name)

        # Define a client to query Spot's e-stop status
        self._estop_client = self._robot.ensure_client(EstopClient.default_service_name)

        # Define an image client to interface with Spot's cameras
        self.image_client = SpotImageClient(self._robot)

        # Define clients used to control Spot to open doors
        self.manip_client = self._robot.ensure_client(ManipulationApiClient.default_service_name)
        self.door_client = self._robot.ensure_client(DoorClient.default_service_name)

        # Define a client to later obtain control of Spot (i.e., Spot's "lease")
        self._lease_client: LeaseClient = self._robot.ensure_client(
            LeaseClient.default_service_name,
        )
        self._lease_keeper = None  # Stores a lease and keeps it alive once obtained

        self._mobility_params = RobotCommandBuilder.mobility_params()

        assert self.wait_while_estopped()  # Wait until Spot isn't e-stopped

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

    def take_control(self, resource: str = "body", force: bool = False) -> bool:
        """Request control of a resource from Spot and ensure Spot is powered on.

        In detail, this method performs these steps:
            1. Attempt to acquire the resource's lease and then keep it alive
            2. Attempt to power on Spot, if necessary

        :param resource: Name of the resource for which to acquire a lease
        :param force: Whether the lease should be taken forcefully from any other owner
        :return: Boolean indicating if all attempted operations were successful
        """
        # 1. Attempt to acquire a lease from Spot and keep it alive
        if self._lease_keeper is None:
            self.log_info(f"Acquiring resource '{resource}'...")

            if force:
                self._lease_client.take(resource=resource)  # Forcefully take the lease
            else:
                self._lease_client.acquire(resource=resource)
            self._lease_keeper = LeaseKeepAlive(
                lease_client=self._lease_client,
                resource=resource,
                must_acquire=True,
                return_at_exit=True,
            )
            self.log_info("Lease acquired.")

        # 2. If needed, attempt to power on Spot
        if not self._robot.is_powered_on():
            self.log_info("Powering on Spot... This may take several seconds.")
            self._robot.power_on(timeout_sec=20)

        # Verify that the attempted operations succeeded
        power_success = self._robot.is_powered_on()

        self.log_info("Spot powered on." if power_success else "Spot power on failed.")

        self.log_info("Exiting SpotManager.take_control()...\n")

        return self.check_control()

    def check_control(self) -> bool:
        """Check whether the SpotManager has control of a powered-on robot.

        :returns: Boolean indicating if the manager has the lease and Spot is powered on
        """
        lease_alive = self._lease_keeper is not None and self._lease_keeper.is_alive()
        powered_on = self._robot.is_powered_on()

        return lease_alive and powered_on

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

        clock_skew_s = self.time_sync.robot_clock_skew_s
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
        if not self.check_control():
            return None

        # Issue a command to the robot synchronously (blocks until done sending)
        if duration_s is None:
            command_id: int = self.command_client.robot_command(
                command,
                timesync_endpoint=self.time_sync.get_time_sync_endpoint(),
            )
        else:  # Cut off the command after the given duration
            if self.time_sync.robot_clock_skew_s is None:
                self.log_info("Cannot send robot command because the robot is not time-synced.")
                return None

            command_id: int = self.command_client.robot_command(
                command,
                end_time_secs=time.time() + duration_s,
                timesync_endpoint=self.time_sync.get_time_sync_endpoint(),
            )

        self.log_info(f"Issued robot command with ID: {command_id}")

        return command_id

    def stand_up(self, timeout_s: float, control_params: BodyControlParams | None = None) -> bool:
        """Tell Spot to stand up within the given timeout (in seconds).

        :param timeout_s: Timeout (seconds) for the blocking stand command
        :param control_params: Parameters modifying Spot's standing body pose (defaults to None)
        :return: True if Spot stood up, otherwise False
        """
        if not self.check_control():
            return False

        if control_params is None:
            blocking_stand(self.command_client, timeout_sec=timeout_s)
        else:
            blocking_stand(
                self.command_client,
                timeout_sec=10.0,
                params=MobilityParams(body_control=control_params),
            )

        self.log_info("Robot standing.")
        return True

    def sit_down(self, timeout_s: float) -> bool:
        """Tell Spot to sit down within the given timeout (in seconds).

        :param timeout_s: Timeout (seconds) for the sit command
        :return: True if Spot sat down, otherwise False
        """
        if not self.check_control():
            return False

        blocking_sit(self.command_client, timeout_sec=timeout_s)
        self.log_info("Robot sitting.")
        return True

    def pitch_up(self, timeout_s: float) -> bool:
        """Pitch the robot body up to allow looking upwards with the body cameras.

        :param timeout_s: Timeout (seconds) for the pitch up command
        :return: True if the body was successfully pitched, else False
        """
        if not self.check_control():
            return False

        body_euler_zxy = EulerZXY(0.0, 0.0, -np.pi / 6.0)
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

        return True

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
        now = time.time()

        while now < end_time:
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

            time.sleep(0.1)
            now = time.time()

        return GripperCommandOutcome.FAILURE

    def deploy_arm(self) -> bool:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed.

        :returns: True if Spot's arm was deployed, otherwise False
        """
        if not self.check_control():
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
        if not self.check_control():
            return False

        self.log_info("Stowing Spot's arm...")
        arm_stow = RobotCommandBuilder.arm_stow_command()
        command_id = self.send_robot_command(arm_stow)
        if command_id is None:
            self.log_info("Could not stow Spot's arm.")
            return False

        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now stowed.")
        return True

    def navigate_to_base_pose(self, goal_base_pose: Pose2D, timeout_s: float) -> bool:
        """Send a command to Spot to navigate to the given base pose.

        Note: By default, the command is converted into the "vision" frame.

        :param goal_base_pose: Target base pose for the navigation
        :param timeout_s: Duration (seconds) after which the command times out
        :return: True if the navigation command succeeded, else False
        """
        if not self.check_control():
            return False

        vision_frame = frame_helpers.VISION_FRAME_NAME

        target_pose_v_b = TransformManager.convert_to_frame(goal_base_pose, vision_frame)
        _, _, target_yaw_rad = target_pose_v_b.orientation.to_euler_rpy()

        trajectory_command = RobotCommandBuilder.synchro_se2_trajectory_point_command(
            goal_x=target_pose_v_b.position.x,
            goal_y=target_pose_v_b.position.y,
            goal_heading=target_yaw_rad,
            frame_name=vision_frame,
            params=self._mobility_params,
        )

        command_id = self.send_robot_command(trajectory_command)
        if command_id is None:
            self.log_info("Navigation attempt returned None instead of a command ID.")
            return False

        return block_for_trajectory_cmd(self.command_client, command_id, timeout_sec=timeout_s)

    def send_velocity_command(
        self,
        linear_x_mps: float,
        linear_y_mps: float,
        angular_z_radps: float,
        duration_s: float,
    ) -> bool:
        """Send a velocity command to Spot.

        :param linear_x_mps: Linear velocity in the X direction (m/s)
        :param linear_y_mps: Linear velocity in the Y direction (m/s)
        :param angular_z_radps: Angular velocity about the Z axis (rad/s)
        :param duration_s: Duration (seconds) of the sent command
        :return: Boolean indicating if the command was successfully sent
        """
        if not self.check_control():
            return False

        velocity_cmd = RobotCommandBuilder.synchro_velocity_command(
            v_x=linear_x_mps,
            v_y=linear_y_mps,
            v_rot=angular_z_radps,
            params=self._mobility_params,
        )

        command_id = self.send_robot_command(velocity_cmd, duration_s)
        if command_id is None:
            self.log_info("Velocity command returned None instead of a command ID.")
            return False

        return block_for_trajectory_cmd(self.command_client, command_id, timeout_sec=duration_s)

    def release_control(self) -> None:
        """Release control of Spot so that other clients can control Spot."""
        if self._lease_keeper is not None:
            self.log_info("Releasing control of Spot...")
            self._lease_keeper.shutdown()  # Blocks until complete
            self._lease_keeper = None

    def safely_power_off(self) -> None:
        """Power Spot off by issuing a "safe power off" command."""
        self._robot.power_off(cut_immediately=False, timeout_sec=20)
        assert not self._robot.is_powered_on(), "Robot power off failed."
        self.log_info("Robot safely powered off.")

    def shutdown(self) -> None:
        """Shut-down by stowing the arm, sitting, powering off, and releasing Spot."""
        if self.check_control():
            self.log_info("Shutting down Spot using the controlling SpotManager...")

            self.stow_arm()
            self.safely_power_off()  # Send a "safe power off" command
            self.release_control()  # Return Spot's lease
