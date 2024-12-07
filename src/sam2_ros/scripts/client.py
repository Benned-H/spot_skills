#!/usr/bin/env python
import rospy
from sensor_msgs.msg import Image
from std_msgs.msg import UInt16MultiArray, MultiArrayLayout, MultiArrayDimension
from sam2_ros.srv import Segment, SegmentRequest
import cv2
from cv_bridge import CvBridge


if __name__ == "__main__":
    def callback(msg):
        cv_bridge = CvBridge()
        req = SegmentRequest()
        req.image = msg
        points = UInt16MultiArray()
        layout = MultiArrayLayout()
        n = 1  # number of points
        layout.dim = [MultiArrayDimension("points", n, n*2),
                    MultiArrayDimension("dim", 2, 1)]
        layout.data_offset = 0
        points.layout = layout
        points.data = [req.image.width // 2, req.image.height // 2]
        req.points = points
        req.labels = [True]
        res = service(req)
        mask = cv_bridge.imgmsg_to_cv2(res.masks[0], "mono8")
        cv2.imshow("mask", mask)
        cv2.waitKey(1)

    rospy.wait_for_service("/sam2/query")
    sub = rospy.Subscriber("camera", Image, callback)
    rospy.init_node("sam2_client", anonymous=True)
    service = rospy.ServiceProxy("/sam2/query", Segment)
    rospy.spin()
