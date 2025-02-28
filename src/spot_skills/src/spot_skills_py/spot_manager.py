"""Define a class to manage a sustained connection to a Spot robot."""

from __future__ import annotations

import time
import typing

from bosdyn.api.estop_pb2 import ESTOP_LEVEL_NONE
from bosdyn.api.gripper_command_pb2 import ClawGripperCommand
from bosdyn.api.robot_command_pb2 import RobotCommand
from bosdyn.api.spot.robot_command_pb2 import MobilityParams
from bosdyn.client import frame_helpers
from bosdyn.client import math_helpers
from bosdyn.client import create_standard_sdk
from bosdyn.client.estop import EstopClient
from bosdyn.client.lease import LeaseClient, LeaseKeepAlive
from bosdyn.client.robot_command import (
    RobotCommandBuilder,
    RobotCommandClient,
    blocking_stand,
)
from bosdyn.client.robot_command import block_until_arm_arrives as bd_block_arm_command
from bosdyn.client.robot_state import RobotStateClient
from bosdyn.client.util import setup_logging
from bosdyn.client import frame_helpers
from rospy import loginfo as ros_loginfo
from transform_utils.kinematics import Configuration

from spot_skills_py.spot_arm_controller import GripperCommandOutcome
from spot_skills_py.spot_configuration import SPOT_SDK_ARM_JOINT_NAMES
from spot_skills_py.spot_image_client import SpotImageClient
from spot_skills_py.spot_sync import SpotTimeSync


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

        # Define a client to later obtain control of Spot (i.e., Spot's "lease")
        self._lease_client: LeaseClient = self._robot.ensure_client(
            LeaseClient.default_service_name,
        )
        self._lease_keeper = None  # Stores a lease and keeps it alive once obtained

        assert self.wait_while_estopped()  # Wait until Spot isn't e-stopped

        self._mobility_params = RobotCommandBuilder.mobility_params()

    def wait_while_estopped(self, timeout_s: int = 30) -> bool:
        """Notify the user if Spot is e-stopped by spamming the ROS and Spot logs.

        :param      timeout_s       Time (seconds) after which the method gives up

        :returns    Boolean: Was Spot "e-started" (un-e-stopped) in time?
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

    def take_control(self, resource: str = "body") -> bool:
        """Request control of a resource from Spot and ensure Spot is powered on.

        In detail, this method performs these steps:
            1. Attempt to acquire the resource's lease and then keep it alive
            2. Attempt to power on Spot, if necessary

        :params     resource    Name of the resource for which to acquire a lease

        :returns    Boolean indicating if all attempted operations were successful
        """
        # 1. Attempt to acquire a lease from Spot and keep it alive
        if self._lease_keeper is None:
            self.log_info(f"Acquiring resource '{resource}'...")
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
        lease_alive = self.check_lease_alive()
        power_success = self._robot.is_powered_on()

        self.log_info("Spot powered on." if power_success else "Spot power on failed.")

        self.log_info("Exiting SpotManager.take_control()...\n")

        return lease_alive and power_success

    def check_lease_alive(self) -> bool:
        """Check whether the SpotManager has a live lease for Spot."""
        return self._lease_keeper is not None and self._lease_keeper.is_alive()

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

    def send_robot_command(self, command: RobotCommand, end_time_secs: int=None) -> int:
        """Command Spot to execute the given robot command.

        Note: The RobotCommandClient.robot_command() method will automatically update
            all timestamps in the command from local time to robot time.

        :param      command     Command for Spot to execute

        :returns    ID (integer) of the issued robot command
        """
        # Issue a command to the robot synchronously (blocks until done sending)
        command_id: int = self.command_client.robot_command(
            command,
            end_time_secs=end_time_secs,
            timesync_endpoint=self.time_sync.get_time_sync_endpoint(),
        )

        return command_id

    def trajectory_cmd(
        self,
        goal_x: float,
        goal_y: float,
        goal_heading: float,
        cmd_duration: float,
        frame_name: str = "odom",
        precise_position: bool = False,
        mobility_params: MobilityParams = None,
    ) -> typing.Tuple[bool, str]:
        """Send a trajectory motion command to the robot.

        Args:
            goal_x: Position X coordinate in meters
            goal_y: Position Y coordinate in meters
            goal_heading: Pose heading in radians
            cmd_duration: Time-to-live for the command in seconds.
            frame_name: frame_name to be used to calc the target position. 'odom' or 'vision'
            precise_position: if set to false, the status STATUS_NEAR_GOAL and STATUS_AT_GOAL will be equivalent. If
            true, the robot must complete its final positioning before it will be considered to have successfully
            reached the goal.
            mobility_params: Mobility parameters to send along with this command

        Returns:
            (bool, str) tuple indicating whether the command was successfully sent, and a message
        """
        if mobility_params is None:
            mobility_params = self._mobility_params
        self._trajectory_status_unknown = False
        self.at_goal = False
        self.near_goal = False
        self.last_trajectory_command_precise = precise_position
        self.log_info("got command duration of {}".format(cmd_duration))
        end_time = time.time() + cmd_duration
        error = None
        try:
            if frame_name == "vision":
                vision_tform_body = frame_helpers.get_vision_tform_body(
                    self._state_client.get_robot_state().kinematic_state.transforms_snapshot
                )
                body_tform_goal = math_helpers.SE3Pose(
                    x=goal_x, y=goal_y, z=0, rot=math_helpers.Quat.from_yaw(goal_heading)
                )
                vision_tform_goal = vision_tform_body * body_tform_goal
                cmd_id = self.send_robot_command(
                    RobotCommandBuilder.synchro_se2_trajectory_point_command(
                        goal_x=vision_tform_goal.x,
                        goal_y=vision_tform_goal.y,
                        goal_heading=vision_tform_goal.rot.to_yaw(),
                        frame_name=frame_helpers.VISION_FRAME_NAME,
                        params=mobility_params,
                    ),
                    end_time_secs=end_time
                )
                success = True
            elif frame_name == "odom":
                odom_tform_body = frame_helpers.get_odom_tform_body(
                    self._state_client.get_robot_state().kinematic_state.transforms_snapshot
                )
                body_tform_goal = math_helpers.SE3Pose(
                    x=goal_x, y=goal_y, z=0, rot=math_helpers.Quat.from_yaw(goal_heading)
                )
                odom_tform_goal = odom_tform_body * body_tform_goal
                cmd_id = self.send_robot_command(
                    RobotCommandBuilder.synchro_se2_trajectory_point_command(
                        goal_x=odom_tform_goal.x,
                        goal_y=odom_tform_goal.y,
                        goal_heading=odom_tform_goal.rot.to_yaw(),
                        frame_name=frame_helpers.ODOM_FRAME_NAME,
                        params=mobility_params,
                    ),
                    end_time_secs=end_time
                )
                success = True
            else:
                raise ValueError("frame_name must be 'vision' or 'odom'")
        except Exception as e:
            success = False
            error = e
            print("Error:", e)
        
        if success:
            print("success")
            self.last_trajectory_command = cmd_id
        
            # for i in range(10):
            #     print(self.command_client.robot_command_feedback(cmd_id, timeout=1))
            #     time.sleep(0.1)
            #     for j in range(5):
            #         print()

        return success, "Success" if success else str(error)


    def cmd_vel(self, 
        linear_x: float = 0.0,
        linear_y: float = 0.0,
        angular_z: float = 0.0,
        duration_s: float = 1.0,
    ) -> bool:
        """Send a velocity command to Spot.

        :param      linear_x     Linear velocity in the X direction (m/s)
        :param      linear_y     Linear velocity in the Y direction (m/s)
        :param      angular_z    Angular velocity in the Z direction (rad/s)
        :param      duration_s   Duration (seconds) for which to send the command

        :returns    Boolean indicating if the command was successfully sent
        """
        if not self.check_lease_alive():
            return False

        cmd = RobotCommandBuilder.synchro_velocity_command(
            v_x=linear_x,
            v_y=linear_y,
            v_rot=angular_z,
            params=self._mobility_params
        )
        cmd_id = self.send_robot_command(
            cmd,
            end_time_secs=time.time() + duration_s,
        )
        self.log_info(f"Velocity command ID: {cmd_id}")
        return True


    def stand_up(self, timeout_s: float) -> bool:
        """Tell Spot to stand up within the given timeout (in seconds).

        :param timeout_s: Timeout (seconds) for the blocking stand command
        :returns: True if Spot stood up, otherwise False
        """
        if not self.check_lease_alive():
            return False

        blocking_stand(self.command_client, timeout_sec=timeout_s)
        self.log_info("Robot standing.")
        return True

    def block_until_arm_arrives(self, command_id: int) -> None:
        """Block until Spot's arm arrives at the identified command's goal.

        :param      command_id      ID of a robot command for Spot's arm
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
        if not self.check_lease_alive():
            return False

        self.log_info("Deploying Spot's arm to the 'ready' position...")
        arm_ready = RobotCommandBuilder.arm_ready_command()
        command_id = self.send_robot_command(arm_ready)
        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now ready.")
        return True

    def stow_arm(self) -> bool:
        """Stow Spot's arm and wait until the arm has finished stowing.

        :returns: True if Spot's arm was stowed, otherwise False
        """
        if not self.check_lease_alive():
            return False

        self.log_info("Stowing Spot's arm...")
        arm_stow = RobotCommandBuilder.arm_stow_command()
        command_id = self.send_robot_command(arm_stow)
        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now stowed.")
        return True

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
        self.log_info("Shutting down Spot manager...")

        if self.check_lease_alive():
            self.stow_arm()
            self.safely_power_off()  # Send a "safe power off" command
            self.release_control()  # Return Spot's lease
