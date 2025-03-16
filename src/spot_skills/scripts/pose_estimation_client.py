"""Define a ROS node providing a client for the EstimatePose service."""

from __future__ import annotations

from pathlib import Path
from typing import TYPE_CHECKING

import rospy
from std_srvs.srv import SetBool, SetBoolRequest, SetBoolResponse
from transform_utils.kinematics import DEFAULT_FRAME, Pose3D
from transform_utils.kinematics_ros import pose_from_msg, pose_to_stamped_msg
from transform_utils.ros.services import ServiceCaller
from transform_utils.transform_manager import TransformManager
from transform_utils.world_model.load_from_yaml import load_known_object_names_from_yaml

from pose_estimation_msgs.msg import PoseEstimate
from pose_estimation_msgs.srv import EstimatePose, EstimatePoseRequest, EstimatePoseResponse
from spot_skills.srv import GetRGBDPairs, GetRGBDPairsRequest, GetRGBDPairsResponse

if TYPE_CHECKING:
    from geometry_msgs.msg import PoseStamped


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
        self._rgbd_pair_service = ServiceCaller[GetRGBDPairsRequest, GetRGBDPairsResponse](
            image_service_name,
            GetRGBDPairs,
            timeout_s=30.0,
        )

        self._pose_service = ServiceCaller[EstimatePoseRequest, EstimatePoseResponse](
            pose_service_name,
            EstimatePose,
            timeout_s=120.0,
        )

        # Configure the pose estimation client based on ROS params
        cameras_list_str = rospy.get_param("/pose_estimation/default_cameras")
        self.camera_names = [c.strip() for c in cameras_list_str.split(",")]

        env_yaml_path = Path(rospy.get_param("ENV_YAML"))
        assert env_yaml_path.exists(), f"Invalid YAML path was provided: {env_yaml_path}"
        self._objects: list[str] = load_known_object_names_from_yaml(env_yaml_path)
        self._next_obj_idx = 0

        self.global_frame = DEFAULT_FRAME  # Relative frame used as the static "world" frame

        self.pose_pub = rospy.Publisher("/estimated_object_poses", PoseEstimate, queue_size=10)

        # Allow other nodes to enable or disable pose estimate publishing
        self.enable_srv = rospy.Service("enable_publishing", SetBool, self.enable_publishing)
        self.disable_srv = rospy.Service("disable_publishing", SetBool, self.disable_publishing)
        self.publishing_enabled = True  # Default: Publish any estimated object poses

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

    def call_pose_estimation(self, object_name: str) -> None:
        """Call the pose estimation service for the named object.

        :param object_name: Name of the object whose pose is estimated
        """
        rgbd_pairs_request = GetRGBDPairsRequest(camera_names=self.camera_names)

        rgbd_pairs_msg = self._rgbd_pair_service(rgbd_pairs_request)
        assert rgbd_pairs_msg is not None, "Received None instead of a GetRGBDPairsResponse."

        # Immediately look up all camera transforms (pose_w_c) at the time of the image capture
        camera_poses: dict[str, Pose3D] = {}
        for camera_name, rgbd_pair in zip(self.camera_names, rgbd_pairs_msg.rgbd_pairs):
            camera_frame = rgbd_pair.camera_info.header.frame_id  # Optical frame of the camera
            capture_time = rgbd_pair.camera_info.header.stamp  # Acquisition time of the images
            pose_w_c = TransformManager.lookup_transform(
                camera_frame,
                self.global_frame,
                capture_time,
            )
            if pose_w_c is not None:
                camera_poses[camera_name] = pose_w_c

        for camera_name, rgbd_pair in zip(self.camera_names, rgbd_pairs_msg.rgbd_pairs):
            request = EstimatePoseRequest()
            request.rgb = rgbd_pair.rgb
            request.depth = rgbd_pair.depth
            request.info = rgbd_pair.camera_info
            request.object_name = object_name

            response = self._pose_service(request)
            if response is None or not response.object_found:
                continue

            rospy.loginfo(f"Received pose estimate for the object '{object_name}'")

            pose_w_c = camera_poses[camera_name]
            pose_c_o = pose_from_msg(response.pose)  # Pose of object (o) w.r.t. camera (c)
            pose_w_o = pose_w_c @ pose_c_o

            # Broadcast the estimated object pose w.r.t. to the camera for debugging purposes
            TransformManager.broadcast_transform(f"{object_name}_wrt_camera", pose_c_o)

            # Publish the object's estimated pose if the client's mode permits it
            if self.publishing_enabled:
                pose_stamped_msg: PoseStamped = pose_to_stamped_msg(pose_w_o)
                msg = PoseEstimate(object_name, pose_stamped_msg, response.confidence)
                self.pose_pub.publish(msg)

    def enable_publishing(self, req: SetBoolRequest) -> SetBoolResponse:
        """Enable the publishing of pose estimates.

        :param req: SetBool service request
        :returns: SetBoolResponse with success status and message
        """
        del req
        self.publishing_enabled = True
        return SetBoolResponse(success=True, message="Publishing enabled")

    def disable_publishing(self, req: SetBoolRequest) -> SetBoolResponse:
        """Disable the publishing of pose estimates.

        :param req: SetBool service request
        :returns: SetBoolResponse with success status and message
        """
        del req
        self.publishing_enabled = False
        return SetBoolResponse(success=True, message="Publishing disabled")


def main() -> None:
    """Launch a client for the EstimatePose ROS service."""
    TransformManager.init_node("pose_estimation_client")

    client = PoseEstimateClient()
    client.main_loop(freq_hz=2.0)


if __name__ == "__main__":
    main()
