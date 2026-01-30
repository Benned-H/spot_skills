"""Define a class to interface with Spot's LiDAR point cloud service."""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

import numpy as np
from bosdyn.api.point_cloud_pb2 import PointCloud as PointCloudProto
from bosdyn.api.point_cloud_pb2 import PointCloudResponse
from bosdyn.client.frame_helpers import (
    BODY_FRAME_NAME,
    GROUND_PLANE_FRAME_NAME,
    VISION_FRAME_NAME,
    get_a_tform_b,
)
from bosdyn.client.point_cloud import build_pc_request
from bosdyn.util import timestamp_to_sec
from robotics_utils.perception import PointCloud

from spot_skills_py.spot.spot_conversion import pose_from_sdk

if TYPE_CHECKING:
    from bosdyn.api.geometry_pb2 import FrameTreeSnapshot
    from bosdyn.client.point_cloud import PointCloudClient
    from robotics_utils.spatial import Pose3D

    from spot_skills_py.spot.spot_manager import SpotManager


@dataclass(frozen=True)
class StampedPose3D:
    """A Pose3D and an associated timestamp (seconds)."""

    pose: Pose3D
    timestamp_s: float


@dataclass(frozen=True)
class StampedPointCloud:
    """A PointCloud with the sensor pose at acquisition time."""

    cloud: PointCloud
    cloud_frame: str
    """Reference frame of the XYZ data in the point cloud."""

    sensor_pose: Pose3D
    timestamp_s: float


class SpotLiDAR:
    """An interface for requesting and processing LiDAR data from Spot."""

    def __init__(self, manager: SpotManager, lidar_source: str = "velodyne-point-cloud"):
        """Initialize the SpotLiDAR interface.

        :param manager: Interface providing an authenticated Spot robot instance
        :param lidar_source: LiDAR point cloud source name (default: "velodyne-point-cloud")
        """
        self._manager = manager
        self._point_cloud_client: PointCloudClient = manager._robot.ensure_client(lidar_source)
        self.lidar_source = lidar_source

    def request_generic_pointcloud(self) -> PointCloudResponse | None:
        """Request a point cloud using the generic (i.e., non-LiDAR-specific) interface.

        This uses `build_pc_request` which does NOT set CLOUD_TYPE_LIDAR, so it
        returns a generic PointCloud without beam/scan structure or pose history.

        This is the same approach used in spot_ros/spot_wrapper's SpotEAP class.

        :return: PointCloudResponse containing generic point cloud data
        """
        request = build_pc_request(self.lidar_source)
        responses = self._point_cloud_client.get_point_cloud([request])
        if not responses:
            return None
        return responses[0]

    def _log_snapshot_frames(self, snapshot: FrameTreeSnapshot) -> None:
        """Log all frames available in a transforms_snapshot for debugging."""
        edge_map = snapshot.child_to_parent_edge_map
        frames_info = []
        for child_frame, edge in edge_map.items():
            frames_info.append(f"  {child_frame} -> {edge.parent_frame_name}")
        self._manager.log_info("Snapshot frames:\n" + "\n".join(frames_info))

    def get_stamped_pointcloud(
        self,
        min_height_m: float = 0.1,
        max_height_m: float = 2.0,
        output_frame: str = VISION_FRAME_NAME,
    ) -> StampedPointCloud | None:
        """Request a height-filtered point cloud with the sensor pose at acquisition time.

        Uses the embedded transforms_snapshot in the PointCloudResponse to extract the
        exact sensor pose when the data was captured. This allows correlating point cloud
        data with Spot's pose, enabling aggregation of multiple captures.

        :param min_height_m: Minimum height of included points (meters)
        :param max_height_m: Maximum height of included points (meters)
        :param output_frame: Reference frame used for the point cloud (default: "vision")
        :return: StampedPointCloud with points, sensor pose, and timestamp, or None if no data
        """
        response = self.request_generic_pointcloud()
        if response is None:
            return None

        # Get the robot state, which has the full transform tree available from Spot
        # Retrieve immediately after the point cloud to minimize motion drift
        robot_state = self._manager.get_robot_state()

        # PointCloudResponse Reference:
        # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html#pointcloudresponse
        cloud_proto = response.point_cloud
        source = cloud_proto.source
        sensor_frame = source.frame_name_sensor
        acquisition_time_s = timestamp_to_sec(source.acquisition_time)

        # Find the sensor pose in the robot's body frame
        snapshot = source.transforms_snapshot
        body_t_sensor = get_a_tform_b(snapshot, BODY_FRAME_NAME, sensor_frame)
        if body_t_sensor is None:
            self._manager.log_info(
                f"Could not find transform from '{sensor_frame}' to '{BODY_FRAME_NAME}'.",
            )
            self._log_snapshot_frames(snapshot)
            return None

        pose_b_s = pose_from_sdk(body_t_sensor, ref_frame=BODY_FRAME_NAME)

        # Find the body frame's pose in the output frame
        robot_snapshot = robot_state.kinematic_state.transforms_snapshot
        output_t_body = get_a_tform_b(robot_snapshot, output_frame, BODY_FRAME_NAME)
        if output_t_body is None:
            self._manager.log_info(
                f"Could not find transform from '{BODY_FRAME_NAME}' to '{output_frame}'.",
            )
            self._log_snapshot_frames(robot_snapshot)
            return None

        pose_o_b = pose_from_sdk(output_t_body, ref_frame=output_frame)
        pose_o_s = pose_o_b @ pose_b_s  # Sensor w.r.t. the output frame

        # Find the body frame's pose in the ground-plane estimate frame
        gpe_t_body = get_a_tform_b(robot_snapshot, GROUND_PLANE_FRAME_NAME, BODY_FRAME_NAME)
        if gpe_t_body is None:
            self._manager.log_info(
                f"Unable to transform from '{BODY_FRAME_NAME}' to '{GROUND_PLANE_FRAME_NAME}'.",
            )
            self._log_snapshot_frames(robot_snapshot)
            return None

        pose_gpe_b = pose_from_sdk(gpe_t_body, ref_frame=GROUND_PLANE_FRAME_NAME)
        pose_gpe_s = pose_gpe_b @ pose_b_s  # Sensor w.r.t. GPE frame

        # Parse point cloud data into a NumPy array
        if cloud_proto.encoding != PointCloudProto.ENCODING_XYZ_32F:
            raise RuntimeError(f"Unexpected point cloud encoding: {cloud_proto.encoding}")

        point_data = np.frombuffer(cloud_proto.data, dtype=np.float32)
        points = point_data.reshape((cloud_proto.num_points, 3))

        # Filter out invalid points indicated by (0, 0, 0)
        valid_mask = np.any(points != 0, axis=1)
        valid_points = points[valid_mask]
        valid_point_cloud = PointCloud(points=valid_points)

        # Filter out points based on their height in the ground-plane estimate frame
        point_cloud_gpe = valid_point_cloud.transform(pose_gpe_s)
        z_coords_gpe = point_cloud_gpe.points[:, 2]
        height_mask = (z_coords_gpe >= min_height_m) & (z_coords_gpe <= max_height_m)
        filtered_points = valid_points[height_mask]  # Shape (N, 3)

        # Transform the remaining points into the requested output frame
        point_cloud_wrt_sensor = PointCloud(points=filtered_points)
        point_cloud_wrt_output = point_cloud_wrt_sensor.transform(pose_o_s)

        return StampedPointCloud(
            cloud=point_cloud_wrt_output,
            cloud_frame=output_frame,
            sensor_pose=pose_o_s,
            timestamp_s=acquisition_time_s,
        )
