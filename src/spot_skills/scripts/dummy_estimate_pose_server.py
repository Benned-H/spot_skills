"""Define a ROS node providing a dummy version of the EstimatePose service."""

import rospy

from object_detection_msgs.srv import EstimatePose, EstimatePoseRequest, EstimatePoseResponse
from spot_skills.kinematics.kinematics import Pose3D
from spot_skills.kinematics.kinematics_ros import pose_to_stamped_msg


class DummyPoseEstimateServer:
    """A dummy server for the EstimatePose service."""

    def __init__(self, service_name: str = "/detect_object_pose") -> None:
        """Initialize the server with the service topic name.

        :param service_name: Name of the pose estimation ROS service
        """
        self.service_name = service_name
        self.service = rospy.Service(self.service_name, EstimatePose, self.handle_pose_estimation)

    def handle_pose_estimation(self, request_msg: EstimatePoseRequest) -> EstimatePoseResponse:
        """Handle a service request to estimate an object's pose.

        :param request_msg: Message containing an RGB-D image pair and the name of an object
        :return: Message containing the estimated pose, if the object was detected
        """
        del request_msg

        response_msg = EstimatePoseResponse()
        response_msg.object_found = True
        response_msg.pose = pose_to_stamped_msg(Pose3D.identity())

        return response_msg


def main() -> None:
    """Initialize a ROS node, set up the pose estimation server, and spin."""
    rospy.init_node("estimate_pose_server")
    server = DummyPoseEstimateServer()
    rospy.spin()


if __name__ == "__main__":
    main()
