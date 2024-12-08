#!/usr/bin/env python
# take the image from the rostopic and run the sam2 model on it
# and show the segmentation outputs
import os

import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
from sam2_ros.srv import Segment, SegmentRequest, SegmentResponse
import numpy as np
import torch
from sam2.build_sam import build_sam2
from sam2.sam2_image_predictor import SAM2ImagePredictor


if __name__ == "__main__":
    checkpoint = "/opt/sam2/checkpoints/sam2.1_hiera_large.pt"
    if not os.path.exists(checkpoint):
        cwd = os.getcwd()
        os.chdir("/opt/sam2/checkpoints")
        os.system("./download_ckpts.sh")
        os.chdir(cwd)
    model_cfg = "configs/sam2.1/sam2.1_hiera_l.yaml"
    sam2 = build_sam2(model_cfg, checkpoint)
    predictor = SAM2ImagePredictor(sam2)

    def segment_callback(req: SegmentRequest):
        bridge = CvBridge()
        image = bridge.imgmsg_to_cv2(req.image, "bgr8")
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        points = None
        boxes = None
        labels = None
        if len(req.points.data) > 0:
            points = np.array(req.points.data)
            shape = []
            for dim in req.points.layout.dim:
                shape.append(dim.size)
            points = points.reshape(shape)
        if len(req.boxes.data) > 0:
            boxes = np.array(req.boxes.data)
            shape = []
            for dim in req.boxes.layout.dim:
                shape.append(dim.size)
            boxes = boxes.reshape(shape)
        if len(req.labels) > 0:
            labels = np.array(req.labels)

        res = SegmentResponse()
        with torch.inference_mode(), torch.autocast("cuda", dtype=torch.bfloat16):
            predictor.set_image(image)
            masks, scores, _ = predictor.predict(point_coords=points,
                                                 point_labels=labels,
                                                 box=boxes,
                                                 multimask_output=False)
            if masks.ndim == 4:
                n_masks = masks.shape[0]
                masks = masks[:, 0]
                scores = scores[:, 0]
            else:
                n_masks = 1
            for i in range(n_masks):
                img = Image()
                img.height = masks.shape[1]
                img.width = masks.shape[2]
                img.encoding = "mono8"
                img.step = masks.shape[2]
                img.data = (masks[i].astype(np.uint8)*255).tobytes()
                res.masks.append(img)
                res.scores.append(scores[i])
        return res

    rospy.init_node("sam2_server", anonymous=True)
    service = rospy.Service("sam2/query", Segment, segment_callback)
    rospy.spin()
