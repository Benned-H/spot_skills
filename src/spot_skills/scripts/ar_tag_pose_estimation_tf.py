from pathlib import Path

import rospy
from robotics_utils.perception.pose_estimation import FiducialSystem
from robotics_utils.ros.fiducial_tracker import FiducialTracker
from robotics_utils.ros.transform_manager import TransformManager

if __name__ == "__main__":
    TransformManager.init_node("alvar_forward")
    vfs = FiducialSystem.from_yaml(Path("src/spot_skills/config/apriltags.yaml"))
    ft = FiducialTracker(vfs, prefix="ar_pose_marker")
    rospy.spin()
