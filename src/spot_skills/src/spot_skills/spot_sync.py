"""Define a class to manage time synchronization with a Spot robot.

Note: Generally, timestamps in Protobuf messages should be specified in robot time.
    However, the RobotCommandClient automatically converts outgoing Protobuf messages
    from local time to robot time, using the TimeSyncEndpoint provided by this class.

Reference:
  https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/time_sync.html
  https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command
"""

import time
from typing import TYPE_CHECKING

from bosdyn.client.time_sync import TimeSyncClient, TimeSyncEndpoint
from bosdyn.util import duration_to_seconds

if TYPE_CHECKING:
    from bosdyn.client.robot import Robot


class SpotTimeSync:
    """A wrapper to manage time synchronization with Spot."""

    def __init__(self, robot: Robot) -> None:
        """Initialize a time-sync client for the given robot.

        :param      robot       Point of access for the robot's clients
        """
        # Create a client and thread-safe endpoint to time-sync with Spot
        # Reference: https://dev.bostondynamics.com/search.html?q=TimeSyncClient
        self._time_sync_client = robot.ensure_client(
            TimeSyncClient.default_service_name,
        )
        self._time_sync_endpoint = TimeSyncEndpoint(self._time_sync_client)

        self.clock_skew_s = None  # Stores the estimated robot clock skew (seconds)

        self.max_round_trip_s = -1.0  # Maximum duration (seconds) of any round trip
        self.max_sync_time_s = -1.0  # Maximum duration (seconds) a resync has taken

        self.total_sync_time_s = 0.0  # Total time (seconds) spent time-syncing
        self.total_sync_count = 0  # Number of completed calls to resync()

        self.resync()  # Synchronize with Spot until a time-sync is established

    def get_round_trip_s(self) -> float:
        """Return the current round trip time (seconds) to communicate with Spot.

        :returns    Duration (seconds) taken by round-trip communication with Spot
        """
        return duration_to_seconds(self._time_sync_endpoint.round_trip_time)

    def get_avg_sync_time_s(self) -> float:
        """Return the average duration (seconds) each resync with Spot takes.

        :returns    Average duration (seconds) taken by each resync with Spot
        """
        return self.total_sync_time_s / self.total_sync_count

    def get_time_sync_endpoint(self) -> TimeSyncEndpoint:
        """Return the time-sync endpoint stored in this class.

        :returns    TimeSyncEndpoint object used to convert local times to robot times
        """
        return self._time_sync_endpoint

    def resync(self) -> None:
        """Ensure that a time-sync with Spot is established and/or maintained."""
        start_time_s = time.time()

        sync_established = self._time_sync_endpoint.get_new_estimate()

        if not sync_established:
            sync_success = self._time_sync_endpoint.establish_timesync()
            assert sync_success, "Could not establish a time sync with Spot!"

        # Update member variables based on the new sync information
        self.clock_skew_s = duration_to_seconds(self._time_sync_endpoint.clock_skew)
        self.max_round_trip_s = max(self.max_round_trip_s, self.get_round_trip_s())

        end_time_s = time.time()

        sync_duration_s = end_time_s - start_time_s

        self.max_sync_time_s = max(self.max_sync_time_s, sync_duration_s)

        self.total_sync_time_s += sync_duration_s
        self.total_sync_count += 1
