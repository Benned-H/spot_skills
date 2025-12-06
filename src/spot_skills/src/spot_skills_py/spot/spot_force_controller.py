"""Define a class to control Spot's arm using force sensing for surface detection."""

from __future__ import annotations

import time
from typing import TYPE_CHECKING

import numpy as np
from bosdyn.api import (
    arm_command_pb2,
    geometry_pb2,
    robot_command_pb2,
    synchronized_command_pb2,
    trajectory_pb2,
)
from bosdyn.client.frame_helpers import HAND_FRAME_NAME, ODOM_FRAME_NAME, get_a_tform_b
from bosdyn.client.robot_command import block_until_arm_arrives
from bosdyn.util import seconds_to_duration
from robotics_utils.kinematics.planes import Plane3D

if TYPE_CHECKING:
    from numpy.typing import NDArray

    from spot_skills_py.spot.spot_manager import SpotManager


class SpotForceController:
    """A controller for Spot's arm that uses force sensing for surface detection."""

    def __init__(self, spot_manager: SpotManager):
        """Initialize the force controller for Spot's arm.

        :param spot_manager: Manager of the connection to Spot
        """
        assert spot_manager.has_arm(), "Cannot control Spot's arm if Spot has no arm!"
        self._manager = spot_manager

    def probe_surface(
        self,
        direction: NDArray[np.float64] | None = None,
        max_distance_m: float = 0.2,
        velocity_m_per_s: float = 0.02,
        force_threshold_n: float = 15.0,
        num_probes: int = 3,
        probe_interval_s: float = 0.5,
    ) -> Plane3D:
        """Probe forward to detect a surface using force sensing.

        Moves the gripper forward (relative to the end-effector frame) until contact
        is detected via force threshold. Re-probes multiple times to build confidence
        in the surface location, then returns a plane representation.

        :param direction: Direction vector in hand frame (defaults to [1, 0, 0] = forward)
        :param max_distance_m: Maximum distance to probe forward (meters)
        :param velocity_m_per_s: Probing velocity (meters per second)
        :param force_threshold_n: Force threshold to detect contact (Newtons)
        :param num_probes: Number of probes to perform for averaging
        :param probe_interval_s: Time to wait between probes (seconds)
        :return: Plane3D representation of the detected surface
        """
        if not self._manager.has_control:
            raise RuntimeError("Cannot probe; SpotManager doesn't control Spot.")

        # Default to probing forward in the hand frame (X-axis)
        if direction is None:
            direction = np.array([1.0, 0.0, 0.0])
        else:
            # Normalize the direction vector
            direction = np.asarray(direction, dtype=np.float64)
            direction = direction / np.linalg.norm(direction)

        self._manager.log_info(f"Starting surface probe with {num_probes} probes...")

        # Collect contact points from multiple probes
        contact_points = []
        for i in range(num_probes):
            self._manager.log_info(f"Probe {i + 1}/{num_probes}...")
            contact_point = self._single_probe(
                direction=direction,
                max_distance_m=max_distance_m,
                velocity_m_per_s=velocity_m_per_s,
                force_threshold_n=force_threshold_n,
            )
            contact_points.append(contact_point)

            # Wait between probes (except after the last one)
            if i < num_probes - 1:
                time.sleep(probe_interval_s)

        # Average the contact points to get a more reliable surface point
        contact_points_array = np.array(contact_points)
        avg_contact_point = contact_points_array.mean(axis=0)

        self._manager.log_info(f"Surface detected at: {avg_contact_point}")

        # The surface normal is opposite to the probing direction
        # (we probed forward, so the surface faces backward toward us)
        surface_normal = -direction

        return Plane3D(point=avg_contact_point, normal=surface_normal)

    def _single_probe(
        self,
        direction: NDArray[np.float64],
        max_distance_m: float,
        velocity_m_per_s: float,
        force_threshold_n: float,
    ) -> NDArray[np.float64]:
        """Perform a single probing motion and return the contact point.

        Uses incremental movements to probe forward, checking force after each step.

        :param direction: Normalized direction vector in hand frame
        :param max_distance_m: Maximum distance to probe
        :param velocity_m_per_s: Probing velocity
        :param force_threshold_n: Force threshold for contact detection
        :return: Contact point in odom frame (shape: (3,))
        """
        # Use small incremental steps for better control
        step_size_m = 0.01  # 1 cm steps
        step_duration_s = step_size_m / velocity_m_per_s
        num_steps = int(max_distance_m / step_size_m)

        distance_traveled = 0.0
        contact_detected = False
        contact_position = None

        for step in range(num_steps):
            # Get current robot state and hand pose
            robot_state = self._manager.get_robot_state()

            # Check force before moving (in case we're already in contact)
            if robot_state.manipulator_state.HasField("estimated_end_effector_force_in_hand"):
                force_in_hand = robot_state.manipulator_state.estimated_end_effector_force_in_hand
                force_magnitude = np.linalg.norm(
                    [force_in_hand.x, force_in_hand.y, force_in_hand.z],
                )

                if force_magnitude > force_threshold_n:
                    # Contact detected!
                    odom_t_hand = get_a_tform_b(
                        robot_state.kinematic_state.transforms_snapshot,
                        ODOM_FRAME_NAME,
                        HAND_FRAME_NAME,
                    )
                    contact_position = np.array([odom_t_hand.x, odom_t_hand.y, odom_t_hand.z])
                    contact_detected = True
                    self._manager.log_info(f"Contact detected! Force: {force_magnitude:.2f} N")
                    break

            # No contact yet, take another step forward
            odom_t_hand = get_a_tform_b(
                robot_state.kinematic_state.transforms_snapshot,
                ODOM_FRAME_NAME,
                HAND_FRAME_NAME,
            )

            # Transform direction vector to odom frame
            direction_in_odom = odom_t_hand.rotation.transform_point(
                direction[0],
                direction[1],
                direction[2],
            )
            direction_in_odom = np.array(direction_in_odom)

            # Compute next target position
            current_position = np.array([odom_t_hand.x, odom_t_hand.y, odom_t_hand.z])
            target_position = current_position + direction_in_odom * step_size_m

            # Build a short Cartesian trajectory for this step
            start_pose = odom_t_hand.to_proto()
            target_pose_proto = geometry_pb2.SE3Pose(
                position=geometry_pb2.Vec3(
                    x=target_position[0],
                    y=target_position[1],
                    z=target_position[2],
                ),
                rotation=start_pose.rotation,  # Keep same orientation
            )

            traj_points = [
                trajectory_pb2.SE3TrajectoryPoint(
                    pose=start_pose,
                    time_since_reference=seconds_to_duration(0.0),
                ),
                trajectory_pb2.SE3TrajectoryPoint(
                    pose=target_pose_proto,
                    time_since_reference=seconds_to_duration(step_duration_s),
                ),
            ]

            hand_trajectory = trajectory_pb2.SE3Trajectory(points=traj_points)

            # Create arm cartesian command (pure position control)
            arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
                pose_trajectory_in_task=hand_trajectory,
                root_frame_name=ODOM_FRAME_NAME,
                x_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
                y_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
                z_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
                rx_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
                ry_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
                rz_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            )

            arm_command = arm_command_pb2.ArmCommand.Request(
                arm_cartesian_command=arm_cartesian_command,
            )
            synchronized_command = synchronized_command_pb2.SynchronizedCommand.Request(
                arm_command=arm_command,
            )
            robot_command = robot_command_pb2.RobotCommand(
                synchronized_command=synchronized_command,
            )

            # Send the command and wait for completion
            command_id = self._manager.send_robot_command(robot_command)
            block_until_arm_arrives(self._manager.command_client, command_id, step_duration_s + 1.0)

            distance_traveled += step_size_m

        if not contact_detected:
            self._manager.log_info("No contact detected; reached max distance.")
            # Return the final position
            robot_state = self._manager.get_robot_state()
            odom_t_hand = get_a_tform_b(
                robot_state.kinematic_state.transforms_snapshot,
                ODOM_FRAME_NAME,
                HAND_FRAME_NAME,
            )
            contact_position = np.array([odom_t_hand.x, odom_t_hand.y, odom_t_hand.z])

        return contact_position

    def retract_after_probe(
        self,
        retract_distance_m: float = 0.05,
        direction: NDArray[np.float64] | None = None,
    ) -> None:
        """Retract the gripper after probing (move backward from contact).

        :param retract_distance_m: Distance to retract (meters)
        :param direction: Direction to retract in hand frame (defaults to [-1, 0, 0] = backward)
        """
        # Default to retracting backward in the hand frame (opposite of probe direction)
        if direction is None:
            direction = np.array([-1.0, 0.0, 0.0])
        else:
            direction = np.asarray(direction, dtype=np.float64)
            direction = direction / np.linalg.norm(direction)

        self._manager.log_info(f"Retracting {retract_distance_m:.3f} m...")

        # Get current robot state and hand pose
        robot_state = self._manager.get_robot_state()
        odom_t_hand = get_a_tform_b(
            robot_state.kinematic_state.transforms_snapshot,
            ODOM_FRAME_NAME,
            HAND_FRAME_NAME,
        )

        # Transform direction vector to odom frame
        direction_in_odom = odom_t_hand.rotation.transform_point(
            direction[0],
            direction[1],
            direction[2],
        )
        direction_in_odom = np.array(direction_in_odom)

        # Compute target position
        current_position = np.array([odom_t_hand.x, odom_t_hand.y, odom_t_hand.z])
        target_position = current_position + direction_in_odom * retract_distance_m

        # Build retraction trajectory (relatively fast)
        retract_duration_s = 1.0
        start_pose = odom_t_hand.to_proto()
        target_pose_proto = geometry_pb2.SE3Pose(
            position=geometry_pb2.Vec3(
                x=target_position[0],
                y=target_position[1],
                z=target_position[2],
            ),
            rotation=start_pose.rotation,
        )

        traj_points = [
            trajectory_pb2.SE3TrajectoryPoint(
                pose=start_pose,
                time_since_reference=seconds_to_duration(0.0),
            ),
            trajectory_pb2.SE3TrajectoryPoint(
                pose=target_pose_proto,
                time_since_reference=seconds_to_duration(retract_duration_s),
            ),
        ]

        hand_trajectory = trajectory_pb2.SE3Trajectory(points=traj_points)

        # Create arm cartesian command
        arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
            pose_trajectory_in_task=hand_trajectory,
            root_frame_name=ODOM_FRAME_NAME,
            x_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            y_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            z_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            rx_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            ry_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            rz_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
        )

        arm_command = arm_command_pb2.ArmCommand.Request(
            arm_cartesian_command=arm_cartesian_command,
        )
        synchronized_command = synchronized_command_pb2.SynchronizedCommand.Request(
            arm_command=arm_command,
        )
        robot_command = robot_command_pb2.RobotCommand(synchronized_command=synchronized_command)

        # Send the command and wait for completion
        command_id = self._manager.send_robot_command(robot_command)
        block_until_arm_arrives(self._manager.command_client, command_id, retract_duration_s + 1.0)

        self._manager.log_info("Retraction complete.")
