"""Define a class to manage a sustained connection to a Spot robot."""

import time

from bosdyn.api.estop_pb2 import ESTOP_LEVEL_NONE
from bosdyn.api.robot_command_pb2 import RobotCommand
from bosdyn.client import create_standard_sdk
from bosdyn.client.estop import EstopClient
from bosdyn.client.lease import (
    LeaseClient,
    LeaseKeepAlive,
    LeaseNotOwnedByWallet,
    LeaseWallet,
    NoSuchLease,
)
from bosdyn.client.robot_command import RobotCommandBuilder, RobotCommandClient
from bosdyn.client.robot_command import block_until_arm_arrives as bd_block_arm_command
from bosdyn.client.robot_command import blocking_stand
from bosdyn.client.robot_state import RobotStateClient
from bosdyn.client.util import setup_logging
from rospy import loginfo as ros_loginfo

from spot_skills.joint_trajectory import JointsPoint
from spot_skills.spot_sync import SpotTimeSync


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
        self.command_client = self._robot.ensure_client(
            RobotCommandClient.default_service_name,
        )

        # Define a client to query the state of the robot
        self._state_client = self._robot.ensure_client(
            RobotStateClient.default_service_name,
        )

        # Define a client to query Spot's e-stop status
        self._estop_client = self._robot.ensure_client(EstopClient.default_service_name)

        # Define a client to later obtain control of Spot (i.e., Spot's "lease")
        self._lease_client: LeaseClient = self._robot.ensure_client(
            LeaseClient.default_service_name,
        )
        self._lease_keeper = None  # Stores a lease and keeps it alive once obtained

        assert self.wait_while_estopped()  # Wait until Spot isn't e-stopped

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
        self.log_info(f"List of leases: {list_leases}")

        wallet: LeaseWallet = self._lease_client.lease_wallet

        possible_resources = ["body", "gripper", "arm", "mobility", "fan", "full-arm"]

        for resource in possible_resources:
            try:
                status = wallet.get_lease_state(resource).lease_status
                self.log_info(f"Status of lease '{resource}': {status}.")
            except NoSuchLease:
                self.log_info(f"Couldn't get status of lease '{resource}'.")

            try:
                lease = wallet.get_lease(resource)
                self.log_info(f"Lease named {resource}: {lease}")
            except LeaseNotOwnedByWallet:
                self.log_info(f"Lease named {resource} was not owned!")

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
            self.log_info("Lease acquired. Logging info for debugging...")
            self.log_lease_info()

        # 2. If needed, attempt to power on Spot
        if not self._robot.is_powered_on():
            self.log_info("Powering on Spot... This may take several seconds.")
            self._robot.power_on(timeout_sec=20)

        # Verify that the attempted operations succeeded
        lease_alive = self._lease_keeper is not None and self._lease_keeper.is_alive()
        power_success = self._robot.is_powered_on()

        self.log_info("Spot powered on." if power_success else "Spot power on failed.")

        self.log_info("Exiting SpotManager.take_control()...\n")

        return lease_alive and power_success

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

        clock_skew_s = self.time_sync.clock_skew_s
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

    def get_arm_state(self) -> JointsPoint:
        """Query and return the current state of Spot's arm.

        :returns    Point storing the current positions/velocities of Spot's arm joints
        """
        robot_state = self._state_client.get_robot_state()

        arm_joint_names_from_spot = [
            "arm0.sh0",
            "arm0.sh1",
            "arm0.el0",
            "arm0.el1",
            "arm0.wr0",
            "arm0.wr1",
        ]  # Use the joint names as sent from Spot directly (differs from URDF names)
        # See Lines 64-84 of spot_ros/spot_driver/src/spot_driver/ros_helpers.py

        joint_positions = [float("nan")] * len(arm_joint_names_from_spot)
        joint_velocities = [float("nan")] * len(arm_joint_names_from_spot)
        # Note: Ignoring arm joints' accelerations

        for joint in robot_state.kinematic_state.joint_states:
            if joint.name in arm_joint_names_from_spot:
                joint_idx = arm_joint_names_from_spot.index(joint.name)
                joint_positions[joint_idx] = joint.position.value
                joint_velocities[joint_idx] = joint.velocity.value

        return JointsPoint(joint_positions, joint_velocities, 0.0)

    def send_robot_command(self, command: RobotCommand) -> int:
        """Command Spot to execute the given robot command.

        Note: The RobotCommandClient.robot_command() method will automatically update
            all timestamps in the command from local time to robot time.

        :param      command     Command for Spot to execute

        :returns    ID (integer) of the issued robot command
        """
        # Issue a command to the robot synchronously (blocks until done sending)
        command_id: int = self.command_client.robot_command(
            command,
            timesync_endpoint=self.time_sync.get_time_sync_endpoint(),
        )
        self.log_info(f"Issued robot command with ID: {command_id}")

        return command_id

    def stand_up(self, timeout_s: float) -> None:
        """Tell Spot to stand up within the given timeout (in seconds).

        :param      timeout_s       Timeout (seconds) for the blocking stand command
        """
        blocking_stand(self.command_client, timeout_sec=timeout_s)
        self.log_info("Robot standing.")

    def block_until_arm_arrives(self, command_id: int) -> None:
        """Block until Spot's arm arrives at the identified command's goal.

        :param      command_id      ID of a robot command for Spot's arm
        """
        self.log_info("Blocking until arm arrives...")
        bd_block_arm_command(self.command_client, command_id)
        time.sleep(0.5)
        self.log_info("Done blocking.\n")

    def deploy_arm(self) -> None:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed."""
        self.log_info("Deploying Spot's arm to the 'ready' position...")
        arm_ready = RobotCommandBuilder.arm_ready_command()
        command_id = self.send_robot_command(arm_ready)
        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now ready.")

    def stow_arm(self) -> None:
        """Stow Spot's arm and wait until the arm has finished stowing."""
        self.log_info("Stowing Spot's arm...")
        arm_stow = RobotCommandBuilder.arm_stow_command()
        command_id = self.send_robot_command(arm_stow)
        self.block_until_arm_arrives(command_id)
        self.log_info("Arm is now stowed.")

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

        if self._lease_keeper is not None and self._lease_keeper.is_alive():
            self.stow_arm()
            self.safely_power_off()  # Send a "safe power off" command
            self.release_control()  # Return Spot's lease
