#!/usr/bin/python3
import cv2
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

class Camera:
    def __init__(self):
        self.pub = rospy.Publisher('camera', Image, queue_size=1)
        self.bridge = CvBridge()
        self.cap = cv2.VideoCapture(0)

    def publish(self):
        ret, frame = self.cap.read()
        if ret:
            try:
                self.pub.publish(self.bridge.cv2_to_imgmsg(frame, "bgr8"))
            except CvBridgeError as e:
                print(e)

    def run(self):
        rate = rospy.Rate(10)
        while not rospy.is_shutdown():
            self.publish()
            rate.sleep()

if __name__ == '__main__':
    rospy.init_node('camera')
    camera = Camera()
    camera.run()
