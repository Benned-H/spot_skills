#!/usr/bin/env python3

# /// script
# dependencies = [
#   "lerobot_robot_spot @ file:///${LEROBOT_SPOT_ROOT}",
# ]
# requires-python = ">=3.10, <3.13"
# ///

"""Run a trained LeRobot policy on the real Spot robot.

This script runs in a Python 3.10+ environment via ``uv run``. It is designed
to be called from the ROS (Python 3.8) environment via subprocess, following
the same bridge pattern used for Gemini Robotics-ER.

Communication with the parent process is via JSON lines on stdout.

Usage (standalone):
    LEROBOT_SPOT_ROOT=/path/to/lerobot-spot uv run policy_replay_service.py \
        --hostname <ip> --username <user> --password <pass> \
        --pretrained-path <path> --dataset-path <path>
"""

from __future__ import annotations

import argparse
import json
import signal
import sys
import time
from pathlib import Path

import numpy as np
import torch

from lerobot.configs.policies import PreTrainedConfig
from lerobot.datasets.lerobot_dataset import LeRobotDatasetMetadata
from lerobot.datasets.utils import build_dataset_frame
from lerobot.policies.act.modeling_act import ACTPolicy  # noqa: F401 — registers 'act'
from lerobot.policies.factory import make_policy, make_pre_post_processors
from lerobot.policies.utils import make_robot_action
from lerobot.utils.constants import ACTION, OBS_STR
from lerobot.utils.control_utils import predict_action
from lerobot.utils.utils import get_safe_torch_device

from lerobot_robot_spot import SpotRobot, SpotRobotConfig


def emit_json(data: dict) -> None:
    """Print a single-line JSON message to stdout for the parent process."""
    print(json.dumps(data, default=str).replace("\n", ""), flush=True)  # noqa: T201


def emit_error(message: str) -> None:
    """Emit an error JSON message and exit."""
    emit_json({"type": "error", "success": False, "error": message})
    sys.exit(1)


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Replay a trained LeRobot policy on Spot")
    p.add_argument("--hostname", required=True)
    p.add_argument("--username", required=True)
    p.add_argument("--password", required=True)
    p.add_argument(
        "--image-sources",
        nargs="+",
        default=["frontleft_fisheye_image", "frontright_fisheye_image", "hand_color_image"],
    )
    p.add_argument("--image-width", type=int, default=640)
    p.add_argument("--image-height", type=int, default=480)
    p.add_argument(
        "--pretrained-path",
        required=True,
        help="Path to pretrained model dir",
    )
    p.add_argument(
        "--dataset-path",
        required=True,
        help="Full path to training dataset",
    )
    p.add_argument("--device", default="cuda", help="Inference device: cuda or cpu")
    p.add_argument("--fps", type=int, default=10)
    p.add_argument("--episode-time-s", type=float, default=30.0)
    p.add_argument("--task", type=str, default=None)
    return p.parse_args()


def main() -> None:
    args = parse_args()

    # Flag set by SIGINT handler for graceful shutdown
    stop_requested = False

    def handle_sigint(_signum: int, _frame: object) -> None:
        nonlocal stop_requested
        stop_requested = True

    signal.signal(signal.SIGINT, handle_sigint)

    try:
        # ── Load policy ───────────────────────────────────────────────────────
        print(f"Loading policy from {args.pretrained_path} ...", flush=True)  # noqa: T201
        policy_cfg = PreTrainedConfig.from_pretrained(args.pretrained_path)
        policy_cfg.pretrained_path = args.pretrained_path
        policy_cfg.device = args.device

        dataset_path = Path(args.dataset_path)
        repo_id = "/".join(dataset_path.parts[-2:])
        ds_meta = LeRobotDatasetMetadata(repo_id, root=dataset_path)

        policy = make_policy(policy_cfg, ds_meta=ds_meta)
        policy.eval()

        preprocessor, postprocessor = make_pre_post_processors(
            policy_cfg=policy_cfg,
            pretrained_path=args.pretrained_path,
            preprocessor_overrides={"device_processor": {"device": args.device}},
        )

        device = get_safe_torch_device(args.device)
        ds_features = ds_meta.features
        print(f"Policy loaded. Action dim: {ds_features[ACTION]['shape']}", flush=True)  # noqa: T201

        # ── Connect robot ─────────────────────────────────────────────────────
        cfg = SpotRobotConfig(
            hostname=args.hostname,
            username=args.username,
            password=args.password,
            image_sources=args.image_sources,
            image_width=args.image_width,
            image_height=args.image_height,
        )
        robot = SpotRobot(cfg)
        print("Connecting to Spot ...", flush=True)  # noqa: T201
        robot.connect()
        print(f"Connected: {robot.is_connected}", flush=True)  # noqa: T201

        emit_json({"type": "started", "fps": args.fps, "episode_time_s": args.episode_time_s})

        # ── Control loop ──────────────────────────────────────────────────────
        loop_dt = 1.0 / float(args.fps)

        policy.reset()
        preprocessor.reset()
        postprocessor.reset()

        t0 = time.perf_counter()
        step = 0

        while time.perf_counter() - t0 < args.episode_time_s and not stop_requested:
            t_start = time.perf_counter()

            obs = robot.get_observation()
            obs_frame = build_dataset_frame(ds_features, obs, OBS_STR)

            with torch.no_grad():
                action_tensor = predict_action(
                    observation=obs_frame,
                    policy=policy,
                    device=device,
                    preprocessor=preprocessor,
                    postprocessor=postprocessor,
                    use_amp=False,
                    task=args.task,
                    robot_type=robot.name,
                )

            if step == 0:
                print(f"[debug] raw action tensor: {action_tensor}", flush=True)  # noqa: T201
                for k, v in obs_frame.items():
                    print(f"[debug] obs_frame[{k}]: shape={v.shape}, dtype={v.dtype}", flush=True)  # noqa: T201

            if torch.any(torch.isnan(action_tensor)):
                print(f"[warn] NaN in action at step {step}, skipping", flush=True)  # noqa: T201
                continue

            action_dict = make_robot_action(action_tensor, ds_features)
            robot.send_action(action_dict)

            step += 1
            elapsed = time.perf_counter() - t_start
            sleep_t = loop_dt - elapsed
            if sleep_t > 0:
                time.sleep(sleep_t)

            if step % (args.fps * 5) == 0:
                elapsed_total = time.perf_counter() - t0
                emit_json({
                    "type": "step",
                    "step": step,
                    "elapsed_s": round(elapsed_total, 1),
                    "vx": round(action_dict.get("base.vx", 0), 3),
                    "arm_x": round(action_dict.get("arm.pose.x", 0), 3),
                })

        total_time = time.perf_counter() - t0
        emit_json({
            "type": "completed",
            "success": True,
            "total_steps": step,
            "total_time_s": round(total_time, 1),
            "stopped_early": stop_requested,
        })

    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        if exc_tb is None:
            file_line = ""
        else:
            exc_file = Path(exc_tb.tb_frame.f_code.co_filename).name
            exc_line = exc_tb.tb_lineno
            file_line = f" ({exc_file}, line {exc_line})"
        emit_error(f"{type(e).__name__}: {e!s}{file_line}")

    finally:
        # Send zero-velocity stop and disconnect
        print("Sending zero-velocity command and disconnecting ...", flush=True)  # noqa: T201
        try:
            obs = robot.get_observation()
            stop_action = {
                "base.vx": 0.0,
                "base.vy": 0.0,
                "base.vyaw": 0.0,
                **{k: float(obs[k]) for k in obs if k.startswith("arm.pose.")},
            }
            robot.send_action(stop_action)
        except Exception:
            pass
        try:
            robot.disconnect_keep_powered()
        except Exception:
            pass
        print("Done.", flush=True)  # noqa: T201


if __name__ == "__main__":
    main()
