"""Define a class to manage a sustained connection to a Spot robot.

This file has reviewed the contents of the following Spot SDK examples:
    hello_spot.py
"""

import time

from bosdyn.api.estop_pb2 import ESTOP_LEVEL_NONE
from bosdyn.api.robot_command_pb2 import RobotCommand
from bosdyn.client import create_standard_sdk
from bosdyn.client.estop import EstopClient
from bosdyn.client.lease import LeaseClient, LeaseKeepAlive
from bosdyn.client.robot_command import RobotCommandClient, blocking_stand
from bosdyn.client.robot_state import RobotStateClient
from bosdyn.client.util import setup_logging
from rospy import loginfo

from spot_skills.joint_trajectory import JointsPoint
from spot_skills.spot_sync import SpotTimeSync


class SpotManager:
    """A wrapper to ensure that Spot is safely connected and controllable."""

    def __init__(self, client_name: str, hostname: str, username: str, password: str):
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
        self.time_sync = SpotTimeSync()

        self.log_info("Time sync has been established with Spot.")
        self.log_sync_info()

        # Establish member variables for clients that may be needed for Spot
        self._state_client = self._robot.ensure_client(
            RobotStateClient.default_service_name,
        )
        self.command_client = None  # Used to command Spot to move (non-private)

        # Establish a client to query Spot's e-stop status
        self._estop_client = self._robot.ensure_client(EstopClient.default_service_name)

        # Establish a client to obtain control of Spot (i.e., Spot's "lease")
        self._lease_client = self._robot.ensure_client(LeaseClient.default_service_name)
        self._lease_keeper = None  # Stores a lease and keeps it alive once obtained

        assert self.wait_while_estopped()  # Wait until Spot isn't e-stopped

    def wait_while_estopped(self, timeout_sec: int = 30) -> bool:
        """Notify the user if Spot is e-stopped by spamming the ROS and Spot logs.

        :param      timeout_sec     Time (seconds) after which the method gives up

        :returns    Boolean: Was Spot "e-started" (un-e-stopped) in time?
        """
        estop_level = self._estop_client.get_status().stop_level

        start_t = time.time()

        while (time.time() - start_t) < timeout_sec:
            if estop_level == ESTOP_LEVEL_NONE:
                self.log_info("Spot is not e-stopped, continuing on...")
                return True

            self.log_info("Spot is currently e-stopped!")

            time.sleep(0.5)
            estop_level = self._estop_client.get_status().stop_level

        log_message = f"Spot remained e-stopped after {timeout_sec} seconds."
        self.log_info(log_message)
        return False

    def take_control(self) -> bool:
        """Prepare to control Spot and ensure that Spot is powered on.

        In detail, this method performs these steps:
            1. Attempt to acquire Spot's lease and store it in a member variable
            2. Initialize a client to command Spot, if uninitialized
            3. Attempt to power on Spot, if necessary

        :returns    Boolean indicating if all attempted operations were successful
        """
        # 1. Attempt to acquire Spot's lease and keep it alive
        self._lease_client.acquire(resource="body")
        self._lease_keeper = LeaseKeepAlive(
            self._lease_client,
            must_acquire=True,
            return_at_exit=True,
        )

        # 2. If needed, initialize a client to command Spot to move
        if self.command_client is None:
            self.command_client = self._robot.ensure_client(
                RobotCommandClient.default_service_name,
            )

        # 3. If needed, attempt to power on Spot
        if not self._robot.is_powered_on():
            self.log_info("Powering on Spot... This may take several seconds.")
            self._robot.power_on(timeout_sec=20)

        # Verify that the attempted operations succeeded
        lease_alive = self._lease_keeper.is_alive()
        has_command_client = self.command_client is not None
        power_success = self._robot.is_powered_on()

        self.log_info("Spot powered on." if power_success else "Spot power on failed.")

        self.log_info("Exiting SpotManager.take_control()...")

        return lease_alive and has_command_client and power_success

    def log_info(self, message: str) -> None:
        """Log the given message to the Spot and ROS information logs.

        :param      message     String to be logged via Spot SDK and ROS
        """
        manager_age_s = time.time() - self._created_time_s

        formatted_message = f"[SpotManager after {manager_age_s:.3f} sec] {message}"

        self._robot.logger.info(formatted_message)
        loginfo(formatted_message)

    def log_sync_info(self) -> None:
        """Log information characterizing the time sync and communication latency."""
        self.time_sync.resync()

        round_trip_s = self.time_sync.get_round_trip_s()
        self.log_info(f"Current round trip time: {round_trip_s} seconds.")

        clock_skew_s = self.time_sync.get_clock_skew_s()
        self.log_info(f"Current robot clock skew from local: {clock_skew_s} seconds.")

        max_sync_time_s = self.time_sync.max_sync_time_s
        self.log_info(
            f"Maximum duration a time-sync has taken: {max_sync_time_s} seconds.",
        )

    def has_arm(self) -> bool:
        """Check whether the Spot robot has an arm connected."""
        return self._robot.has_arm()

    def get_arm_state(self) -> JointsPoint:
        """Query and return the current state of Spot's arm."""
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

        arm_joint_positions = [None] * len(arm_joint_names_from_spot)
        arm_joint_velocities = [None] * len(arm_joint_names_from_spot)
        # Note: Ignoring arm joints' accelerations

        for joint in robot_state.kinematic_state.joint_states:
            if joint.name in arm_joint_names_from_spot:
                joint_idx = arm_joint_names_from_spot.index(joint.name)
                arm_joint_positions[joint_idx] = joint.position.value
                arm_joint_velocities[joint_idx] = joint.velocity.value

        return JointsPoint(arm_joint_positions, arm_joint_velocities, None)

    def send_robot_command(self, command: RobotCommand):
        """Command Spot to execute the given robot command.

        :param      command     Command for Spot to execute
        :returns    ID of the issued robot command
        """
        has_command_client = self.command_client is not None
        assert has_command_client, "Cannot command Spot without a command client!"

        # Issue a command to the robot synchronously (blocks until done sending)
        command_id: int = self.command_client.robot_command(command)
        self.log_info(f"Issued robot command with ID: {command_id}")

        return command_id

    def stand_up(self, timeout_s: float) -> None:
        """Tell Spot to stand up within the given timeout (in seconds).

        :param      timeout_s       Timeout (seconds) for the blocking stand command
        """
        blocking_stand(self.command_client, timeout_sec=timeout_s)
        self.log_info("Robot standing.")

    def release_control(self) -> None:
        """Release control of Spot so that other clients can control Spot."""
        self.log_info("Releasing control of Spot...")
        self._lease_keeper.shutdown()  # Blocks until complete

    def safely_power_off(self) -> None:
        """Power Spot off by issuing a "safe power off" command."""
        self._robot.power_off(cut_immediately=False, timeout_sec=20)
        assert not self._robot.is_powered_on(), "Robot power off failed."
        self.log_info("Robot safely powered off.")
