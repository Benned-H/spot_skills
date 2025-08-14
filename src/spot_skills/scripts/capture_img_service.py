#!/usr/bin/env python
import rospy
from std_srvs.srv import Trigger, TriggerResponse
from pathlib import Path

from bosdyn.client.image import ImageClient, build_image_request
from bosdyn.api import image_pb2
from PIL import Image
from stitch_front_images_distortion import stitch
from bosdyn.client import Robot, create_standard_sdk
import bosdyn.client.util as bdu
from typing import Tuple, Optional
from pathlib import Path
import os
from std_msgs.msg import String                    
import yaml
import numpy as np
import io
import cv2

FRONT_IMAGE_SOURCES = ['frontright_fisheye_image', 'frontleft_fisheye_image']
GRIPPER_IMAGE_SOURCE = "hand_color_image"
JPEG_QUALITY = 100

ROBOT_HOSTNAME = os.environ.get("SPOT_HOST", "128.148.140.20") #tusker:"128.148.140.22"
ROBOT_USERNAME = os.environ.get("SPOT_USER", "user")
ROBOT_PASSWORD = os.environ.get("SPOT_PW", "bigbubbabigbubba")

class ImageCapturer:
    """Capture images from the robot and stitch them together."""

    def __init__(self, robot: Optional[Robot]):
        if robot is None:
            self.sdk = create_standard_sdk("skill_seq_capture")
            self.robot = self.sdk.create_robot(ROBOT_HOSTNAME)
        else:
            self.robot = robot
        bdu.authenticate(self.robot)
        self.robot.sync_with_directory()
        self.robot.time_sync.wait_for_sync()
        self.robot.hostname = ROBOT_HOSTNAME
        self.client: Optional[ImageClient] = None
        if self.robot is not None:
            self.client = self.robot.ensure_client(ImageClient.default_service_name)

    #REMOVED
    def _grab_gripper_pil(self) -> np.ndarray:
        """Capture a single image from the gripper camera and return as NumPy array."""
        if self.client is None:
            # Dry-run: solid blue placeholder image
            w, h = 640, 480
            arr = np.full((h, w, 3), (0, 0, 255), dtype=np.uint8)
            return arr

        # Build and send the image request
        req = build_image_request(GRIPPER_IMAGE_SOURCE,
                                quality_percent=JPEG_QUALITY,
                                pixel_format=image_pb2.Image.PIXEL_FORMAT_RGB_U8)
        response = self.client.get_image_async([req], timeout=2.0)[0]

        # Decode the image bytes to PIL, then to NumPy
        img = Image.open(io.BytesIO(response.shot.image.data))
        return np.array(img)

    #CHANGED
    def _grab_pil_pair(self, cam_type) -> Tuple[Image.Image, Image.Image]:
        if self.client is None:
            # Dry‑run: generate placeholder images
            w, h = 640, 480
            arr1 = np.full((h, w, 3), (255, 0, 0), dtype=np.uint8)
            arr2 = np.full((h, w, 3), (0, 255, 0), dtype=np.uint8)
            return Image.fromarray(arr1), Image.fromarray(arr2)

        if cam_type == "Front":
            reqs = [build_image_request(src, quality_percent=JPEG_QUALITY, pixel_format=image_pb2.Image.PIXEL_FORMAT_RGB_U8) for src in FRONT_IMAGE_SOURCES]
        else:
            reqs = [build_image_request(src, quality_percent=JPEG_QUALITY, pixel_format=image_pb2.Image.PIXEL_FORMAT_RGB_U8) for src in [GRIPPER_IMAGE_SOURCE]]

        responses = self.client.get_image_async(reqs, timeout=2.0)
        return responses
    
    def capture_and_stitch(self, save_path: Path, cam_type: str):
        """Capture and write JPEGs; return their paths."""
        if cam_type == "Front":
            responses = self._grab_pil_pair(cam_type)
            image_np = stitch(responses)
        else:
            responses = self._grab_pil_pair(cam_type)
            responses = responses.result()
            image_data = responses[0].shot.image.data
            image_np = cv2.imdecode(np.frombuffer(image_data, dtype=np.uint8), cv2.IMREAD_COLOR)

        Image.fromarray(image_np).save(save_path)



def handle_capture(req):
    # ─── Subscribe briefly to get latest img & skill info ─────────────────────────
    msg = rospy.wait_for_message('skill_info', String, timeout=120.0)
    info = yaml.safe_load(msg.data)                                 
    img_path = info['img_path']
    cam_type = info['cam_type']
    # rospy.loginfo(f"Current working directory: {os.getcwd()}")           

    # initialize capturer (pass in real Robot or None)
    capturer = ImageCapturer(robot=None)
    try:
        capturer.capture_and_stitch(Path(img_path), cam_type)
        rospy.loginfo(f"Saved ⇒ {img_path}")

        return TriggerResponse(success=True,
                               message=f"Image saved to {img_path}")
    except Exception as e:
        return TriggerResponse(success=False,
                               message=str(e))

if __name__ == '__main__':
    rospy.init_node('capture_and_stitch_service')
    # advertise the service
    srv = rospy.Service('/spot/take_picture', Trigger, handle_capture)
    rospy.loginfo("Ready to capture & stitch images on /capture_and_stitch")
    rospy.spin()
