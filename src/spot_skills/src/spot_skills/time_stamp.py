"""Define a dataclass representing timestamps relative to the Unix epoch."""

from dataclasses import dataclass
from enum import Enum

from google.protobuf.timestamp_pb2 import Timestamp as TimestampProto

NSEC_PER_SEC = 10**9


class SystemClock(Enum):
    """A system clock relative to which a timestamp is specified."""

    ROBOT = 0
    LOCAL = 1


@dataclass
class TimeStamp:
    """A timestamp representing a specific time relative to the Unix epoch.

    This time is specified as the number of seconds and nanoseconds since the epoch.
    """

    time_s: int  # Seconds since the Unix epoch began
    time_ns: int  # Nanoseconds since the timestamp's second began
    clock: SystemClock  # System clock relative to which this timestamp is specified

    @classmethod
    def from_proto(cls, timestamp_proto: TimestampProto):
        """Construct a TimeStamp from an equivalent Protobuf message.

        Typically, Protobuf timestamp messages use the robot clock.

        :param    timestamp_proto    Timestamp since the Unix epoch began
        """
        return cls(timestamp_proto.seconds, timestamp_proto.nanos, SystemClock.ROBOT)

    @classmethod
    def from_time_s(cls, time_s: float, clock: SystemClock):
        """Construct a TimeStamp from a number of seconds since the Epoch.

        :param      time_s      Time (seconds) since the Epoch
        :param      clock       Relative system clock for the timestamp
        """
        rounded_time_s = int(time_s)
        remaining_time_ns = int((time_s - rounded_time_s) * NSEC_PER_SEC)

        return cls(rounded_time_s, remaining_time_ns, clock)

    def to_time_s(self) -> float:
        """Convert this timestamp into a number of seconds since the Unix epoch.

        :returns    Time (seconds) since the Unix epoch started
        """
        return self.time_s + self.time_ns / NSEC_PER_SEC
