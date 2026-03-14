# LeRobot Behavior Cloning Integration

## Summary
Integrated LeRobot policy replay into `spot_skills_py` using the same `uv run` subprocess bridge pattern as the Gemini Robotics-ER integration. LeRobot requires Python 3.10+ but the ROS environment runs Python 3.8/3.11 (RoboStack). The subprocess force-takes the BD SDK lease; the ROS wrapper re-takes it after.

## Architecture
- **Bridge pattern**: Python 3.8 ROS code spawns a Python 3.10+ subprocess via `uv run` with PEP 723 script metadata
- **JSON IPC**: Subprocess outputs JSON status lines on stdout (`started`, `step`, `completed`, `error`)
- **Lease handling**: Subprocess force-takes lease via `SpotRobot.connect()`. Wrapper re-acquires via `self._manager.ensure_control(take_by_force=True)` after subprocess exits.

## Files Created
1. `src/spot_skills/src/spot_skills_py/behavior_cloning/__init__.py` — exports `PolicyReplayBridge`
2. `src/spot_skills/src/spot_skills_py/behavior_cloning/policy_replay_service.py` — standalone PEP 723 script (Python 3.10+), adapted from `/home/guest/git/lerobot-spot/spot_policy_replay.py`
3. `src/spot_skills/src/spot_skills_py/behavior_cloning/policy_replay_bridge.py` — bridge class using `subprocess.Popen` + threaded output streaming

## Files Modified
- `src/spot_skills/src/spot_skills_py/spot/spot_ros_wrapper.py`:
  - Added import of `PolicyReplayBridge`
  - Added `spot/policy_replay` Trigger service registration in `__init__`
  - Added `handle_policy_replay` method (~line 1897)

## Model Location
- Trained models live under: `lerobot-spot/outputs/train/<model-name>/<policy-type>/checkpoints/last/pretrained_model/`
- Available models: `spot-open-drawer`, `spot-pick-from-drawer`, `spot-scili-close-door`
- Default dataset: `/home/guest/git/lerobot-spot/data/yourname/spot-scili-close-door_20260304_222712`

## Default Paths (in handle_policy_replay)
- `~model_name`: Name of trained model under `outputs/train/` (default: `spot-scili-close-door`). The policy type subdir (e.g. `diffusion`) is auto-detected.
- `~dataset_path`: `/home/guest/git/lerobot-spot/data/yourname/spot-scili-close-door_20260304_222712`
- `~lerobot_spot_root`: `/docker/spot_skills/lerobot-spot`

## Key Dependencies
- `lerobot_robot_spot` package at `/home/guest/git/lerobot-spot/lerobot_robot_spot/` — its pyproject.toml pulls in `lerobot>=0.4.4`, `bosdyn_client`, `bosdyn_api`
- PEP 723 dependency: `lerobot_robot_spot @ file:///${LEROBOT_SPOT_ROOT}`

## Testing
- **Standalone**: `LEROBOT_SPOT_ROOT=/docker/spot_skills/lerobot-spot uv run .../policy_replay_service.py --hostname <ip> --username <user> --password <pass> --model-name spot-scili-close-door --dataset-path <path>`
- **ROS**: `rosservice call /spot/policy_replay` (requires spot_wrapper_node running)

## Reference Pattern
- Gemini bridge: `src/spot_skills/src/robotics_utils/src/robotics_utils/vision/vlms/gemini/gemini_robotics_bridge.py`
- Gemini service: `src/spot_skills/src/robotics_utils/src/robotics_utils/vision/vlms/gemini/gemini_keypoint_service.py`

## Notes
- First `uv run` is slow (downloads torch, lerobot, etc.). Subsequent runs use cached venv.
- The `spot/policy_replay` service only exists when `spot_wrapper_node` is running.
- Repo root directory is owned by `root` — need `sudo` to create top-level dirs or fix permissions.
