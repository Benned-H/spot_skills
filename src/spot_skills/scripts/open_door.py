# Copyright (c) 2023 Boston Dynamics, Inc.  All rights reserved.
#
# Downloading, reproducing, distributing or otherwise using the SDK Software
# is subject to the terms and conditions of the Boston Dynamics Software
# Development Kit License (20191101-BDSDK-SL).

"""Tutorial to show how to use Spot to open a door.

The robot should start sitting on the ground, facing the door, approximately 1 meter away.
The robot should be powered off.
The use of an external estop client is required.
"""

import argparse
import math
import sys
import time

import cv2
import numpy as np
import torch
from bosdyn import geometry
from bosdyn.api import basic_command_pb2, geometry_pb2, manipulation_api_pb2
from bosdyn.api.image_pb2 import Image, ImageCapture, ImageRequest, ImageResponse
from bosdyn.api.manipulation_api_pb2 import (  # <-
    ManipulationApiFeedbackRequest,
    ManipulationApiRequest,
    WalkToObjectInImage,
)
from bosdyn.api.spot import door_pb2  # <-
from bosdyn.client import create_standard_sdk, frame_helpers
from bosdyn.client.door import DoorClient  # <-
from bosdyn.client.image import ImageClient, build_image_request
from bosdyn.client.lease import LeaseClient, LeaseKeepAlive
from bosdyn.client.manipulation_api_client import ManipulationApiClient
from bosdyn.client.robot_command import RobotCommandBuilder, RobotCommandClient, blocking_stand
from bosdyn.client.util import add_base_arguments, authenticate, setup_logging
from PIL import Image as im
from transformers import OwlViTForObjectDetection, OwlViTProcessor


def get_handle_xy(rgb_image_dict, text_queries=["door hinge"]):
    """Mimic the clicking-on action for getting the handle location using obeject detection model."""
    "rgb_image_dict: dictionary of rbg images, got it the same way as image_dict"

    # Construct side by side image in the same way as side_by_side property
    fr_fisheye_image = rgb_image_dict["frontright_fisheye_image"][1]
    fl_fisheye_image = rgb_image_dict["frontleft_fisheye_image"][1]

    fr_fisheye_image = cv2.rotate(fr_fisheye_image, cv2.ROTATE_90_CLOCKWISE)
    fl_fisheye_image = cv2.rotate(fl_fisheye_image, cv2.ROTATE_90_CLOCKWISE)

    side_by_side_org = np.hstack([fr_fisheye_image, fl_fisheye_image])
    # cv2.imshow("visualize side by side img", side_by_side_org)
    # cv2.waitKey()
    # cv2.destroyAllWindows()
    side_by_side = im.fromarray(side_by_side_org)

    # Init model, Use GPU if available
    if torch.cuda.is_available():
        device = torch.device("cuda")
    else:
        device = torch.device("cpu")
    model = OwlViTForObjectDetection.from_pretrained("google/owlvit-large-patch14")
    # Set model in evaluation mode
    model = model.to(device)
    model.eval()

    processor = OwlViTProcessor.from_pretrained("google/owlvit-large-patch14")
    # mixin = ImageFeatureExtractionMixin()

    # Process image and text inputs
    inputs = processor(text=text_queries, images=side_by_side, return_tensors="pt").to(device)

    # Get predictions
    with torch.no_grad():
        outputs = model(**inputs)
    logits = torch.max(outputs["logits"][0], dim=-1)
    scores = torch.sigmoid(logits.values).cpu().detach().numpy()

    # labels = logits.indices.cpu().detach().numpy() # no need to use labels
    boxes = outputs["pred_boxes"][0].cpu().detach().numpy()
    score, box = max([(score, box) for score, box in zip(scores, boxes)], key=lambda x: x[0])
    cx, cy, bw, bh = box

    # owl-vit resize the model, so we need to resize it back with the box
    original_x, original_y = side_by_side.size
    cx_new = cx * original_x
    cy_new = cy * original_y
    print("picking point", int(cx_new), int(cy_new))
    print("size of the image", original_x, original_y)

    cv2.circle(side_by_side_org, (int(cx_new), int(cy_new)), 30, (255, 0, 0), 5)
    cv2.imshow("stop if bad", side_by_side_org)
    cv2.waitKey()
    cv2.destroyAllWindows()
    return int(cx_new), int(cy_new)


def safe_power_off(robot):
    """Sit and power off robot.

    Args:
        robot: (Robot) Interface to Spot robot.

    """
    robot.logger.info("Powering off robot...")
    robot.power_off(cut_immediately=False, timeout_sec=20)
    assert not robot.is_powered_on(), "Robot power off failed."
    robot.logger.info("Robot safely powered off.")


def check_estop(robot):
    """Verify that robot is not estopped. E-Stop should be run in a separate process.

    Args:
        robot: (Robot) Interface to Spot robot.

    """
    assert not robot.is_estopped(), (
        "Robot is estopped. Please use an external E-Stop client, "
        "such as the estop SDK example, to configure E-Stop."
    )


def walk_to_object_in_image(robot, request_manager, debug):
    """Command the robot to walk toward user selected point. The WalkToObjectInImage feedback
    reports a raycast result, converting the 2D touchpoint to a 3D location in space.

    Args:
        robot: (Robot) Interface to Spot robot.
        request_manager: (RequestManager) Object for bookkeeping user touch points.
        debug (bool): Show intermediate debug image.

    Returns:
        ManipulationApiResponse: Feedback from WalkToObjectInImage request.

    """
    manip_client = robot.ensure_client(ManipulationApiClient.default_service_name)
    manipulation_api_request = request_manager.get_walk_to_object_in_image_request(debug)

    # Send a manipulation API request. Using the points selected by the user, the robot will
    # walk toward the door handle.
    robot.logger.info("Walking toward door...")
    response = manip_client.manipulation_api_command(manipulation_api_request)

    # Check feedback to verify the robot walks to the handle. The service will also return a
    # FrameTreeSnapshot that contain a walkto_raycast_intersection point.
    command_id = response.manipulation_cmd_id
    feedback_request = ManipulationApiFeedbackRequest(manipulation_cmd_id=command_id)
    timeout_sec = 15.0
    end_time = time.time() + timeout_sec
    while time.time() < end_time:
        response = manip_client.manipulation_api_feedback_command(feedback_request)
        assert response.manipulation_cmd_id == command_id, "Got feedback for wrong command."
        if response.current_state == manipulation_api_pb2.MANIP_STATE_DONE:
            return response
    raise Exception("Manip command timed out. Try repositioning the robot.")
    robot.logger.info("Walked to door.")
    return response


def get_images_as_cv2(robot, sources):
    """Request image sources from robot. Decode and store as OpenCV image as well as proto.

    Args:
        robot: (Robot) Interface to Spot robot.
        sources: (list) String names of image sources.

    Returns:
        dict: Dictionary from image source name to (image proto, CV2 image) pairs.

    """
    image_client = robot.ensure_client(ImageClient.default_service_name)
    image_responses = image_client.get_image_from_sources(sources)
    image_dict = dict()

    requests = []
    for source in sources:
        request = build_image_request(
            source,
            quality_percent=100,
            pixel_format=Image.PIXEL_FORMAT_RGB_U8,
        )
        requests.append(request)

    for response in image_responses:
        # Convert image proto to CV2 image, for display later.
        image = np.frombuffer(response.shot.image.data, dtype=np.uint8)
        image = cv2.imdecode(image, -1)
        image_dict[response.source.name] = (response, image)

    # separately haev rbg image side by side
    rgb_image_responses = image_client.get_image(requests)
    rgb_image_dict = dict()

    for response in rgb_image_responses:
        # Convert image proto to CV2 image, for display later.
        image = np.frombuffer(response.shot.image.data, dtype=np.uint8)
        image = cv2.imdecode(image, -1)
        rgb_image_dict[response.source.name] = (response, image)

    return image_dict, rgb_image_dict


class RequestManager:
    """Helper object for displaying side by side images to the user and requesting user selected
    touchpoints. This class handles the bookkeeping for converting between a touchpoints of side by
    side display image of the frontleft and frontright fisheye images and the individual images.

    Args:
        image_dict: (dict) Dictionary from image source name to (image proto, CV2 image) pairs.
        window_name: (str) Name of display window.

    """

    def __init__(self, image_dict, window_name):
        self.image_dict = image_dict
        self.window_name = window_name
        self.handle_position_side_by_side = None
        self.hinge_position_side_by_side = None
        self._side_by_side = None
        self.clicked_source = None

    @property
    def side_by_side(self):
        """cv2.Image: Side by side rotated frontleft and frontright fisheye images"""
        if self._side_by_side is not None:
            return self._side_by_side

        # Convert CV2 images to numpy for processing.
        fr_fisheye_image = self.image_dict["frontright_fisheye_image"][1]
        fl_fisheye_image = self.image_dict["frontleft_fisheye_image"][1]

        # Rotate the images to align with robot Z axis.
        fr_fisheye_image = cv2.rotate(fr_fisheye_image, cv2.ROTATE_90_CLOCKWISE)
        fl_fisheye_image = cv2.rotate(fl_fisheye_image, cv2.ROTATE_90_CLOCKWISE)

        self._side_by_side = np.hstack([fr_fisheye_image, fl_fisheye_image])

        return self._side_by_side

    def user_input_set(self):
        """bool: True if handle and hinge position set."""
        return self.handle_position_side_by_side and self.hinge_position_side_by_side

    def _on_mouse(self, event, x, y, flags, param):
        if event == cv2.EVENT_LBUTTONDOWN:
            if not self.handle_position_side_by_side:
                cv2.circle(self.side_by_side, (x, y), 30, (255, 0, 0), 5)
                _draw_text_on_image(self.side_by_side, "Click hinge.")
                cv2.imshow(self.window_name, self.side_by_side)
                self.handle_position_side_by_side = (x, y)
            elif not self.hinge_position_side_by_side:
                self.hinge_position_side_by_side = (x, y)

    def get_user_input_handle_and_hinge(self):
        """Open window showing the side by side fisheye images with on-screen prompts for user."""
        _draw_text_on_image(self.side_by_side, "Click handle.")
        cv2.imshow(self.window_name, self.side_by_side)
        cv2.setMouseCallback(self.window_name, self._on_mouse)
        while not self.user_input_set():
            cv2.waitKey(1)
        cv2.destroyAllWindows()

    def get_walk_to_object_in_image_request(self, debug):
        """Convert from touchpoints in side by side image to a WalkToObjectInImage request.
        Optionally show debug image of touch point.

        Args:
            debug (bool): Show intermediate debug image.

        Returns:
            ManipulationApiRequest: Request with WalkToObjectInImage info populated.

        """
        # Figure out which source the user actually clicked.
        height, width = self.side_by_side.shape
        if self.handle_position_side_by_side[0] > width / 2:
            self.clicked_source = "frontleft_fisheye_image"
            rotated_pixel = self.handle_position_side_by_side
            rotated_pixel = (rotated_pixel[0] - width / 2, rotated_pixel[1])
        else:
            self.clicked_source = "frontright_fisheye_image"
            rotated_pixel = self.handle_position_side_by_side

        # Undo pixel rotation by rotation 90 deg CCW.
        manipulation_cmd = WalkToObjectInImage()
        th = -math.pi / 2
        xm = width / 4
        ym = height / 2
        x = rotated_pixel[0] - xm
        y = rotated_pixel[1] - ym
        manipulation_cmd.pixel_xy.x = math.cos(th) * x - math.sin(th) * y + ym
        manipulation_cmd.pixel_xy.y = math.sin(th) * x + math.cos(th) * y + xm

        # Optionally show debug image.
        if debug:
            clicked_cv2 = self.image_dict[self.clicked_source][1]
            c = (255, 0, 0)
            cv2.circle(
                clicked_cv2,
                (int(manipulation_cmd.pixel_xy.x), int(manipulation_cmd.pixel_xy.y)),
                30,
                c,
                5,
            )
            cv2.imshow("Debug", clicked_cv2)
            cv2.waitKey(0)
            cv2.destroyAllWindows()

        # Populate the rest of the Manip API request.
        clicked_image_proto = self.image_dict[self.clicked_source][0]
        manipulation_cmd.frame_name_image_sensor = clicked_image_proto.shot.frame_name_image_sensor
        manipulation_cmd.transforms_snapshot_for_camera.CopyFrom(
            clicked_image_proto.shot.transforms_snapshot,
        )
        manipulation_cmd.camera_model.CopyFrom(clicked_image_proto.source.pinhole)
        door_search_dist_meters = 1.25
        manipulation_cmd.offset_distance.value = door_search_dist_meters

        request = ManipulationApiRequest(walk_to_object_in_image=manipulation_cmd)
        return request

    @property
    def vision_tform_sensor(self):
        """Look up vision_tform_sensor for sensor which user clicked.

        Returns:
            math_helpers.SE3Pose

        """
        clicked_image_proto = self.image_dict[self.clicked_source][0]
        frame_name_image_sensor = clicked_image_proto.shot.frame_name_image_sensor
        snapshot = clicked_image_proto.shot.transforms_snapshot
        return frame_helpers.get_a_tform_b(
            snapshot,
            frame_helpers.VISION_FRAME_NAME,
            frame_name_image_sensor,
        )

    @property
    def hinge_side(self):
        """Calculate if hinge is on left or right side of door based on user touchpoints.

        Returns:
            DoorCommand.HingeSide

        """
        handle_x = self.handle_position_side_by_side[0]
        hinge_x = self.hinge_position_side_by_side[0]
        if handle_x < hinge_x:
            hinge_side = door_pb2.DoorCommand.HINGE_SIDE_RIGHT
        else:
            hinge_side = door_pb2.DoorCommand.HINGE_SIDE_LEFT
        return hinge_side


def _draw_text_on_image(image, text):
    font_scale = 4
    thickness = 4
    font = cv2.FONT_HERSHEY_PLAIN
    (text_width, text_height) = cv2.getTextSize(
        text,
        font,
        fontScale=font_scale,
        thickness=thickness,
    )[0]

    rectangle_bgr = (255, 255, 255)
    text_offset_x = 10
    text_offset_y = image.shape[0] - 25
    border = 10
    box_coords = (
        (text_offset_x - border, text_offset_y + border),
        (text_offset_x + text_width + border, text_offset_y - text_height - border),
    )
    cv2.rectangle(image, box_coords[0], box_coords[1], rectangle_bgr, cv2.FILLED)
    cv2.putText(
        image,
        text,
        (text_offset_x, text_offset_y),
        font,
        fontScale=font_scale,
        color=(0, 0, 0),
        thickness=thickness,
    )


def open_door(robot, request_manager, snapshot):
    """Command the robot to automatically open a door via the door service API.

    Args:
        robot: (Robot) Interface to Spot robot.
        request_manager: (RequestManager) Object for bookkeeping user touch points.
        snapshot: (TransformSnapshot) Snapshot from the WalkToObjectInImage command which contains
            the 3D location reported from a raycast based on the user hinge touch point.

    """
    robot.logger.info("Opening door...")

    # Using the raycast intersection point and the
    vision_tform_raycast = frame_helpers.get_a_tform_b(
        snapshot,
        frame_helpers.VISION_FRAME_NAME,
        frame_helpers.RAYCAST_FRAME_NAME,
    )
    vision_tform_sensor = request_manager.vision_tform_sensor
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

    auto_cmd.hinge_side = door_pb2.DoorCommand.HINGE_SIDE_LEFT  # <- hardcoded to open to the LEFT
    auto_cmd.swing_direction = door_pb2.DoorCommand.SWING_DIRECTION_PULL  # <- hardcoded to be PULL

    door_command = door_pb2.DoorCommand.Request(auto_grasp_command=auto_cmd)
    request = door_pb2.OpenDoorCommandRequest(door_command=door_command)

    # Command the robot to open the door.
    door_client = robot.ensure_client(DoorClient.default_service_name)
    response = door_client.open_door(request)

    feedback_request = door_pb2.OpenDoorFeedbackRequest()
    feedback_request.door_command_id = response.door_command_id

    timeout_sec = 60.0
    end_time = time.time() + timeout_sec
    while time.time() < end_time:
        feedback_response = door_client.open_door_feedback(feedback_request)
        if (
            feedback_response.status
            != basic_command_pb2.RobotCommandFeedbackStatus.STATUS_PROCESSING
        ):
            raise Exception("Door command reported status ")
        if feedback_response.feedback.status == door_pb2.DoorCommand.Feedback.STATUS_COMPLETED:
            robot.logger.info("Opened door.")
            return
        time.sleep(0.5)
    raise Exception("Door command timed out. Try repositioning the robot.")


def execute_open_door(robot, options):
    """High level behavior sequence for commanding the robot to open a door."""
    # TODO: Pitch up

    # Capture images from the two from cameras.
    sources = ["frontleft_fisheye_image", "frontright_fisheye_image"]
    image_dict, rgb_image_dict = get_images_as_cv2(robot, sources)

    # Get handle and hinge locations from user input.
    window_name = "Open Door Example"
    request_manager = RequestManager(image_dict, window_name)
    # request_manager.get_user_input_handle_and_hinge()
    request_manager.handle_position_side_by_side = get_handle_xy(
        rgb_image_dict,
    )  # <- just need x,y for for this
    # assert request_manager.user_input_set(), "Failed to get user input for handle and hinge."

    # Tell the robot to walk toward the door.
    manipulation_feedback = walk_to_object_in_image(robot, request_manager, options.debug)
    time.sleep(3.0)

    # The ManipulationApiResponse for the WalkToObjectInImage command returns a transform snapshot
    # that contains where user clicked door handle point intersects the world. We use this
    # intersection point to execute the door command.
    snapshot = manipulation_feedback.transforms_snapshot_manipulation_data

    # Execute the door command.
    open_door(robot, request_manager, snapshot)

    # Safely power off the robot, which sits then cuts motor power. # <- not to shut down
    # safe_power_off(robot)
