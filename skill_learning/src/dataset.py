"""PyTorch Dataset for BC-RNN training from rosbag or synced .npy data."""

from __future__ import annotations

import glob
import os

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


def _trim_static_ends(
    images: list,
    poses: list,
    window: int = 5,
    threshold: float = 1e-4,
) -> tuple[list, list]:
    """Remove static (non-moving) frames from the start and end of a trajectory.

    Uses a sliding window over the 6D pose sequence to compute variance.
    Frames are considered static when the max variance across all 6 pose
    dimensions within the window is below *threshold*.

    Args:
        images:    List of images (same length as poses).
        poses:     List of (6,) float32 arrays.
        window:    Number of frames in the sliding variance window.
        threshold: Max variance below which the gripper is considered static.

    Returns:
        Trimmed (images, poses) lists.
    """
    n = len(poses)
    if n < window:
        return images, poses

    pose_arr = np.stack(poses)  # (N, 6)

    # Compute per-frame windowed variance (max across 6 dims)
    variances = np.zeros(n)
    half_w = window // 2
    for i in range(n):
        start = max(0, i - half_w)
        end = min(n, i + half_w + 1)
        variances[i] = np.var(pose_arr[start:end], axis=0).max()

    # Find first and last frame where variance exceeds threshold
    moving = variances >= threshold
    if not np.any(moving):
        # Entire trajectory is static — return empty
        return [], []

    first = int(np.argmax(moving))
    last = int(n - 1 - np.argmax(moving[::-1]))

    images = images[first:last + 1]
    poses = poses[first:last + 1]
    return images, poses


def _load_records_from_npy(path: str, joint_name: str) -> tuple[list, list]:
    """Load images and poses from a synced .npy file.

    Returns:
        (images, poses) where images is a list of (H, W) uint8 arrays
        and poses is a list of (6,) float32 arrays.
    """
    records = np.load(path, allow_pickle=True)
    images, poses = [], []
    for r in records:
        if joint_name not in r["tf"]:
            continue
        images.append(r["obs"])
        poses.append(matrix_to_6d_pose(r["tf"][joint_name]))
    return images, poses


def _load_records_from_bag(
    path: str,
    joint_name: str,
    image_topic: str,
    tf_topic: str,
    parent_frame: str,
    sync_threshold: float,
) -> tuple[list, list]:
    """Load images and poses directly from a rosbag file.

    Returns:
        (images, poses) same format as _load_records_from_npy.
    """
    from src.utils import load_synced_from_bag

    records = load_synced_from_bag(
        bag_path=path,
        image_topic=image_topic,
        tf_topic=tf_topic,
        parent_frame=parent_frame,
        child_frame=joint_name,
        sync_threshold=sync_threshold,
    )
    images, poses = [], []
    for r in records:
        if joint_name not in r["tf"]:
            continue
        images.append(r["obs"])
        poses.append(matrix_to_6d_pose(r["tf"][joint_name]))
    return images, poses


class BCRNNDataset(Dataset):
    """Dataset for BC-RNN training.

    Each sample is a trajectory of (image, state, action) tuples, where:
      - image:  (T, 1, H, W) grayscale, normalized for ResNet
      - state:  (T, 6) 6D pose of the target joint
      - action: (T, 6) target action (delta or absolute, depending on delta_actions)

    The last timestep of each trajectory is excluded since it has no next pose.

    Supports both pre-synced .npy files and raw .bag (rosbag) files. When
    .bag files are provided, images and TF transforms are extracted and synced
    automatically (requires rosbag to be installed).

    Args:
        data_paths:  List of .npy or .bag file paths, or a directory containing
                     them. Directories are scanned for both *.npy and *.bag.
        joint_name:  TF child frame to extract pose from. Default: "hand".
        image_size:  (H, W) to resize images to. Default: (224, 224).
        seq_len:     If provided, slice trajectories into fixed-length windows.
                     If None, each trajectory is one sample (variable length).
        delta_actions: If True, actions are pose[t+1] - pose[t] (delta).
                       If False, actions are pose[t+1] (absolute). Default: True.
        rosbag_config: Dict with keys for rosbag extraction (only needed for
                       .bag files): image_topic, tf_topic, parent_frame,
                       sync_threshold. Default: None (uses .npy only).
        debug:       If True, save extracted rosbag data as .npy files.
        debug_dir:   Directory to save debug .npy files. Default: "debug/".
        trim_static: Dict with trimming config, or None to disable. Keys:
                       window - sliding window size (default 5).
                       threshold - max variance below which frames are static
                                   (default 1e-4).
        subsample:   Keep every Nth frame (1 = keep all, 2 = skip every other,
                     etc.). Applied after trimming. Default: 1.
    """

    def __init__(
        self,
        data_paths: str | list[str],
        joint_name: str = "hand",
        image_size: tuple[int, int] = (224, 224),
        seq_len: int | None = None,
        delta_actions: bool = True,
        rosbag_config: dict | None = None,
        debug: bool = False,
        debug_dir: str = "debug/",
        trim_static: dict | None = None,
        subsample: int = 1,
    ) -> None:
        # Resolve paths
        if isinstance(data_paths, str):
            if os.path.isdir(data_paths):
                npy_files = sorted(glob.glob(os.path.join(data_paths, "*.npy")))
                bag_files = sorted(glob.glob(os.path.join(data_paths, "*.bag")))
                data_paths = npy_files + bag_files
            else:
                data_paths = [data_paths]

        self.joint_name = joint_name
        self.image_size = image_size
        self.seq_len = seq_len
        self.delta_actions = delta_actions

        # Image transform: grayscale uint8 -> float, resize, normalize for ResNet
        self.img_transform = transforms.Compose([
            transforms.ToPILImage(),
            transforms.Resize(image_size),
            transforms.Grayscale(),  # ensure single channel
            transforms.ToTensor(),  # [0, 255] uint8 -> [0, 1] float, (1, H, W)
            transforms.Normalize(mean=[0.449], std=[0.226]),
        ])

        # Default rosbag config
        bag_cfg = rosbag_config or {}
        image_topic = bag_cfg.get("image_topic", "/camera/image_raw")
        tf_topic = bag_cfg.get("tf_topic", "/tf")
        parent_frame = bag_cfg.get("parent_frame", "body")
        sync_threshold = bag_cfg.get("sync_threshold", 0.05)

        # Trimming config
        self.trim_static = trim_static

        if debug:
            os.makedirs(debug_dir, exist_ok=True)

        # Load all trajectories and build index
        self.samples = []  # list of (images, states, actions) per window/trajectory
        for path in data_paths:
            ext = os.path.splitext(path)[1].lower()

            if ext == ".bag":
                images, poses = _load_records_from_bag(
                    path, joint_name, image_topic, tf_topic,
                    parent_frame, sync_threshold,
                )
                # Save debug .npy if requested
                if debug and images:
                    records = []
                    for img, pose_vec in zip(images, poses):
                        records.append({
                            "obs": img,
                            "tf": {joint_name: pose_vec},
                        })
                    bag_name = os.path.splitext(os.path.basename(path))[0]
                    debug_path = os.path.join(debug_dir, f"{bag_name}_synced.npy")
                    np.save(debug_path, np.array(records, dtype=object))
                    print(f"  [debug] Saved {len(records)} records to {debug_path}")
            elif ext == ".npy":
                images, poses = _load_records_from_npy(path, joint_name)
            else:
                print(f"  Skipping unsupported file: {path}")
                continue

            # Trim static start/end frames
            if trim_static is not None and images:
                before = len(images)
                images, poses = _trim_static_ends(
                    images, poses,
                    window=trim_static.get("window", 5),
                    threshold=trim_static.get("threshold", 1e-4),
                )
                if before != len(images):
                    print(f"  Trimmed {os.path.basename(path)}: "
                          f"{before} -> {len(images)} frames")

            # Subsample: keep every Nth frame
            if subsample > 1 and images:
                before = len(images)
                images = images[::subsample]
                poses = poses[::subsample]
                print(f"  Subsampled {os.path.basename(path)}: "
                      f"{before} -> {len(images)} frames (every {subsample})")

            if len(images) < 2:
                continue

            poses = np.stack(poses)  # (N, 6)

            if seq_len is not None:
                # Sliding window: each window of seq_len consecutive frames
                for start in range(len(images) - seq_len):
                    end = start + seq_len
                    states = poses[start:end]
                    next_poses = poses[start + 1:end + 1]
                    actions = next_poses - states if delta_actions else next_poses
                    self.samples.append((images[start:end], states, actions))
            else:
                # Full trajectory (drop last frame since no next pose)
                states = poses[:-1]
                next_poses = poses[1:]
                actions = next_poses - states if delta_actions else next_poses
                self.samples.append((images[:-1], states, actions))
        
        # Compute per-dimension action normalization stats
        if self.samples:
            all_actions = np.concatenate(
                [a for _, _, a in self.samples], axis=0
            )  # (total_frames, 6)
            self.action_mean = all_actions.mean(axis=0).astype(np.float32)  # (6,)
            self.action_std = all_actions.std(axis=0).astype(np.float32)    # (6,)
            self.action_std = np.maximum(self.action_std, 1e-8)  # avoid div-by-zero

            # Normalize stored actions in-place
            for i in range(len(self.samples)):
                imgs, states, actions = self.samples[i]
                actions = (actions - self.action_mean) / self.action_std
                self.samples[i] = (imgs, states, actions)
        else:
            self.action_mean = np.zeros(6, dtype=np.float32)
            self.action_std = np.ones(6, dtype=np.float32)

    def __len__(self) -> int:
        return len(self.samples)

    def __getitem__(self, idx: int) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
        imgs_raw, states_np, actions_np = self.samples[idx]

        # Transform images: resize, normalize
        imgs = torch.stack([
            self.img_transform(img)
            for img in imgs_raw
        ])  # (T, 1, H, W)

        states = torch.from_numpy(states_np).float()   # (T, 6)
        actions = torch.from_numpy(actions_np).float()  # (T, 6)
        return imgs, states, actions
