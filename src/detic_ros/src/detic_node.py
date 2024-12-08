#!/usr/local/bin/python3.10
import os
import sys

import torch
import numpy as np
from std_msgs.msg import UInt16MultiArray, MultiArrayLayout, MultiArrayDimension
import rospy
from cv_bridge import CvBridge
from detic_ros.srv import Detect, DetectRequest, DetectResponse

from detectron2 import model_zoo
from detectron2.engine import DefaultPredictor
from detectron2.config import get_cfg
from detectron2.data import MetadataCatalog
sys.path.insert(0, '/docker/Detic/third_party/CenterNet2/')
sys.path.insert(0, "/docker/Detic")
sys.path.insert(0, "/docker")
from centernet.config import add_centernet_config
from Detic.detic.config import add_detic_config
from Detic.detic.modeling.utils import reset_cls_test
from Detic.detic.modeling.text.text_encoder import build_text_encoder


def FasterRCNN_predictor():
    cfg = get_cfg()
    cfg.merge_from_file(model_zoo.get_config_file("COCO-Detection/faster_rcnn_R_50_FPN_1x.yaml"))
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = 0.5
    cfg.MODEL.WEIGHTS = model_zoo.get_checkpoint_url("COCO-Detection/faster_rcnn_R_50_FPN_1x.yaml")
    predictor = DefaultPredictor(cfg)
    return predictor

# some model loading scripts are taken from below (MIT license)
# https://github.com/bdaiinstitute/detic-sam
def DETIC_predictor(detic_package_path="Detic", device="cuda", vocabulary="openimages", classes=None):
    # Build the detector and download our pretrained weights
    cfg = get_cfg()
    add_centernet_config(cfg)
    add_detic_config(cfg)
    cfg.merge_from_file("/docker/Detic/configs/Detic_LCOCOI21k_CLIP_SwinB_896b32_4x_ft4x_max-size.yaml")
    cfg.MODEL.WEIGHTS = 'https://dl.fbaipublicfiles.com/detic/Detic_LCOCOI21k_CLIP_SwinB_896b32_4x_ft4x_max-size.pth'
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = 0.5 # set threshold for this model
    cfg.MODEL.ROI_BOX_HEAD.ZEROSHOT_WEIGHT_PATH = 'rand'
    cfg.MODEL.ROI_HEADS.ONE_CLASS_PER_PROPOSAL = True # For better visualization purpose. Set to False for all classes.
    cfg.MODEL.DEVICE = device
    cwd = os.getcwd()
    os.chdir(detic_package_path)
    detic_predictor = DefaultPredictor(cfg)
    if classes is None:
        metadata = default_vocab(detic_predictor, vocabulary=vocabulary)
    else:
        metadata = custom_vocab(detic_predictor, classes)
    detic_predictor.metadata = metadata
    os.chdir(cwd)
    return detic_predictor

def default_vocab(detic_predictor, vocabulary="lvis"):
    # Setup the model's vocabulary using build-in datasets
    BUILDIN_CLASSIFIER = {
        'lvis': 'datasets/metadata/lvis_v1_clip_a+cname.npy',
        'objects365': 'datasets/metadata/o365_clip_a+cnamefix.npy',
        'openimages': 'datasets/metadata/oid_clip_a+cname.npy',
        'coco': 'datasets/metadata/coco_clip_a+cname.npy',
    }

    BUILDIN_METADATA_PATH = {
        'lvis': 'lvis_v1_val',
        'objects365': 'objects365_v2_val',
        'openimages': 'oid_val_expanded',
        'coco': 'coco_2017_val',
    }

    metadata = MetadataCatalog.get(BUILDIN_METADATA_PATH[vocabulary])
    classifier = BUILDIN_CLASSIFIER[vocabulary]
    num_classes = len(metadata.thing_classes)
    reset_cls_test(detic_predictor.model, classifier, num_classes)
    return metadata

def get_clip_embeddings(vocabulary, prompt='a '):
    text_encoder = build_text_encoder(pretrain=True)
    text_encoder.eval()
    texts = [prompt + x for x in vocabulary]
    emb = text_encoder(texts).detach().permute(1, 0).contiguous().cpu()
    return emb

def custom_vocab(detic_predictor, classes):
    metadata = MetadataCatalog.get("__unused2")
    metadata.thing_classes = classes # Change here to try your own vocabularies!
    classifier = get_clip_embeddings(metadata.thing_classes)
    num_classes = len(metadata.thing_classes)
    reset_cls_test(detic_predictor.model, classifier, num_classes)

    # Reset visualization threshold
    output_score_threshold = 0.5
    for cascade_stages in range(len(detic_predictor.model.roi_heads.box_predictor)):
        detic_predictor.model.roi_heads.box_predictor[cascade_stages].test_score_thresh = output_score_threshold
    return metadata


if __name__ == "__main__":
    predictor = DETIC_predictor(detic_package_path="/docker/Detic")
    # predictor = FasterRCNN_predictor()
    thing_classes = predictor.metadata.thing_classes

    def detect_callback(req: DetectRequest):
        bridge = CvBridge()
        image = bridge.imgmsg_to_cv2(req.image, "bgr8")
        with torch.inference_mode():
            outputs = predictor(image)
        res = DetectResponse()
        labels = outputs["instances"].pred_classes
        labels = [thing_classes[c] for c in labels]
        n = len(labels)
        res.labels = labels
        res.scores = outputs["instances"].scores.cpu().numpy().tolist()
        boxes = UInt16MultiArray()
        layout = MultiArrayLayout()
        layout.dim = [MultiArrayDimension("boxes", n, n*4),
                      MultiArrayDimension("dim", 4, 4)]
        layout.data_offset = 0
        boxes.layout = layout
        boxes.data = outputs["instances"].pred_boxes.tensor.cpu().numpy().astype(np.uint16).reshape(-1).tolist()
        res.boxes = boxes
        return res

    rospy.init_node("detic_server", anonymous=True)
    service = rospy.Service("detic/query", Detect, detect_callback)
    rospy.spin()
