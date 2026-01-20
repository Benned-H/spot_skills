"""Define a class to interface with Spot's LiDAR point cloud service.

Reference: https://github.com/boston-dynamics/spot-sdk/blob/master/python/examples/velodyne_client/client.py
"""

from __future__ import annotations

from typing import TYPE_CHECKING

import numpy as np
from bosdyn.api import point_cloud_pb2
from robotics_utils.geometry import Point3D
from robotics_utils.perception import LaserScan2D
from robotics_utils.spatial import Pose2D, Pose3D, Quaternion

if TYPE_CHECKING:
    from bosdyn.api.point_cloud_pb2 import PointCloudRequest
    from bosdyn.client.point_cloud import PointCloudClient
    from bosdyn.client.robot import Robot

VISION_FRAME = "vision"
"""Reference frame for LiDAR pose history (Spot's vision world frame)."""


class SpotLiDAR:
    """An interface for requesting and processing LiDAR data from Spot."""

    def __init__(self, robot: Robot, lidar_source: str = "velodyne-point-cloud"):
        """Initialize the SpotLiDAR interface.

        :param robot: Authenticated Spot robot instance
        :param lidar_source: LiDAR point cloud source name (default: "velodyne-point-cloud")
        """
        self._robot = robot
        self._point_cloud_client: PointCloudClient = robot.ensure_client(lidar_source)
        self.lidar_source = lidar_source

    def _build_lidar_request(self) -> PointCloudRequest:
        """Build a PointCloudRequest configured for LiDAR data.

        :return: PointCloudRequest with CLOUD_TYPE_LIDAR set
        """
        request = point_cloud_pb2.PointCloudRequest()
        request.point_cloud_source_name = self.lidar_source
        request.cloud_type = point_cloud_pb2.PointCloudRequest.CLOUD_TYPE_LIDAR
        return request

    def _parse_pose_sample(self, pose_sample: LidarPoseSample) -> tuple[float, Pose3D]:
        """Parse a LidarPoseSample into a timestamp and Pose3D.

        :param pose_sample: LidarPoseSample from lidar_pose_history
        :return: Tuple of (timestamp_sec, Pose3D)
        """
        timestamp_sec = pose_sample.timestamp.seconds + pose_sample.timestamp.nanos * 1e-9
        pos = pose_sample.position
        rot = pose_sample.rotation
        pose = Pose3D(
            position=Point3D(pos.x, pos.y, pos.z),
            orientation=Quaternion(x=rot.x, y=rot.y, z=rot.z, w=rot.w),
            ref_frame=VISION_FRAME,
        )
        return timestamp_sec, pose

    def _interpolate_pose(
        self,
        t: float,
        t0: float,
        pose0: Pose3D,
        t1: float,
        pose1: Pose3D,
    ) -> Pose2D:
        """Linearly interpolate between two poses and project to 2D.

        :param t: Target timestamp
        :param t0: Timestamp of first pose
        :param pose0: First pose
        :param t1: Timestamp of second pose
        :param pose1: Second pose
        :return: Interpolated Pose2D at timestamp t
        """
        if t1 == t0:
            return pose0.to_2d()

        alpha = (t - t0) / (t1 - t0)
        alpha = np.clip(alpha, 0.0, 1.0)

        # Linear interpolation for position
        x = pose0.position.x + alpha * (pose1.position.x - pose0.position.x)
        y = pose0.position.y + alpha * (pose1.position.y - pose0.position.y)

        # Linear interpolation for yaw (handles wraparound)
        yaw0 = pose0.yaw_rad
        yaw1 = pose1.yaw_rad
        delta_yaw = np.arctan2(np.sin(yaw1 - yaw0), np.cos(yaw1 - yaw0))
        yaw = yaw0 + alpha * delta_yaw

        return Pose2D(x=x, y=y, yaw_rad=yaw, ref_frame=VISION_FRAME)

    def _get_pose_for_scan(
        self,
        scan_idx: int,
        num_scans: int,
        pose_samples: list[tuple[float, Pose3D]],
    ) -> Pose2D:
        """Get the interpolated pose for a specific scan index.

        :param scan_idx: Index of the scan (0 to num_scans-1)
        :param num_scans: Total number of scans
        :param pose_samples: List of (timestamp, pose) tuples from pose history
        :return: Interpolated Pose2D for the scan
        """
        if not pose_samples:
            return Pose2D(x=0.0, y=0.0, yaw_rad=0.0, ref_frame=VISION_FRAME)

        if len(pose_samples) == 1:
            return pose_samples[0][1].to_2d()

        # Compute the timestamp for this scan by interpolating between first and last
        t_start = pose_samples[0][0]
        t_end = pose_samples[-1][0]
        scan_t = t_start + (scan_idx / max(num_scans - 1, 1)) * (t_end - t_start)

        # Find bracketing pose samples for interpolation
        for i in range(len(pose_samples) - 1):
            t0, pose0 = pose_samples[i]
            t1, pose1 = pose_samples[i + 1]
            if t0 <= scan_t <= t1:
                return self._interpolate_pose(scan_t, t0, pose0, t1, pose1)

        # Extrapolate using the last two samples if scan_t is beyond the range
        t0, pose0 = pose_samples[-2]
        t1, pose1 = pose_samples[-1]
        return self._interpolate_pose(scan_t, t0, pose0, t1, pose1)

    def get_laser_scans(
        self,
        min_height_m: float = 0.1,
        max_height_m: float = 2.0,
        range_min_m: float = 0.5,
        range_max_m: float = 100.0,
    ) -> list[LaserScan2D]:
        """Request LiDAR data and return per-scan LaserScan2D objects with interpolated poses.

        Each scan corresponds to a single rotational position of the LiDAR, with all beams
        firing simultaneously. The sensor pose for each scan is interpolated from the
        lidar_pose_history provided by the SDK.

        :param min_height_m: Minimum height of included points (meters)
        :param max_height_m: Maximum height of included points (meters)
        :param range_min_m: Minimum valid range (meters)
        :param range_max_m: Maximum valid range (meters)
        :return: List of LaserScan2D objects, one per scan, with interpolated sensor poses
        """
        request = self._build_lidar_request()
        responses = self._point_cloud_client.get_point_cloud([request])

        if not responses:
            return []

        response = responses[0]
        lidar_cloud = response.lidar_cloud

        num_beams = lidar_cloud.num_beams
        num_scans = lidar_cloud.num_scans

        if num_beams == 0 or num_scans == 0:
            return []

        # Parse pose history for interpolation
        pose_samples = [
            self._parse_pose_sample(sample) for sample in lidar_cloud.lidar_pose_history
        ]

        # Parse point data - structured as num_beams x num_scans, row-major order
        # Reshape to (num_beams, num_scans, 3) for easy column (scan) access
        point_data = np.frombuffer(lidar_cloud.data, dtype=np.float32)
        points = point_data.reshape((num_beams, num_scans, 3))

        laser_scans = []

        for scan_idx in range(num_scans):
            # Extract points for this scan (all beams at this rotational position)
            scan_points = points[:, scan_idx, :]  # Shape: (num_beams, 3)

            # Filter out invalid points (0, 0, 0) indicating missing returns
            valid_mask = np.any(scan_points != 0, axis=1)
            valid_points = scan_points[valid_mask]

            if valid_points.shape[0] == 0:
                continue

            # Filter by height (z-coordinate relative to sensor)
            z_coords = valid_points[:, 2]
            height_mask = (z_coords >= min_height_m) & (z_coords <= max_height_m)
            filtered_points = valid_points[height_mask]

            if filtered_points.shape[0] == 0:
                continue

            # Convert to 2D polar coordinates (range, bearing) in sensor frame
            x_coords = filtered_points[:, 0]
            y_coords = filtered_points[:, 1]
            ranges_m = np.sqrt(x_coords**2 + y_coords**2)
            bearings_rad = np.arctan2(y_coords, x_coords)
            beam_data = np.stack([ranges_m, bearings_rad], axis=1).astype(np.float32)

            # Get interpolated sensor pose for this scan
            sensor_pose = self._get_pose_for_scan(scan_idx, num_scans, pose_samples)

            laser_scan = LaserScan2D(
                sensor_pose=sensor_pose,
                beam_data=beam_data,
                range_min_m=range_min_m,
                range_max_m=range_max_m,
            )

            if laser_scan.num_beams > 0:
                laser_scans.append(laser_scan)

        return laser_scans
