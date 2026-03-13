"""Define functions to enable Spot to erase a whiteboard.

Note: Originally adapted from the Spot SDK example "erase.py".
"""

from __future__ import annotations

import time
from dataclasses import dataclass
from typing import TYPE_CHECKING

from bosdyn.api import (
    arm_command_pb2,
    geometry_pb2,
    robot_command_pb2,
    synchronized_command_pb2,
    trajectory_pb2,
)
from bosdyn.api.spot import robot_command_pb2 as spot_command_pb2
from bosdyn.client.frame_helpers import BODY_FRAME_NAME
from bosdyn.client.robot_command import block_until_arm_arrives
from bosdyn.util import seconds_to_duration
from robotics_utils.perception import PlaneEstimate, PointCloud

from spot_skills_py.spot.spot_conversion import pose_to_sdk

if TYPE_CHECKING:
    from robotics_utils.geometry import Plane3D
    from robotics_utils.spatial import Pose3D

    from spot_skills_py.spot.spot_lidar import SpotLiDAR
    from spot_skills_py.spot.spot_manager import SpotManager


def generate_zigzag_erase_pattern(
    x_min: float,
    x_max: float,
    z_min: float,
    z_max: float,
    x_spacing_m: float,
) -> list[tuple[float, float]]:
    """Generate a zig-zag erase pattern for a rectangular region in map frame.

    Creates a pattern of top-to-bottom vertical strokes with diagonal transitions
    between columns. Starts at (x_min, z_max) and moves rightward (increasing x).

    All coordinates are in map frame, where:
    - x is the horizontal axis (left/right relative to the board)
    - z is the vertical axis (up/down)

    :param x_min: Minimum x-coordinate in map frame (left edge of erase region)
    :param x_max: Maximum x-coordinate in map frame (right edge of erase region)
    :param z_min: Minimum z-coordinate (bottom of erase region)
    :param z_max: Maximum z-coordinate (top of erase region)
    :param x_spacing_m: Distance between adjacent vertical strokes
    :return: List of (x, z) tuples in map frame representing the erase trajectory
    """
    points: list[tuple[float, float]] = []

    # Start from left side (x_min) and move right
    x = x_min
    while x <= x_max:
        points.append((x, z_max))  # Top of column
        points.append((x, z_min))  # Bottom of column (vertical erase stroke)

        x += x_spacing_m  # Move to next column (if there is one)
        # The diagonal transition happens implicitly: (x_prev, z_min) -> (x_next, z_max)

    return points


def group_points_into_swaths(
    xz_points: list[tuple[float, float]],
    reachable_half_width_m: float,
) -> list[tuple[float, list[tuple[float, float]]]]:
    """Group (x, z) points in map frame into swaths based on reachable arm width.

    Each swath contains points within a ±reachable_half_width_m band centered at
    some x value. Returns swaths ordered from min x to max x, with the target
    robot x position needed to reach each swath.

    :param xz_points: List of (x, z) tuples in map frame
    :param reachable_half_width_m: Half-width (meters) of what the arm can reach
    :return: List of (target_robot_x, points) tuples, where target_robot_x is where
             the robot should be positioned (map x) to reach this swath, and points
             are the (x, z) tuples in that swath
    """
    if not xz_points:
        return []

    # Find the x range
    x_values = [x for x, _ in xz_points]
    x_min, x_max = min(x_values), max(x_values)

    # Calculate swath boundaries
    swath_width = 2 * reachable_half_width_m
    swaths: list[tuple[float, list[tuple[float, float]]]] = []

    # Start from x_min and create swaths moving toward x_max
    swath_center = x_min + reachable_half_width_m
    while swath_center - reachable_half_width_m <= x_max:
        swath_min = swath_center - reachable_half_width_m
        swath_max = swath_center + reachable_half_width_m

        # Collect points in this swath
        swath_points = [(x, z) for x, z in xz_points if swath_min - 1e-6 <= x <= swath_max + 1e-6]

        if swath_points:
            # The target robot x position: robot should be at swath_center in map x
            # so that targets are centered in front of the robot
            target_robot_x = swath_center
            swaths.append((target_robot_x, swath_points))

        swath_center += swath_width

    return swaths


def erase_board(
    manager: SpotManager,
    erase_traj_poses: list[Pose3D],
    force_n: float = 10.0,
    segment_time_s: float = 3.0,
    standoff_distance_m: float = 0.05,
    standoff_wait_s: float = 3.0,
) -> None:
    """Use the given Spot manager to erase a whiteboard along the given trajectory.

    All poses are in the body frame. The robot stays in place and erases
    whatever is directly in front of it.

    - +x = forward (toward the board)
    - +y = left, -y = right (sweep direction)
    - +z = up

    Force is applied in body +x direction (pressing into the board).
    Standoff is in body -x direction (pulling back from the board).

    :param manager: SpotManager instance with an authenticated robot
    :param erase_traj_poses: List of Pose3D waypoints in body frame
    :param force_n: Force (Newtons) to apply in body +x direction (toward whiteboard)
    :param segment_time_s: Time (seconds) to move between consecutive waypoints
    :param standoff_distance_m: Distance (meters) behind first pose to deploy arm (for safety)
    :param standoff_wait_s: Time (seconds) to wait at standoff pose before starting
    """
    assert manager.has_arm(), "Robot requires an arm to erase a whiteboard!"
    assert len(erase_traj_poses) >= 2, "Need at least 2 poses for a trajectory."

    manager.log_info("Now starting erase_board()...")
    manager.log_info(f"Force: {force_n} N (body +x), segment time: {segment_time_s} s")

    # Make Spot stand and enable Spot to adjust its body height to assist manipulation
    body_control = spot_command_pb2.BodyControlParams(
        body_assist_for_manipulation=spot_command_pb2.BodyControlParams.BodyAssistForManipulation(
            enable_hip_height_assist=True,
            enable_body_yaw_assist=True,
        ),
    )

    manager.stand_up(10, control_params=body_control)

    # Convert Pose3D list to SDK SE3Pose objects (poses are in body frame)
    hand_poses = [pose_to_sdk(pose) for pose in erase_traj_poses]

    # Create standoff pose: first pose shifted back in body -x direction (away from board)
    first_pose = hand_poses[0]
    standoff_pose = first_pose.__class__(
        x=first_pose.x - standoff_distance_m,  # Shift in body -x (away from board)
        y=first_pose.y,
        z=first_pose.z,
        rot=first_pose.rotation,
    )

    # Deploy arm to standoff pose (position control, no force) instead of default 'deployed'
    manager.log_info(
        f"Moving arm to standoff pose ({standoff_distance_m * 100:.0f} cm behind start)...",
    )
    standoff_traj = trajectory_pb2.SE3Trajectory(
        points=[
            trajectory_pb2.SE3TrajectoryPoint(
                pose=standoff_pose.to_proto(),
                time_since_reference=seconds_to_duration(3.0),  # 3 sec to reach standoff
            ),
        ],
    )
    arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
        pose_trajectory_in_task=standoff_traj,
        root_frame_name=BODY_FRAME_NAME,
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
    command_id = manager.send_robot_command(robot_command)
    block_until_arm_arrives(manager.command_client, command_id, 10.0)

    # Wait at standoff pose - user can take control here if position looks wrong
    manager.log_info(
        f"At standoff pose. Waiting {standoff_wait_s} s before starting erase "
        "(take control now to abort)...",
    )
    time.sleep(standoff_wait_s)

    # --------------- #
    # Hybrid position-force mode and trajectories.

    # Build trajectory points with correct timestamps:
    # For pairwise trajectories, first point at t=0, second at t=segment_time_s
    traj_points_start = [
        trajectory_pb2.SE3TrajectoryPoint(
            pose=hand_pose.to_proto(),
            time_since_reference=seconds_to_duration(0.0),  # Start point at t=0
        )
        for hand_pose in hand_poses
    ]
    traj_points_end = [
        trajectory_pb2.SE3TrajectoryPoint(
            pose=hand_pose.to_proto(),
            time_since_reference=seconds_to_duration(segment_time_s),  # End at t=segment
        )
        for hand_pose in hand_poses
    ]

    # Build pairwise trajectories (move between consecutive waypoints)
    hand_trajs = [
        trajectory_pb2.SE3Trajectory(points=[traj_points_start[i], traj_points_end[i + 1]])
        for i in range(len(hand_poses) - 1)
    ]

    # Force in body +x direction (toward the board, which is in front of the robot)
    force = geometry_pb2.Vec3(x=force_n, y=0.0, z=0.0)
    torque = geometry_pb2.Vec3(x=0, y=0, z=0)
    wrench = geometry_pb2.Wrench(force=force, torque=torque)

    wrench_traj_point = trajectory_pb2.WrenchTrajectoryPoint(
        wrench=wrench,
        time_since_reference=seconds_to_duration(segment_time_s),
    )
    wrench_trajectory = trajectory_pb2.WrenchTrajectory(points=[wrench_traj_point])

    # First, move from standoff to first pose with force control (approach the board)
    manager.log_info("Approaching board (standoff -> first pose with force control)...")
    approach_traj = trajectory_pb2.SE3Trajectory(
        points=[
            trajectory_pb2.SE3TrajectoryPoint(
                pose=standoff_pose.to_proto(),
                time_since_reference=seconds_to_duration(0.0),
            ),
            trajectory_pb2.SE3TrajectoryPoint(
                pose=first_pose.to_proto(),
                time_since_reference=seconds_to_duration(segment_time_s),
            ),
        ],
    )
    arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
        pose_trajectory_in_task=approach_traj,
        root_frame_name=BODY_FRAME_NAME,
        wrench_trajectory_in_task=wrench_trajectory,
        x_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_FORCE,
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
    command_id = manager.send_robot_command(robot_command)
    block_until_arm_arrives(manager.command_client, command_id, segment_time_s + 2.0)

    # Now execute the erase trajectory segments
    num_segments = len(hand_trajs)
    for i, hand_traj in enumerate(hand_trajs):
        manager.log_info(f"Erasing segment {i + 1}/{num_segments}...")

        arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
            pose_trajectory_in_task=hand_traj,
            root_frame_name=BODY_FRAME_NAME,
            wrench_trajectory_in_task=wrench_trajectory,
            x_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_FORCE,
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

        command_id = manager.send_robot_command(robot_command)
        block_until_arm_arrives(manager.command_client, command_id, (segment_time_s * 1.5) + 2.0)

    time.sleep(2)  # Chill after erasing for a bit

    # Stow Spot's arm to indicate that erasing has finished
    manager.stow_arm()


# @dataclass(frozen=True)
# class WhiteboardEstimate:
#     """Result of whiteboard plane estimation from a LiDAR scan."""

#     plane: Plane3D
#     """Estimated plane in the robot's body frame."""

#     depth_m: float
#     """Distance from body origin to plane centroid along x-axis."""

#     plane_estimate: PlaneEstimate
#     """Full PlaneEstimate with inlier information."""


# def estimate_whiteboard_depth(
#     lidar: SpotLiDAR,
#     half_width_m: float = 0.3,
#     min_height_m: float = 0.3,
#     max_height_m: float = 1.5,
#     min_x_m: float = 0.7,
#     inlier_threshold_m: float = 0.02,
#     ransac_iterations: int = 500,
# ) -> WhiteboardEstimate | None:
#     """Estimate the depth to a whiteboard using LiDAR point cloud and RANSAC plane fitting.

#     Filters the LiDAR point cloud to a vertical slice in front of the robot
#     (within +/- half_width_m in the body y-axis) and fits a plane using RANSAC.

#     :param lidar: SpotLiDAR instance for acquiring point cloud data
#     :param half_width_m: Half-width (meters) of the filtering region w.r.t. the robot body y-axis
#     :param min_height_m: Minimum height (meters) of points to include (z in GPE frame)
#     :param max_height_m: Maximum height (meters) of points to include (z in GPE frame)
#     :param min_x_m: Minimum x-coordinate w.r.t robot body frame to include points
#     :param inlier_threshold_m: RANSAC inlier distance threshold
#     :param ransac_iterations: Number of RANSAC iterations
#     :return: WhiteboardEstimate with plane and depth, or None if estimation fails
#     """
#     # Get height-filtered point cloud in BODY frame
#     # SpotLiDAR.get_stamped_pointcloud already does height filtering using GPE frame
#     stamped_cloud = lidar.get_stamped_pointcloud(
#         min_height_m=min_height_m,
#         max_height_m=max_height_m,
#         output_frame=BODY_FRAME_NAME,
#     )

#     if stamped_cloud is None or not len(stamped_cloud.cloud):
#         return None

#     points = stamped_cloud.cloud.points  # Shape (N, 3), columns are [x, y, z] in body frame

#     # Filter to vertical slice: keep points within +/- half_width_m in y
#     # Also filter to only points in front of robot (x > min_x_m)
#     y_mask = (points[:, 1] >= -half_width_m) & (points[:, 1] <= half_width_m)
#     x_mask = points[:, 0] > min_x_m
#     combined_mask = y_mask & x_mask

#     filtered_points = points[combined_mask]

#     if len(filtered_points) < 10:  # Need minimum points for RANSAC
#         return None

#     filtered_cloud = PointCloud(points=filtered_points)

#     # Fit plane using RANSAC
#     plane_estimate = PlaneEstimate.fit_plane_ransac(
#         pointcloud=filtered_cloud,
#         inlier_threshold_m=inlier_threshold_m,
#         iterations=ransac_iterations,
#     )

#     if plane_estimate is None:
#         return None

#     # Compute depth: x-coordinate of plane centroid (distance along body x-axis)
#     depth_m = float(plane_estimate.plane.point[0])

#     return WhiteboardEstimate(
#         plane=plane_estimate.plane,
#         depth_m=depth_m,
#         plane_estimate=plane_estimate,
#     )
