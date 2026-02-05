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
from bosdyn.client.frame_helpers import (
    BODY_FRAME_NAME,
    GRAV_ALIGNED_BODY_FRAME_NAME,
    ODOM_FRAME_NAME,
    get_a_tform_b,
)
from bosdyn.client.robot_command import RobotCommandBuilder, block_until_arm_arrives
from bosdyn.util import seconds_to_duration
from robotics_utils.perception import PlaneEstimate, PointCloud

from spot_skills_py.spot.spot_conversion import pose_to_sdk

if TYPE_CHECKING:
    from robotics_utils.geometry import Plane3D
    from robotics_utils.spatial import Pose3D

    from spot_skills_py.spot.spot_lidar import SpotLiDAR
    from spot_skills_py.spot.spot_manager import SpotManager


def erase_board(
    manager: SpotManager,
    erase_traj_poses: list[Pose3D],
    force_x_n: float = 10.0,
    segment_time_s: float = 5.0,
) -> None:
    """Use the given Spot manager to erase a whiteboard along the given trajectory.

    The trajectory poses must already be expressed in the odom frame (`ODOM_FRAME_NAME`).

    :param manager: SpotManager instance with an authenticated robot
    :param erase_traj_poses: List of Pose3D waypoints in ODOM frame
    :param force_x_n: Force to apply along the body x-axis (toward whiteboard)
    :param segment_time_s: Time (seconds) to move between consecutive waypoints
    """
    assert manager.has_arm(), "Robot requires an arm to erase a whiteboard!"
    assert len(erase_traj_poses) >= 2, "Need at least 2 poses for a trajectory."

    manager.log_info("Now starting erase_board()...")

    # Make Spot stand and enable Spot to adjust its body height to assist manipulation
    body_control = spot_command_pb2.BodyControlParams(
        body_assist_for_manipulation=spot_command_pb2.BodyControlParams.BodyAssistForManipulation(
            enable_hip_height_assist=True,
            enable_body_yaw_assist=True,
        ),
    )

    manager.stand_up(10, control_params=body_control)
    manager.deploy_arm()  # Unstow Spot's arm

    # Start in gravity-compensation mode (but zero force)
    f_x = 0  # Newtons
    f_y = 0
    f_z = 0

    # We won't have any rotational torques
    torque_x = 0
    torque_y = 0
    torque_z = 0

    # Duration in seconds.
    seconds = 1000

    # Use the helper function to build a single wrench
    command = RobotCommandBuilder.arm_wrench_command(
        f_x,
        f_y,
        f_z,
        torque_x,
        torque_y,
        torque_z,
        BODY_FRAME_NAME,
        seconds,
    )

    command_id = manager.send_robot_command(command)
    manager.log_info("Zero force commanded...")

    time.sleep(2.0)  # TODO: Should we instead wait for the command to finish?

    # --------------- #

    # Hybrid position-force mode and trajectories.

    # Convert Pose3D list to SDK SE3Pose objects (poses are already in odom frame)
    hand_poses = [pose_to_sdk(pose) for pose in erase_traj_poses]

    # Build trajectory points
    time_since_reference = seconds_to_duration(segment_time_s)
    traj_points = [
        trajectory_pb2.SE3TrajectoryPoint(
            pose=hand_pose.to_proto(),
            time_since_reference=time_since_reference,
        )
        for hand_pose in hand_poses
    ]

    # Build pairwise trajectories (move between consecutive waypoints)
    hand_trajs = [
        trajectory_pb2.SE3Trajectory(points=[traj_points[i], traj_points[i + 1]])
        for i in range(len(traj_points) - 1)
    ]

    # Get current robot state to compute wrench direction in odom frame
    robot_state = manager.get_robot_state()
    odom_t_flat_body = get_a_tform_b(
        robot_state.kinematic_state.transforms_snapshot,
        ODOM_FRAME_NAME,
        GRAV_ALIGNED_BODY_FRAME_NAME,
    )

    # Transform force from body frame to odom frame
    force_tuple = odom_t_flat_body.rotation.transform_point(x=force_x_n, y=f_y, z=f_z)
    force = geometry_pb2.Vec3(x=force_tuple[0], y=force_tuple[1], z=force_tuple[2])
    torque = geometry_pb2.Vec3(x=0, y=0, z=0)
    wrench = geometry_pb2.Wrench(force=force, torque=torque)

    traj_point = trajectory_pb2.WrenchTrajectoryPoint(
        wrench=wrench,
        time_since_reference=seconds_to_duration(segment_time_s),
    )
    trajectory = trajectory_pb2.WrenchTrajectory(points=[traj_point])
    for hand_traj in hand_trajs:
        arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
            pose_trajectory_in_task=hand_traj,
            root_frame_name=ODOM_FRAME_NAME,
            wrench_trajectory_in_task=trajectory,
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

        # Send the request
        command_id = manager.send_robot_command(robot_command)

        # manager.block_until_arm_arrives(command_id)
        block_until_arm_arrives(manager.command_client, command_id, 5.0)

    time.sleep(2)  # Chill after erasing for a bit

    # Stow Spot's arm to indicate that erasing has finished
    manager.stow_arm()


@dataclass(frozen=True)
class WhiteboardEstimate:
    """Result of whiteboard plane estimation from a LiDAR scan."""

    plane: Plane3D
    """Estimated plane in the robot's body frame."""

    depth_m: float
    """Distance from body origin to plane centroid along x-axis."""

    plane_estimate: PlaneEstimate
    """Full PlaneEstimate with inlier information."""


def estimate_whiteboard_depth(
    lidar: SpotLiDAR,
    half_width_m: float = 0.3,
    min_height_m: float = 0.3,
    max_height_m: float = 1.5,
    min_x_m: float = 0.7,
    inlier_threshold_m: float = 0.02,
    ransac_iterations: int = 500,
) -> WhiteboardEstimate | None:
    """Estimate the depth to a whiteboard using LiDAR point cloud and RANSAC plane fitting.

    Filters the LiDAR point cloud to a vertical slice in front of the robot
    (within +/- half_width_m in the body y-axis) and fits a plane using RANSAC.

    :param lidar: SpotLiDAR instance for acquiring point cloud data
    :param half_width_m: Half-width (meters) of the filtering region w.r.t. the robot body y-axis
    :param min_height_m: Minimum height (meters) of points to include (z in GPE frame)
    :param max_height_m: Maximum height (meters) of points to include (z in GPE frame)
    :param min_x_m: Minimum x-coordinate w.r.t robot body frame to include points
    :param inlier_threshold_m: RANSAC inlier distance threshold
    :param ransac_iterations: Number of RANSAC iterations
    :return: WhiteboardEstimate with plane and depth, or None if estimation fails
    """
    # Get height-filtered point cloud in BODY frame
    # SpotLiDAR.get_stamped_pointcloud already does height filtering using GPE frame
    stamped_cloud = lidar.get_stamped_pointcloud(
        min_height_m=min_height_m,
        max_height_m=max_height_m,
        output_frame=BODY_FRAME_NAME,
    )

    if stamped_cloud is None or not len(stamped_cloud.cloud):
        return None

    points = stamped_cloud.cloud.points  # Shape (N, 3), columns are [x, y, z] in body frame

    # Filter to vertical slice: keep points within +/- half_width_m in y
    # Also filter to only points in front of robot (x > min_x_m)
    y_mask = (points[:, 1] >= -half_width_m) & (points[:, 1] <= half_width_m)
    x_mask = points[:, 0] > min_x_m
    combined_mask = y_mask & x_mask

    filtered_points = points[combined_mask]

    if len(filtered_points) < 10:  # Need minimum points for RANSAC
        return None

    filtered_cloud = PointCloud(points=filtered_points)

    # Fit plane using RANSAC
    plane_estimate = PlaneEstimate.fit_plane_ransac(
        pointcloud=filtered_cloud,
        inlier_threshold_m=inlier_threshold_m,
        iterations=ransac_iterations,
    )

    if plane_estimate is None:
        return None

    # Compute depth: x-coordinate of plane centroid (distance along body x-axis)
    depth_m = float(plane_estimate.plane.point[0])

    return WhiteboardEstimate(
        plane=plane_estimate.plane,
        depth_m=depth_m,
        plane_estimate=plane_estimate,
    )
