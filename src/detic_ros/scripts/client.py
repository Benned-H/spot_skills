#!/usr/bin/env python
import rospy
import numpy as np
from sensor_msgs.msg import Image
from detic_ros.srv import Detect, DetectRequest


if __name__ == "__main__":
    def callback(msg):
        req = DetectRequest()
        req.image = msg
        res = service(req)
        boxes = None
        if len(res.boxes.data) > 0:
            boxes = np.array(res.boxes.data, dtype=np.uint16)
            shape = []
            for dim in res.boxes.layout.dim:
                shape.append(dim.size)
            boxes = boxes.reshape(shape)
        print(boxes)

    rospy.wait_for_service("/detic/query")
    sub = rospy.Subscriber("camera", Image, callback)
    rospy.init_node("sam2_client", anonymous=True)
    service = rospy.ServiceProxy("/detic/query", Detect)
    rospy.spin()
