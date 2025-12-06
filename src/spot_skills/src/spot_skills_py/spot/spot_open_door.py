"""Define utility functions to support Spot automatically opening a door."""

from __future__ import annotations

import time
from typing import TYPE_CHECKING

import cv2
import numpy as np
import rospy
from bosdyn.api import geometry_pb2
from bosdyn.api.basic_command_pb2 import RobotCommandFeedbackStatus
from bosdyn.api.manipulation_api_pb2 import (
    MANIP_STATE_DONE,
    ManipulationApiFeedbackRequest,
    ManipulationApiRequest,
    ManipulationApiResponse,
    WalkToObjectInImage,
)
from bosdyn.api.spot import door_pb2
from bosdyn.client import frame_helpers
from robotics_utils.kinematics import Point3D
from robotics_utils.ros import TransformManager
from robotics_utils.vision import PixelXY, RGBImage
from robotics_utils.vision.vlms.gemini import GeminiRoboticsBridge
from robotics_utils.visualization import display_in_window

if TYPE_CHECKING:
    from spot_skills_py.spot.spot_manager import SpotManager


class SpotDoorOpener:
    """A utility class to store shared data across multiple door-opening functions."""

    def __init__(self, manager: SpotManager, gemini_api_key: str | None) -> None:
        """Initialize the door-opening class by storing the SpotManager.

        :param manager: Interface used to control Spot through the Spot SDK
        :param gemini_api_key: API key used to call Gemini Robotics-ER 1.5 (RuntimeError if None)
        """
        self.manager = manager
        self.api_key = gemini_api_key
        self.image_dict: dict | None = None
        self.rgb_image_dict: dict | None = None
        self.handle_xy = None  # Pixel coordinate of door handle in the side-by-side image
        self.pixel_source_image: str | None = None

    def capture_door_handle_image(self, pitch_rad: float = -np.pi / 6.0) -> RGBImage:
        """Pitch Spot's body to take an image of a door handle in front of Spot."""
        self.manager.pitch_up(pitch_rad)
        time.sleep(3.0)  # Let the camera focus

        # Try using Spot's gripper camera
        sources = ["hand_color_image"]
        self.image_dict, self.rgb_image_dict = self.manager.image_client.get_images_as_cv2(sources)

        hand_image = self.rgb_image_dict["hand_color_image"][1]
        hand_image = cv2.cvtColor(hand_image, cv2.COLOR_BGR2RGB)

        rgb = RGBImage(hand_image)
        rgb.to_file("/docker/spot_skills/images/open_door_image.jpg")

        return rgb

    def detect_handle_xy(self, image: RGBImage) -> PixelXY | None:
        """Detect the (x,y) coordinate of a door handle in the given image.

        Uses Gemini Robotics-ER for keypoint detection via a subprocess bridge.

        :param image: RGB image in which a door handle is detected
        :return: Detected (x,y) pixel coordinate, or None if no door handle was detected
        """
        if self.api_key is None:
            raise RuntimeError("Cannot call Gemini Robotics-ER 1.5; no API key provided.")

        rospy.loginfo(f"Image shape: {image.data.shape}")

        # Use Gemini keypoint detection via bridge to newer Python environment
        queries = ["silver door handle"]
        try:
            detections = GeminiRoboticsBridge.detect_keypoints(self.api_key, image, queries)
        except Exception as e:
            rospy.logerr(f"Gemini keypoint detection failed: {e}")
            return None

        if not detections.detections:
            rospy.logwarn("No door handle detected in image.")
            return None

        self.handle_xy = detections.detections[0].keypoint
        self.pixel_source_image = "hand_color_image"

        detections_visualized = RGBImage(data=detections.convert_for_visualization())
        detections_visualized.to_file("/docker/spot_skills/images/detected_door_handle.jpg")

        cv2.destroyAllWindows()
        display_in_window(detections, "Detected Door Handle", wait=True)  # DO NOT REMOVE (SAFETY)
        rospy.loginfo(f"Detected door handle at pixel: {self.handle_xy}")

        return self.handle_xy

    def create_walk_to_object_in_image_request(
        self,
        handle_xy: PixelXY,
        door_offset_m: float,
    ) -> ManipulationApiRequest:
        """Construct a manipulation API request to make Spot walk to the object at the given pixel.

        :param handle_xy: (x,y) pixel coordinates of the detected door handle
        :param door_offset_m: Spot will stand this offset (m) from the door
        :return: Manipulation API request Protobuf message
        """
        if self.handle_xy is None:
            raise ValueError("self.handle_xy was None.")

        manipulation_cmd = WalkToObjectInImage()
        manipulation_cmd.pixel_xy.x = handle_xy.x
        manipulation_cmd.pixel_xy.y = handle_xy.y

        # Populate the rest of the Manip API request.
        clicked_image_proto = self.image_dict[self.pixel_source_image][0]
        manipulation_cmd.frame_name_image_sensor = clicked_image_proto.shot.frame_name_image_sensor
        manipulation_cmd.transforms_snapshot_for_camera.CopyFrom(
            clicked_image_proto.shot.transforms_snapshot,
        )
        manipulation_cmd.camera_model.CopyFrom(clicked_image_proto.source.pinhole)
        manipulation_cmd.offset_distance.value = door_offset_m

        return ManipulationApiRequest(walk_to_object_in_image=manipulation_cmd)

    def walk_to_object_in_image(
        self,
        request: ManipulationApiRequest,
        timeout_s: float = 15.0,
    ) -> ManipulationApiResponse:
        """Command the robot to walk toward a specified point in an image.

        Note: Adapted from the open_door.py example from the Spot SDK.

        :param request: Protobuf message requesting a manipulation action on Spot
        :param timeout_s: Duration (seconds) before the manipulation command is abandoned
        :return: Protobuf message expressing the result of the requested manipulation
        """
        self.manager.log_info("Walking toward door...")
        response = self.manager.manip_client.manipulation_api_command(request)

        # Check feedback to verify the robot walks to the handle. The service will also return a
        # FrameTreeSnapshot that contain a walkto_raycast_intersection point.
        command_id = response.manipulation_cmd_id

        feedback_request = ManipulationApiFeedbackRequest(manipulation_cmd_id=command_id)

        end_time = time.time() + timeout_s
        while time.time() < end_time:
            response = self.manager.manip_client.manipulation_api_feedback_command(feedback_request)
            assert response.manipulation_cmd_id == command_id, "Got feedback for wrong command."
            if response.current_state == MANIP_STATE_DONE:
                self.manager.log_info("Walked to door.")
                return response

        raise Exception("Manipulation command timed out. Try repositioning the robot.")

    def open_door(
        self,
        *,
        is_pull: bool,
        hinge_on_left: bool,
        door_offset_m: float = 1.0,
        ray_search_dist_m: float = 0.5,
        timeout_s: float = 60.0,
        phase_timeout_s: float = 15.0,
    ) -> bool:
        """Command the robot to automatically open a door using the Spot SDK.

        :param image: Image in which Spot has detected a door handle
        :param is_pull: Boolean indicating if the door swings open by pulling toward Spot
        :param hinge_on_left: Boolean indicating if the door hinge is on the left (per Spot's view)
        :param door_offset_m: Spot will stand this offset (m) from the door
        :param ray_search_dist_m: Distance (m) searched along the ray to the door handle
        :param timeout_s: Timeout (seconds) for the "Open Door" command (defaults to 60)
        :param phase_timeout_s: Timeout (seconds) for any single phase of the door-opening
        :return: True if the door was opened, otherwise False
        """
        assert self.handle_xy is not None, "Cannot open door without the door handle pixel!"

        self.manager.log_info("Opening door...")

        # Store the initial transform of the vision frame w.r.t. Spot's body frame
        initial_pose_b_v = TransformManager.lookup_transform("vision", "body")
        if initial_pose_b_v is None:
            self.manager.log_info("Cannot open door because pose lookup failed.")
            return False

        # Tell the robot to walk through the door
        request = self.create_walk_to_object_in_image_request(self.handle_xy, door_offset_m)
        manipulation_feedback = self.walk_to_object_in_image(request)
        time.sleep(3.0)

        assert self.pixel_source_image is not None, "Expected pixel image source to be known."

        # The ManipulationApiResponse for the WalkToObjectInImage command returns a transform
        # snapshot that contains where the door handle pixel intersects the vision frame. We use
        # this intersection point to execute the door command.
        snapshot = manipulation_feedback.transforms_snapshot_manipulation_data

        vision_tform_raycast = frame_helpers.get_a_tform_b(
            snapshot,
            frame_helpers.VISION_FRAME_NAME,
            frame_helpers.RAYCAST_FRAME_NAME,
        )
        raycast_point_wrt_vision = vision_tform_raycast.get_translation()

        position_v_dh = Point3D.from_array(raycast_point_wrt_vision)  # Door handle w.r.t. vision

        initial_position_b_dh = initial_pose_b_v @ position_v_dh  # Door handle w.r.t. body
        handle_x_wrt_body = initial_position_b_dh.x  # Initial forward distance from body

        self.manager.log_info(
            f"Door handle estimated as {handle_x_wrt_body:.2f} m in front of Spot.",
        )

        clicked_image_proto = self.image_dict[self.pixel_source_image][0]
        frame_name_image_sensor = clicked_image_proto.shot.frame_name_image_sensor

        vision_tform_sensor = frame_helpers.get_a_tform_b(
            clicked_image_proto.shot.transforms_snapshot,
            frame_helpers.VISION_FRAME_NAME,
            frame_name_image_sensor,
        )

        ray_from_camera_to_obj = raycast_point_wrt_vision - vision_tform_sensor.get_translation()
        ray_from_camera_to_obj_norm = np.sqrt(np.sum(ray_from_camera_to_obj**2))
        ray_from_camera_normalized = ray_from_camera_to_obj / ray_from_camera_to_obj_norm

        auto_cmd = door_pb2.DoorCommand.AutoGraspCommand()
        auto_cmd.frame_name = frame_helpers.VISION_FRAME_NAME
        search_ray = ray_search_dist_m * ray_from_camera_normalized
        search_ray_start_in_frame = raycast_point_wrt_vision - search_ray
        auto_cmd.search_ray_start_in_frame.CopyFrom(
            geometry_pb2.Vec3(
                x=search_ray_start_in_frame[0],
                y=search_ray_start_in_frame[1],
                z=search_ray_start_in_frame[2],
            ),
        )

        search_ray_end_in_frame = raycast_point_wrt_vision + search_ray
        auto_cmd.search_ray_end_in_frame.CopyFrom(
            geometry_pb2.Vec3(
                x=search_ray_end_in_frame[0],
                y=search_ray_end_in_frame[1],
                z=search_ray_end_in_frame[2],
            ),
        )

        auto_cmd.hinge_side = (
            door_pb2.DoorCommand.HINGE_SIDE_LEFT
            if hinge_on_left
            else door_pb2.DoorCommand.HINGE_SIDE_RIGHT
        )

        auto_cmd.swing_direction = (
            door_pb2.DoorCommand.SWING_DIRECTION_PULL
            if is_pull
            else door_pb2.DoorCommand.SWING_DIRECTION_PUSH
        )

        door_command = door_pb2.DoorCommand.Request(auto_grasp_command=auto_cmd)
        request = door_pb2.OpenDoorCommandRequest(door_command=door_command)

        safety_margin_m = 0.3  # Allow small distance (meters) past estimated door handle

        # Command the robot to open the door.
        response = self.manager.door_client.open_door(request)

        feedback_request = door_pb2.OpenDoorFeedbackRequest()
        feedback_request.door_command_id = response.door_command_id

        end_time = time.time() + timeout_s
        last_status = None
        last_status_change_time = time.time()

        success = None  # True = Door was opened, False = Failure case, None = Timed out

        while time.time() < end_time:
            feedback_response = self.manager.door_client.open_door_feedback(feedback_request)
            current_door_status = feedback_response.feedback.status

            if feedback_response.status != RobotCommandFeedbackStatus.STATUS_PROCESSING:
                self.manager.log_info(f"Door command reported status {feedback_response.status}")
                success = False
                break

            # Check Spot's current position relative to its initial pose
            curr_v_b = TransformManager.lookup_transform(child_frame="body", parent_frame="vision")
            if curr_v_b is None:
                self.manager.log_info("Cannot open door because pose lookup failed.")
                success = False
                break

            curr_wrt_initial_body = initial_pose_b_v @ curr_v_b
            past_door_m = curr_wrt_initial_body.position.x - handle_x_wrt_body

            if past_door_m > safety_margin_m:
                self.manager.log_info(f"Moved {past_door_m:.2f} m past the door, now halting...")
                success = True
                break

            # Track status changes
            if current_door_status != last_status:
                self.manager.log_info(f"Door opening phase: {current_door_status}")
                last_status = current_door_status
                last_status_change_time = time.time()

            # Check if we've been stuck in this phase for too long
            in_phase_for = time.time() - last_status_change_time
            if in_phase_for > phase_timeout_s:
                self.manager.log_info(
                    f"Stuck in phase {current_door_status} for {in_phase_for:.2f} s, aborting.",
                )
                success = False
                break

            if current_door_status == door_pb2.DoorCommand.Feedback.STATUS_COMPLETED:
                self.manager.log_info("Opened door.")
                success = True
                break

            time.sleep(0.5)

        if success is None:
            self.manager.log_info(f"Door opening timed out after {timeout_s} total seconds.")
            success = False

        # Regardless of the outcome, make sure to freeze the robot
        self.manager.stop_robot(stow_arm=True)

        return success
