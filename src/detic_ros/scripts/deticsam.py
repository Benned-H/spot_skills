#!/usr/local/bin/python3.10
import time

import rospy
import numpy as np
import cv2
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from detic_ros.srv import Detect, DetectRequest
from sam2_ros.srv import Segment, SegmentRequest


def create_mask_overlay(mask, random_color=True):
    if random_color:
        color = np.concatenate([np.random.random(3), np.array([0.6])], axis=0)
    else:
        color = np.array([30/255, 144/255, 255/255, 0.6])
    mask_image =  mask[:, :, np.newaxis] * color.reshape(1, 1, -1)
    contours, _ = cv2.findContours(mask,cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE) 
    contours = [cv2.approxPolyDP(contour, epsilon=0.01, closed=True) for contour in contours]
    mask_image = cv2.drawContours(mask_image, contours, -1, (1, 1, 1, 0.5), thickness=2)
    return mask_image.astype(np.uint8)


if __name__ == "__main__":
    def callback(msg):
        start = time.time()
        req = DetectRequest()
        req.image = msg
        res = detic_srv(req)
        req = SegmentRequest()
        req.image = msg
        req.boxes = res.boxes
        res = sam2_srv(req)
        cv_bridge = CvBridge()
        image = cv_bridge.imgmsg_to_cv2(msg, "bgra8")
        for mask in res.masks:
            mask_img = cv_bridge.imgmsg_to_cv2(mask, "mono8")
            overlay = create_mask_overlay(mask_img)
            image = cv2.addWeighted(image, 1, overlay, 0.5, 0)
        end = time.time()
        cv2.imshow("image", image)
        cv2.waitKey(1)
        print(f"Time taken: {end - start:.2f}s")

    rospy.wait_for_service("/detic/query")
    rospy.wait_for_service("/sam2/query")
    sub = rospy.Subscriber("camera", Image, callback, queue_size=2)
    rospy.init_node("deticsam_client", anonymous=True)
    detic_srv = rospy.ServiceProxy("/detic/query", Detect)
    sam2_srv = rospy.ServiceProxy("/sam2/query", Segment)
    rospy.spin()
