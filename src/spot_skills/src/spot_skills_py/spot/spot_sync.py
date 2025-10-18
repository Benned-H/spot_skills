"""Define a class to manage time synchronization with Spot."""

from __future__ import annotations

import time
from typing import TYPE_CHECKING

import rospy
from bosdyn.util import duration_to_seconds

from spot_skills_py.time_stamp import TimeStamp, TimestampProto

if TYPE_CHECKING:
    from bosdyn.client.robot import Robot
    from bosdyn.client.time_sync import TimeSyncEndpoint


class SpotTimeSync:
    """A wrapper to manage time synchronization with Spot."""

    def __init__(self, robot: Robot) -> None:
        """Use the given robot for its timesync endpoint."""
        self._robot = robot

        self.max_round_trip_s = -1.0  # Maximum duration (seconds) of any round trip
        self.max_sync_time_s = -1.0  # Maximum duration (seconds) a time-sync has taken

        self.total_sync_time_s = 0.0  # Total time (seconds) spent time-syncing
        self.total_sync_count = 0  # Number of completed calls to resync()

        self.resync()  # Blocks until robot is synchronized

    @property
    def endpoint(self) -> TimeSyncEndpoint:
        """Retrieve the robot's live timesync endpoint."""
        return self._robot.time_sync.endpoint

    def resync(self) -> None:
        """Re-establish a time-sync with Spot (blocks until robot is synchronized)."""
        start_time = time.time()

        self._robot.time_sync.wait_for_sync()
        self.max_round_trip_s = max(self.max_round_trip_s, self.get_round_trip_s())

        end_time = time.time()  # Put as much of this function as possible before this line
        sync_duration_s = end_time - start_time

        self.max_sync_time_s = max(self.max_sync_time_s, sync_duration_s)

        self.total_sync_time_s += sync_duration_s
        self.total_sync_count += 1

    def get_round_trip_s(self) -> float:
        """Return the current round-trip time (seconds) to communicate with Spot."""
        return duration_to_seconds(self.endpoint.round_trip_time)

    def get_robot_clock_skew_s(self) -> float:
        """Return the robot clock skew (in seconds) relative to the local machine."""
        return duration_to_seconds(self.endpoint.clock_skew)

    def get_avg_sync_time_s(self) -> float:
        """Return the average duration (seconds) taken by each resync with Spot."""
        return self.total_sync_time_s / self.total_sync_count

    def local_timestamp_from_proto(self, timestamp_proto: TimestampProto) -> TimeStamp:
        """Convert the given Spot-time Protobuf message to a local-time TimeStamp.

        :param timestamp_proto: Protobuf message from Spot (time relative to robot clock)
        :return: TimeStamp object converted into the local time
        """
        timestamp_spot = TimeStamp.from_proto(timestamp_proto)
        return timestamp_spot.shift_by_duration_s(timestamp_spot, -self.get_robot_clock_skew_s())

    def proto_to_ros_timestamp(self, timestamp_proto: TimestampProto) -> rospy.Time:
        """Convert the given Spot-time Protobuf message to a ROS timestamp.

        :param timestamp_proto: Protobuf message from Spot (time relative to robot clock)
        :return: ROS timestamp corresponding to the Protobuf message
        """
        local_timestamp = self.local_timestamp_from_proto(timestamp_proto)
        local_s = local_timestamp.to_time_s()
        return rospy.Time.from_sec(local_s)
