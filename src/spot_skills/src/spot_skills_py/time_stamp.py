"""Define a dataclass representing timestamps relative to the Unix epoch."""

from __future__ import annotations

from dataclasses import dataclass

from google.protobuf.timestamp_pb2 import Timestamp as TimestampProto

NSEC_PER_SEC = 10**9


@dataclass
class TimeStamp:
    """A timestamp representing a specific time relative to the Unix epoch.

    This time is specified as the number of seconds and nanoseconds since the epoch.
    """

    time_s: int  # Seconds since the Unix epoch began
    time_ns: int  # Nanoseconds since the timestamp's second began

    @classmethod
    def from_proto(cls, timestamp_proto: TimestampProto) -> TimeStamp:
        """Construct a TimeStamp from an equivalent Protobuf message.

        :param    timestamp_proto   Protobuf of a timestamp relative to the Unix epoch

        :returns    TimeStamp constructed based on the given timestamp Protobuf
        """
        return cls(timestamp_proto.seconds, timestamp_proto.nanos)

    @classmethod
    def from_time_s(cls, time_s: float) -> TimeStamp:
        """Construct a TimeStamp from a time (in seconds) since the Unix epoch.

        :param      time_s      Time (seconds) since the Epoch

        :returns    TimeStamp constructed based on the given time (seconds)
        """
        rounded_time_s = int(time_s)
        remaining_time_ns = int((time_s - rounded_time_s) * NSEC_PER_SEC)

        return cls(rounded_time_s, remaining_time_ns)

    @classmethod
    def shift_by_duration_s(cls, baseline: TimeStamp, shift_by_s: float) -> TimeStamp:
        """Construct a timestamp based on the given one, but shifted by the given duration.

        :param baseline: Timestamp providing the "baseline" time for the new timestamp
        :param shift_by_s: Duration (seconds) by which to shift the new timestamp
        :return: New timestamp corresponding to the given timestamp plus the shift duration
        """
        new_time_s = baseline.to_time_s() + shift_by_s
        return TimeStamp.from_time_s(new_time_s)

    def to_time_s(self) -> float:
        """Convert this timestamp into a local time relative to the Unix epoch.

        :returns    Local time (seconds) since the Unix epoch started
        """
        return self.time_s + self.time_ns / NSEC_PER_SEC

    def to_proto(self) -> TimestampProto:
        """Convert this timestamp into a Protobuf message.

        Note: Does not account for local-to-robot time conversion, as the robot command
            client will automatically make this conversion for us.

        :returns    Timestamp Protobuf message equivalent to this timestamp
        """
        return TimestampProto(seconds=self.time_s, nanos=self.time_ns)
