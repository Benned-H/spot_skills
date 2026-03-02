"""PyTorch Dataset for BC-RNN training from synced rosbag data."""

from __future__ import annotations

import glob
import os

import cv2
import numpy as np
import torch
from torch.utils.data import Dataset
from torchvision import transforms


def matrix_to_6d_pose(mat: np.ndarray) -> np.ndarray:
    """Extract 6D pose (x, y, z, roll, pitch, yaw) from a 4x4 transform matrix."""
    pos = mat[:3, 3]
    R = mat[:3, :3]
    # ZYX euler angles (roll, pitch, yaw)
    pitch = np.arctan2(-R[2, 0], np.sqrt(R[0, 0] ** 2 + R[1, 0] ** 2))
    if np.abs(np.cos(pitch)) < 1e-6:
        # Gimbal lock
        yaw = 0.0
        roll = np.arctan2(R[0, 1], R[1, 1])
    else:
        yaw = np.arctan2(R[1, 0], R[0, 0])
        roll = np.arctan2(R[2, 1], R[2, 2])
    return np.array([pos[0], pos[1], pos[2], roll, pitch, yaw], dtype=np.float32)


class BCRNNDataset(Dataset):
    """Dataset for BC-RNN training.

    Each sample is a trajectory of (image, state, action) tuples, where:
      - image:  (T, 3, H, W) normalized for ResNet
      - state:  (T, 6) 6D pose of the target joint
      - action: (T, 6) 6D pose at the next timestep (target)

    The last timestep of each trajectory is excluded since it has no next pose.

    Args:
        data_paths:  List of synced .npy file paths (from utils.sync_image_tf),
                     or a directory containing them.
        joint_name:  TF child frame to extract pose from. Default: "hand".
        image_size:  (H, W) to resize images to. Default: (224, 224).
        seq_len:     If provided, slice trajectories into fixed-length windows.
                     If None, each trajectory is one sample (variable length).
    """

    def __init__(
        self,
        data_paths: str | list[str],
        joint_name: str = "hand",
        image_size: tuple[int, int] = (224, 224),
        seq_len: int | None = None,
    ) -> None:
        # Resolve paths
        if isinstance(data_paths, str):
            if os.path.isdir(data_paths):
                data_paths = sorted(glob.glob(os.path.join(data_paths, "*.npy")))
            else:
                data_paths = [data_paths]

        self.joint_name = joint_name
        self.image_size = image_size
        self.seq_len = seq_len

        # Image transform: BGR uint8 -> RGB float, resize, normalize for ResNet
        self.img_transform = transforms.Compose([
            transforms.ToPILImage(),
            transforms.Resize(image_size),
            transforms.ToTensor(),  # [0, 255] uint8 -> [0, 1] float, HWC -> CHW
            transforms.Normalize(
                mean=[0.485, 0.456, 0.406],
                std=[0.229, 0.224, 0.225],
            ),
        ])

        # Load all trajectories and build index
        self.samples = []  # list of (images, states, actions) per window/trajectory
        for path in data_paths:
            records = np.load(path, allow_pickle=True)
            images, poses = [], []
            for r in records:
                if joint_name not in r["tf"]:
                    continue
                images.append(r["obs"])
                poses.append(matrix_to_6d_pose(r["tf"][joint_name]))

            if len(images) < 2:
                continue

            images = images  # list of (H, W, 3) BGR uint8
            poses = np.stack(poses)  # (N, 6)

            if seq_len is not None:
                # Sliding window: each window of seq_len consecutive frames
                for start in range(len(images) - seq_len):
                    end = start + seq_len
                    self.samples.append((
                        images[start:end],
                        poses[start:end],
                        poses[start + 1:end + 1],
                    ))
            else:
                # Full trajectory (drop last frame since no next pose)
                self.samples.append((
                    images[:-1],
                    poses[:-1],
                    poses[1:],
                ))

    def __len__(self) -> int:
        return len(self.samples)

    def __getitem__(self, idx: int) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
        imgs_raw, states_np, actions_np = self.samples[idx]

        # Transform images: BGR -> RGB, resize, normalize
        imgs = torch.stack([
            self.img_transform(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
            for img in imgs_raw
        ])  # (T, 3, H, W)

        states = torch.from_numpy(states_np).float()   # (T, 6)
        actions = torch.from_numpy(actions_np).float()  # (T, 6)
        return imgs, states, actions
