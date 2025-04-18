"""Launch a ROS node to forward Alvar AR tag detections into /tf frames."""

from pathlib import Path

import rospy
from transform_utils.perception.april_tag import AprilTagSystem
from transform_utils.perception.tag_tracker import TagTracker
from transform_utils.transform_manager import TransformManager
from transform_utils.world_model.april_tag import AprilTagSystem
from transform_utils.world_model.tag_tracker import TagTracker
from transform_utils.world_model.object_pose_recorder import ObjectPoseRecorder

def main() -> None:
    """Create a node to forward AR tag detections into the /tf topic."""
    TransformManager.init_node("marker_listener")

    yaml_path = Path(rospy.get_param("~apriltags_yaml_path"))
    objects_yml = Path(rospy.get_param("~object_map_yaml", "/tmp/object_map.yaml"))
    tag_system = AprilTagSystem.from_yaml(yaml_path)

    _ = TagTracker(tag_system)
    _ = ObjectPoseRecorder(tag_system, objects_yml) 
    rospy.spin()


if __name__ == "__main__":
    main()
