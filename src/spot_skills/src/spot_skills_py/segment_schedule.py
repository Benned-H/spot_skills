"""Define a dataclass to schedule a segmented ArmJointTrajectory."""

from __future__ import annotations

import time
from dataclasses import dataclass
from typing import TYPE_CHECKING

from bosdyn.util import duration_to_seconds, seconds_to_duration

if TYPE_CHECKING:
    from bosdyn.api.arm_command_pb2 import ArmJointTrajectory
    from bosdyn.api.robot_command_pb2 import RobotCommand


@dataclass
class SegmentSchedule:
    """A local-time schedule for a segmented ArmJointTrajectory."""

    ref_local_time_s: float
    """Shared reference time (in local time) for the entire trajectory."""

    segment_rel_times_s: list[float]
    """First time_since_reference (seconds) for each trajectory segment."""

    commands: list[RobotCommand]
    """A RobotCommand Protobuf message per trajectory segment."""

    min_lead_s: float = 0.5
    """Minimum lead time (seconds) to send each segment in advance of its execution."""

    def __post_init__(self) -> None:
        """Verify required properties of any constructed SegmentSchedule instance."""
        assert len(self.segment_rel_times_s) == len(self.commands), "Schedule/commands mismatch."

    def _first_abs_local_time_s(self, idx: int) -> float:
        """Retrieve the absolute local time (seconds) of the first knot point in segment `idx`."""
        return self.ref_local_time_s + self.segment_rel_times_s[idx]

    def compute_send_local_time_s(self, idx: int, send_early_s: float) -> float:
        """Compute the local wall-clock time (seconds) at which to send segment `idx`."""
        assert 0 <= idx < len(self.segment_rel_times_s), f"Segment index {idx} is out of range."

        return self._first_abs_local_time_s(idx) - max(0.0, send_early_s)

    def slide_segment_if_late(
        self,
        idx: int,
        traj: ArmJointTrajectory,
        send_early_s: float,
    ) -> float:
        """If the first knot point in segment `idx` would arrive late, slide the schedule.

        :param idx: Index of the segment under consideration
        :param traj: Trajectory data for the segment
        :param send_early_s: Desired duration (seconds) to send the segment before it starts
        :return: Delta applied (seconds); 0.0 if not late
        """
        assert 0 <= idx < len(self.segment_rel_times_s), f"Segment index {idx} is out of range."
        assert traj.HasField("reference_time"), "Segment must have a reference_time (local time)."

        # Find the earliest allowable local start time for the segment
        segment_start_local_time_s = self._first_abs_local_time_s(idx)
        local_now_s = time.time()

        earliest_start_local_time_s = local_now_s + send_early_s

        # Robot requires the segment's first relative time to be *after* the receiving time
        #   i.e., segment_start_time > now + communication latency
        if segment_start_local_time_s <= earliest_start_local_time_s:
            delta_s = earliest_start_local_time_s - segment_start_local_time_s

            # Shift the current segment's Protobuf message
            for p in traj.points:
                shifted_rel_time_s = duration_to_seconds(p.time_since_reference) + delta_s
                p.time_since_reference.CopyFrom(seconds_to_duration(shifted_rel_time_s))

            # Enforce strictly monotonic knot point relative times
            prev_t = float("-inf")
            for p in traj.points:
                t = duration_to_seconds(p.time_since_reference)
                if t <= prev_t:
                    t = prev_t + 1e-3
                    p.time_since_reference.CopyFrom(seconds_to_duration(t))
                prev_t = t

            # Update the rest of the segment schedule accordingly
            for j in range(idx, len(self.segment_rel_times_s)):
                self.segment_rel_times_s[j] += delta_s

            return delta_s

        return 0.0
