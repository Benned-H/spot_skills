"""Define a class encapsulating control of Spot's arm via the Spot SDK."""

import time
from contextlib import contextmanager
from dataclasses import dataclass
from typing import Generator, Optional, Self

from bosdyn.api import arm_command_pb2, robot_command_pb2
from bosdyn.client import create_standard_sdk
from bosdyn.client.lease import LeaseClient, LeaseKeepAlive
from bosdyn.client.robot_command import RobotCommandClient, arm_joint_move_helper
from bosdyn.client.robot_state import RobotStateClient
from bosdyn.client.util import authenticate, setup_logging
from bosdyn.util import duration_to_seconds, seconds_to_timestamp
from trajectory_msgs.msg import JointTrajectory


class SpotNeedsArmError(Exception):
    """An exception representing when Spot doesn't have an arm connected."""

    def __init__(self) -> None:
        super().__init__("Cannot control Spot's arm if Spot has no arm!")


class SpotEstoppedError(Exception):
    """An exception representing when Spot has been e-stopped."""

    def __init__(self) -> None:
        super().__init__("Spot has been e-stopped; cannot proceed!")


@dataclass
class TrajPoint:
    """A struct representing joint positions and velocities at a particular time."""

    joint_angles_rad: list[float]
    joint_velocities_radps: Optional[list[float]]
    time_since_reference_s: float

    @classmethod
    def from_protobuf(
        cls: type[Self], protobuf_point: arm_command_pb2.ArmJointTrajectoryPoint
    ) -> "TrajPoint":
        """Construct a TrajPoint from the given ArmJointTrajectoryPoint."""
        pos = protobuf_point.position
        vel = protobuf_point.velocity

        joint_angle_doubles = [pos.sh0, pos.sh1, pos.el0, pos.el1, pos.wr0, pos.wr1]
        joint_angles_rad = [a.value for a in joint_angle_doubles]

        joint_velocity_doubles = [vel.sh0, vel.sh1, vel.el0, vel.el1, vel.wr0, vel.wr1]
        joint_velocities_radps = [v.value for v in joint_velocity_doubles]

        return cls(
            joint_angles_rad,
            joint_velocities_radps,
            duration_to_seconds(protobuf_point.time_since_reference),
        )


@dataclass
class ArmJointMoveCommandFeedback:
    """A struct organizing important feedback from the protobuf message.

    Possible status values are:
        STATUS_UNKNOWN      (0) - Indicates an internal error
        STATUS_COMPLETE     (1)
        STATUS_IN_PROGRESS  (2)
        STATUS_STALLED      (3) - Spot's arm has stopped making progress

    Possible planner status values are:
        PLANNER_STATUS_UNKNOWN  (0) - Indicates an internal error
        PLANNER_STATUS_SUCCESS  (1) - A solution through the desired points was found
        PLANNER_STATUS_MODIFIED (2) - The planner had to modify the desired points
        PLANNER_STATUS_FAILED   (3) - Failed to compute a valid trajectory (unlikely)
    """

    status: int
    planner_status: int
    planned_points: list[TrajPoint]  # Spot's planned attempt to follow the trajectory
    time_to_goal_s: float  # Duration (sec) until joints are at the goal position


class SpotArmController:
    """A wrapper to control Spot's arm using the Spot SDK."""

    def __init__(self, hostname: str) -> None:
        """Initialize the controller for Spot's arm by connecting to Spot via the SDK.

        Reference: spot-sdk/python/examples/hello_spot/hello_spot.py

        :param      hostname        DNS name or IP literal of the Spot robot
        """
        setup_logging(verbose=True)

        self._sdk = create_standard_sdk("ArmControllerClient")
        self._robot = self._sdk.create_robot(hostname)
        authenticate(self._robot)

        # Establish a time sync with the robot. Blocks until sync is established
        self._robot.time_sync.wait_for_sync()

        # Verify that Spot has an arm and isn't e-stopped
        if not self._robot.has_arm():
            raise SpotNeedsArmError()
        if self._robot.is_estopped():
            raise SpotEstoppedError

        # The robot state client provides access to the state of Spot's arm
        self._robot_state_client = self._robot.ensure_client(
            RobotStateClient.default_service_name
        )
        self._command_client = self._robot.ensure_client(
            RobotCommandClient.default_service_name
        )
        self._command_id = None

        self._lease_client = self._robot.ensure_client(LeaseClient.default_service_name)

        self._reference_time_s = None  # Time (s) since computer's epoch began
        self._reference_timestamp = None  # Robot-synchronized reference time
        self.reset_reference_time()

    def reset_reference_time(self) -> float:
        """Reset the internal reference time used to synchronize sent trajectories.

        :returns    Time (seconds) since the computer's epoch began
        """
        self._reference_time_s = time.time()
        self._reference_timestamp = seconds_to_timestamp(self._reference_time_s)

    @contextmanager
    def get_lease_keeper(
        self, must_acquire: bool = True
    ) -> Generator[bosdyn.client.lease.LeaseKeepAlive, None, None]:
        """Yield an object to issue lease liveness checks to Spot.

        :param      must_acquire    If True, throws exception if lease isn't acquired

        :yields     A resource that issues liveness checks on a background thread
        """
        lease_keeper = LeaseKeepAlive(
            self._lease_client, must_acquire=must_acquire, return_at_exit=True
        )

        try:
            yield lease_keeper
        finally:
            lease_keeper.shutdown()

    def convert_trajectory(
        self, trajectory: JointTrajectory
    ) -> robot_command_pb2.RobotCommand:
        """Convert the given trajectory message into a synchro RobotCommand for Spot.

        :param      trajectory      Trajectory of (position, velocity, time) points
        :returns    robot_command_pb2.RobotCommand with a corresponding arm trajectory
        """
        positions = [point.positions for point in trajectory.points]
        velocities = [point.velocities for point in trajectory.points]

        # Spot's arm_joint_move_helper expects the times since the reference point
        times = [point.time_from_start for point in trajectory.points]

        return arm_joint_move_helper(
            positions,
            times,
            joint_velocities=velocities,
            ref_time=self._reference_timestamp,
        )  # TODO - Could specify max vel/acc based on ROS parameters/

    def command_trajectory(self, trajectory: JointTrajectory) -> None:
        """Command Spot to execute the given joint trajectory.

        :param      trajectory      Trajectory of (position, velocity, time) points
        """
        robot_command = self.convert_trajectory(trajectory)
        self._command_id = self._command_client.robot_command(robot_command)

    def query_feedback(self) -> ArmJointMoveCommandFeedback:
        """Query Spot for feedback on the last sent ArmJointMoveCommand."""
        protobuf_feedback = self._command_client.robot_command_feedbck(self._command_id)
        sync_feedback = protobuf_feedback.feedback.synchronized_feedback
        joint_move_feedback = sync_feedback.arm_command_feedback.arm_joint_move_feedback

        return ArmJointMoveCommandFeedback(
            int(joint_move_feedback.status),
            int(joint_move_feedback.planner_status),
            [TrajPoint.from_protobuf(p) for p in joint_move_feedback.planned_points],
            duration_to_seconds(joint_move_feedback.time_to_goal),
        )
