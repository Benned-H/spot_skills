"""Define a ROS node providing a client for the EstimatePose service."""

from __future__ import annotations

from typing import TYPE_CHECKING

import rospy
from transform_utils.kinematics import DEFAULT_FRAME, Pose3D
from transform_utils.kinematics_ros import pose_from_msg, pose_to_stamped_msg
from transform_utils.ros.services import ServiceCaller
from transform_utils.transform_manager import TransformManager

from pose_estimation_msgs.msg import PoseEstimate
from pose_estimation_msgs.srv import EstimatePose, EstimatePoseRequest, EstimatePoseResponse
from spot_skills.srv import (
    GetRGBDPairs,
    GetRGBDPairsRequest,
    GetRGBDPairsResponse,
    ObjectNameService,
    ObjectNameServiceRequest,
    ObjectNameServiceResponse,
)

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

        # Configure the pose estimation service based on ROS params
        cameras_list_str = rospy.get_param("/pose_estimation/default_cameras")
        self.camera_names: list[str] = [c.strip() for c in cameras_list_str.split(",")]

        self.known_objects: list[str] = rospy.get_param("known_objects")
        self.active_objects: list[str] = []
        self._next_obj_idx = 0

        self.global_frame = "vision"  # Relative frame used as the static "world" frame

        # Publish estimated object poses to the /estimated_object_poses topic
        self.pose_pub = rospy.Publisher("/estimated_object_poses", PoseEstimate, queue_size=10)

        # Provide services to enable/disable pose estimation for specific objects
        self.enable_srv = rospy.Service("~enable_object", ObjectNameService, self.enable_object)
        self.disable_srv = rospy.Service("~disable_object", ObjectNameService, self.disable_object)

    def next_object(self) -> str | None:
        """Find the next object of interest for pose estimation.

        :return: Name of the next object to be pose-estimated (or None if no active objects)
        """
        if not self.active_objects:
            return None

        self._next_obj_idx = max(self._next_obj_idx, 0) % len(self.active_objects)
        object_name = self.active_objects[self._next_obj_idx]
        self._next_obj_idx += 1
        return object_name

    def main_loop(self, freq_hz: float) -> None:
        """Loop at the given frequency (Hz) while calling the pose estimation service.

        :param freq_hz: Nominal frequency (Hz) at which the client calls the service
        """
        rate_hz = rospy.Rate(freq_hz)
        while not rospy.is_shutdown():
            if self.active_objects:
                object_to_find = self.next_object()

                if object_to_find is not None:
                    self.call_pose_estimation(object_to_find)
            else:
                rospy.loginfo_throttle(10, "Pose estimation is currently inactive for all objects.")
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

            # Broadcast the estimated object pose w.r.t. to the camera for debugging
            TransformManager.broadcast_transform(f"{object_name}_wrt_camera", pose_c_o)
            TransformManager.broadcast_transform(object_name, pose_w_o)

            # Publish the object's estimated pose
            pose_stamped_msg: PoseStamped = pose_to_stamped_msg(pose_w_o)
            msg = PoseEstimate(object_name, pose_stamped_msg, response.confidence)
            self.pose_pub.publish(msg)

    def enable_object(self, req: ObjectNameServiceRequest) -> ObjectNameServiceResponse:
        """Enable pose estimation for the object requested via ROS service.

        :param req: Request message specifying which object should have pose estimation enabled
        :return: Response message conveying whether the request was successfully completed
        """
        if req.object_name not in self.known_objects:
            return ObjectNameServiceResponse(
                success=False,
                message=f"Cannot enable pose estimation for unknown object '{req.object_name}'.",
            )

        if req.object_name not in self.active_objects:
            self.active_objects.append(req.object_name)

        success = req.object_name in self.active_objects
        resulting_status = "enabled" if success else "disabled"
        message = f"Pose estimation is now {resulting_status} for object '{req.object_name}'."

        return ObjectNameServiceResponse(success, message)

    def disable_object(self, req: ObjectNameServiceRequest) -> ObjectNameServiceResponse:
        """Disable pose estimation for the object requested via ROS service.

        :param req: Request message specifying which object should have pose estimation disabled
        :return: Response message conveying whether the request was successfully completed
        """
        if req.object_name not in self.known_objects:
            return ObjectNameServiceResponse(
                success=False,
                message=f"Cannot disable pose estimation for unknown object '{req.object_name}'.",
            )

        if req.object_name in self.active_objects:
            self.active_objects.remove(req.object_name)

        success = req.object_name not in self.active_objects
        resulting_status = "disabled" if success else "enabled"
        message = f"Pose estimation is now {resulting_status} for object '{req.object_name}'."

        return ObjectNameServiceResponse(success, message)


def main() -> None:
    """Launch a client for the EstimatePose ROS service."""
    TransformManager.init_node("pose_estimation_client")

    client = PoseEstimateClient()
    client.main_loop(freq_hz=5.0)


if __name__ == "__main__":
    main()
