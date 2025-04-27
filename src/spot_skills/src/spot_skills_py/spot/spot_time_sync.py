"""Define a class to manage time synchronization with Spot."""

from __future__ import annotations

from bosdyn.client.time_sync import TimeSyncClient, TimeSyncEndpoint
from bosdyn.util import duration_to_seconds
from transform_utils.logging import log_error
from transform_utils.time_sync import SyncResult, TimeSync


class SpotTimeSync(TimeSync):
    """A wrapper to manage converting between the local clock and Spot's clock."""

    def __init__(self, client: TimeSyncClient) -> None:
        """Initialize the parent TimeSync class after storing the time-sync client.

        :param client: A client for establishing time-sync with Spot
        """
        self._time_sync_client = client
        self._time_sync_endpoint = TimeSyncEndpoint(client)

        super().__init__()

    def _sync(self) -> SyncResult | None:
        """Synchronize with Spot's clock.

        :return: Latest data from robot time-sync (None if synchronization fails)
        """
        synced = self._time_sync_endpoint.get_new_estimate()  # True if time-sync established

        if not synced:
            # Don't break once synced so that subsequent synchronizations last similarly as long
            synced = self._time_sync_endpoint.establish_timesync(break_on_success=False)

            if not synced:
                log_error("Could not establish a time sync with Spot!")
                return None

        robot_clock_skew_s = duration_to_seconds(self._time_sync_endpoint.clock_skew)
        round_trip_time_s = duration_to_seconds(self._time_sync_endpoint.round_trip_time)

        return SyncResult(robot_clock_skew_s, round_trip_time_s)

    def get_time_sync_endpoint(self) -> TimeSyncEndpoint:
        """Retrieve the time-sync endpoint stored by this class."""
        return self._time_sync_endpoint
