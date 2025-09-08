"""Define a dataclass to schedule a segmented ArmJointTrajectory."""

from __future__ import annotations

import time
from dataclasses import dataclass
from typing import TYPE_CHECKING

from bosdyn.util import seconds_to_timestamp

if TYPE_CHECKING:
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

    MIN_BUMP_S: float = 0.01
    """Minimum duration (seconds) by which a late segment must be delayed."""

    def __post_init__(self) -> None:
        """Verify required properties of any constructed SegmentSchedule instance."""
        assert len(self.segment_rel_times_s) == len(self.commands), "Schedule/commands mismatch."

        for command in self.commands:
            traj = command.synchronized_command.arm_command.arm_joint_move_command.trajectory
            assert traj.HasField("reference_time"), "Segment must have a (local) reference_time."

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
        send_early_s: float,
    ) -> float:
        """If the first knot point in segment `idx` would arrive late, slide the schedule.

        :param idx: Index of the segment under consideration
        :param send_early_s: Desired duration (seconds) to send the segment before it starts
        :return: Delta applied (seconds); 0.0 if not late
        """
        assert 0 <= idx < len(self.segment_rel_times_s), f"Segment index {idx} is out of range."

        # Find the earliest allowable local start time for the segment
        segment_start_local_s = self._first_abs_local_time_s(idx)
        earliest_start_local_s = time.time() + send_early_s

        # Robot requires the segment's first relative time to be *after* the receiving time
        #   i.e., segment_start_time > now + communication latency
        if segment_start_local_s <= earliest_start_local_s:
            delta_s = max(earliest_start_local_s - segment_start_local_s, self.MIN_BUMP_S)

            new_ref_local_s = self.ref_local_time_s + delta_s  # New shared reference time
            self.ref_local_time_s = new_ref_local_s

            # Update this segment and all future segments' reference time
            new_ref_timestamp = seconds_to_timestamp(new_ref_local_s)
            for j in range(idx, len(self.segment_rel_times_s)):
                self.commands[
                    j
                ].synchronized_command.arm_command.arm_joint_move_command.trajectory.reference_time.CopyFrom(
                    new_ref_timestamp,
                )

            return delta_s

        return 0.0
