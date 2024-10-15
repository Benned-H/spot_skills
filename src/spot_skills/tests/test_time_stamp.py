"""Verify expected behaviors of the TimeStamp class."""

import time
from math import isclose

from spot_skills.time_stamp import TimeStamp


def test_to_from_time_s() -> None:
    """Verify that a time is unchanged after converting to a timestamp and back."""
    # Arrange - Query the current local time
    time_s = time.time()

    # Act - Convert the current time into a timestamp, then back
    timestamp = TimeStamp.from_time_s(time_s)
    result_time_s = timestamp.to_time_s()

    # Assert - Expect that the time is unchanged after the conversion
    assert isclose(time_s, result_time_s)


def test_to_from_proto() -> None:
    """Verify that a timestamp is unchanged after converting to a Protobuf and back."""
    # Arrange - Query the current time and construct a corresponding timestamp
    time_s = time.time()
    timestamp = TimeStamp.from_time_s(time_s)

    # Act - Convert the timestamp to a Protobuf message, then convert back
    timestamp_proto = timestamp.to_proto()
    from_proto_timestamp = TimeStamp.from_proto(timestamp_proto)

    # Assert - Expect that the resulting timestamp equals the original timestamp
    assert timestamp.time_s == from_proto_timestamp.time_s
    assert timestamp.time_ns == from_proto_timestamp.time_ns
