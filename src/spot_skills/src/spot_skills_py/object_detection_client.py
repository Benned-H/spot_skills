"""Define a class to call a ROS service for an object detector."""

from __future__ import annotations

import sensor_msgs.msg
from transform_utils.ros.services import ServiceCaller

from pose_estimation_msgs.srv import DetectObjects, DetectObjectsRequest, DetectObjectsResponse


class DetectObjectClient:
    """A client of the object detection ROS service."""

    def __init__(
        self,
        text_queries: list[str],
        detection_service_name: str = "/detect_object_pixel_xy",
    ) -> None:
        """Initialize the client by establishing its service caller object."""
        self._obj_detect_service = ServiceCaller[DetectObjectsRequest, DetectObjectsResponse](
            detection_service_name,
            DetectObjects,
            timeout_s=120.0,
        )

        self.text_queries = text_queries  # Strings used to prompt the object detector

    def call_on_image(self, image_msg: sensor_msgs.msg.Image) -> DetectObjectsResponse | None:
        """Call the object detection service using the given image message."""
        request_msg = DetectObjectsRequest(image=image_msg, text_queries=self.text_queries)
        return self._obj_detect_service(request_msg)
