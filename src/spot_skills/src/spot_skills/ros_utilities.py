"""Define utility functions for convenience when working with ROS."""

from __future__ import annotations

import rospy


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
