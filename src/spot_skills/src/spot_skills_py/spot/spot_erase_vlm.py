"""Improved whiteboard erasing using depth-based plane estimation and VLM detection.

This module provides perception-driven erasing that:
    1. Estimates the wall plane using depth cameras and RANSAC
    2. Detects areas to erase using Gemini Robotics bounding boxes
    3. Projects detected regions onto the estimated plane
    4. Generates force-controlled erasing trajectories aligned to the plane normal
"""

from robotics_utils.kinematics import Plane3D, Rectangle3D

from spot_skills_py.spot import SpotImageClient, SpotManager


class SpotEraser:
    """A class to enable Spot to erase whiteboards."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the erasing class with interfaces for Spot."""
        self.manager = manager
