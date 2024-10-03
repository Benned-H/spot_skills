"""Define a class to control Spot's arm using the Spot SDK."""

from bosdyn.client import robot_command
from bosdyn.client.robot_command import RobotCommandBuilder

from spot_skills.joint_trajectory import JointTrajectory
from spot_skills.spot_manager import SpotManager


class SpotArmController:
    """A wrapper to control Spot's arm using the Spot SDK."""

    def __init__(self, spot_manager: SpotManager):
        """Initialize the controller for Spot's arm using a manager for Spot.

        :param    spot_manager    Manager of the connection to the Spot
        """
        assert spot_manager.has_arm(), "Cannot control Spot's arm if Spot has no arm!"

        # Ensure we can control Spot, and that Spot is powered on
        self._spot_manager = spot_manager
        self._spot_manager.take_control()

        # Establish member variables to store data about the most-recent trajectory
        self._last_command_id = None  # ID of the most recent robot command to Spot
        self._last_trajectory = None  # Most recent trajectory sent to Spot

    def command_trajectory(self, trajectory: JointTrajectory) -> None:
        """Command Spot to execute the given joint trajectory.

        :param    trajectory    Trajectory of joint (position, velocity) points
        """
        robot_command = trajectory.to_robot_command()
        self._command_id = self._spot_manager.send_robot_command(robot_command)
        self._last_trajectory = trajectory

    def block_until_arm_arrives(self) -> None:
        """Block until Spot's arm arrives at the current command ID's goal."""
        robot_command.block_until_arm_arrives(
            self._spot_manager.command_client,
            self._command_id,
        )

    def deploy_arm(self) -> None:
        """Deploy Spot's arm to "ready" and wait until the arm has deployed."""
        arm_ready = RobotCommandBuilder.arm_ready_command()
        self._command_id = self._spot_manager.send_robot_command(arm_ready)
        self.block_until_arm_arrives()

    def stow_arm(self) -> None:
        """Stow Spot's arm and wait until the arm has finished stowing."""
        arm_stow = RobotCommandBuilder.arm_stow_command()
        self._command_id = self._spot_manager.send_robot_command(arm_stow)
        self.block_until_arm_arrives()
