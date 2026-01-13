"""Define a class to interface with Spot's LiDAR point cloud service."""

from __future__ import annotations

import numpy as np
from bosdyn.client.point_cloud import PointCloudClient, build_pc_request
from bosdyn.client.robot import Robot
from robotics_utils.perception import LaserScan2D
from robotics_utils.spatial import Pose2D

VELODYNE_SERVICE_NAME = "velodyne-point-cloud"


class SpotLiDAR:
    """Interface for requesting and processing LiDAR data from Spot.

    This class provides a simple interface to retrieve point cloud data from Spot's
    Velodyne LiDAR sensor and convert it to 2D laser scans for navigation.
    """

    def __init__(self, robot: Robot):
        """Initialize the SpotLiDAR interface.

        :param robot: Authenticated Spot robot instance
        """
        self._robot = robot
        self._point_cloud_client: PointCloudClient = robot.ensure_client(
            VELODYNE_SERVICE_NAME
        )

    def get_point_cloud(self, source: str = "velodyne-point-cloud") -> np.ndarray:
        """Request point cloud from Spot SDK.

        :param source: Point cloud source name (default: "velodyne-point-cloud")
        :return: (N, 3) NumPy array of (x, y, z) points in world frame
        :raises: bosdyn.client.exceptions.ResponseError if request fails
        """
        # Build point cloud request
        request = build_pc_request(source)

        # Get point cloud response (synchronous)
        responses = self._point_cloud_client.get_point_cloud([request])

        if len(responses) == 0:
            # No response received
            return np.empty((0, 3), dtype=np.float32)

        response = responses[0]

        # Extract point cloud data from response
        # The response contains a PointCloudResponse protobuf message
        # with a point_cloud field containing the actual data

        if not hasattr(response, "point_cloud") or response.point_cloud is None:
            # No point cloud data in response
            return np.empty((0, 3), dtype=np.float32)

        point_cloud = response.point_cloud

        # Convert point cloud encoding to NumPy array
        # The encoding format depends on the point cloud source
        # For Velodyne, it's typically XYZ_F32 (3 float32 values per point)

        if point_cloud.encoding == point_cloud.ENCODING_XYZ_32F:
            # Parse as 3xN array of float32 values
            num_points = point_cloud.num_points
            point_data = np.frombuffer(point_cloud.data, dtype=np.float32)
            points = point_data.reshape((num_points, 3))
        else:
            # Unsupported encoding
            raise ValueError(f"Unsupported point cloud encoding: {point_cloud.encoding}")

        # Filter out invalid points (0, 0, 0) which indicate missing data
        valid_mask = np.any(points != 0, axis=1)
        valid_points = points[valid_mask]

        return valid_points

    def get_laser_scan_2d(
        self,
        min_height_m: float = 0.1,
        max_height_m: float = 2.0,
        range_min_m: float = 0.5,
        range_max_m: float = 100.0,
        source: str = "velodyne-point-cloud",
    ) -> LaserScan2D:
        """Get 2D laser scan from LiDAR.

        :param min_height_m: Minimum height to include (meters)
        :param max_height_m: Maximum height to include (meters)
        :param range_min_m: Minimum valid range (meters)
        :param range_max_m: Maximum valid range (meters)
        :param source: Point cloud source name
        :return: LaserScan2D with filtered and converted points
        """
        # Get 3D point cloud
        points_3d = self.get_point_cloud(source=source)

        # Get robot's current pose for the sensor pose
        # For simplicity, use identity pose at origin
        # In a real application, you would get the actual robot pose from robot state
        # or from the point cloud response's transform tree
        sensor_pose = Pose2D(x=0.0, y=0.0, yaw_rad=0.0, ref_frame="odom")

        # Convert to 2D laser scan
        laser_scan = LaserScan2D.from_point_cloud_3d(
            points_3d=points_3d,
            sensor_pose=sensor_pose,
            min_height_m=min_height_m,
            max_height_m=max_height_m,
            range_min_m=range_min_m,
            range_max_m=range_max_m,
        )

        return laser_scan
