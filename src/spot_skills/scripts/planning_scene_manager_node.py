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
    yaml_path = get_ros_param("~environment_yaml", Path)
    tree = KinematicTree.from_yaml(yaml_path)
    manager = PlanningSceneManager()
    manager.synchronize_state(tree)

    rospy.loginfo(f"Updated the planning scene per {yaml_path}, now broadcasting transforms...")

    try:
        rate_hz = rospy.Rate(TransformManager.LOOP_HZ)
        while not rospy.is_shutdown():
            # Broadcast all robot base poses with frame names: f"{robot_name}_base_pose"
            for robot_name, base_pose in tree.robot_base_poses.items():
                TransformManager.broadcast_transform(f"{robot_name}_base_pose", base_pose)

            # Broadcast all object poses
            for object_name, object_pose in tree.object_poses.items():
                TransformManager.broadcast_transform(object_name, object_pose)

            rate_hz.sleep()

    except rospy.ROSInterruptException as ros_exc:
        rospy.logwarn(f"[planning_scene_manager_node] {ros_exc}")


if __name__ == "__main__":
    main()
