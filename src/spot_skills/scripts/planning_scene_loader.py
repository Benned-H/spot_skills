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

    yaml_path_str = rospy.get_param(yaml_rosparam)
    rospy.loginfo(f"Found rosparam '{yaml_rosparam}': {yaml_path_str}")
    yaml_path = Path(yaml_path_str)

    # Create the scene handler and load meshes from file (loops)
    _ = SceneHandler(yaml_path)


if __name__ == "__main__":
    main()
