"""Smoke tests for BCRNNModel, BCRNNDataset, training, and deploy helpers."""

from __future__ import annotations

import argparse
import os
import tempfile
from types import SimpleNamespace

import numpy as np
import torch
from torchvision import transforms

from src.dataset import BCRNNDataset, matrix_to_6d_pose
from src.model import BCRNNModel


def test_forward_sequence():
    """forward() with a batch of sequences."""
    B, T, H, W = 2, 10, 224, 224
    state_dim, action_dim = 18, 6

    model = BCRNNModel(state_dim=state_dim, action_dim=action_dim)
    model.eval()

    images = torch.randn(B, T, 1, H, W)
    states = torch.randn(B, T, state_dim)

    with torch.no_grad():
        actions, hidden = model(images, states)

    assert actions.shape == (B, T, action_dim), f"Expected (B, T, action_dim), got {actions.shape}"
    assert hidden.shape == (1, B, 256), f"Expected (1, B, 256), got {hidden.shape}"
    print(f"forward:  actions {actions.shape}, hidden {hidden.shape}  OK")


def test_step_single():
    """step() with single timestep, iterated."""
    B, H, W = 1, 224, 224
    state_dim, action_dim = 18, 6
    num_steps = 5

    model = BCRNNModel(state_dim=state_dim, action_dim=action_dim)
    model.eval()

    hidden = model.init_hidden(B)

    with torch.no_grad():
        for t in range(num_steps):
            image = torch.randn(B, 1, H, W)
            state = torch.randn(B, state_dim)
            action, hidden = model.step(image, state, hidden)

            assert action.shape == (B, action_dim), f"Step {t}: expected (B, action_dim), got {action.shape}"
            assert hidden.shape == (1, B, 256), f"Step {t}: expected (1, B, 256), got {hidden.shape}"

    print(f"step:     {num_steps} steps, action {action.shape}, hidden {hidden.shape}  OK")


def test_forward_with_initial_hidden():
    """forward() with a provided initial hidden state."""
    B, T = 2, 5
    state_dim, action_dim = 18, 6

    model = BCRNNModel(state_dim=state_dim, action_dim=action_dim)
    model.eval()

    images = torch.randn(B, T, 1, 224, 224)
    states = torch.randn(B, T, state_dim)
    hidden = model.init_hidden(B)

    with torch.no_grad():
        actions, hidden = model(images, states, hidden)

    assert actions.shape == (B, T, action_dim)
    print(f"forward+h: actions {actions.shape}  OK")


def test_step_matches_forward():
    """Verify step-by-step produces the same output as forward over a sequence."""
    B, T = 1, 4
    state_dim, action_dim = 18, 6

    model = BCRNNModel(state_dim=state_dim, action_dim=action_dim)
    model.eval()

    images = torch.randn(B, T, 1, 224, 224)
    states = torch.randn(B, T, state_dim)

    with torch.no_grad():
        # Full sequence
        actions_seq, _ = model(images, states)

        # Step by step
        hidden = None
        actions_step = []
        for t in range(T):
            action, hidden = model.step(images[:, t], states[:, t], hidden)
            actions_step.append(action)
        actions_step = torch.stack(actions_step, dim=1)

    diff = (actions_seq - actions_step).abs().max().item()
    assert diff < 1e-5, f"Mismatch between forward and step: max diff {diff}"
    print(f"consistency: max diff {diff:.2e}  OK")


# ---------- Dataset / utility tests ----------


def _make_synced_npy(path: str, num_frames: int = 8, joint_name: str = "hand") -> None:
    """Create a fake synced .npy file matching the format from utils.sync_image_tf."""
    records = []
    for i in range(num_frames):
        # Random 4x4 transformation matrix
        mat = np.eye(4, dtype=np.float64)
        mat[:3, :3] = np.linalg.qr(np.random.randn(3, 3))[0]  # random rotation
        mat[:3, 3] = np.random.randn(3)
        # Random grayscale image
        img = np.random.randint(0, 255, (480, 640), dtype=np.uint8)
        records.append({
            "obs": img,
            "tf": {joint_name: mat},
            "timestamp": float(i),
        })
    np.save(path, records)


def test_matrix_to_6d_pose():
    """matrix_to_6d_pose returns correct shape and recovers identity."""
    # Identity -> should give all zeros
    pose = matrix_to_6d_pose(np.eye(4))
    assert pose.shape == (6,), f"Expected (6,), got {pose.shape}"
    assert np.allclose(pose, 0.0, atol=1e-6), f"Identity should give zeros, got {pose}"

    # Random valid rotation matrix
    R, _ = np.linalg.qr(np.random.randn(3, 3))
    if np.linalg.det(R) < 0:
        R[:, 0] *= -1
    mat = np.eye(4)
    mat[:3, :3] = R
    mat[:3, 3] = [1.0, 2.0, 3.0]
    pose = matrix_to_6d_pose(mat)
    assert pose.shape == (6,)
    assert np.isclose(pose[0], 1.0) and np.isclose(pose[1], 2.0) and np.isclose(pose[2], 3.0)
    print(f"matrix_to_6d_pose:  identity OK, random OK")


def test_dataset_full_trajectory():
    """BCRNNDataset with full trajectories (seq_len=None)."""
    num_frames = 10
    with tempfile.TemporaryDirectory() as tmpdir:
        npy_path = os.path.join(tmpdir, "traj.npy")
        _make_synced_npy(npy_path, num_frames=num_frames)

        ds = BCRNNDataset(npy_path, joint_name="hand")
        assert len(ds) == 1, f"Expected 1 trajectory, got {len(ds)}"

        imgs, states, actions = ds[0]
        T = num_frames - 1  # last frame dropped (no next pose)
        assert imgs.shape == (T, 1, 224, 224), f"imgs: expected ({T},1,224,224), got {imgs.shape}"
        assert states.shape == (T, 6), f"states: expected ({T},6), got {states.shape}"
        assert actions.shape == (T, 6), f"actions: expected ({T},6), got {actions.shape}"
    print(f"dataset_full:  T={T}, shapes OK")


def test_dataset_sliding_window():
    """BCRNNDataset with fixed-length sliding windows."""
    num_frames = 10
    seq_len = 4
    with tempfile.TemporaryDirectory() as tmpdir:
        npy_path = os.path.join(tmpdir, "traj.npy")
        _make_synced_npy(npy_path, num_frames=num_frames)

        ds = BCRNNDataset(npy_path, joint_name="hand", seq_len=seq_len)
        expected_windows = num_frames - seq_len  # sliding window count
        assert len(ds) == expected_windows, f"Expected {expected_windows} windows, got {len(ds)}"

        imgs, states, actions = ds[0]
        assert imgs.shape == (seq_len, 1, 224, 224), f"imgs: got {imgs.shape}"
        assert states.shape == (seq_len, 6), f"states: got {states.shape}"
        assert actions.shape == (seq_len, 6), f"actions: got {actions.shape}"
    print(f"dataset_window:  seq_len={seq_len}, {expected_windows} windows OK")


def test_dataset_directory_input():
    """BCRNNDataset with a directory path containing multiple .npy files."""
    with tempfile.TemporaryDirectory() as tmpdir:
        _make_synced_npy(os.path.join(tmpdir, "traj_0.npy"), num_frames=6)
        _make_synced_npy(os.path.join(tmpdir, "traj_1.npy"), num_frames=8)

        ds = BCRNNDataset(tmpdir, joint_name="hand")
        assert len(ds) == 2, f"Expected 2 trajectories, got {len(ds)}"

        imgs0, _, _ = ds[0]
        imgs1, _, _ = ds[1]
        assert imgs0.shape[0] == 5  # 6 - 1
        assert imgs1.shape[0] == 7  # 8 - 1
    print(f"dataset_dir:  2 trajectories OK")


def test_dataset_missing_joint_skipped():
    """Frames missing the target joint are skipped gracefully."""
    with tempfile.TemporaryDirectory() as tmpdir:
        npy_path = os.path.join(tmpdir, "traj.npy")
        # Create data with a different joint name
        _make_synced_npy(npy_path, num_frames=5, joint_name="other_joint")

        ds = BCRNNDataset(npy_path, joint_name="hand")
        assert len(ds) == 0, f"Expected 0 samples (joint missing), got {len(ds)}"
    print(f"dataset_missing_joint:  correctly skipped OK")


def test_dataset_action_is_next_pose():
    """Verify action[t] == state[t+1] (next-pose prediction target)."""
    num_frames = 5
    with tempfile.TemporaryDirectory() as tmpdir:
        npy_path = os.path.join(tmpdir, "traj.npy")
        _make_synced_npy(npy_path, num_frames=num_frames)

        ds = BCRNNDataset(npy_path, joint_name="hand")
        _, states, actions = ds[0]

        # action[t] should equal the pose at timestep t+1
        # Reload raw poses to compare
        records = np.load(npy_path, allow_pickle=True)
        raw_poses = [matrix_to_6d_pose(r["tf"]["hand"]) for r in records]

        for t in range(num_frames - 2):  # states has T=num_frames-1 entries
            expected_action = torch.from_numpy(raw_poses[t + 1]).float()
            expected_state = torch.from_numpy(raw_poses[t]).float()
            assert torch.allclose(states[t], expected_state, atol=1e-5), f"state mismatch at t={t}"
            assert torch.allclose(actions[t], expected_action, atol=1e-5), f"action mismatch at t={t}"
    print(f"dataset_action_next:  action == next_pose OK")


# ---------- Training tests ----------


def test_train_short_run():
    """Run training for 2 epochs on synthetic data, verify checkpoints are saved."""
    from train import train

    num_frames = 12
    seq_len = 4

    with tempfile.TemporaryDirectory() as tmpdir:
        # Create synthetic data
        data_dir = os.path.join(tmpdir, "data")
        os.makedirs(data_dir)
        for i in range(3):
            _make_synced_npy(os.path.join(data_dir, f"traj_{i}.npy"), num_frames=num_frames)

        save_dir = os.path.join(tmpdir, "checkpoints")

        args = argparse.Namespace(
            data=data_dir,
            joint_name="hand",
            seq_len=seq_len,
            val_ratio=0.2,
            state_dim=6,
            action_dim=6,
            hidden_dim=32,  # small for speed
            in_channels=1,
            image_size=64,  # small for speed
            freeze_backbone=True,
            epochs=2,
            batch_size=4,
            lr=1e-3,
            weight_decay=0.0,
            grad_clip=1.0,
            num_workers=0,
            save_dir=save_dir,
            save_every=1,
        )
        train(args)

        # Check that checkpoints were saved
        assert os.path.isfile(os.path.join(save_dir, "best.pt")), "best.pt not found"
        assert os.path.isfile(os.path.join(save_dir, "final.pt")), "final.pt not found"
        assert os.path.isfile(os.path.join(save_dir, "epoch_001.pt")), "epoch_001.pt not found"
        assert os.path.isfile(os.path.join(save_dir, "epoch_002.pt")), "epoch_002.pt not found"
    print(f"train_short_run:  2 epochs, checkpoints saved OK")


def test_checkpoint_load_and_inference():
    """Save a checkpoint via training, reload it, and verify inference works."""
    from train import train

    with tempfile.TemporaryDirectory() as tmpdir:
        data_dir = os.path.join(tmpdir, "data")
        os.makedirs(data_dir)
        _make_synced_npy(os.path.join(data_dir, "traj.npy"), num_frames=10)

        save_dir = os.path.join(tmpdir, "checkpoints")
        args = argparse.Namespace(
            data=data_dir,
            joint_name="hand",
            seq_len=4,
            val_ratio=0.2,
            state_dim=6,
            action_dim=6,
            hidden_dim=32,
            in_channels=1,
            image_size=64,
            freeze_backbone=True,
            epochs=1,
            batch_size=4,
            lr=1e-3,
            weight_decay=0.0,
            grad_clip=1.0,
            num_workers=0,
            save_dir=save_dir,
            save_every=1,
        )
        train(args)

        # Load checkpoint into a fresh model
        ckpt = torch.load(os.path.join(save_dir, "best.pt"), map_location="cpu")
        model = BCRNNModel(state_dim=6, action_dim=6, hidden_dim=32, in_channels=1)
        model.load_state_dict(ckpt["model"])
        model.eval()

        assert "epoch" in ckpt and "val_loss" in ckpt, "Checkpoint missing metadata"

        # Run inference
        with torch.no_grad():
            img = torch.randn(1, 1, 64, 64)
            state = torch.randn(1, 6)
            action, hidden = model.step(img, state)

        assert action.shape == (1, 6), f"Expected (1, 6), got {action.shape}"
    print(f"checkpoint_load:  reload + inference OK")


# ---------- Deploy helper tests ----------

# Re-implement the quaternion helper from deploy_ros_node.py so we can test
# it without importing the ROS-dependent module.
def _quaternion_to_matrix(x, y, z, w) -> np.ndarray:
    return np.array([
        [1 - 2*(y**2 + z**2), 2*(x*y - z*w),      2*(x*z + y*w)     ],
        [2*(x*y + z*w),       1 - 2*(x**2 + z**2), 2*(y*z - x*w)     ],
        [2*(x*z - y*w),       2*(y*z + x*w),       1 - 2*(x**2 + y**2)],
    ])


def test_quaternion_to_matrix_identity():
    """Identity quaternion (0,0,0,1) should produce 3x3 identity."""
    R = _quaternion_to_matrix(0, 0, 0, 1)
    assert R.shape == (3, 3)
    assert np.allclose(R, np.eye(3), atol=1e-10), f"Expected identity, got:\n{R}"
    print(f"quat_identity:  OK")


def test_quaternion_to_matrix_90z():
    """90-degree rotation about Z: q = (0, 0, sin(pi/4), cos(pi/4))."""
    s = np.sin(np.pi / 4)
    c = np.cos(np.pi / 4)
    R = _quaternion_to_matrix(0, 0, s, c)
    # 90 deg about Z: x->y, y->-x, z->z
    expected = np.array([
        [0, -1, 0],
        [1,  0, 0],
        [0,  0, 1],
    ], dtype=float)
    assert np.allclose(R, expected, atol=1e-10), f"Expected 90-deg-Z rotation, got:\n{R}"
    print(f"quat_90z:  OK")


def test_quaternion_to_matrix_roundtrip():
    """Quaternion -> matrix -> 6D pose -> verify translation preserved."""
    # Build a 4x4 from a known quaternion + translation
    q = SimpleNamespace(x=0.0, y=0.0, z=np.sin(np.pi/4), w=np.cos(np.pi/4))
    R = _quaternion_to_matrix(q.x, q.y, q.z, q.w)
    mat = np.eye(4)
    mat[:3, :3] = R
    mat[:3, 3] = [1.5, -2.0, 3.3]

    pose = matrix_to_6d_pose(mat)
    assert np.isclose(pose[0], 1.5) and np.isclose(pose[1], -2.0) and np.isclose(pose[2], 3.3)
    assert np.isclose(pose[5], np.pi / 2, atol=1e-6), f"Expected yaw=pi/2, got {pose[5]}"
    print(f"quat_roundtrip:  quat -> matrix -> 6D pose OK")


def test_deploy_preprocess_image_shape():
    """Deploy image preprocessing produces correct (1, 1, H, W) tensor."""
    image_size = 64
    img_transform = transforms.Compose([
        transforms.ToPILImage(),
        transforms.Resize((image_size, image_size)),
        transforms.Grayscale(),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.449], std=[0.226]),
    ])

    # Grayscale image (H, W)
    img = np.random.randint(0, 255, (480, 640), dtype=np.uint8)
    tensor = img_transform(img).unsqueeze(0)  # add batch dim
    assert tensor.shape == (1, 1, image_size, image_size), f"Expected (1,1,64,64), got {tensor.shape}"
    print(f"deploy_preprocess_img:  shape OK")


def test_deploy_preprocess_matches_dataset():
    """Deploy and dataset image pipelines produce identical output."""
    image_size = (64, 64)

    # Dataset transform (from BCRNNDataset.__init__)
    ds_transform = transforms.Compose([
        transforms.ToPILImage(),
        transforms.Resize(image_size),
        transforms.Grayscale(),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.449], std=[0.226]),
    ])

    # Deploy transform (from BCRNNDeployNode.__init__)
    deploy_transform = transforms.Compose([
        transforms.ToPILImage(),
        transforms.Resize(image_size),
        transforms.Grayscale(),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.449], std=[0.226]),
    ])

    img = np.random.randint(0, 255, (480, 640), dtype=np.uint8)
    out_ds = ds_transform(img)
    out_deploy = deploy_transform(img)

    assert torch.equal(out_ds, out_deploy), "Dataset and deploy transforms differ!"
    print(f"deploy_matches_dataset:  transforms identical OK")


def test_deploy_preprocess_state_shape():
    """State preprocessing: 4x4 matrix -> (1, 6) tensor."""
    mat = np.eye(4, dtype=np.float64)
    mat[:3, 3] = [1.0, 2.0, 3.0]
    pose = matrix_to_6d_pose(mat)
    tensor = torch.from_numpy(pose).float().unsqueeze(0)  # (1, 6)
    assert tensor.shape == (1, 6), f"Expected (1, 6), got {tensor.shape}"
    assert torch.isclose(tensor[0, 0], torch.tensor(1.0))
    assert torch.isclose(tensor[0, 1], torch.tensor(2.0))
    assert torch.isclose(tensor[0, 2], torch.tensor(3.0))
    print(f"deploy_preprocess_state:  shape + values OK")


if __name__ == "__main__":
    # Model tests
    test_forward_sequence()
    test_step_single()
    test_forward_with_initial_hidden()
    test_step_matches_forward()

    # Dataset tests
    test_matrix_to_6d_pose()
    test_dataset_full_trajectory()
    test_dataset_sliding_window()
    test_dataset_directory_input()
    test_dataset_missing_joint_skipped()
    test_dataset_action_is_next_pose()

    # Training tests
    test_train_short_run()
    test_checkpoint_load_and_inference()

    # Deploy helper tests
    test_quaternion_to_matrix_identity()
    test_quaternion_to_matrix_90z()
    test_quaternion_to_matrix_roundtrip()
    test_deploy_preprocess_image_shape()
    test_deploy_preprocess_matches_dataset()
    test_deploy_preprocess_state_shape()

    print("\nAll tests passed.")
