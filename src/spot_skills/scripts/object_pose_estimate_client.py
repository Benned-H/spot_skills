"""Define a ROS node providing a client for the DetectObjectPose service."""

from __future__ import annotations

import rospy

from object_detection_msgs.srv import DetectObjectPose, DetectObjectRequest, DetectObjectResponse
from spot_skills.kinematics.kinematics import DEFAULT_FRAME
from spot_skills.kinematics.kinematics_ros import pose_from_msg
from spot_skills.kinematics.transform_manager import TransformManager
from spot_skills.ros_utilities import get_ros_param
from spot_skills.srv import GetPairedRGBD, GetPairedRGBDRequest, GetPairedRGBDResponse


class PoseEstimateClient:
    """A wrapper that manages calling the DetectObjectPose service."""

    def __init__(
        self,
        pose_service_name: str = "/detect_object_pose",
        image_service_name: str = "/spot/get_paired_rgbd",
    ) -> None:
        """Initialize the service client with the relevant topic names.

        :param pose_service_name: Name of the pose estimation ROS service
        :param image_service_name: Name of the ROS service used to capture RGBD image pairs
        """
        rospy.wait_for_service(pose_service_name, timeout=rospy.Time.from_sec(30.0))
        self.pose_service_name = pose_service_name
        self._pose_service_caller = rospy.ServiceProxy(self.pose_service_name, DetectObjectPose)

        rospy.wait_for_service(image_service_name, timeout=rospy.Time.from_sec(30.0))
        self.image_service_name = image_service_name
        self._image_service_caller = rospy.ServiceProxy(image_service_name, GetPairedRGBD)

        # Find configuration for the pose estimation service from ROS params        
        self.camera_name: str = get_ros_param("/spot/pose_estimation_camera")
        self._objects: list[str] = get_ros_param("known_objects")

        self._next_obj_idx = 0

    def next_object(self) -> str:
        """Find the next object of interest for pose estimation.

        :return: Name of the next object to be pose-estimated
        """
        object_name = self._objects[self._next_obj_idx]
        self._next_obj_idx = (self._next_obj_idx + 1) % len(self._objects)
        return object_name

    def main_loop(self, freq_hz: float) -> None:
        """Loop at the given frequency (Hz) while calling the pose estimation service.

        :param freq_hz: Nominal frequency (Hz) at which the client calls the service
        """
        rate_hz = rospy.Rate(freq_hz)
        while not rospy.is_shutdown():
            rgbd_pair = self.call_paired_rgbd()
            self.call_pose_estimation(rgbd_pair)
            rate_hz.sleep()

    def call_paired_rgbd(self) -> GetPairedRGBDResponse:
        """Capture a paired RGB and depth image using the relevant ROS service."""
        request = GetPairedRGBDRequest(self.camera_name)

        try:
            response: GetPairedRGBDResponse = self._image_service_caller(request)
        except rospy.ServiceException as exc:
            rospy.logerr(f"[{self.image_service_name}] Could not call service: {exc}")
        else:
            rospy.loginfo(f"[{self.image_service_name}] Successful response: {response}")
            return response

    def call_pose_estimation(self, rgbd_pair: GetPairedRGBDResponse) -> None:
        """Call the pose estimation service using the given RGB and depth image pair.

        :param rgbd_pair: Paired RGB and depth images with corresponding camera info
        """
        request = DetectObjectRequest()
        request.image = rgbd_pair.image
        request.depth = rgbd_pair.depth
        request.info = rgbd_pair.info

        object_to_find = self.next_object()
        request.query = object_to_find

        try:
            response: DetectObjectResponse = self._pose_service_caller(request)
        except rospy.ServiceException as exc:
            rospy.logerr(f"[{self.pose_service_name}] Could not call service: {exc}")
        else:
            rospy.loginfo(f"[{self.pose_service_name}] Successful response: {response}")

            if not response.object_found:
                return

            camera_frame = rgbd_pair.info.header.frame_id  # Optical frame of the camera
            capture_time = rgbd_pair.info.header.stamp  # Acquisition time of the images

            # Find the camera pose w.r.t. the world frame at the time of the image capture
            pose_w_c = TransformManager.lookup_transform(camera_frame, DEFAULT_FRAME, capture_time)

            pose_c_o = pose_from_msg(response.pose)  # Pose of object (o) w.r.t. camera (c)
            pose_w_o = pose_w_c @ pose_c_o

            # Broadcast the estimated pose in the world frame using tf2
            TransformManager.broadcast_transform(object_to_find, pose_w_o)


def main() -> None:
    """Launch a client for the DetectObjectPose ROS service."""
    rospy.init_node("pose_estimation_client")
    client = PoseEstimateClient()
    client.main_loop(freq_hz=2.0)


if __name__ == "__main__":
    main()
