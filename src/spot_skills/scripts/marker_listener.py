"""Define a class to forward Alvar AR tag detections into /tf."""

from pathlib import Path

import rospy
from transform_utils.transform_manager import TransformManager
from transform_utils.world_model.april_tag import AprilTagSystem
from transform_utils.world_model.tag_tracker import TagTracker


def main() -> None:
    """Create a node to forward AR tag detections into the /tf topic."""
    TransformManager.init_node("marker_listener")

    yaml_path = Path(rospy.get_param("~apriltags_yaml_path"))
    tag_system = AprilTagSystem.from_yaml(yaml_path)

    _ = TagTracker(tag_system)
    rospy.spin()


if __name__ == "__main__":
    main()
