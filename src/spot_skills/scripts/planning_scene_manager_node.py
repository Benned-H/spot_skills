"""Update the MoveIt planning scene based on an environment loaded from YAML."""

from pathlib import Path

import rospy
from robotics_utils.kinematics.kinematic_tree import KinematicTree
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.planning_scene_manager import PlanningSceneManager
from robotics_utils.ros.transform_manager import TransformManager


def main() -> None:
    """Load an environment from YAML and update the MoveIt planning scene accordingly."""
    TransformManager.init_node("planning_scene_manager_node")
    yaml_path = get_ros_param("/environment_yaml", Path)
    tree = KinematicTree.from_yaml(yaml_path)
    _ = PlanningSceneManager(tree)

    rospy.loginfo(f"Updated the planning scene based on {yaml_path}, now exiting...")


if __name__ == "__main__":
    main()
