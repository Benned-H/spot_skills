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
from bosdyn.client.util import authenticate, setup_logging
from rospy import loginfo


class SpotManager:
    """A wrapper to ensure that Spot is safely connected and controllable."""

    def __init__(self, client_name: str, robot_hostname: str):
        """Initialize the Spot manager by connecting to Spot.

        The robot's hostname can be:
            - A DNS name (e.g., spot.intranet.example.com)
            - An IP literal (e.g., 10.0.63.1)

        :param      client_name         Name to use for the created Spot SDK client
        :param      robot_hostname      Network address of the robot to connect to

        Reference: spot-sdk/python/examples/hello_spot/hello_spot.py
        """
        setup_logging(verbose=True)  # Use verbose logging for the Spot SDK

        # Create one robot object, although the SDK client can manage more than one
        self._sdk = create_standard_sdk(client_name)
        self._robot = self._sdk.create_robot(robot_hostname)
        authenticate(self._robot)  # Need to authenticate with Spot before using it
        self._robot.time_sync.wait_for_sync()  # Establish a time sync with the robot

        # Establish member variables for clients that may be needed for Spot
        self._state_client = None  # Used to access Spot's state information
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
                loginfo("[SpotManager] Spot is not e-stopped, continuing on...")
                self._robot.logger.info("Robot is not e-stopped, continuing on...")
                return True

            loginfo("[SpotManager] Spot is currently e-stopped!")
            self._robot.logger.info("Robot is currently e-stopped!")
            time.sleep(0.5)
            estop_level = self._estop_client.get_status().stop_level

        log_message = f"Spot remained e-stopped after {timeout_sec} seconds."
        self._robot.logger.info(log_message)
        loginfo(f"[SpotManager] {log_message}")
        return False

    def take_control(self) -> bool:
        """Prepare to control Spot and ensure that Spot is powered on.

        In detail, this method performs these steps:
            1. Attempt to acquire Spot's lease and store it in a member variable
            2. Initialize a client to command Spot, if uninitialized
            3. Attempt to power on Spot, if necessary

        :returns    Boolean indicating if all attempted operations were successful
        """
        # 1. Attempt to acquire Spot's lease using a LeaseKeepAlive object
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
            self._robot.logger.info(
                "Powering on Spot... This may take several seconds.",
            )
            self._robot.power_on(timeout_sec=20)

        # Verify that the attempted operations succeeded
        lease_alive = self._lease_keeper.is_alive()
        has_command_client = self.command_client is not None
        power_on_success = self._robot.is_powered_on()

        if power_on_success:
            self._robot.logger.info("Robot powered on.")
        else:
            self._robot.logger.info("Robot power on failed.")

        return lease_alive and has_command_client and power_on_success

    def has_arm(self) -> bool:
        """Check whether the Spot robot has an arm connected."""
        return self._robot.has_arm()

    def send_robot_command(self, command: RobotCommand):
        """Command Spot to execute the given robot command.

        :param      command     Command for Spot to execute
        :returns    ID of the issued robot command
        """
        has_command_client = self.command_client is not None
        assert has_command_client, "Cannot command Spot without a command client!"

        # Issue a command to the robot synchronously (blocks until done sending)
        command_id = self.command_client.robot_command(command)

        # TODO: Determine and document the type of the resulting command ID
        log_message = (
            f"Issued robot command with ID: {command_id}"
            f" and type {type(command_id)}"
        )

        self._robot.logger.info(log_message)

        return command_id

    def stand_up(self, timeout_s: float) -> None:
        """Tell Spot to stand up within the given timeout (in seconds).

        :param      timeout_s       Timeout (seconds) for the blocking stand command
        """
        blocking_stand(self.command_client, timeout_sec=timeout_s)
        self._robot.logger.info("Robot standing.")

    def safely_power_off(self) -> None:
        """Power Spot off by issuing a "safe power off" command."""
        self._robot.power_off(cut_immediately=False, timeout_sec=20)
        assert not self._robot.is_powered_on(), "Robot power off failed."
        self._robot.logger.info("Robot safely powered off.")

    def release_control(self) -> None:
        """Release control of Spot so that other clients can control Spot."""
        lease = self._lease_keeper.shutdown()  # Blocks until complete
        self._lease_client.return_lease(lease)
        self._lease_keeper = None
