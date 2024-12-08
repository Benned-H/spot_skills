"""Define utility functions for convenience when working with ROS."""

from __future__ import annotations

from pathlib import Path

import rospy
from rospkg import RosPack
from std_srvs.srv import Trigger, TriggerResponse


def get_ros_params(ros_param_names: list[str]) -> list:
    """Read and return the given ROS parameters from the parameter server.

    :param      ros_param_names     Names of the desired ROS parameters

    :returns    List of the resulting values, else asserts on unfound parameter
    """
    param_values = []

    for param_name in ros_param_names:
        assert rospy.has_param(param_name), f"Cannot find '{param_name}' rosparam."

        param_values.append(rospy.get_param(param_name))

    return param_values


def trigger_service(service_name: str) -> bool:
    """Call the named ROS service of the std_srvs/Trigger type.

    :param service_name: Name of the std_srvs/Trigger service to be called
    :returns: Boolean success returned by the service (True or False)
    """
    rospy.wait_for_service(service_name)
    service_caller = rospy.ServiceProxy(service_name, Trigger)

    success = False
    try:
        response: TriggerResponse = service_caller()
        rospy.loginfo(f"[{service_name}] Service response message: {response.message}")
        success = response.success
    except rospy.ServiceException as exc:
        rospy.logerr(f"[{service_name}] Could not communicate with service: {exc}")

    return success


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
