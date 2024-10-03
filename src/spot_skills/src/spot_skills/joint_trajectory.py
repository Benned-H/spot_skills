"""Define dataclasses to represent joint trajectories over time."""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import duration_to_seconds
from google.protobuf import timestamp_pb2
from trajectory_msgs.msg import JointTrajectory as JointTrajectoryMsg
from trajectory_msgs.msg import JointTrajectoryPoint as JointPointMsg

if TYPE_CHECKING:
    from bosdyn.api.arm_command_pb2 import ArmJointTrajectory, ArmJointTrajectoryPoint
    from bosdyn.api.robot_command_pb2 import RobotCommand

NSEC_PER_SEC = 10**9


@dataclass
class TimeStamp:
    """A timestamp representing a specific moment in time relative to the Unix epoch.

    This class specifies the number of seconds and nanoseconds since the Unix epoch.
    """

    time_s: int  # Seconds since the Unix epoch began
    time_ns: int  # Nanoseconds since the timestamp's second began

    @classmethod
    def from_proto(cls, timestamp_proto: timestamp_pb2.Timestamp):
        """Construct a TimeStamp from an equivalent Protobuf message.

        :param    timestamp_proto    Timestamp since the Unix epoch began
        """
        return cls(timestamp_proto.seconds, timestamp_proto.nanos)

    @classmethod
    def from_time_s(cls, time_s: float):
        """Construct a TimeStamp from a number of seconds since the Epoch.

        :param      time_s      Time (seconds) since the Epoch
        """
        timestamp_s = int(time_s)
        timestamp_ns = int((time_s - timestamp_s) * NSEC_PER_SEC)

        return cls(timestamp_s, timestamp_ns)

    def to_proto(self) -> timestamp_pb2.Timestamp:
        """Convert this timestamp into an equivalent Protobuf message.

        :returns    Protobuf message representing a Unix epoch timestamp
        """
        return timestamp_pb2.Timestamp(seconds=self.time_s, nanos=self.time_ns)

    def to_time_s(self) -> float:
        """Convert this timestamp into a number of seconds since the Unix epoch.

        :returns    Time (seconds) since the Unix epoch started
        """
        return self.time_s + self.time_ns / NSEC_PER_SEC


@dataclass
class JointTrajectoryPoint:
    """A knot point describing an arm's joints in phase space at a particular time.

    The represented phase space includes positions (angles) and optional velocities.
    """

    positions_rad: list[float]  # Position (rad) of each joint at this timestep
    velocities_radps: list[float]  # Velocity (rad/s) of each joint at this timestep
    time_from_start_s: float  # Duration (seconds) since the start of the trajectory

    @classmethod
    def from_proto(cls, point_proto: ArmJointTrajectoryPoint):
        """Construct a JointTrajectoryPoint from an equivalent Protobuf message.

        :param    point_proto    Protobuf message representing a joint point
        """
        pos = point_proto.position  # An arm_command_pb2.ArmJointPosition
        vel = point_proto.velocity  # An arm_command_pb2.ArmJointVelocity

        # Extract joint angles (radians) from google.protobuf.DoubleValues
        angle_doubles = [pos.sh0, pos.sh1, pos.el0, pos.el1, pos.wr0, pos.wr1]
        angles_rad = [a.value for a in angle_doubles]

        # Extract joint velocities (radians/second) from google.protobuf.DoubleValues
        velocity_doubles = [vel.sh0, vel.sh1, vel.el0, vel.el1, vel.wr0, vel.wr1]
        velocities_radps = [v.value for v in velocity_doubles]

        time_since_start_s = duration_to_seconds(point_proto.time_since_reference)

        assert len(angles_rad) == len(velocities_radps), "Inconsistent joint count!"

        return cls(angles_rad, velocities_radps, time_since_start_s)

    @classmethod
    def from_ros_msg(cls, point_msg: JointPointMsg):
        """Construct a JointTrajectoryPoint from an equivalent ROS message.

        :param    point_msg    ROS message representing a joint point
        """
        time_from_start_s = point_msg.time_from_start.to_sec()
        return cls(point_msg.positions, point_msg.velocities, time_from_start_s)


@dataclass
class JointTrajectory:
    """A trajectory describing an arm's joints in phase space over time.

    Note: Removed joint names, as they have not seemed essential for current goals.
        i.e, spot_arm_joint_names = ["sh0", "sh1", "el0", "el1", "wr0", "wr1"]

    In a phase space representation, the velocities of the state variables are
    treated as state variables. Accelerations can be treated similarly.
    """

    reference_timestamp: TimeStamp  # Relative timestamp for trajectory point times
    points: list[JointTrajectoryPoint]  # Points in the trajectory

    @classmethod
    def from_proto(cls, trajectory_proto: ArmJointTrajectory):
        """Construct a JointTrajectory from an equivalent Protobuf message.

        :param    trajectory_proto    Trajectory of joint points as a Protobuf message
        """
        timestamp = TimeStamp.from_proto(trajectory_proto.reference_time)

        points = [JointTrajectoryPoint.from_proto(p) for p in trajectory_proto.points]

        # Note: Ignoring maximum velocity/acceleration from Protobuf message

        return cls(timestamp, points)

    @classmethod
    def from_ros_msg(cls, trajectory_msg: JointTrajectoryMsg):
        """Construct a JointTrajectory from an equivalent ROS message.

        :param    trajectory_msg    Trajectory of joint points as a ROS message
        """
        stamp_msg = trajectory_msg.header.stamp
        timestamp = TimeStamp(stamp_msg.secs, stamp_msg.nsecs)

        points = [JointTrajectoryPoint.from_ros_msg(p) for p in trajectory_msg.points]

        # Note: Ignoring joint names from ROS message

        return cls(timestamp, points)

    def to_robot_command(self) -> RobotCommand:
        """Convert this JointTrajectory into a populated robot command for Spot.

        :returns    Command for Spot to execute, containing this arm trajectory
        """
        positions = [point.positions_rad for point in self.points]
        velocities = [point.velocities_radps for point in self.points]
        times = [point.time_from_start_s for point in self.points]

        timestamp_proto = self.reference_timestamp.to_proto()

        return RobotCommandBuilder.arm_joint_move_helper(
            joint_positions=positions,
            times=times,
            joint_velocities=velocities,
            ref_time=timestamp_proto,
            # TODO: Could raise velocity and acceleration limits (max_vel, max_acc)
        )
