"""Define utility functions for convenience when working with ROS."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import rospy
from rospkg import RosPack
from std_srvs.srv import Trigger, TriggerResponse


def get_ros_param(param_name: str) -> Any:
    """Read and return the requested ROS parameter from the parameter server.

    :param param_name: Name of the ROS parameter

    :returns: Value of the parameter, else asserts if unfound
    """
    assert rospy.has_param(param_name), f"Cannot find '{param_name}' rosparam."
    return rospy.get_param(param_name)


def resolve_package_path(filepath: str) -> Path | None:
    """Resolve a filepath relative to a ROS package.

    Example:
        Input (relative): spot_skills/launch/demo.launch
        Output (absolute): /home/Documents/catkin_ws/src/spot_skills/launch/demo.launch

    :param filepath: Path to a file, relative to some ROS package

    :returns: Path object containing the full absolute path (returns None if path DNE)

    """
    package_name, relative_path = filepath.split("/", maxsplit=1)

    rospack = RosPack()
    package_path = rospack.get_path(package_name)

    full_path = Path(package_path, relative_path)

    if not full_path.exists():
        rospy.logerr(f"Could not resolve package-relative filepath: {filepath}.")
        return None

    return full_path
