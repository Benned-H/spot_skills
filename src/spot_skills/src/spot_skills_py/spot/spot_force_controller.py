"""Define a class to control Spot's arm using force sensing for surface detection."""

from __future__ import annotations

import time
from typing import TYPE_CHECKING

import numpy as np
from bosdyn.client.frame_helpers import ODOM_FRAME_NAME
from bosdyn.client.math_helpers import SE3Pose
from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import seconds_to_timestamp
from robotics_utils.geometry import Plane3D, Point3D
from robotics_utils.ros import PoseBroadcastThread

from spot_skills_py.spot.spot_conversion import HAND_T_FINGERTIP, pose_from_sdk

if TYPE_CHECKING:
    from spot_skills_py.spot.spot_manager import SpotManager


class SpotForceController:
    """A controller for Spot's arm that uses force sensing for surface detection."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the force controller with an interface to control Spot."""
        assert manager.has_arm(), "Cannot force-control Spot's arm if Spot has no arm!"
        self._manager = manager

        self._pose_broadcaster = PoseBroadcastThread()

    def probe_surface(
        self,
        direction: Point3D = Point3D(1, 0, 0),  # noqa: B008
        max_distance_m: float = 0.2,
        velocity_mps: float = 0.02,
        force_threshold_n: float = 8.0,
        force_check_hz: float = 50.0,
        num_probes: int = 3,
        probe_interval_s: float = 0.5,
    ) -> Plane3D | None:
        """Probe forward with Spot's gripper to detect a surface using force sensing.

        Moves the gripper forward (relative to the end-effector frame) until contact
        is detected. Re-probes multiple times to build confidence in the surface
        location, then returns a plane representation.

        :param direction: Direction vector in end-effector frame (defaults to (1, 0, 0) = forward)
        :param max_distance_m: Maximum distance to probe forward (meters)
        :param velocity_mps: Probing velocity (meters per second)
        :param force_threshold_n: Force threshold to detect contact (Newtons)
        :param force_check_hz: Frequency (Hz) to check force sensor during probing
        :param num_probes: Number of probes to perform for averaging
        :param probe_interval_s: Time to wait between probes (seconds)
        :return: Plane3D representation of the detected surface, or None if no surface was detected
        """
        if not self._manager.has_control:
            raise RuntimeError("Cannot probe; SpotManager doesn't control Spot.")

        direction = direction.normalized()  # Normalize the direction vector

        self._manager.log_info(f"Starting surface probe with {num_probes} probes...")

        contact_points = []
        for i in range(num_probes):
            self._manager.log_info(f"Probe {i + 1}/{num_probes}...")
            contact_point = self._single_probe(
                direction=direction,
                max_distance_m=max_distance_m,
                velocity_mps=velocity_mps,
                force_threshold_n=force_threshold_n,
                force_check_hz=force_check_hz,
            )
            if contact_point is not None:
                contact_points.append(contact_point.to_array())

            # Wait between probes (except after the last one)
            if i < num_probes - 1:
                time.sleep(probe_interval_s)

        if not contact_points:
            self._manager.log_info("All probes failed to find contact; returning None...")
            return None

        avg_contact_point = np.asarray(contact_points).mean(axis=0)

        self._manager.log_info(f"Surface detected at: {avg_contact_point}")

        # Assume that the surface normal is opposite our probing direction
        surface_normal = -direction.to_array()

        return Plane3D(point=avg_contact_point, normal=surface_normal)

    def _single_probe(
        self,
        direction: Point3D,
        max_distance_m: float,
        velocity_mps: float,
        force_threshold_n: float,
        force_check_hz: float,
    ) -> Point3D | None:
        """Perform a single probing motion and return the contact point.

        :param direction: Direction vector in end-effector frame
        :param max_distance_m: Maximum distance to probe forward (meters)
        :param velocity_mps: Probing velocity (meters per second)
        :param force_threshold_n: Force threshold to detect contact (Newtons)
        :param force_check_hz: Frequency (Hz) to check force sensor during probing
        :return: Contact position of Spot's hand in the odom frame (or None if no contact detected)
        """
        # Capture initial end-effector pose to return to after contact
        initial_pose = self._manager.get_hand_pose(ref_frame=ODOM_FRAME_NAME)
        self._pose_broadcaster.poses["probe_initial_pose"] = pose_from_sdk(
            initial_pose,
            ref_frame=ODOM_FRAME_NAME,
        )

        # Pre-construct the return-to-initial-pose command for immediate execution on contact
        return_command = RobotCommandBuilder.arm_pose_command_from_pose(
            hand_pose=initial_pose.to_proto(),
            frame_name=ODOM_FRAME_NAME,
            seconds=1,  # Quick return to minimize contact time
        )

        # Calculate the target pose (max_distance_m in the probing direction)
        direction_in_odom = np.asarray(
            initial_pose.rotation.transform_point(direction.x, direction.y, direction.z),
        )
        initial_xyz = np.asarray([initial_pose.x, initial_pose.y, initial_pose.z])
        target_xyz = Point3D.from_array(initial_xyz + direction_in_odom * max_distance_m)
        target_pose = SE3Pose(
            x=target_xyz.x,
            y=target_xyz.y,
            z=target_xyz.z,
            rot=initial_pose.rotation,
        )
        self._pose_broadcaster.poses["probe_target_pose"] = pose_from_sdk(
            target_pose,
            ref_frame=ODOM_FRAME_NAME,
        )

        # Build a two-pose Cartesian trajectory with proper timing
        # Based on: spot-sdk/python/examples/arm_trajectory/arm_long_cartesian_trajectory.py
        total_duration_s = max_distance_m / velocity_mps
        start_time = time.time() + 0.5  # Push the trajectory reference time into the future
        ref_time = seconds_to_timestamp(start_time)

        self._manager.log_info(f"Probing with a {total_duration_s:.2f}-second trajectory...")
        arm_cartesian_command = RobotCommandBuilder.arm_cartesian_move_helper(
            se3_poses=[initial_pose.to_proto(), target_pose.to_proto()],
            times=[-0.1, total_duration_s],  # Start in the past for smooth execution!
            root_frame_name=ODOM_FRAME_NAME,
            ref_time=ref_time,
        )

        # Send the trajectory (non-blocking)
        command_id = self._manager.send_robot_command(
            arm_cartesian_command,
            duration_s=total_duration_s + 3.0,
        )
        if command_id is None:
            self._manager.log_info("Received None instead of command ID when probing!")
            return None

        # Monitor force at the specified frequency
        check_period_s = 1.0 / force_check_hz
        contact_point = None
        return_id = None

        end_time = time.time() + total_duration_s
        while time.time() < end_time:
            robot_state = self._manager.get_robot_state()
            wrench = robot_state.manipulator_state.estimated_end_effector_wrench_in_end_effector
            force_n = np.linalg.norm(np.asarray([wrench.force.x, wrench.force.y, wrench.force.z]))

            if force_n > force_threshold_n:  # Contact detected!
                # Record current pose as contact location, then IMMEDIATELY retract
                touch_pose = self._manager.get_hand_pose(ref_frame=ODOM_FRAME_NAME)

                # Send pre-built return command immediately!
                return_id = self._manager.send_robot_command(return_command)

                # NOW calculate the contact point for return value (using recorded touch_pose)
                self._manager.log_info(f"Contact detected! Force: {force_n:.2f} N.")
                contact_xyz_odom_hand = np.asarray([touch_pose.x, touch_pose.y, touch_pose.z])

                # Transform hand-to-fingertip offset from hand frame to odom frame
                fingertip_offset_expressed_in_odom = np.asarray(
                    touch_pose.rotation.transform_point(*HAND_T_FINGERTIP.position.to_tuple()),
                )
                contact_xyz = contact_xyz_odom_hand + fingertip_offset_expressed_in_odom
                contact_point = Point3D.from_array(contact_xyz)

                break

            time.sleep(check_period_s)

        # If contact was never detected, wait until trajectory finishes, then move to initial pose
        if contact_point is None:
            self._manager.log_info("No contact detected; waiting for trajectory to finish.")
            self._manager.block_until_arm_arrives(command_id)
            return_id = self._manager.send_robot_command(return_command)  # Return to initial pose

        self._manager.log_info("Waiting for arm to return to initial pose...")
        if return_id is not None:
            self._manager.block_until_arm_arrives(return_id)
        else:
            time.sleep(1.5)  # Wait for the 1-second return command to complete (with buffer)

        return contact_point
