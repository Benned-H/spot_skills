"""Define a class to manage time synchronization with a Spot robot.

Note: In general, timestamps in Protobuf messages should be specified in robot time.
    Use this class to convert between local-time and robot-time timestamps.

Reference:
  https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/time_sync.html
"""

import time

from bosdyn.client.robot import Robot
from bosdyn.client.time_sync import TimeSyncClient, TimeSyncEndpoint
from bosdyn.util import duration_to_seconds
from google.protobuf.timestamp_pb2 import Timestamp as TimestampProto

from spot_skills.time_stamp import SystemClock, TimeStamp


class SpotTimeSync:
    """A wrapper to manage time synchronization with Spot."""

    def __init__(self, robot: Robot) -> None:
        """Initialize a time-sync client for the given robot.

        :param      robot       Point of access for the robot's clients
        """
        self._robot = robot  # Assume SpotManager has already authenticated w/ Spot

        # Create a client and thread-safe endpoint to time-sync with Spot
        # Reference: https://dev.bostondynamics.com/search.html?q=TimeSyncClient
        self._time_sync_client = self._robot.ensure_client(
            TimeSyncClient.default_service_name,
        )
        self._time_sync_endpoint = TimeSyncEndpoint(self._time_sync_client)

        # Declare a member variable to convert local times to robot time
        # Reference: `spot-sdk/python/bosdyn-core/src/bosdyn/util.py`
        self._robot_time_converter = None

        # Synchronize with Spot until a time-sync is established
        self.max_sync_time_s = -1  # Maximum duration (seconds) a resync has taken
        self.resync()

    def get_round_trip_s(self) -> float:
        """Return the current round trip time (seconds) to communicate with Spot.

        :returns    Duration (seconds) round-trip communication with Spot takes
        """
        return duration_to_seconds(self._time_sync_endpoint.round_trip_time)

    def get_clock_skew_s(self) -> float:
        """Return the current clock skew (seconds) from the time-sync service.

        :returns    Clock skew (seconds) of the robot clock from the local time
        """
        return duration_to_seconds(self._time_sync_endpoint.clock_skew)

    def resync(self) -> None:
        """Ensure that a time-sync with Spot is established and/or maintained.

        Note: The `self.max_sync_time_s` member variable tracks the longest duration
            that a single call to this method has needed to run.
        """
        start_time_s = time.time()

        sync_established = self._time_sync_endpoint.get_new_estimate()

        if not sync_established:
            sync_success = self._time_sync_endpoint.establish_timesync()
            assert sync_success, "Could not establish a time sync with Spot!"

        self._robot_time_converter = self._time_sync_endpoint.get_robot_time_converter()

        end_time_s = time.time()

        self.max_sync_time_s = max(self.longest_sync_s, end_time_s - start_time_s)

    def timestamp_to_proto(self, timestamp: TimeStamp) -> TimestampProto:
        """Convert the given timestamp into a robot-time Protobuf message.

        :param      timestamp       Timestamp relative to the Unix epoch

        :returns    Timestamp Protobuf message corresponding to the given timestamp
        """
        if timestamp.clock == SystemClock.LOCAL:  # Convert from local to robot time
            local_time_s = timestamp.to_time_s()
            return self._robot_time_converter.robot_timestamp_from_local_secs(
                local_time_s,
            )

        if timestamp.clock == SystemClock.ROBOT:  # Use robot time in Protobuf message
            return TimestampProto(seconds=timestamp.time_s, nanos=timestamp.time_ns)

        raise AssertionError(f"Unexpected type of SystemClock: {timestamp.clock}")

    def timestamp_proto_to_local_s(self, timestamp_proto: TimestampProto) -> float:
        """Convert the given Protobuf timestamp message into a local time (seconds).

        :param      timestamp_proto     Protobuf message representing a timestamp

        :returns    Local time (seconds) since the Unix epoch began
        """
        return self._robot_time_converter.local_seconds_from_robot_timestamp(
            timestamp_proto,
        )
