#!/usr/local/bin/python3.10
import time

import rospy
import numpy as np
import cv2
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from detic_ros.srv import Detect, DetectRequest, SegmentQuery, SegmentQueryResponse
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
    def SegmentQueryHandler(req):
        start = time.time()
        detect_req = DetectRequest()
        detect_req.image = req.image
        
        
        detic_response = detic_srv(detect_req)
        segment_req = SegmentRequest()
        segment_req.image = req.image
        segment_req.boxes = detic_response.boxes

        sam_respose = sam2_srv(segment_req)
        cv_bridge = CvBridge()
        image = cv_bridge.imgmsg_to_cv2(req.image, "bgra8")
        for mask in sam_respose.masks:
            mask_img = cv_bridge.imgmsg_to_cv2(mask, "mono8")
            overlay = create_mask_overlay(mask_img)
            image = cv2.addWeighted(image, 1, overlay, 0.5, 0)

        img_msg = cv_bridge.cv2_to_imgmsg(image,"bgra8")
        return SegmentQueryResponse(img_msg)
        # end = time.time()
        # cv2.imshow("image", image)
        # cv2.waitKey(1)
        # print(f"Time taken: {end - start:.2f}s")

    rospy.wait_for_service("/detic/query")
    rospy.wait_for_service("/sam2/query")
    sub = rospy.Service('segment_query', SegmentQuery, SegmentQueryHandler)
    rospy.init_node("deticsam_client", anonymous=True)
    detic_srv = rospy.ServiceProxy("/detic/query", Detect)
    sam2_srv = rospy.ServiceProxy("/sam2/query", Segment)
    rospy.spin()
