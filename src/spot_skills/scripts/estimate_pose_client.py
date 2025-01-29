"""Define a ROS node providing a client for the EstimatePose service."""

from __future__ import annotations

import rospy
from sensor_msgs.msg import Image
from transform_utils.kinematics import DEFAULT_FRAME
from transform_utils.kinematics_ros import pose_from_msg
from transform_utils.transform_manager import TransformManager

from object_detection_msgs.srv import EstimatePose, EstimatePoseRequest, EstimatePoseResponse
from spot_skills.ros_utilities import get_ros_param
from spot_skills.srv import GetPairedRGBD, GetPairedRGBDRequest, GetPairedRGBDResponse


class PoseEstimateClient:
    """A wrapper that manages calling the EstimatePose service."""

    def __init__(
        self,
        pose_service_name: str = "/detect_object_pose",
        image_service_name: str = "/spot/get_paired_rgbd",
    ) -> None:
        """Initialize the service client with the relevant topic names.

        :param pose_service_name: Name of the pose estimation ROS service
        :param image_service_name: Name of the ROS service used to capture RGBD image pairs
        """
        rospy.wait_for_service(pose_service_name, timeout=30.0)
        self.pose_service_name = pose_service_name
        self._pose_service_caller = rospy.ServiceProxy(self.pose_service_name, EstimatePose)

        rospy.wait_for_service(image_service_name, timeout=30.0)
        self.image_service_name = image_service_name
        self._image_service_caller = rospy.ServiceProxy(image_service_name, GetPairedRGBD)

        # Configure the pose estimation service based on ROS params
        self.camera_name: str = get_ros_param("~default_camera")
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
            object_to_find = self.next_object()
            self.call_pose_estimation(object_to_find)
            rate_hz.sleep()

    def get_paired_rgbd(self) -> GetPairedRGBDResponse:
        """Capture a paired RGB and depth image using the relevant ROS service."""
        request = GetPairedRGBDRequest(self.camera_name)

        try:
            response: GetPairedRGBDResponse = self._image_service_caller(request)
        except rospy.ServiceException as exc:
            rospy.logerr(f"[{self.image_service_name}] Could not call service: {exc}")
            return None

        if response is None:
            rospy.logerr(f"[{self.image_service_name}] Response message was None")

        return response

    def call_pose_estimation(self, object_name: str) -> None:
        """Call the pose estimation service for the named object.

        :param object_name: Name of the object whose pose is estimated
        """
        rgbd_pair = self.get_paired_rgbd()

        # Record the relative pose of the camera frame w.r.t. the world frame
        camera_frame = rgbd_pair.info.header.frame_id  # Optical frame of the camera
        capture_time = rgbd_pair.info.header.stamp  # Acquisition time of the images
        pose_w_c = TransformManager.lookup_transform(camera_frame, DEFAULT_FRAME, capture_time)

        request = EstimatePoseRequest()
        request.rgb = rgbd_pair.rgb
        request.depth = rgbd_pair.depth
        request.info = rgbd_pair.info
        request.query = object_name

        try:
            response: EstimatePoseResponse = self._pose_service_caller(request)
        except rospy.ServiceException as exc:
            rospy.logerr(f"[{self.pose_service_name}] Could not call service: {exc}")
            return

        if response is None:
            rospy.logerr(f"[{self.pose_service_name}] Response message was None")
            return
        if not response.object_found:
            return

        pose_c_o = pose_from_msg(response.pose)  # Pose of object (o) w.r.t. camera (c)
        pose_w_o = pose_w_c @ pose_c_o

        # Broadcast the estimated object pose w.r.t. to the camera (for debugging) and world
        TransformManager.broadcast_transform(f"{object_name}_wrt_camera", pose_c_o)
        TransformManager.broadcast_transform(object_name, pose_w_o)


def main() -> None:
    """Launch a client for the EstimatePose ROS service."""
    TransformManager.init_node("estimate_pose_client")

    client = PoseEstimateClient()
    client.main_loop(freq_hz=2.0)


if __name__ == "__main__":
    main()
