"""Define a class to call a ROS service for an object detector."""

from __future__ import annotations

import rospy
from sensor_msgs.msg import Image as ImageMsg
from transform_utils.ros.services import ServiceCaller

from pose_estimation_msgs.srv import DetectObjects, DetectObjectsRequest, DetectObjectsResponse


class DetectObjectClient:
    """A client of the object detection ROS service."""

    def __init__(self, queries: list[str], service_name: str = "/detect_object_pixel_xy") -> None:
        """Initialize the client by establishing its service caller object."""
        self.text_queries = queries  # Strings used to prompt the object detector

        self._obj_detect_service: ServiceCaller | None = None

        try:
            self._obj_detect_service = ServiceCaller[DetectObjectsRequest, DetectObjectsResponse](
                service_name,
                DetectObjects,
                timeout_s=30,
            )
        except (rospy.ServiceException, rospy.ROSException) as exc:
            rospy.loginfo(f"Could not access object detection service: {exc}")
            self._obj_detect_service = None

        if self._obj_detect_service is None:
            error_msg = f"DetectObjectClient requires the {service_name} service!"
            raise RuntimeError(error_msg)

    def call_on_image(self, image_msg: ImageMsg) -> DetectObjectsResponse | None:
        """Call the object detection service using the given image message."""
        if self._obj_detect_service is None:
            return None

        request_msg = DetectObjectsRequest(image=image_msg, text_queries=self.text_queries)
        return self._obj_detect_service(request_msg)
