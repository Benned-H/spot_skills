"""Define a class to forward Alvar AR tag detections into /tf."""

import rospy
from ar_track_alvar_msgs.msg import AlvarMarkers
from transform_utils.kinematics import Pose3D
from transform_utils.kinematics_ros import pose_from_msg
from transform_utils.transform_manager import TransformManager


class TagTracker:
    """Stores and re-publishes the poses of detected AR tags."""

    def __init__(self) -> None:
        """Initialize the TagTracker by retrieving expected tag sizes from ROS parameters."""
        self.tag_poses: dict[int, Pose3D] = {}

        self._body_cam_marker_size_cm = rospy.get_param("/spot/ar/body_cam_marker_size_cm")
        self._hand_cam_marker_size_cm = rospy.get_param("/spot/ar/hand_cam_marker_size_cm")

    def marker_callback(self, markers_msg: AlvarMarkers) -> None:
        """Store updated tag poses from detected AR markers.

        :param markers_msg: Message containing a list of tag detections
        """
        for marker in markers_msg.markers:
            rospy.loginfo(f"Detected Marker ID: {marker.id} with confidence {marker.confidence}.")
            self.tag_poses[marker.id] = pose_from_msg(marker.pose)

        # TODO: Filter which poses are trusted based on the actual tag size and camera name


def main() -> None:
    """Create a node to forward AR tag detections into the /tf topic."""
    TransformManager.init_node("marker_listener")

    _ = TagTracker()
    rospy.spin()


if __name__ == "__main__":
    main()
