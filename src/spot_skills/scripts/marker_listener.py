#!/usr/bin/env python

"""Launch a ROS node to forward visual fiducial detections into /tf frames."""

from pathlib import Path

import rospy
from robotics_utils.perception.sensors.visual_fiducials import VisualFiducialSystem
from robotics_utils.ros.fiducial_tracker import FiducialTracker
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.transform_manager import TransformManager


def main() -> None:
    """Create a node to forward AR tag detections into the /tf topic."""
    TransformManager.init_node("marker_listener")

    yaml_path = get_ros_param("~apriltags_yaml_path", Path)
    fiducial_system = VisualFiducialSystem.from_yaml(yaml_path)

    _ = FiducialTracker(fiducial_system, prefix="/ar_pose_marker")

    rospy.loginfo("Successfully initialized FiducialTracker, now spinning...")
    rospy.spin()


if __name__ == "__main__":
    main()
