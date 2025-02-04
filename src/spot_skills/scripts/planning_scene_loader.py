"""Demonstrate loading of meshes from file into MoveIt's planning scene."""

import sys

import moveit_commander
import rospy
from spot_skills_py.planning_scene.scene_handler import SceneHandler


def main() -> None:
    """Load meshes from file and display within MoveIt's planning scene."""
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("planning_scene_loader")

    scene_handler = SceneHandler.initialize_from_rosparam("meshes_yaml")
    scene_handler.broadcast_tf_loop(10)  # Re-broadcast loop at 10 Hz


if __name__ == "__main__":
    main()
