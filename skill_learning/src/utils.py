"""
Utilities for skill learning.

Usage:
    Saving images as PNGs:
    python skill_learning/utils.py traj_0.bag /spot/camera/frontleft/image image ./output/traj_
0/camera

"""

from __future__ import annotations

import argparse
import os

import cv2
import matplotlib.pyplot as plt
import numpy as np
import rosbag
from cv_bridge import CvBridge
from geometry_msgs.msg import TransformStamped


def read_bag_topic(bag_path: str, topic: str) -> list[tuple[float, object]]:
    """Read all messages from a single topic in a rosbag.

    Returns:
        List of (timestamp_sec, msg) tuples in chronological order.
    """
    messages = []
    with rosbag.Bag(bag_path, "r") as bag:
        for _, msg, t in bag.read_messages(topics=[topic]):
            messages.append((t.to_sec(), msg))
    return messages


# ---------------------------------------------------------------------------
# TF helpers
# ---------------------------------------------------------------------------

def _quaternion_to_matrix(q) -> np.ndarray:
    x, y, z, w = q.x, q.y, q.z, q.w
    return np.array([
        [1 - 2*(y**2 + z**2), 2*(x*y - z*w),      2*(x*z + y*w)     ],
        [2*(x*y + z*w),       1 - 2*(x**2 + z**2), 2*(y*z - x*w)     ],
        [2*(x*z - y*w),       2*(y*z + x*w),       1 - 2*(x**2 + y**2)],
    ])


def transform_to_matrix(transform: TransformStamped) -> np.ndarray:
    """Convert a TransformStamped to a 4x4 homogeneous transformation matrix."""
    t = transform.transform.translation
    mat = np.eye(4)
    mat[:3, :3] = _quaternion_to_matrix(transform.transform.rotation)
    mat[:3, 3] = [t.x, t.y, t.z]
    return mat


# ---------------------------------------------------------------------------
# Saving functions
# ---------------------------------------------------------------------------

def save_tf_topic_as_npy(
    bag_path: str,
    topic: str,
    output_path: str,
    parent_frame: str = "map",
    child_frame: str = None,
) -> None:
    """Read TF messages from a rosbag and save as a list of dicts in one .npy.

    Filtering rules:
      - parent_frame + child_frame : only that specific frame pair.
      - parent_frame only           : all children of that parent.
      - neither                     : parent_frame defaults to 'map'.

    Produces a single .npy file (loaded with np.load(..., allow_pickle=True))
    containing a list of dicts, each with:
      - "parent_frame": str
      - "child_frame":  str
      - "timestamp":    float (seconds)
      - "matrix":       np.ndarray, shape (4, 4), float64

    Args:
        bag_path:      Path to the .bag file.
        topic:         TF topic, e.g. '/tf' or '/tf_static'.
        output_path:   Output .npy file path.
        parent_frame:  Keep only transforms whose header.frame_id matches.
                       Defaults to 'map'.
        child_frame:   If provided, additionally filter by child_frame_id.
    """
    messages = read_bag_topic(bag_path, topic)

    # Group transforms by timestamp: each entry is a dict mapping
    # child_frame_id -> 4x4 matrix (transform from parent_frame to that child).
    from collections import OrderedDict
    timestamped: OrderedDict[float, dict[str, np.ndarray]] = OrderedDict()

    for t, msg in messages:
        for tf_stamped in msg.transforms:
            if tf_stamped.header.frame_id != parent_frame:
                continue
            if child_frame is not None and tf_stamped.child_frame_id != child_frame:
                continue
            if t not in timestamped:
                timestamped[t] = {}
            timestamped[t][tf_stamped.child_frame_id] = transform_to_matrix(tf_stamped)

    # Build list of {"timestamp": float, "transforms": {child_name: 4x4 matrix}}
    records = []
    for t, transforms in timestamped.items():
        records.append({"timestamp": t, "transforms": transforms})

    np.save(output_path, np.array(records, dtype=object))

    all_children = set()
    for r in records:
        all_children.update(r["transforms"].keys())
    child_label = ", ".join(sorted(all_children)) if all_children else "none"
    print(f"Saved {len(records)} timesteps "
          f"({parent_frame} → {child_label}) to {output_path}")


def save_image_topic_as_images(
    bag_path: str,
    topic: str,
    output_dir: str,
) -> None:
    """Read image messages from a rosbag and save them as PNG files.

    Handles both sensor_msgs/Image and sensor_msgs/CompressedImage.
    Images are named sequentially (00000.png, 00001.png, …) and a companion
    timestamps.npy (shape (N,), float64 seconds) is written to output_dir.

    Args:
        bag_path:   Path to the .bag file.
        topic:      Camera topic, e.g. '/camera/image_raw'.
        output_dir: Directory in which to save the images.
    """
    os.makedirs(output_dir, exist_ok=True)
    bridge = CvBridge()
    messages = read_bag_topic(bag_path, topic)
    timestamps = []

    for i, (t, msg) in enumerate(messages):
        if msg._type == "sensor_msgs/CompressedImage":
            buf = np.frombuffer(msg.data, np.uint8)
            img = cv2.imdecode(buf, cv2.IMREAD_COLOR)
        else:
            img = bridge.imgmsg_to_cv2(msg, desired_encoding="bgr8")

        cv2.imwrite(os.path.join(output_dir, f"{i:05d}.png"), img)
        timestamps.append(t)

    np.save(os.path.join(output_dir, "timestamps.npy"), np.array(timestamps))
    print(f"Saved {len(messages)} images to {output_dir}/")


# ---------------------------------------------------------------------------
# Synchronization
# ---------------------------------------------------------------------------

def sync_image_tf(
    image_dir: str,
    tf_npy_path: str,
    output_path: str,
    threshold: float = 0.05,
) -> None:
    """Pair each image with the closest TF record by timestamp.

    Uses image timestamps as reference. For each image, finds the TF record
    with the smallest time difference and includes the pair only if the gap
    is within *threshold* seconds.

    Produces a single .npy file (loaded with np.load(..., allow_pickle=True))
    containing a list of dicts in timestamp order, each with:
      - "obs":       np.ndarray, the image (H, W, 3), uint8 BGR
      - "tf":        dict, {child_frame_name: 4x4 matrix} (same as in tf.npy)
      - "timestamp": float, the image timestamp (seconds)

    Args:
        image_dir:   Directory containing numbered PNGs and timestamps.npy
                     (as produced by save_image_topic_as_images).
        tf_npy_path: Path to the .npy file produced by save_tf_topic_as_npy.
        output_path: Where to save the synchronized .npy file.
        threshold:   Maximum allowed time gap (seconds) between an image and
                     its matched TF record. Pairs exceeding this are dropped.
    """
    # Load image timestamps and TF records
    img_timestamps = np.load(os.path.join(image_dir, "timestamps.npy"))
    tf_records = np.load(tf_npy_path, allow_pickle=True)
    tf_timestamps = np.array([r["timestamp"] for r in tf_records])

    # List image files in order
    img_files = sorted(
        f for f in os.listdir(image_dir) if f.endswith(".png")
    )

    paired = []
    for i, img_t in enumerate(img_timestamps):
        # Find closest TF timestamp
        idx = np.argmin(np.abs(tf_timestamps - img_t))
        gap = abs(tf_timestamps[idx] - img_t)
        if gap > threshold:
            continue

        img = cv2.imread(os.path.join(image_dir, img_files[i]))
        paired.append({
            "obs": img,
            "tf": tf_records[idx]["transforms"],
            "timestamp": float(img_t),
        })

    np.save(output_path, np.array(paired, dtype=object))
    print(f"Synced {len(paired)}/{len(img_timestamps)} image-TF pairs "
          f"(threshold={threshold}s) to {output_path}")


# ---------------------------------------------------------------------------
# Visualization
# ---------------------------------------------------------------------------

def visualize_tf_npy(npy_path: str, child_frame: str = None, relative: bool = True) -> None:
    """Plot 3D trajectories from a saved TF .npy file.

    Args:
        npy_path:    Path to the .npy file produced by save_tf_topic_as_npy.
        child_frame: If provided, only visualize this child frame. Otherwise
                     plot all child frames found in the data.
        relative:    If True, show transforms relative to the first timestep
                     (like rosbag_to_transforms.py). If False, show absolute.
    """
    records = np.load(npy_path, allow_pickle=True)

    # Collect per-child-frame trajectories: {name: list of 4x4 matrices}
    trajectories: dict[str, list[np.ndarray]] = {}
    for r in records:
        for name, matrix in r["transforms"].items():
            if child_frame is not None and name != child_frame:
                continue
            trajectories.setdefault(name, []).append(matrix)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection="3d")
    ax.set_xlabel("X")
    ax.set_ylabel("Y")
    ax.set_zlabel("Z")

    for name, matrices in trajectories.items():
        if relative:
            inv_initial = np.linalg.inv(matrices[0])
            matrices = [inv_initial @ m for m in matrices]

        positions = np.array([m[:3, 3] for m in matrices])
        ax.plot(positions[:, 0], positions[:, 1], positions[:, 2], label=name)

        # Draw orientation axes at evenly spaced keyframes
        n = len(matrices)
        step = max(1, n // 20)
        scale = 0.05
        for i in range(0, n, step):
            origin = matrices[i][:3, 3]
            rot = matrices[i][:3, :3]
            ax.plot(*zip(origin, origin + scale * rot[:, 0]), "r-", linewidth=0.5)
            ax.plot(*zip(origin, origin + scale * rot[:, 1]), "g-", linewidth=0.5)
            ax.plot(*zip(origin, origin + scale * rot[:, 2]), "b-", linewidth=0.5)

    ax.legend()
    ax.set_title(f"TF trajectories ({'relative' if relative else 'absolute'})")
    plt.tight_layout()
    plt.show()


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract / visualize ROS topics from bag files."
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    # --- save command ---
    sp_save = subparsers.add_parser("save", help="Extract a topic from a bag and save to disk.")
    sp_save.add_argument("bag", help="Path to the .bag file.")
    sp_save.add_argument("topic", help="ROS topic name to extract (e.g. /tf, /camera/image_raw).")
    sp_save.add_argument(
        "type",
        choices=["tf", "image"],
        help="Data type: 'tf' saves 4x4 matrices as .npy; 'image' saves PNG frames.",
    )
    sp_save.add_argument("save_path", help="Output folder (created if it does not exist).")
    sp_save.add_argument(
        "--parent-frame",
        default=None,
        help="(tf only) Filter by parent frame (header.frame_id). Defaults to 'map'.",
    )
    sp_save.add_argument(
        "--child-frame",
        default=None,
        help="(tf only) Filter to a specific child_frame_id.",
    )

    # --- sync command ---
    sp_sync = subparsers.add_parser("sync", help="Pair images with closest TF records.")
    sp_sync.add_argument("image_dir", help="Directory with PNGs and timestamps.npy.")
    sp_sync.add_argument("tf_npy", help="Path to tf.npy from the save command.")
    sp_sync.add_argument("output", help="Output .npy file path.")
    sp_sync.add_argument(
        "--threshold",
        type=float,
        default=0.05,
        help="Max time gap (seconds) for pairing. Default: 0.05.",
    )

    # --- visualize command ---
    sp_viz = subparsers.add_parser("visualize", help="Plot 3D trajectories from a saved TF .npy.")
    sp_viz.add_argument("npy", help="Path to the .npy file produced by the save command.")
    sp_viz.add_argument(
        "--child-frame",
        default=None,
        help="Only visualize this child frame.",
    )
    sp_viz.add_argument(
        "--absolute",
        action="store_true",
        help="Show absolute transforms instead of relative to the first timestep.",
    )

    args = parser.parse_args()

    if args.command == "save":
        os.makedirs(args.save_path, exist_ok=True)
        if args.type == "tf":
            output_path = os.path.join(args.save_path, "tf.npy")
            parent = args.parent_frame if args.parent_frame is not None else "map"
            save_tf_topic_as_npy(
                args.bag, args.topic, output_path,
                parent_frame=parent, child_frame=args.child_frame,
            )
        else:
            save_image_topic_as_images(args.bag, args.topic, args.save_path)

    elif args.command == "sync":
        sync_image_tf(
            args.image_dir, args.tf_npy, args.output,
            threshold=args.threshold,
        )

    elif args.command == "visualize":
        visualize_tf_npy(
            args.npy,
            child_frame=args.child_frame,
            relative=not args.absolute,
        )


if __name__ == "__main__":
    main()
