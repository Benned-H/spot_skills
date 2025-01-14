"""Define a ROS node providing a client for the DetectObjectPose service."""

import rospy

from object_detection_msgs.srv import DetectObjectPose, DetectObjectRequest, DetectObjectResponse


class PoseEstimateClient:
    """A wrapper that manages calling the DetectObjectPose service."""

    def __init__(self, service_name: str = "/detect_object_pose", wait_s: float = 20.0) -> None:
        """Initialize the service client with the relevant topic name.

        :param service_name: Name of the service's ROS topic
        :param wait_s: Duration (seconds) to wait for the service before giving up
        """
        rospy.wait_for_service(service_name, timeout=rospy.Time.from_sec(wait_s))
        self.service_name = service_name
        self._service_caller = rospy.ServiceProxy(service_name, DetectObjectPose)

    def call_service(self) -> None:
        """Call the pose estimation service."""
        request = DetectObjectRequest()
        # TODO: Populate the service request using up-to-date images

        try:
            response: DetectObjectResponse = self._service_caller(request)
            rospy.loginfo(f"[{self.service_name}] Service response: {response}")
            # TODO: Process/publish result!
        except rospy.ServiceException as exc:
            rospy.logerr(f"[{self.service_name}] Could not call service: {exc}")

        # TODO: What to return or publish?


def main() -> None:
    """Launch a client for the DetectObjectPose ROS service."""
    rospy.init_node("pose_estimation_client")


if __name__ == "__main__":
    main()
