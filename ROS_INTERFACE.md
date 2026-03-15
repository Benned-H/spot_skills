# Spot Skills — ROS Interface Reference

## Services

### Robot Control

| Service                  | Type      | Description                 |
| ------------------------ | --------- | --------------------------- |
| `spot/stand`             | `Trigger` | Stand the robot             |
| `spot/sit`               | `Trigger` | Sit the robot               |
| `spot/flatten_body_pose` | `Trigger` | Flatten body pose           |
| `spot/shutdown`          | `Trigger` | Shutdown the robot          |
| `spot/take_control`      | `Trigger` | Acquire robot control lease |
| `spot/release_control`   | `Trigger` | Release robot control lease |
| `spot/dock`              | `Trigger` | Dock the robot              |
| `spot/undock`            | `Trigger` | Undock the robot            |

### Arm / Manipulation

| Service                         | Type            | Description                                                                                                                                                         |
| ------------------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `spot/grasp_object`             | `GraspObject`   | Grasp a named object. Request: `object_name`. Response: `success`, `message`, `new_pose`                                                                            |
| `spot/release_object`           | `ReleaseObject` | Release a held object. Request: `object_name`, `new_parent_frame`. Response: `success`, `message`, `new_pose`                                                       |
| `spot/unlock_arm`               | `Trigger`       | Unlock the arm for control                                                                                                                                          |
| `spot/stow_arm`                 | `Trigger`       | Stow the arm                                                                                                                                                        |
| `spot/deploy_arm`               | `Trigger`       | Deploy/unstow the arm                                                                                                                                               |
| `spot/probe_surface`            | `ProbeSurface`  | Probe a surface with force control. Request: `direction`, `max_distance_m`, `velocity_mps`, `force_threshold_n`, `force_check_hz`, `num_probes`, `probe_interval_s` |
| `spot/erase_board`              | `Trigger`       | Erase a board (whiteboard erasing skill)                                                                                                                            |
| `spot/open_drawer`              | `Trigger`       | Open a drawer                                                                                                                                                       |
| `spot/pick_object`              | `NameService`   | Pick a named object using Spot's gripper (no pose estimation). Request: `name`                                                                                      |
| `spot/pick_from_drawer`         | `NameService`   | Pick a named object from a drawer — runs pose estimation, then picks. Request: `name`                                                                               |
| `spot/pick_from_filing_cabinet` | `NameService`   | Pick a named object from a filing cabinet — runs pose estimation, then picks. Request: `name`                                                                       |
| `spot/open_door`                | `OpenDoor`      | Open a door. Request: `body_pitch_rad`, `is_pull`, `hinge_on_left`, `door_offset_m`, `ray_search_dist_m`                                                            |

### Navigation

| Service                            | Type             | Description                                                                       |
| ---------------------------------- | ---------------- | --------------------------------------------------------------------------------- |
| `/spot/navigation/to_pose`         | `NavigateToPose` | Navigate to a target pose. Request: `target_base_pose` (PoseStamped), `timeout_s` |
| `/spot/navigation/to_waypoint`     | `NameService`    | Navigate to a named waypoint                                                      |
| `/spot/navigation/create_waypoint` | `NameService`    | Create a new named waypoint at current location                                   |

### GraphNav / Mapping

| Service                      | Type          | Description                        |
| ---------------------------- | ------------- | ---------------------------------- |
| `/spot/reload_map_to_seed`   | `Trigger`     | Reload map-to-seed frame transform |
| `/spot/relocalize`           | `Trigger`     | Trigger relocalization             |
| `spot/start_mapping`         | `Trigger`     | Start recording a GraphNav map     |
| `spot/stop_mapping`          | `Trigger`     | Stop recording a GraphNav map      |
| `spot/save_map`              | `Trigger`     | Save the current GraphNav map      |
| `spot/export_occupancy_grid` | `NameService` | Export occupancy grid              |

### Motion Planning

| Service                    | Type                 | Description                                                                                                                                                             |
| -------------------------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `spot/compute_motion_plan` | `ComputeMotionPlan`  | Compute a motion plan. Request: `target_pose` (PoseStamped), `ignored_objects`, `ignore_all_collisions`. Response: `success`, `message`, `trajectory` (JointTrajectory) |
| `spot/playback_trajectory` | `PlaybackTrajectory` | Play back a recorded trajectory. Request: `yaml_path`                                                                                                                   |
| `spot/policy_replay`       | `NameService`        | Replay a learned policy by name                                                                                                                                         |

### Perception

| Service                          | Type                      | Description                                                           |
| -------------------------------- | ------------------------- | --------------------------------------------------------------------- |
| `spot/get_rgbd_pairs`            | `GetRGBDPairs`            | Get RGBD image pairs. Request: `camera_names`. Response: `rgbd_pairs` |
| `spot/get_rgb_images`            | `GetRGBImages`            | Get RGB images from cameras                                           |
| `spot/capture_image_observation` | `CaptureImageObservation` | Capture an image observation                                          |
| `pose_lookup`                    | `PoseLookup`              | Look up a named pose                                                  |
| `spot/pose_estimation/pause`     | `NameService`             | Pause pose estimation for a named object                              |
| `spot/pose_estimation/resume`    | `NameService`             | Resume pose estimation for a named object                             |

### Scene Management

| Service                     | Type          | Description                                   |
| --------------------------- | ------------- | --------------------------------------------- |
| `spot/moveit/hide_object`   | `NameService` | Hide an object from the MoveIt planning scene |
| `spot/moveit/unhide_object` | `NameService` | Unhide an object in the MoveIt planning scene |
| `spot/reset_state`          | `NameService` | Reset scene state                             |
| `spot/set_container_open`   | `NameService` | Set a container's open/closed state           |

### LiDAR

| Service             | Type      | Description                         |
| ------------------- | --------- | ----------------------------------- |
| `spot/pause_lidar`  | `Trigger` | Pause LiDAR point cloud publishing  |
| `spot/resume_lidar` | `Trigger` | Resume LiDAR point cloud publishing |

### Joint State Multiplexer

| Service          | Type          | Description                          |
| ---------------- | ------------- | ------------------------------------ |
| `set_joint_mode` | `NameService` | Switch the active joint state source |

### Spot CAM

| Service                                      | Type                | Description                       |
| -------------------------------------------- | ------------------- | --------------------------------- |
| `/spot/cam/set_screen`                       | `SetString`         | Set the WebRTC screen             |
| `/spot/cam/set_ir_meter_overlay`             | `SetIRMeterOverlay` | Set IR meter overlay              |
| `/spot/cam/set_ir_colormap`                  | `SetIRColormap`     | Set IR colormap                   |
| `/spot/cam/audio/set_volume`                 | `SetFloat`          | Set audio volume                  |
| `/spot/cam/audio/play`                       | `PlaySound`         | Play a sound                      |
| `/spot/cam/audio/load`                       | `LoadSound`         | Load a sound                      |
| `/spot/cam/audio/delete`                     | `SetString`         | Delete a sound                    |
| `/spot/cam/stream/set_params`                | `SetStreamParams`   | Set stream parameters             |
| `/spot/cam/stream/enable_congestion_control` | `SetBool`           | Enable/disable congestion control |
| `/spot/cam/ptz/set_position`                 | `SetPTZState`       | Set PTZ position                  |
| `/spot/cam/ptz/set_velocity`                 | `SetPTZState`       | Set PTZ velocity                  |
| `/spot/cam/ptz/reset_autofocus`              | `Trigger`           | Reset PTZ autofocus               |
| `/spot/cam/ptz/look_at_point`                | `LookAtPoint`       | Point camera at a target          |

---

## Topics

### Published Topics

#### Camera Images

| Topic                           | Type         | Description              |
| ------------------------------- | ------------ | ------------------------ |
| `camera/back/image`             | `Image`      | Back camera image        |
| `camera/frontleft/image`        | `Image`      | Front-left camera image  |
| `camera/frontright/image`       | `Image`      | Front-right camera image |
| `camera/left/image`             | `Image`      | Left camera image        |
| `camera/right/image`            | `Image`      | Right camera image       |
| `camera/hand_mono/image`        | `Image`      | Hand mono camera image   |
| `camera/hand_color/image`       | `Image`      | Hand color camera image  |
| `camera/back/camera_info`       | `CameraInfo` | Back camera info         |
| `camera/frontleft/camera_info`  | `CameraInfo` | Front-left camera info   |
| `camera/frontright/camera_info` | `CameraInfo` | Front-right camera info  |
| `camera/left/camera_info`       | `CameraInfo` | Left camera info         |
| `camera/right/camera_info`      | `CameraInfo` | Right camera info        |
| `camera/hand_mono/camera_info`  | `CameraInfo` | Hand mono camera info    |
| `camera/hand_color/camera_info` | `CameraInfo` | Hand color camera info   |

#### Robot State

| Topic                | Type                         | Description                          |
| -------------------- | ---------------------------- | ------------------------------------ |
| `joint_states`       | `JointState`                 | Joint positions, velocities, efforts |
| `tf`                 | `TFMessage`                  | Transform tree                       |
| `odometry`           | `Odometry`                   | Robot odometry                       |
| `odometry_corrected` | `Odometry`                   | Corrected odometry                   |
| `odometry/twist`     | `TwistWithCovarianceStamped` | Velocity estimate                    |
| `world_objects`      | `WorldObjectArray`           | Detected world objects               |

#### Status

| Topic                    | Type                 | Description                 |
| ------------------------ | -------------------- | --------------------------- |
| `status/metrics`         | `Metrics`            | Robot metrics               |
| `status/leases`          | `LeaseArray`         | Active leases               |
| `status/feet`            | `FootStateArray`     | Foot contact states         |
| `status/estop`           | `EStopStateArray`    | E-stop states               |
| `status/wifi`            | `WiFiState`          | WiFi status                 |
| `status/power_state`     | `PowerState`         | Power state                 |
| `status/battery_states`  | `BatteryStateArray`  | Battery states              |
| `status/behavior_faults` | `BehaviorFaultState` | Behavior faults             |
| `status/system_faults`   | `SystemFaultState`   | System faults               |
| `status/motion_allowed`  | `Bool`               | Whether motion is allowed   |
| `status/feedback`        | `Feedback`           | Command feedback            |
| `status/mobility_params` | `MobilityParams`     | Current mobility parameters |

#### Point Clouds & Maps

| Topic              | Type            | Description                          |
| ------------------ | --------------- | ------------------------------------ |
| `lidar/points`     | `PointCloud2`   | Raw LiDAR point cloud                |
| `spot/lidar_cloud` | `PointCloud2`   | Filtered LiDAR point cloud (latched) |
| `occupancy_grid`   | `OccupancyGrid` | Occupancy grid map                   |

#### Visualization

| Topic                           | Type           | Description                 |
| ------------------------------- | -------------- | --------------------------- |
| `visualization_marker`          | `Marker`       | Visualization markers       |
| `rviz_markers`                  | `MarkerArray`  | RViz marker array (latched) |
| `/spot/navigation/planned_path` | `Path`         | Planned navigation path     |
| `/estimated_object_poses`       | `PoseEstimate` | Estimated object poses      |

#### Spot CAM

| Topic                            | Type                  | Description                 |
| -------------------------------- | --------------------- | --------------------------- |
| `/spot/cam/image`                | `Image`               | Spot CAM image stream       |
| `/spot/cam/status/leds`          | `Float32MultiArray`   | LED states (latched)        |
| `/spot/cam/status/power`         | `PowerStatus`         | CAM power status (latched)  |
| `/spot/cam/screens`              | `StringMultiArray`    | Available screens (latched) |
| `/spot/cam/status/temperatures`  | `TemperatureArray`    | Temperature readings        |
| `/spot/cam/status/built_in_test` | `BITStatus`           | Built-in test status        |
| `/spot/cam/stream/params`        | `StreamParams`        | Stream parameters (latched) |
| `/spot/cam/ptz/list`             | `PTZDescriptionArray` | PTZ descriptions (latched)  |
| `/spot/cam/ptz/positions`        | `PTZStateArray`       | PTZ positions               |
| `/spot/cam/ptz/velocities`       | `PTZStateArray`       | PTZ velocities              |

#### End-Effector Control

| Topic              | Type          | Description                   |
| ------------------ | ------------- | ----------------------------- |
| `/spot/ee_pose`    | `PoseStamped` | End-effector pose             |
| `/spot/ee_cmd_vel` | `Twist`       | End-effector velocity command |

### Subscribed Topics

| Topic                  | Type          | Description                             |
| ---------------------- | ------------- | --------------------------------------- |
| `cmd_vel`              | `Twist`       | Velocity commands for base motion       |
| `/spot/ee_pose`        | `PoseStamped` | End-effector pose target (manipulation) |
| `spot/lidar_cloud`     | `PointCloud2` | LiDAR cloud input (for filtering)       |
| `spot/cam/set_leds`    | `Float32`     | Set LED brightness                      |
| `spot/cam/set_power`   | `PowerStatus` | Set CAM power                           |
| `spot/cam/cycle_power` | `PowerStatus` | Cycle CAM power                         |

---

## Action Servers

| Action                                   | Type                          | Description                                 |
| ---------------------------------------- | ----------------------------- | ------------------------------------------- |
| `gripper_controller/gripper_action`      | `GripperCommandAction`        | Gripper open/close commands                 |
| `arm_controller/follow_joint_trajectory` | `FollowJointTrajectoryAction` | Arm trajectory execution (MoveIt interface) |
| `/spot/cam/ptz/look_at_point`            | `LookAtPointAction`           | Point camera at a target with tracking      |

## Custom Action Definitions

| Action          | Fields                                                                                            |
| --------------- | ------------------------------------------------------------------------------------------------- |
| `LookAtPoint`   | Goal: `target` (PointStamped), `image_width`, `zoom_level`, `track`. Result: `success`, `message` |
| `Dock`          | Goal: `dock_id`, `undock`. Result: `success`, `message`, `DockState`                              |
| `NavigateTo`    | Goal: `navigate_to` (waypoint ID). Result: `success`, `message`, `waypoint_id`                    |
| `NavigateRoute` | Route-based navigation                                                                            |
| `PoseBody`      | Body pose control                                                                                 |
| `Trajectory`    | Trajectory execution                                                                              |

---

## Skill Execution Guide

### Precondition Reference

| Precondition        | Required By                                                         | Notes                                                                                                                                                                                            |
| ------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `spot/take_control` | All skills (implicit)                                               | Most handlers call `ensure_control(take_by_force=False)` internally. Call explicitly at startup or if another client holds control.                                                              |
| `spot/unlock_arm`   | `open_door`, `release_object`, `erase_board`, `playback_trajectory` | These handlers explicitly check `arm_interface.locked` and **fail immediately** if the arm is locked. `grasp_object` does **not** require this — the manipulator handles arm control internally. |
| `spot/stand`        | Navigation, manipulation                                            | Not always enforced in code, but the robot must be standing to walk or use the arm.                                                                                                              |
| `spot/stow_arm`     | Navigation (recommended)                                            | Not enforced, but navigating with an unstowed arm risks collisions.                                                                                                                              |

### Real-World Experiment Sequence

The sequence below executes a multi-step task: navigate to a door, open it, go to a drawer, open it, pick up an eraser1, place it in a cabinet, close the door, retrieve the eraser1, and erase a board.

If you want to run this as a single executable instead of individual `rosservice call`s, use `src/spot_skills/scripts/run_real_world_experiment.py`.

```bash
# Take control and undock
rosservice call /spot/take_control "{}"
rosservice call /spot/unlock_arm "{}"
rosservice call /spot/undock "{}"

# Go to the drawer, then open it
rosservice call /spot/navigation/to_waypoint "name: 'open_drawer'"
rosservice call /spot/open_drawer "{}"

# Go to the door and open it
rosservice call /spot/navigation/to_waypoint "name: 'open_door'"
rosservice call /spot/open_door "{body_pitch_rad: -0.1, is_pull: false, hinge_on_left: true, door_offset_m: 1.25, ray_search_dist_m: 0.25}"

# Go back to the dresser (two waypoints needed) and then pick the eraser
rosservice call /spot/navigation/to_waypoint "name: 'open_drawer'"
rosservice call /spot/navigation/to_waypoint "name: 'pick_from_drawer'"
rosservice call /spot/pick_from_drawer "name: 'eraser1'"

# Head into the office area, then to the filing cabinet
rosservice call /spot/navigation/to_waypoint "name: 'open_drawer'"
rosservice call /spot/navigation/to_waypoint "name: 'into_office'"
rosservice call /spot/navigation/to_waypoint "name: 'approach_filing_cabinet'"
rosservice call /spot/navigation/to_waypoint "name: 'facing_filing_cabinet'"

# Place the eraser onto the filing cabinet, then back away
rosservice call /spot/place_on_cabinet "name: 'eraser1'"
rosservice call /spot/navigation/to_waypoint "name: 'approach_filing_cabinet'"

# Head over and close the door
rosservice call /spot/navigation/to_waypoint "name: 'close_door'"
rosservice call /spot/policy_replay "name: 'spot-close-door2-combined'"

# Pick the eraser from the top of the filing cabinet
rosservice call /spot/navigation/to_waypoint "name: 'approach_filing_cabinet'"
rosservice call /spot/navigation/to_waypoint "name: 'facing_filing_cabinet'"
rosservice call /spot/pick_from_filing_cabinet "name: 'eraser1'"

# Go to the board and erase it
rosservice call /spot/navigation/to_waypoint "name: 'approach_filing_cabinet'"
rosservice call /spot/navigation/to_waypoint "name: 'erase'"
rosservice call /spot/erase_board "{}"
```

### Key Notes

- **No dedicated Close Door service.** `open_door` with `is_pull: true` pulls the door toward the robot, effectively closing it if Spot is on the pull side. Swap `is_pull` / `hinge_on_left` based on approach direction.
- **`unlock_arm` is idempotent** — safe to call even if the arm is already unlocked. It also forces `take_control` internally.
- **`stow_arm` before navigation** is not enforced by the code but strongly recommended to avoid collisions with the environment during transit.
- **`grasp_object` is self-contained** — unlike most manipulation skills, it does not require a prior `unlock_arm` call; the manipulator manages arm control internally.
- **`pick_object` vs `pick_from_drawer`** — `pick_object` assumes the object's pose is already being tracked (e.g., via AprilTag) and does not run pose estimation; `pick_from_drawer` runs pose estimation for both the object and the drawer, then picks. Neither service navigates — the robot must already be at the correct location.
- **`erase_board` uses ROS parameters** to define the board geometry. These must be set (via launch file or `rosparam set`) before calling the service.
