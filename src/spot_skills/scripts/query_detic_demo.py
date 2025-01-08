#!/usr/bin/env python
import sys, os

import numpy as np
import rospy
import cv2
from cv_bridge import CvBridge
# sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from detic_ros.srv import SegmentQuery, SegmentQueryRequest

from sensor_msgs.msg import Image

def query_publisher(img, query):
    rospy.wait_for_service("segment_query")
    segement_service = rospy.ServiceProxy("segment_query",SegmentQuery)
    resp = segement_service(img,query)
    return resp.segmented_image

if __name__ == "__main__":

    rospy.init_node('test', log_level=rospy.INFO)
    msg = rospy.wait_for_message("/spot/camera/hand_color/image", Image)
    cv_bridge = CvBridge()
    image = cv_bridge.imgmsg_to_cv2(msg, "bgra8")
    # cv2.imshow("image", image)
    # cv2.waitKey(0)

    segmented_image = query_publisher(msg, 'cup')


    image = cv_bridge.imgmsg_to_cv2(segmented_image, "bgra8")
    cv2.imshow("image", image)
    cv2.waitKey(0)
