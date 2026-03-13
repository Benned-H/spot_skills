"""Utilities for estimating distances from depth images via 3D reprojection."""

from __future__ import annotations

import numpy as np
from robotics_utils.spatial import Pose3D
from robotics_utils.vision import DepthImage
from robotics_utils.vision.cameras import CameraIntrinsics


def back_project_depth(
    depth: DepthImage,
    intrinsics: CameraIntrinsics,
) -> np.ndarray:
    """Back-project valid depth pixels into a (N, 3) point cloud in camera optical frame.

    Camera optical frame convention: +z forward, +x right, +y down.

    :param depth: Depth image with values in meters
    :param intrinsics: Pinhole camera intrinsics (fx, fy, x0, y0)
    :return: (N, 3) array of 3D points in the camera frame
    """
    data = depth.data
    rows, cols = data.shape
    u, v = np.meshgrid(np.arange(cols), np.arange(rows))

    valid = data > 0.0
    z = data[valid]
    x = (u[valid] - intrinsics.x0) / intrinsics.fx * z
    y = (v[valid] - intrinsics.y0) / intrinsics.fy * z

    return np.column_stack([x, y, z])


def estimate_panel_distance(
    depth: DepthImage,
    intrinsics: CameraIntrinsics,
    cam_pose_in_body: Pose3D,
    lateral_tol: float = 0.5,
    vertical_tol: float = 0.5,
    min_forward: float = 0.1,
) -> float | None:
    """Estimate the distance to a panel in front of the robot using 3D reprojection.

    Back-projects all valid depth pixels into the body frame and returns the
    median forward distance (body +x) of points that fall within the specified
    lateral and vertical tolerance window.

    :param depth: Depth image (meters)
    :param intrinsics: Camera intrinsics
    :param cam_pose_in_body: SE3 pose of the camera in the body frame
    :param lateral_tol: Half-width of the lateral filter (body Y), in meters
    :param vertical_tol: Half-width of the vertical filter (body Z), in meters
    :param min_forward: Minimum forward distance to consider, in meters
    :return: Median forward distance in meters, or None if no valid points found
    """
    pts_cam = back_project_depth(depth, intrinsics)
    if len(pts_cam) == 0:
        return None

    # Transform each camera-frame point into the body frame
    homogeneous = cam_pose_in_body.to_homogeneous_matrix()
    ones = np.ones((len(pts_cam), 1))
    pts_body = (homogeneous @ np.hstack([pts_cam, ones]).T).T[:, :3]

    bx = pts_body[:, 0]
    by = pts_body[:, 1]
    bz = pts_body[:, 2]

    mask = (np.abs(by) < lateral_tol) & (np.abs(bz) < vertical_tol) & (bx > min_forward)
    if not mask.any():
        return None

    return float(np.median(bx[mask]))
