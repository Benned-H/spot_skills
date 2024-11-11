"""Demonstrate loading of meshes from file into MoveIt's planning scene."""

import sys
from pathlib import Path

import moveit_commander
import rospy

from spot_skills.scene_handler import SceneHandler


def main() -> None:
    """Load meshes from file and display within MoveIt's planning scene."""
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("planning_scene_loader")

    yaml_rosparam = "meshes_yaml"

    if not rospy.has_param(yaml_rosparam):
        rospy.logfatal(f"Cannot find '{yaml_rosparam}' rosparam.")
        sys.exit(1)

    yaml_filepath = rospy.get_param(yaml_rosparam)
    rospy.loginfo(f"Found rosparam '{yaml_rosparam}': {yaml_filepath}")

    # Create the scene handler and use it to load meshes from file
    scene_handler = SceneHandler()

    yaml_path_obj = Path(yaml_filepath)
    scene_handler.load_scene_from_yaml(yaml_path_obj)

    rospy.spin()


if __name__ == "__main__":
    main()
