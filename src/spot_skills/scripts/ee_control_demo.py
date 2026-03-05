#!/usr/bin/env python

"""Test end-effector position and velocity control on Spot's arm.

This demo cycles Spot's arm through the following phases:
  1. Left  (ee_pose  - position control: reset arm to left extreme)
  2. Right (ee_cmd_vel - velocity control: full left-to-right sweep, accelerating)
  ... then repeat.

Using position control to snap to the left extreme and then driving the full
~1.2 m sweep rightward with a linearly-accelerating velocity command gives a
wide, continuous test of the velocity controller across its operating range.

Run this demo via its launch file:
    roslaunch spot_skills ee_control_demo.launch spot_name:=NAME_HERE
"""

import rospy
from geometry_msgs.msg import PoseStamped, Twist
from robotics_utils.ros import trigger_service
from robotics_utils.ros.msg_conversion import pose_to_stamped_msg
from robotics_utils.spatial import Pose3D

# ---------------------------------------------------------------------------
# Path geometry: kept identical to the MoveIt demo for easy comparison
# ---------------------------------------------------------------------------
_FORWARD_M = 0.6
_TO_SIDE_M = 0.6  # maximum lateral reach (m)
_Z_VARIATION_M = 0.05
_Z_WRT_BODY = 0.4  # height in body frame (m)

# ---------------------------------------------------------------------------
# Velocity-phase parameters
# ---------------------------------------------------------------------------
# Min/max rightward speed for the acceleration ramp (m/s).
# Staying within ~0.3 m/s keeps the arm well within Spot's safe range.
_VEL_MIN_MPS = 0.05
_VEL_MAX_MPS = 0.30

# How long to drive the rightward velocity phase (seconds).
# Full left-to-right sweep = 2 * _TO_SIDE_M = 1.2 m.
# Average ramp speed = (_VEL_MIN_MPS + _VEL_MAX_MPS) / 2 ≈ 0.175 m/s
# → 1.2 m / 0.175 m/s ≈ 6.9 s; use 7.0 s to reach the right extent.
_VEL_PHASE_DURATION_S = 7.0

# Publish rate for velocity commands (Hz).
# Each command lasts _ee_velocity_cmd_duration_s = 0.5 s in the wrapper, so
# publishing at 10 Hz provides 5x overlap: robust to ~400 ms latency spikes.
_VEL_PUBLISH_HZ = 10.0

# Optional: add a small downward component to test multi-axis blending.
# Set to 0.0 to disable.
_VEL_Z_MPS = -0.03  # slight downward drift during rightward movement

# ---------------------------------------------------------------------------
# Position-phase parameters
# ---------------------------------------------------------------------------
# Duration to keep re-publishing the left-pose target (seconds).
# The wrapper moves the EE at _ee_pose_max_vel_mps = 0.4 m/s, so a 1.2 m
# return trip (right → left) takes ~3 s.  5 s gives ~2 s of dwell at the
# left extreme before the velocity sweep begins.
_POSE_HOLD_S = 5.0
_POSE_PUBLISH_HZ = 5.0  # republish rate while holding a position target


def _command_pose(pub: rospy.Publisher, pose: Pose3D, duration_s: float, rate_hz: float) -> None:
    """Repeatedly publish a PoseStamped target until duration_s elapses."""
    msg: PoseStamped = pose_to_stamped_msg(pose)
    rate = rospy.Rate(rate_hz)
    end_time = rospy.Time.now() + rospy.Duration.from_sec(duration_s)
    while not rospy.is_shutdown() and rospy.Time.now() < end_time:
        pub.publish(msg)
        rate.sleep()


def _command_rightward_velocity(
    pub: rospy.Publisher,
    duration_s: float,
    rate_hz: float,
    min_speed_mps: float,
    max_speed_mps: float,
    z_speed_mps: float,
) -> None:
    """Publish rightward velocity commands with a linear acceleration ramp.

    Speed increases linearly from *min_speed_mps* at t=0 to *max_speed_mps*
    at t=duration_s.  A constant *z_speed_mps* component can be included to
    test multi-axis blending (set to 0 to disable).

    After the phase ends a zero-velocity command is sent to cleanly stop.
    """
    rate = rospy.Rate(rate_hz)
    start = rospy.Time.now()

    while not rospy.is_shutdown():
        elapsed = (rospy.Time.now() - start).to_sec()
        if elapsed >= duration_s:
            break

        t = min(elapsed / duration_s, 1.0)  # normalised progress [0, 1]
        speed_y = min_speed_mps + t * (max_speed_mps - min_speed_mps)

        twist = Twist()
        twist.linear.y = -speed_y  # negative y → rightward in body frame
        twist.linear.z = z_speed_mps

        rospy.loginfo(
            f"ee_cmd_vel  y={twist.linear.y:+.3f} m/s  z={twist.linear.z:+.3f} m/s"
            f"  (t={elapsed:.2f}/{duration_s:.1f} s,  ramp={t * 100:.0f}%)",
        )
        pub.publish(twist)
        rate.sleep()

    # Explicit zero command so the wrapper doesn't coast on a stale command.
    pub.publish(Twist())
    rospy.loginfo("ee_cmd_vel: sent zero-velocity to stop.")


def main() -> None:
    """Run the end-effector control demo."""
    rospy.init_node("ee_control_demo")

    ee_pose_pub = rospy.Publisher("/spot/ee_pose", PoseStamped, queue_size=1)
    ee_vel_pub = rospy.Publisher("/spot/ee_cmd_vel", Twist, queue_size=1)

    trigger_service("spot/take_control")

    # Stand up first (retry until successful), then unlock the arm.
    stood_up = False
    while not stood_up and not rospy.is_shutdown():
        stood_up = trigger_service("spot/stand").success
        rospy.sleep(3.0)

    trigger_service("spot/unlock_arm")

    left_pose = Pose3D.from_xyz_rpy(
        x=_FORWARD_M,
        y=_TO_SIDE_M,
        z=_Z_WRT_BODY + _Z_VARIATION_M,
        ref_frame="body",
    )

    rospy.loginfo(
        "EE control demo started.\n"
        "Cycle: left(pose) → right(vel, ramping) → …\n"
        f"Velocity ramp: {_VEL_MIN_MPS} → {_VEL_MAX_MPS} m/s over {_VEL_PHASE_DURATION_S} s"
        + (f", z={_VEL_Z_MPS} m/s" if _VEL_Z_MPS != 0.0 else ""),
    )

    while not rospy.is_shutdown():
        # --- Phase 1: reset to left extreme using position control ---
        rospy.loginfo("Phase 1: left pose (ee_pose)")
        _command_pose(ee_pose_pub, left_pose, _POSE_HOLD_S, _POSE_PUBLISH_HZ)

        # --- Phase 2: full left-to-right sweep using velocity control ---
        rospy.loginfo("Phase 2: rightward velocity sweep (ee_cmd_vel, linear ramp)")
        _command_rightward_velocity(
            ee_vel_pub,
            duration_s=_VEL_PHASE_DURATION_S,
            rate_hz=_VEL_PUBLISH_HZ,
            min_speed_mps=_VEL_MIN_MPS,
            max_speed_mps=_VEL_MAX_MPS,
            z_speed_mps=_VEL_Z_MPS,
        )

        # Brief pause before the next cycle begins.
        rospy.sleep(0.5)


if __name__ == "__main__":
    main()
