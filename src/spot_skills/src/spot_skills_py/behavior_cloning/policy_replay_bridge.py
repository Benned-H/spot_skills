"""Bridge to run LeRobot policy replay from an older version of Python.

This module provides a compatibility layer that allows Python 3.8 code to run
LeRobot behavior cloning inference by spawning a subprocess with Python 3.10+.
"""

from __future__ import annotations

import json
import os
import signal
import subprocess
import threading
from pathlib import Path
from typing import IO, Any, Callable, Dict, List, Optional

from robotics_utils.ros import trigger_service

POLICY_REPLAY_SCRIPT = Path(__file__).parent / "policy_replay_service.py"

DEFAULT_LEROBOT_SPOT_ROOT = Path("/docker/spot_skills/lerobot-spot")


class PolicyReplayBridge:
    """Bridge class to run LeRobot policy replay via subprocess.

    This class works in Python 3.8 but delegates actual policy inference
    to a subprocess running Python 3.10+ with lerobot installed.
    """

    def __init__(
        self,
        lerobot_spot_root: str = str(DEFAULT_LEROBOT_SPOT_ROOT),
        log_fn: Optional[Callable[[str], None]] = None,
        warn_fn: Optional[Callable[[str], None]] = None,
    ) -> None:
        """Initialize the bridge.

        :param lerobot_spot_root: Path to the lerobot-spot package directory
        :param log_fn: Callable for info logging (defaults to print)
        :param warn_fn: Callable for warning logging (defaults to print)
        """
        self._lerobot_spot_root = lerobot_spot_root
        self._log = log_fn or print
        self._warn = warn_fn or print
        self._process = None  # type: Optional[subprocess.Popen]
        self._stdout_thread = None  # type: Optional[threading.Thread]
        self._stderr_thread = None  # type: Optional[threading.Thread]
        self._status_messages = []  # type: List[Dict[str, Any]]
        self._take_control_requested = False
        self._lock = threading.Lock()

    @property
    def is_running(self) -> bool:
        """Check if the subprocess is still running."""
        return self._process is not None and self._process.poll() is None

    def start(
        self,
        hostname: str,
        username: str,
        password: str,
        dataset_path: str,
        model_name: str = None,
        pretrained_path: str = None,
        device: str = "cuda",
        fps: int = 10,
        episode_time_s: float = 15.0,
        image_sources: Optional[List[str]] = None,
        image_width: int = 640,
        image_height: int = 480,
        task: Optional[str] = None,
    ) -> None:
        """Launch the policy replay subprocess.

        :param hostname: Spot robot hostname/IP
        :param username: Spot username
        :param password: Spot password
        :param dataset_path: Path to training dataset
        :param model_name: Name of trained model under outputs/train/
        :param pretrained_path: Full path to pretrained model (overrides model_name)
        :param device: Inference device (cuda or cpu)
        :param fps: Control loop frequency
        :param episode_time_s: Episode duration in seconds
        :param image_sources: Camera source names (None for defaults)
        :param image_width: Image width
        :param image_height: Image height
        :param task: Optional task string for multi-task models
        """
        if self.is_running:
            raise RuntimeError("Policy replay subprocess is already running.")

        cmd = [
            "uv",
            "run",
            "--no-project",
            "--reinstall-package",
            "lerobot_robot_spot",
            str(POLICY_REPLAY_SCRIPT),
            "--hostname",
            hostname,
            "--username",
            username,
            "--password",
            password,
            "--dataset-path",
            str(dataset_path),
            "--device",
            device,
            "--fps",
            str(fps),
            "--episode-time-s",
            str(episode_time_s),
            "--image-width",
            str(image_width),
            "--image-height",
            str(image_height),
            "--force-take-lease",
        ]

        if pretrained_path:
            cmd.extend(["--pretrained-path", str(pretrained_path)])
        elif model_name:
            cmd.extend(["--model-name", str(model_name)])

        if image_sources:
            cmd.extend(["--image-sources", *image_sources])

        if task:
            cmd.extend(["--task", task])

        env = os.environ.copy()
        env["LEROBOT_SPOT_ROOT"] = str(Path(self._lerobot_spot_root).resolve())

        self._status_messages = []
        self._take_control_requested = False
        self._process = subprocess.Popen(
            cmd,
            cwd=str(Path(self._lerobot_spot_root).resolve()),
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )

        self._stdout_thread = threading.Thread(
            target=self._stream_output,
            args=(self._process.stdout, self._log, True),
            daemon=True,
        )
        self._stderr_thread = threading.Thread(
            target=self._stream_output,
            args=(self._process.stderr, self._warn, False),
            daemon=True,
        )
        self._stdout_thread.start()
        self._stderr_thread.start()

    def _stream_output(
        self,
        pipe: Optional[IO[str]],
        log_fn: Callable[[str], None],
        parse_json: bool,
    ) -> None:
        """Read lines from a pipe and log them, optionally parsing JSON status."""
        if pipe is None:
            return
        for line in iter(pipe.readline, ""):
            stripped = line.rstrip()
            if parse_json and stripped.startswith("{"):
                try:
                    msg = json.loads(stripped)
                    with self._lock:
                        self._status_messages.append(msg)
                    log_fn("[policy_replay] " + stripped)
                    if msg.get("type") in {"completed", "error"}:
                        self._request_take_control(f"terminal status '{msg['type']}'")
                    continue
                except json.JSONDecodeError:
                    pass
            log_fn("[policy_replay] " + stripped)

            # Fallback for legacy non-JSON completion lines.
            if "completed" in stripped and "success" in stripped:
                self._request_take_control("completion log line")

        pipe.close()

    def _request_take_control(self, reason: str) -> None:
        """Ask the wrapper to reclaim the Spot lease exactly once per replay."""
        with self._lock:
            if self._take_control_requested:
                return
            self._take_control_requested = True

        try:
            trigger_service("spot/take_control")
            trigger_service("spot/unlock_arm")
            outcome = trigger_service("spot/stow_arm")
        except Exception as exc:  # pragma: no cover - best-effort reclaim during shutdown
            self._warn(
                f"[policy_replay] Failed to request SpotROSWrapper control handoff after "
                f"{reason}: {exc}",
            )
            return

        if outcome.success:
            self._log(
                f"[policy_replay] Requested SpotROSWrapper control handoff after {reason}: "
                f"{outcome.message}",
            )
            return

        self._warn(
            f"[policy_replay] SpotROSWrapper could not take control after {reason}: "
            f"{outcome.message}",
        )

    def stop(self) -> None:
        """Stop the running policy replay by sending SIGINT for graceful shutdown."""
        if not self.is_running or self._process is None:
            return

        self._process.send_signal(signal.SIGINT)

        try:
            self._process.wait(timeout=10.0)
        except subprocess.TimeoutExpired:
            self._warn("[policy_replay] Subprocess did not stop gracefully, killing.")
            self._process.kill()
            self._process.wait(timeout=5.0)

    def wait(self, timeout_s: Optional[float] = None) -> Dict[str, Any]:
        """Block until the subprocess completes and return the final status.

        :param timeout_s: Maximum time to wait (None for no limit)
        :return: Final JSON status dict, or error dict if no status was emitted
        """
        if self._process is None:
            return {"type": "error", "success": False, "error": "No subprocess running."}

        try:
            self._process.wait(timeout=timeout_s)
        except subprocess.TimeoutExpired:
            self.stop()

        # Wait for output threads to finish reading
        if self._stdout_thread is not None:
            self._stdout_thread.join(timeout=5.0)
        if self._stderr_thread is not None:
            self._stderr_thread.join(timeout=5.0)

        with self._lock:
            if self._status_messages:
                return self._status_messages[-1]

        return {
            "type": "error",
            "success": False,
            "error": f"Subprocess exited with code {self._process.returncode} but no status was emitted.",
        }

    def get_latest_status(self) -> Optional[Dict[str, Any]]:
        """Return the most recent JSON status message, or None."""
        with self._lock:
            return self._status_messages[-1] if self._status_messages else None
