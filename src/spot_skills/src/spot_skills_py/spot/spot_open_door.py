"""Define utility functions to support Spot automatically opening a door."""

from __future__ import annotations

import time

import cv2
import numpy as np
from bosdyn.api import geometry_pb2
from bosdyn.api.manipulation_api_pb2 import (
    MANIP_STATE_DONE,
    ManipulationApiFeedbackRequest,
    ManipulationApiRequest,
    ManipulationApiResponse,
    WalkToObjectInImage,
)
from bosdyn.api.spot import door_pb2
from bosdyn.api.spot.basic_command_pb2 import RobotCommandFeedbackStatus
from bosdyn.client import frame_helpers

from spot_skills_py.spot.spot_manager import SpotManager

PixelXY = tuple[float, float]


def calculate_hinge_side(handle_xy: PixelXY, hinge_xy: PixelXY) -> int:
    """Calculate whether a door hinge is on the left or right side of the door.

    :param handle_xy: Pixel coordinate of the door handle
    :param hinge_xy: Pixel coordinate of the door hinge
    :return: Integer representing a hinge on the left side, right side, or unknown
    """
    handle_x = handle_xy[0]
    hinge_x = hinge_xy[0]

    return (
        door_pb2.DoorCommand.HINGE_SIDE_RIGHT
        if (handle_x < hinge_x)
        else door_pb2.DoorCommand.HINGE_SIDE_LEFT
    )


class SpotDoorOpener:
    """A utility class to store shared data across multiple door-opening functions."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the door-opening class by storing the SpotManager."""
        self.manager = manager
        self.image_dict = None
        self.rgb_image_dict = None
        self.side_by_side = None
        self.handle_xy = None  # Pixel coordinate of door handle in the side-by-side image
        self.pixel_source_image = None
        self.rotated_pixel = None

    def capture_side_by_side_image(self) -> np.ndarray:
        """Pitch Spot's body and take a combined image using the two front fisheye cameras.

        :return: Combined side-by-side image from the two front cameras
        """
        self.manager.pitch_up(timeout_s=60)

        # Capture images from the two front cameras
        sources = ["frontleft_fisheye_image", "frontright_fisheye_image"]
        self.image_dict, self.rgb_image_dict = self.manager.image_client.get_images_as_cv2(sources)

        # Convert CV2 images to numpy for processing.
        fr_fisheye_image = self.image_dict["frontright_fisheye_image"][1]
        fl_fisheye_image = self.image_dict["frontleft_fisheye_image"][1]

        # Rotate the images to align with robot Z axis.
        fr_fisheye_image = cv2.rotate(fr_fisheye_image, cv2.ROTATE_90_CLOCKWISE)
        fl_fisheye_image = cv2.rotate(fl_fisheye_image, cv2.ROTATE_90_CLOCKWISE)

        self.side_by_side = np.hstack([fr_fisheye_image, fl_fisheye_image])

        return self.side_by_side

    def set_handle_xy(self, handle_xy: PixelXY) -> None:
        """Store the given pixel coordinate for the door handle, and any related values.

        :param handle_xy: Estimated pixel coordinate of the door handle
        """
        self.handle_xy = handle_xy
        self.compute_pixel_source()

        _, width = self.side_by_side.shape
        is_left: bool = self.handle_xy[0] > width / 2  # Was the image source the left camera?

        self.pixel_source_image = (
            "frontleft_fisheye_image" if is_left else "frontright_fisheye_image"
        )
        self.rotated_pixel = (
            (self.handle_xy[0] - width / 2, self.handle_xy[1]) if is_left else self.handle_xy
        )

    def create_walk_to_object_in_image_request(self) -> ManipulationApiRequest:
        """Construct a manipulation API request to make Spot walk to the object at the given pixel.

        :return: Manipulation API request Protobuf message
        """
        assert self.side_by_side is not None, "Cannot walk to the door; missing side-by-side image!"

        height, width = self.side_by_side.shape

        # Undo pixel rotation by rotation 90 deg CCW.
        manipulation_cmd = WalkToObjectInImage()
        th = -np.pi / 2
        xm = width / 4
        ym = height / 2
        x = self.rotated_pixel[0] - xm
        y = self.rotated_pixel[1] - ym
        manipulation_cmd.pixel_xy.x = np.cos(th) * x - np.sin(th) * y + ym
        manipulation_cmd.pixel_xy.y = np.sin(th) * x + np.cos(th) * y + xm

        # Populate the rest of the Manip API request.
        clicked_image_proto = self.image_dict[self.pixel_source_image][0]
        manipulation_cmd.frame_name_image_sensor = clicked_image_proto.shot.frame_name_image_sensor
        manipulation_cmd.transforms_snapshot_for_camera.CopyFrom(
            clicked_image_proto.shot.transforms_snapshot,
        )
        manipulation_cmd.camera_model.CopyFrom(clicked_image_proto.source.pinhole)

        door_search_dist_m = 1.25  # Distance to the door in meters
        manipulation_cmd.offset_distance.value = door_search_dist_m

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

    def open_door(self, open_door_timeout_s: float = 60) -> bool:
        """Command the robot to automatically open a door using the Spot SDK.

        :param open_door_timeout_s: Timeout (sec) for the "Open Door" robot command, defaults to 60
        :return: True if the door was opened, otherwise False
        """
        assert self.handle_xy is not None, "Cannot open door without the door handle pixel!"

        self.manager.log_info("Opening door...")

        # Tell the robot to walk through the door
        request = self.create_walk_to_object_in_image_request(self.handle_xy)
        manipulation_feedback = self.walk_to_object_in_image(request)
        time.sleep(3.0)

        assert self.pixel_source_image is not None, "Expected pixel image source to be known."

        # The ManipulationApiResponse for the WalkToObjectInImage command returns a transform snapshot
        # that contains where the door handle pixel intersects the world. We use this
        # intersection point to execute the door command.
        snapshot = manipulation_feedback.transforms_snapshot_manipulation_data

        vision_tform_raycast = frame_helpers.get_a_tform_b(
            snapshot,
            frame_helpers.VISION_FRAME_NAME,
            frame_helpers.RAYCAST_FRAME_NAME,
        )

        clicked_image_proto = self.image_dict[self.pixel_source_image][0]
        frame_name_image_sensor = clicked_image_proto.shot.frame_name_image_sensor

        vision_tform_sensor = frame_helpers.get_a_tform_b(
            clicked_image_proto.shot.transforms_snapshot,
            frame_helpers.VISION_FRAME_NAME,
            frame_name_image_sensor,
        )

        raycast_point_wrt_vision = vision_tform_raycast.get_translation()
        ray_from_camera_to_object = raycast_point_wrt_vision - vision_tform_sensor.get_translation()
        ray_from_camera_to_object_norm = np.sqrt(np.sum(ray_from_camera_to_object**2))
        ray_from_camera_normalized = ray_from_camera_to_object / ray_from_camera_to_object_norm

        auto_cmd = door_pb2.DoorCommand.AutoGraspCommand()
        auto_cmd.frame_name = frame_helpers.VISION_FRAME_NAME
        search_dist_meters = 0.25
        search_ray = search_dist_meters * ray_from_camera_normalized
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

        hinge_xy = (0, 0)  # Hardcoded hinge value to enforce door opening LEFT
        auto_cmd.hinge_side = calculate_hinge_side(self.handle_xy, hinge_xy)
        auto_cmd.swing_direction = door_pb2.DoorCommand.SWING_DIRECTION_PULL  # Hardcoded as PULL

        door_command = door_pb2.DoorCommand.Request(auto_grasp_command=auto_cmd)
        request = door_pb2.OpenDoorCommandRequest(door_command=door_command)

        # Command the robot to open the door.
        response = self.manager.door_client.open_door(request)

        feedback_request = door_pb2.OpenDoorFeedbackRequest()
        feedback_request.door_command_id = response.door_command_id

        end_time = time.time() + open_door_timeout_s
        while time.time() < end_time:
            feedback_response = self.manager.door_client.open_door_feedback(feedback_request)
            if feedback_response.status != RobotCommandFeedbackStatus.STATUS_PROCESSING:
                self.manager.log_info(f"Door command reported status {feedback_response.status}")
                return False

            if feedback_response.feedback.status == door_pb2.DoorCommand.Feedback.STATUS_COMPLETED:
                self.manager.log_info("Opened door.")
                return True

            time.sleep(0.5)

        return False
