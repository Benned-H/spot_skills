"""Define a ROS node providing a client for the EstimatePose service."""

from __future__ import annotations

import rospy
from spot_skills_py.ros_utilities import get_ros_param
from transform_utils.kinematics_ros import pose_from_msg
from transform_utils.transform_manager import TransformManager

from object_detection_msgs.srv import EstimatePose, EstimatePoseRequest, EstimatePoseResponse
from spot_skills.srv import GetRGBDPairs, GetRGBDPairsRequest, GetRGBDPairsResponse


class PoseEstimateClient:
    """A wrapper that manages calling the EstimatePose service."""

    def __init__(
        self,
        pose_service_name: str = "/detect_object_pose",
        image_service_name: str = "/spot/get_rgbd_pairs",
    ) -> None:
        """Initialize the service client with the relevant topic names.

        :param pose_service_name: Name of the pose estimation ROS service
        :param image_service_name: Name of the ROS service used to capture RGBD image pairs
        """
        rospy.wait_for_service(image_service_name, timeout=30.0)
        self.image_service_name = image_service_name
        self._image_service_caller = rospy.ServiceProxy(image_service_name, GetRGBDPairs)

        rospy.wait_for_service(pose_service_name, timeout=120.0)
        self.pose_service_name = pose_service_name
        self._pose_service_caller = rospy.ServiceProxy(self.pose_service_name, EstimatePose)

        # Configure the pose estimation service based on ROS params
        cameras_list_str = get_ros_param("/pose_estimation/default_cameras")
        self.camera_names: list[str] = [c.strip() for c in cameras_list_str.split(",")]

        self._next_obj_idx = 0

        self.global_frame = "vision"  # Relative frame used as the static "world" frame

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

    def get_rgbd_pairs(self) -> GetRGBDPairsResponse:
        """Capture paired RGB and depth images for the relevant cameras using a ROS service."""
        request = GetRGBDPairsRequest(camera_names=self.camera_names)

        try:
            response: GetRGBDPairsResponse = self._image_service_caller(request)
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
        rgbd_pairs_msg = self.get_rgbd_pairs()  # One pair of RGB-D images per camera of interest

        for rgbd_pair in rgbd_pairs_msg.rgbd_pairs:
            # Record the relative pose of the camera frame w.r.t. the world frame
            camera_frame = rgbd_pair.camera_info.header.frame_id  # Optical frame of the camera
            capture_time = rgbd_pair.camera_info.header.stamp  # Acquisition time of the images
            pose_w_c = TransformManager.lookup_transform(
                camera_frame,
                self.global_frame,
                capture_time,
            )

            request = EstimatePoseRequest()
            request.rgb = rgbd_pair.rgb
            request.depth = rgbd_pair.depth
            request.info = rgbd_pair.camera_info
            request.query = object_name

            try:
                response: EstimatePoseResponse = self._pose_service_caller(request)
            except rospy.ServiceException as exc:
                rospy.logerr(f"[{self.pose_service_name}] Could not call service: {exc}")
                continue

            if response is None:
                rospy.logerr(f"[{self.pose_service_name}] Response message was None")
                continue
            if not response.object_found:
                continue

            rospy.loginfo(f"Received pose estimate for the object '{object_name}'")
            pose_c_o = pose_from_msg(response.pose)  # Pose of object (o) w.r.t. camera (c)
            pose_w_o = pose_w_c @ pose_c_o

            # Broadcast the estimated object pose w.r.t. to the camera (for debugging) and world
            TransformManager.broadcast_transform(f"{object_name}_wrt_camera", pose_c_o)
            TransformManager.broadcast_transform(object_name, pose_w_o)


def main() -> None:
    """Launch a client for the EstimatePose ROS service."""
    TransformManager.init_node("pose_estimation_client")

    client = PoseEstimateClient()
    client.main_loop(freq_hz=2.0)


if __name__ == "__main__":
    main()
