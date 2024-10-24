"""Define utility functions for convenience when working with ROS."""

from __future__ import annotations

import rospy
import std_msgs.msg


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


class BoolCallbackWrapper:
    """A wrapper that tracks when a std_msgs.Bool message has been recieved."""

    def __init__(self, topic_name: str) -> None:
        """Initialize a subscriber to the specified std_msgs.Bool topic.

        :param      topic_name      Name of a ROS topic for std_msgs.msg.Bool messages
        """
        self._sub = rospy.Subscriber(topic_name, std_msgs.msg.Bool, self.callback)

        self.received_true = False  # Has the subscriber received a 'True' message?

    def callback(self, msg: std_msgs.msg.Bool) -> None:
        """Record when a 'True' message has been recieved."""
        if msg.data:
            self.received_true = True
            rospy.loginfo("[BoolCallbackWrapper] Received true Bool message!")
