"""ROS1 deployment node for BC-RNN policy on Spot.

Subscribes to a camera image topic and /tf, runs the trained BC-RNN model
at a fixed rate, and publishes predicted 6D poses as PoseStamped messages.

Parameters are loaded from a YAML config file (default: ros_node_params.yaml).
"""

from __future__ import annotations

import argparse
import threading

import numpy as np
import torch
import yaml
from cv_bridge import CvBridge
from torchvision import transforms

import rospy
from geometry_msgs.msg import PoseStamped, TransformStamped
from sensor_msgs.msg import Image
from tf2_msgs.msg import TFMessage

from src.dataset import matrix_to_6d_pose
from src.model import BCRNNModel


def _quaternion_to_matrix(q) -> np.ndarray:
    """Convert a geometry_msgs Quaternion to a 3x3 rotation matrix."""
    x, y, z, w = q.x, q.y, q.z, q.w
    return np.array([
        [1 - 2*(y**2 + z**2), 2*(x*y - z*w),      2*(x*z + y*w)     ],
        [2*(x*y + z*w),       1 - 2*(x**2 + z**2), 2*(y*z - x*w)     ],
        [2*(x*z - y*w),       2*(y*z + x*w),       1 - 2*(x**2 + y**2)],
    ])


def transform_to_matrix(transform: TransformStamped) -> np.ndarray:
    """Convert a geometry_msgs TransformStamped to a 4x4 homogeneous matrix."""
    t = transform.transform.translation
    mat = np.eye(4)
    mat[:3, :3] = _quaternion_to_matrix(transform.transform.rotation)
    mat[:3, 3] = [t.x, t.y, t.z]
    return mat


class BCRNNDeployNode:
    """ROS node that runs a trained BC-RNN policy in a loop."""

    def __init__(self, config: dict) -> None:
        self.config = config
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.lock = threading.Lock()

        # Latest observations (updated by callbacks)
        self._latest_image = None  # raw grayscale numpy (H, W) uint8
        self._latest_tf_matrix = None  # 4x4 ndarray

        self.joint_name = config["joint_name"]
        self.parent_frame = config["parent_frame"]

        # Image preprocessing (same as dataset.py)
        image_size = config["model"]["image_size"]
        self.img_transform = transforms.Compose([
            transforms.ToPILImage(),
            transforms.Resize((image_size, image_size)),
            transforms.Grayscale(),
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.449], std=[0.226]),
        ])

        # Denormalization constants for image (not needed for action output,
        # but kept for reference). Action output is raw 6D pose, no normalization
        # is applied during training so no denormalization is needed.

        # Load model
        model_cfg = config["model"]
        self.model = BCRNNModel(
            state_dim=model_cfg["state_dim"],
            action_dim=model_cfg["action_dim"],
            hidden_dim=model_cfg["hidden_dim"],
            in_channels=model_cfg["in_channels"],
            freeze_backbone=True,
        ).to(self.device)
        self.model.eval()

        ckpt = torch.load(config["checkpoint"], map_location=self.device)
        self.model.load_state_dict(ckpt["model"])
        rospy.loginfo(
            f"Loaded checkpoint: {config['checkpoint']} "
            f"(epoch {ckpt.get('epoch', '?')}, val_loss {ckpt.get('val_loss', '?'):.6f})"
        )

        self.delta_actions = config.get("delta_actions", True)

        # GRU hidden state (reset each episode)
        self.hidden = None

        # ROS setup
        topics = config["topics"]
        self.bridge = CvBridge()

        self.image_sub = rospy.Subscriber(
            topics["image_sub"], Image, self._image_callback, queue_size=1
        )
        self.tf_sub = rospy.Subscriber(
            topics["tf_sub"], TFMessage, self._tf_callback, queue_size=1
        )
        self.action_pub = rospy.Publisher(
            topics["action_pub"], PoseStamped, queue_size=1
        )

        self.rate = rospy.Rate(config["rate"])
        rospy.loginfo(
            f"BC-RNN deploy node ready | rate={config['rate']}Hz | "
            f"image={topics['image_sub']} | tf={topics['tf_sub']} | "
            f"action={topics['action_pub']}"
        )

    # ------------------------------------------------------------------
    # ROS callbacks
    # ------------------------------------------------------------------

    def _image_callback(self, msg: Image) -> None:
        """Convert incoming ROS Image to grayscale numpy array."""
        try:
            img = self.bridge.imgmsg_to_cv2(msg, desired_encoding="mono8")
        except Exception as e:
            rospy.logwarn_throttle(5.0, f"Image conversion failed: {e}")
            return

        with self.lock:
            self._latest_image = img  # (H, W) uint8

    def _tf_callback(self, msg: TFMessage) -> None:
        """Extract the target joint transform from a TFMessage."""
        for tf_stamped in msg.transforms:
            if (
                tf_stamped.header.frame_id == self.parent_frame
                and tf_stamped.child_frame_id == self.joint_name
            ):
                mat = transform_to_matrix(tf_stamped)
                with self.lock:
                    self._latest_tf_matrix = mat
                return

    # ------------------------------------------------------------------
    # Inference
    # ------------------------------------------------------------------

    def _preprocess_image(self, img: np.ndarray) -> torch.Tensor:
        """Apply the same transform pipeline as BCRNNDataset."""
        return self.img_transform(img).unsqueeze(0).to(self.device)  # (1, 1, H, W)

    def _preprocess_state(self, tf_matrix: np.ndarray) -> torch.Tensor:
        """Convert 4x4 matrix to 6D pose tensor, same as dataset."""
        pose = matrix_to_6d_pose(tf_matrix)  # (6,) float32
        return torch.from_numpy(pose).float().unsqueeze(0).to(self.device)  # (1, 6)

    @staticmethod
    def _pose_6d_to_pose_stamped(pose: np.ndarray, frame_id: str) -> PoseStamped:
        """Convert (x, y, z, roll, pitch, yaw) to a PoseStamped message."""
        from tf.transformations import quaternion_from_euler

        msg = PoseStamped()
        msg.header.stamp = rospy.Time.now()
        msg.header.frame_id = frame_id
        msg.pose.position.x = float(pose[0])
        msg.pose.position.y = float(pose[1])
        msg.pose.position.z = float(pose[2])

        q = quaternion_from_euler(float(pose[3]), float(pose[4]), float(pose[5]))
        msg.pose.orientation.x = q[0]
        msg.pose.orientation.y = q[1]
        msg.pose.orientation.z = q[2]
        msg.pose.orientation.w = q[3]
        return msg

    def reset_hidden(self) -> None:
        """Reset the GRU hidden state (call at the start of each episode)."""
        self.hidden = None
        rospy.loginfo("Hidden state reset.")

    def run(self) -> None:
        """Main loop: read latest obs, run model.step(), publish action."""
        while not rospy.is_shutdown():
            with self.lock:
                img = self._latest_image
                tf_mat = self._latest_tf_matrix

            if img is None or tf_mat is None:
                rospy.logwarn_throttle(5.0, "Waiting for image and TF data...")
                self.rate.sleep()
                continue

            # Preprocess
            image_tensor = self._preprocess_image(img)
            state_tensor = self._preprocess_state(tf_mat)

            # Inference
            with torch.no_grad():
                action_tensor, self.hidden = self.model.step(
                    image_tensor, state_tensor, self.hidden
                )

            # action_tensor is (1, action_dim)
            action = action_tensor.squeeze(0).cpu().numpy()

            # If delta mode, add current state to get absolute target pose
            if self.delta_actions:
                current_pose = matrix_to_6d_pose(tf_mat)
                action = current_pose + action

            # Publish
            pose_msg = self._pose_6d_to_pose_stamped(action, self.parent_frame)
            self.action_pub.publish(pose_msg)

            self.rate.sleep()


def main() -> None:
    parser = argparse.ArgumentParser(description="Deploy BC-RNN policy as a ROS node")
    parser.add_argument(
        "--config",
        type=str,
        default="config/ros_node_params.yaml",
        help="Path to YAML config file",
    )
    args = parser.parse_args()

    with open(args.config, "r") as f:
        config = yaml.safe_load(f)

    rospy.init_node("bc_rnn_deploy", anonymous=True)
    node = BCRNNDeployNode(config)
    node.run()


if __name__ == "__main__":
    main()
