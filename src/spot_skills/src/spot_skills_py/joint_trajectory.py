"""Define dataclasses to represent joint trajectories over time."""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import duration_to_seconds
from transform_utils.time_sync import SystemClock, Timestamp, TimeSync

from spot_skills_py.spot.spot_configuration import (
    MAP_JOINT_NAMES_URDF_TO_SPOT_SDK,
    SPOT_SDK_ARM_JOINT_NAMES,
    SPOT_URDF_ARM_JOINT_NAMES,
)

if TYPE_CHECKING:
    import trajectory_msgs.msg
    from bosdyn.api.arm_command_pb2 import ArmJointTrajectory, ArmJointTrajectoryPoint
    from bosdyn.api.robot_command_pb2 import RobotCommand
    from transform_utils.kinematics import Configuration


@dataclass
class JointsPoint:
    """A knot point describing the state of an arm's joints during a trajectory.

    This state includes the positions (angles) and velocities of the joints.
    """

    positions_rad: list[float]  # Position (rad) of each joint at this timestep
    velocities_radps: list[float]  # Velocity (rad/s) of each joint at this timestep
    time_from_start_s: float  # Duration (seconds) since the start of the trajectory

    def __post_init__(self) -> None:
        """Verify that any initialized JointsPoint has equally many positions and velocities."""
        num_pos = len(self.positions_rad)
        num_vel = len(self.velocities_radps)

        assert num_pos == num_vel, f"JointsPoint had {num_pos} positions but {num_vel} velocities."

    @classmethod
    def from_proto(cls, point_proto: ArmJointTrajectoryPoint) -> JointsPoint:
        """Construct a JointsPoint from an equivalent Protobuf message.

        :param      point_proto     Protobuf message specifying an arm's joints' state

        :returns    JointsPoint constructed based on the Protobuf trajectory point
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
    def from_ros_msg(cls, point_msg: trajectory_msgs.msg.JointTrajectoryPoint) -> JointsPoint:
        """Construct a JointsPoint from an equivalent ROS message.

        :param point_msg: ROS message representing an arm's joints' state

        :returns: JointsPoint constructed based on the given ROS message
        """
        time_from_start_s = point_msg.time_from_start.to_sec()
        return cls(point_msg.positions, point_msg.velocities, time_from_start_s)

    @classmethod
    def from_configuration(cls, joint_values: Configuration) -> JointsPoint:
        """Construct a JointsPoint from a configuration specifying joint values.

        :param joint_values: Map from joint names to joint values

        :returns: JointsPoint constructed based on the given configuration
        """
        positions = [joint_values[dof] for dof in SPOT_SDK_ARM_JOINT_NAMES]

        return cls(positions, [0] * len(positions), 0)


@dataclass
class JointTrajectory:
    """A trajectory describing an arm's joints in phase space over time.

    In a phase space representation, the velocities of the state variables are
    treated as state variables. Accelerations can be treated similarly.
    """

    reference_timestamp: Timestamp  # Relative timestamp for trajectory point times
    points: list[JointsPoint]  # Points in the trajectory
    joint_names: list[str]

    @classmethod
    def from_proto(cls, trajectory_proto: ArmJointTrajectory) -> JointTrajectory:
        """Construct a JointTrajectory from an equivalent Protobuf message.

        :param      trajectory_proto    Trajectory of joint points as a Protobuf message

        :returns    JointTrajectory constructed based on the given Protobuf trajectory
        """
        timestamp = Timestamp.from_proto(trajectory_proto.reference_time)

        points = [JointsPoint.from_proto(p) for p in trajectory_proto.points]

        # Note: Ignoring maximum velocity/acceleration from Protobuf message

        joint_names = SPOT_SDK_ARM_JOINT_NAMES  # Use Spot SDK's joint names

        return cls(timestamp, points, joint_names)

    @classmethod
    def from_ros_msg(cls, trajectory_msg: trajectory_msgs.msg.JointTrajectory) -> JointTrajectory:
        """Construct a JointTrajectory from an equivalent ROS message.

        Note: Assumes that the ROS message timestamp is relative to the local clock.

        :param      trajectory_msg    Trajectory of joint points as a ROS message
        :returns    JointTrajectory constructed based on the given ROS message
        """
        stamp_msg = trajectory_msg.header.stamp
        timestamp = Timestamp(stamp_msg.secs, stamp_msg.nsecs, SystemClock.LOCAL)

        points = [JointsPoint.from_ros_msg(p) for p in trajectory_msg.points]

        return cls(timestamp, points, trajectory_msg.joint_names)

    def convert_to_spot_sdk(self) -> None:
        """Convert the JointTrajectory to use the Spot SDK's joint names and ordering.

        Asserts if the trajectory's joint names cannot be converted.
        Reorders the joint angles in the trajectory according to the Spot SDK order.
        """
        # Ensure the joint names are either all Spot SDK or all URDF
        using_sdk_names = all(name in SPOT_SDK_ARM_JOINT_NAMES for name in self.joint_names)
        using_urdf_names = all(name in SPOT_URDF_ARM_JOINT_NAMES for name in self.joint_names)
        assert using_sdk_names or using_urdf_names, (
            f"Cannot recognize arm joint names: {self.joint_names}."
        )

        def reorder_joint_values(points: list[JointsPoint], index_mapping: list[int]) -> None:
            """Reorder the joint values in the given list of JointsPoints."""
            for point in points:
                point.positions_rad = [point.positions_rad[i] for i in index_mapping]
                point.velocities_radps = [point.velocities_radps[i] for i in index_mapping]

        # If using URDF names, reorder to match the Spot SDK order
        if using_urdf_names:
            urdf_to_sdk_indices = [
                SPOT_SDK_ARM_JOINT_NAMES.index(MAP_JOINT_NAMES_URDF_TO_SPOT_SDK[urdf_name])
                for urdf_name in self.joint_names
            ]
            reorder_joint_values(self.points, urdf_to_sdk_indices)

        # If using Spot SDK names, reorder the joint values only if necessary
        if using_sdk_names and self.joint_names != SPOT_SDK_ARM_JOINT_NAMES:
            sdk_indices = [
                SPOT_SDK_ARM_JOINT_NAMES.index(sdk_name) for sdk_name in self.joint_names
            ]
            reorder_joint_values(self.points, sdk_indices)

    def segment_to_robot_commands(
        self,
        max_segment_len: int,
        time_sync: TimeSync,
    ) -> list[RobotCommand]:
        """Convert this JointTrajectory into a list of robot commands for Spot.

        Each command will contain a single "segment" of the overall trajectory, obeying
            the given maximum length, so that Spot can quickly process each command.

        Create continuity: First point in each segment = Last point of the previous

        TODO: Could raise or lower the output commands' velocity/acceleration limits

        :param max_segment_len: Maximum allowed length of a single segment (# points)
        :param time_sync: Used for converting between local and robot clock timestamps
        :return: List of RobotCommand objects ready to be sent to Spot
        """
        self.convert_to_spot_sdk()

        positions = [point.positions_rad for point in self.points]
        velocities = [point.velocities_radps for point in self.points]
        times = [point.time_from_start_s for point in self.points]

        # Ensure that time monotonically increases along the trajectory
        for idx in range(1, len(times)):
            time = times[idx]
            prev_time = times[idx - 1]

            if time <= prev_time:
                times[idx] = prev_time + 0.01

        # Create a future-proof timestamp relative to the robot clock
        future_margin_s = time_sync.get_future_margin_s()
        if future_margin_s is None:
            time_sync.resync()
            future_margin_s = time_sync.get_future_margin_s()

            if future_margin_s is None:
                error_msg = "Time-sync unavailable; cannot segment trajectory."
                raise RuntimeError(error_msg)

        # Leave protos relative to local clock; RobotCommandClient will convert them at send-time
        ref_local_ts = Timestamp.now().add_offset_s(future_margin_s)
        ref_local_ts.clock = SystemClock.ROBOT  # Trick our code to skip converting local-to-robot
        ref_robot_proto = time_sync.convert_to_robot_proto(ref_local_ts)
        if ref_robot_proto is None:
            error_msg = "Time-sync unavailable; cannot build reference timestamp."
            raise RuntimeError(error_msg)

        # Segment the trajectory as described in this method's docstring
        commands: list[RobotCommand] = []

        start_idx = 0  # Both indices are inclusive
        end_idx = min(start_idx + max_segment_len, len(self.points)) - 1

        while True:
            segment_positions = positions[start_idx : end_idx + 1]
            segment_velocities = velocities[start_idx : end_idx + 1]
            segment_times = times[start_idx : end_idx + 1]

            # Adjust times within the segment to be relative to an updated reference time
            segment_offset_s = times[start_idx]
            rel_times = [t - segment_offset_s for t in segment_times]
            new_ref_robot_proto = time_sync.add_proto_offset_s(ref_robot_proto, segment_offset_s)

            robot_command = RobotCommandBuilder.arm_joint_move_helper(
                joint_positions=segment_positions,
                times=rel_times,
                joint_velocities=segment_velocities,
                ref_time=new_ref_robot_proto,
            )

            commands.append(robot_command)

            # Exit once we've created a segment containing the trajectory's end
            if end_idx == len(self.points) - 1:
                break

            # Find indices for the next segment, which begins where the last ended
            start_idx = end_idx  # Recall: both are inclusive
            end_idx = min(start_idx + max_segment_len, len(self.points)) - 1

        return commands
