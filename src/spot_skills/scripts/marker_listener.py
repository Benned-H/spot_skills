#!/usr/bin/env python

"""Launch a ROS node to forward Alvar AR tag detections into /tf frames."""

from pathlib import Path

import rospy
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.transform_manager import TransformManager

# TODO: from transform_utils.perception.april_tag import AprilTagSystem
# TODO: from transform_utils.perception.tag_tracker import TagTracker


def main() -> None:
    """Create a node to forward AR tag detections into the /tf topic."""
    TransformManager.init_node("marker_listener")

    yaml_path = get_ros_param("~apriltags_yaml_path", Path)
    tag_system = AprilTagSystem.from_yaml(yaml_path)

    _ = TagTracker(tag_system)

    rospy.loginfo("Successfully initialized TagTracker, now spinning...")
    rospy.spin()


if __name__ == "__main__":
    main()
