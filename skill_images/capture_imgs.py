#!/usr/bin/env python3
"""capture_skill_sequences.py

Interactive data‑collection utility for Boston Dynamics Spot front cameras.

* Walks through five predefined **skill sequences** (hard‑coded below).
* Every **step** (including *step 0*) pauses so you can tele‑operate Spot and
  press **ENTER** when the view is framed.
* Captures front‑left & front‑right fisheye images via the Spot SDK, stitches
  them side‑by‑side with Pillow, and saves a single JPEG.
* Lets you **retake** a capture immediately (type **y** then ENTER).
* Persists a nested dictionary exactly as requested and checkpoints it to
  *skill_sequences.yaml* so a rerun continues where you left off.
* Step 0 is stored with `success: None` **but treated as successful** – two
  images are taken (before & after).

Requirements
------------
```bash
pip install pyyaml pillow bosdyn‑client
```
The script assumes you have an authenticated `bosdyn.client.robot.Robot` on
Spot’s network. See inline TODOs for hostname & credentials.
"""
from __future__ import annotations

import datetime as _dt
import os
import sys
import time
import io
from pathlib import Path
from typing import Dict, List, Tuple, Optional

import yaml
from PIL import Image
from stitch_front_images_distortion import stitch


try:
    # Spot SDK imports
    import bosdyn.client.util as bdu
    from bosdyn.client import create_standard_sdk, Robot
    from bosdyn.client.image import ImageClient, build_image_request
    from bosdyn.api import image_pb2
except ImportError:
    print("[WARN] Spot SDK not found – running in dry‑run mode.")
    Robot = None  # type: ignore

###############################################################################
# User‑adjustable parameters                                                   #
###############################################################################
YAML_PATH = Path("skill_sequences.yaml")
IMAGE_ROOT = Path("skill_images")
IMAGE_ROOT.mkdir(exist_ok=True)

# Front fisheye image sources (Spot 4.0+ names)
IMAGE_SOURCES = ['frontright_fisheye_image', 'frontleft_fisheye_image']
JPEG_QUALITY = 100

ROBOT_HOSTNAME = os.environ.get("SPOT_HOST", "138.16.161.21")
ROBOT_USERNAME = os.environ.get("SPOT_USER", "user")
ROBOT_PASSWORD = os.environ.get("SPOT_PW", "bigbubbabigbubba")
###############################################################################

Skill = Tuple[str, bool]  # (skill_string, success_flag)
Sequence = List[Skill]

SEQUENCES: List[Sequence] = [
    # seq 1
    [
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", True),
        ("GoTo(Table)", True),
        ("Pick(Eraser)", False),
        ("GoTo(Cabinet)", True),
        ("Open(Cabinet)", True),
        ("Pick(Eraser)", True),
        ("Close(Cabinet)", False),
        ("GoTo(WhiteBoard)", True),
        ("Erase(Eraser, WhiteBoard)", True),
    ],
    # seq 2
    [
        ("GoTo(Cabinet)", True),
        ("Open(Cabinet)", True),
        ("Erase(Eraser, WhiteBoard)", False),
        ("Pick(Eraser)", True),
        ("Close(Cabinet)", False),
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
    # seq 3
    [
        ("Open(Cabinet)", False),
        ("OpenDoor(Door)", False),
        ("Close(Cabinet)", False),
        ("GoTo(Door)", True),
        ("GoTo(Table)", True),
        ("Close(Cabinet)", False),
        ("Open(Cabinet)", False),
        ("Pick(Eraser)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
    # seq 4
    [
        ("GoTo(Table)", True),
        ("GoTo(Cabinet)", True),
        ("Close(Cabinet)", False),
        ("Pick(Eraser)", False),
        ("Open(Cabinet)", True),
        ("Pick(Eraser)", True),
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", False),
        ("GoTo(WhiteBoard)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
    # seq 5
    [
        ("Close(Cabinet)", False),
        ("GoTo(Table)", True),
        ("Open(Cabinet)", False),
        ("Close(Cabinet)", False),
        ("GoTo(Cabinet)", True),
        ("Open(Cabinet)", True),
        ("Pick(Eraser)", True),
        ("Close(Cabinet)", False),
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
]

###############################################################################
# Spot helpers                                                                 #
###############################################################################

def connect_to_robot() -> Optional[Robot]:
    """Return a live Robot or None if SDK unavailable."""
    if Robot is None:
        return None
    sdk = create_standard_sdk("skill_seq_capture")
    robot = sdk.create_robot(ROBOT_HOSTNAME)
    bdu.authenticate(robot)
    robot.sync_with_directory()
    robot.time_sync.wait_for_sync()
    robot.hostname = ROBOT_HOSTNAME
    return robot


class ImageCapturer:
    """Wraps Spot ImageClient; falls back to dummy color bars in dry‑run."""

    def __init__(self, robot: Optional[Robot]):
        self.robot = robot
        self.client: Optional[ImageClient] = None
        if robot is not None:
            self.client = robot.ensure_client(ImageClient.default_service_name)

    def _grab_pil_pair(self) -> Tuple[Image.Image, Image.Image]:
        if self.client is None:
            # Dry‑run: generate placeholder images
            import numpy as np
            w, h = 640, 480
            arr1 = np.full((h, w, 3), (255, 0, 0), dtype=np.uint8)
            arr2 = np.full((h, w, 3), (0, 255, 0), dtype=np.uint8)
            return Image.fromarray(arr1), Image.fromarray(arr2)

        reqs = [build_image_request(src, quality_percent=JPEG_QUALITY, pixel_format=image_pb2.Image.PIXEL_FORMAT_RGB_U8) for src in IMAGE_SOURCES]
        responses = self.client.get_image_async(reqs, timeout=2.0)
        return responses
    

    def capture_and_stitch(self, save_path: Path):
        """Capture L/R and write two separate JPEGs; return their paths."""
    
        responses = self._grab_pil_pair()
        image_np = stitch(responses)
        Image.fromarray(image_np).save(save_path)



###############################################################################
# YAML persistence                                                             #
###############################################################################

def load_yaml() -> Dict:
    if YAML_PATH.exists():
        with open(YAML_PATH, "r") as f:
            return yaml.safe_load(f) or {}
    return {}


def save_yaml(data: Dict):
    with open(YAML_PATH, "w") as f:
        yaml.safe_dump(data, f, sort_keys=False, default_flow_style=True)
###############################################################################
# Progress helpers                                                             #
###############################################################################

def find_resume_point(data: Dict) -> Tuple[int, int]:
    """Return (seq_idx, step_idx) to resume from (both 0‑based)."""
    for s_idx, seq in enumerate(SEQUENCES):
        task_key = f"seq_{s_idx+1}"
        if task_key not in data:
            return s_idx, 0
        steps = data[task_key]
        # If step not yet logged, resume there
        for st_idx in range(len(seq) + 1):  # +1 for step 0
            if str(st_idx) not in steps:
                return s_idx, st_idx
    return len(SEQUENCES), 0  # done

###############################################################################
# Main routine                                                                 #
###############################################################################

def main():
    data = load_yaml()
    seq_i, step_i = find_resume_point(data)
    if seq_i >= len(SEQUENCES):
        print("All sequences complete! Nothing to do.")
        return

    robot = connect_to_robot()
    capturer = ImageCapturer(robot)

    for s_idx in range(seq_i, len(SEQUENCES)):
        task_key = f"seq_{s_idx+1}"
        seq = SEQUENCES[s_idx]
        data.setdefault(task_key, {})
        print(f"\n=== Starting {task_key} ===")
        # ─── make a folder for this sequence ───
        sequence_dir = IMAGE_ROOT / task_key
        sequence_dir.mkdir(exist_ok=True)
        for st_idx in range((step_i if s_idx == seq_i else 0), len(seq) + 1):
            # step 0 has no skill string / success flag from list
            if st_idx == 0:
                skill_str = None
                success: Optional[bool] = None
                # skill_str = "None"
                # success   = "None"
            else:
                skill_str, success_flag = seq[st_idx - 1]
                skill_str = skill_str
                success = success_flag
            step_dict = {}
            print(f"\n[{task_key} | step {st_idx}] Skill: {skill_str if skill_str else 'INITIAL'} | success label: {success}")

            # Determine number of captures wanted
            captures: List[str] = []
            capture_labels = ("img",)        # single capture name for every step
            for cap_label in capture_labels:
                while True:
                    input(f"Press ENTER to take {cap_label} snapshot…")
                    # ts = _dt.datetime.now().strftime("%H%M%S_%f")
                    img_name = f"{task_key}_step{st_idx}_{cap_label}.jpg"
                    img_path = sequence_dir / img_name
                    # left_path, right_path = capturer.capture_and_stitch(img_path)
                    capturer.capture_and_stitch(img_path)
                    # print(f"Saved left  ⇒ {left_path}")
                    # print(f"Saved right ⇒ {right_path}")
                    print(f'Saved ⇒ {str(img_path)}')
                    # step_dict["left_image"]  = left_path
                    # step_dict["right_image"] = right_path
                    step_dict['image'] = str(img_path)


                    again = input("Retake? [y/N]: ").strip().lower()
                    if again != "y":
                        captures.append(str(img_path))
                        break  # go to next capture / finished
            # record to dict
            step_dict["skill"] = skill_str
            # step_dict["images"] = captures[0]
            step_dict["success"] = success
            data[task_key][str(st_idx)] = step_dict
            save_yaml(data)
            print("Step saved. YAML checkpoint updated.")

        step_i = 0  # reset for next sequence
        print(f"=== Finished {task_key} ===\n")

    print("\nAll sequences finished! Data stored in", YAML_PATH)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nInterrupted – progress saved to YAML. Bye!")
