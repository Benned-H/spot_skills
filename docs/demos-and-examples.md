# Demos and Examples

Complete guide to running demos and example workflows with the Spot robot.

## Launch Files

### Main Bringup

**[../src/spot_skills/launch/bringup_spot_skills.launch](../src/spot_skills/launch/bringup_spot_skills.launch)**

Launches all core components.

```bash
roslaunch spot_skills bringup_spot_skills.launch spot_name:=<robot_name>
```

**Arguments**:
- `spot_name` (required): Robot hostname or identifier
- `username` (default: user): Spot SDK username
- `password` (default: password): Spot SDK password

### Individual Components

**Spot SDK Driver Only**:
```bash
roslaunch spot_skills bringup_spot_driver.launch spot_name:=<robot_name>
```

**MoveIt Planning**:
```bash
roslaunch spot_skills bringup_spot_moveit.launch
```

**GraphNav Navigation**:
```bash
roslaunch spot_skills bringup_spot_graphnav.launch spot_name:=<robot_name>
```

**Joint State Multiplexing**:
```bash
roslaunch spot_skills bringup_joint_state_mux.launch
```

## Demo Launch Files

### MoveIt Arm Control Demo

**[../src/spot_skills/launch/demos/moveit_spot_demo.launch](../src/spot_skills/launch/demos/moveit_spot_demo.launch)**

Interactive MoveIt demo for arm planning and execution.

**Simulated**:
```bash
roslaunch spot_skills moveit_spot_demo.launch
```

**Real Robot**:
```bash
roslaunch spot_skills moveit_spot_demo.launch real_robot:=true spot_name:=<robot_name>
```

**What it does**:
1. Launches RViz with MoveIt planning plugin
2. Allows interactive motion planning via drag-and-drop
3. Visualizes planned trajectories
4. Executes on real robot (if `real_robot:=true`)

### Direct SDK Trajectory Demo

**[../src/spot_skills/launch/demos/spot_sdk_demo.launch](../src/spot_skills/launch/demos/spot_sdk_demo.launch)**

Demonstrates long trajectory execution via Spot SDK.

```bash
roslaunch spot_skills spot_sdk_demo.launch spot_name:=<robot_name>
```

**What it does**:
1. Connects to robot
2. Stands up robot
3. Executes a predefined long arm trajectory
4. Sits down when complete

### Door Opening Demo

**[../src/spot_skills/launch/demos/open_door_demo.launch](../src/spot_skills/launch/demos/open_door_demo.launch)**

Autonomous door opening skill.

```bash
roslaunch spot_skills open_door_demo.launch spot_name:=<robot_name>
```

**Arguments**:
- `pitch` (default: 0.0): Door handle pitch angle
- `is_pull` (default: true): Pull door (vs push)
- `hinge_on_left` (default: true): Hinge location
- `offset` (default: 0.0): Lateral offset from handle
- `search_dist` (default: 0.5): Search distance for handle

**What it does**:
1. Approaches door
2. Searches for door handle
3. Grasps handle with appropriate force
4. Opens door (pull or push)
5. Releases handle

### Trajectory Playback Demo

**[../src/spot_skills/launch/demos/playback_trajectory_demo.launch](../src/spot_skills/launch/demos/playback_trajectory_demo.launch)**

Playback recorded arm trajectories.

```bash
roslaunch spot_skills playback_trajectory_demo.launch \
  spot_name:=<robot_name> \
  trajectory_file:=/path/to/trajectory.yaml
```

## SLAM and Navigation Demos

### SLAM Mapping Demo

**[../src/spot_skills/launch/spot_slam_demo.launch](../src/spot_skills/launch/spot_slam_demo.launch)**

Build 3D map using RTAB-Map SLAM.

```bash
roslaunch spot_skills spot_slam_demo.launch spot_name:=<robot_name>
```

**Workflow**:
1. Launch demo
2. Drive robot around area (teleoperation or autonomous)
3. Visualize map building in RViz
4. Save map when complete:
   ```bash
   rosservice call /rtabmap/save_map "filename: '/path/to/map.db'"
   ```

**See**: [mapping-demo.md](mapping-demo.md) for detailed instructions.

### GraphNav Demo

**[../src/spot_skills/launch/spot_graphnav_demo.launch](../src/spot_skills/launch/spot_graphnav_demo.launch)**

Visual SLAM navigation with GraphNav.

```bash
roslaunch spot_skills spot_graphnav_demo.launch \
  spot_name:=<robot_name> \
  map_path:=/path/to/graphnav/map
```

**Workflow**:
1. Launch with existing GraphNav map
2. Robot localizes to fiducial marker
3. Navigate to waypoints:
   ```bash
   rosservice call /spot/navigation/to_waypoint "name: 'waypoint_5'"
   ```

**See**: [navigation-demo.md](navigation-demo.md) for detailed instructions.

### Navigation Demo

**[../src/spot_skills/launch/spot_nav_demo.launch](../src/spot_skills/launch/spot_nav_demo.launch)**

ROS navigation stack (move_base) demo.

```bash
roslaunch spot_skills spot_nav_demo.launch spot_name:=<robot_name>
```

**Workflow**:
1. Launch navigation stack
2. Set 2D Nav Goal in RViz
3. Robot plans path and navigates autonomously

## Demo Scripts

### MoveIt Demo Script

**[../src/spot_skills/scripts/spot_moveit_demo.py](../src/spot_skills/scripts/spot_moveit_demo.py)**

Programmatic MoveIt arm control.

```bash
rosrun spot_skills spot_moveit_demo.py
```

**What it does**:
```python
# Pseudocode
move_group.set_named_target("home")
move_group.go()

move_group.set_named_target("extended")
move_group.go()

move_group.set_pose_target(target_pose)
move_group.go()
```

### Long Trajectory Demo

**[../src/spot_skills/scripts/arm_long_trajectory_demo.py](../src/spot_skills/scripts/arm_long_trajectory_demo.py)**

Demonstrates long, multi-point trajectory execution.

```bash
rosrun spot_skills arm_long_trajectory_demo.py --spot_name <robot_name>
```

### Pose Sampling Demo

**[../src/spot_skills/scripts/pose_sampling_demo.py](../src/spot_skills/scripts/pose_sampling_demo.py)**

Demonstrates pose sampling for object placement.

```bash
rosrun spot_skills pose_sampling_demo.py
```

**What it does**:
1. Samples valid placement poses on surfaces
2. Checks collision-free configurations
3. Visualizes samples in RViz

### Generate MoveIt Plans

**[../src/spot_skills/scripts/generate_moveit_plans.py](../src/spot_skills/scripts/generate_moveit_plans.py)**

Pre-generates and saves motion plans.

```bash
rosrun spot_skills generate_moveit_plans.py \
  --start home \
  --goal extended \
  --output plan.yaml
```

## Real-World Experiment Workflow

Complete workflow for real-world experiments combining mapping, localization, perception, and task execution.

### 1. Mapping Phase

```bash
# Launch mapping
roslaunch spot_rtabmap mapping.launch spot_name:=<name>

# Drive robot around environment
# Use keyboard teleoperation or gamepad
rosrun teleop_twist_keyboard teleop_twist_keyboard.py cmd_vel:=/spot/cmd_vel

# Save map when done
rosservice call /rtabmap/save_map "filename: '/data/maps/lab_floor2.db'"
```

### 2. Localization Phase

```bash
# Launch localization with saved map
roslaunch spot_rtabmap localization.launch \
  spot_name:=<name> \
  map_path:=/data/maps/lab_floor2.db

# Wait for localization convergence
# Check RViz for aligned point clouds
```

### 3. Pose Estimation Phase

```bash
# Launch pose estimation server
roslaunch spot_skills pose_estimation.launch

# Capture images and estimate object poses
rosrun spot_skills pose_estimation_client.py --object eraser1

# Results saved to /tmp/object_poses.yaml
```

### 4. Task Planning Phase

```bash
# Set TMP3 parameters
rosparam set DOMAIN_DIR "/docker/spot_skills/src/TMP3/test_domains/SpotTAMP"
rosparam set PROBLEM_NAME "SciLi"
rosparam set PROJ_DIR "/docker/spot_skills/src/TMP3"

# Run TMP3 planner
cd /docker/spot_skills/src/TMP3
python TMP.py

# Refined policy saved to refined_tree.pkl
```

### 5. Execution Phase

```bash
# Execute policy on robot
cd /docker/spot_skills/src/TMP3
python scripts/tamp_executor.py

# Monitor execution in RViz
# Robot executes: pick eraser → navigate to board → erase
```

## Trajectory Recording Workflow

### Record Custom Trajectory

```bash
# 1. Launch spot driver
roslaunch spot_skills bringup_spot_driver.launch spot_name:=<name>

# 2. Start recording
rosrun spot_skills record_transforms.py /tmp/my_trajectory.yaml

# 3. Move robot arm
# Option A: MoveIt
roslaunch spot_skills moveit_spot_demo.launch real_robot:=true spot_name:=<name>
# Drag end-effector in RViz

# Option B: Teleoperation
# Use teach pendant or keyboard teleoperation

# 4. Stop recording (Ctrl+C)

# 5. Trajectory saved to /tmp/my_trajectory.yaml
```

### Playback Recorded Trajectory

```bash
# Via service call
rosservice call /spot/playback_trajectory "yaml_path: '/tmp/my_trajectory.yaml'"

# Via launch file
roslaunch spot_skills playback_trajectory_demo.launch \
  spot_name:=<name> \
  trajectory_file:=/tmp/my_trajectory.yaml
```

## Debugging and Visualization

### RViz Visualization

```bash
# Launch RViz with preconfigured view
roslaunch spot_skills rviz.launch

# Key visualizations:
# - Robot model with joint states
# - Camera images
# - Point clouds
# - TF frames
# - Planned trajectories
# - Cost maps (for navigation)
```

### RQT Tools

```bash
# RQT graph - visualize node/topic graph
rqt_graph

# RQT plot - plot topic data
rqt_plot /joint_states/position[0]

# RQT console - view log messages
rqt_console

# RQT bag - record/playback data
rqt_bag
```

### Record Rosbag

```bash
# Record all topics
rosbag record -a -O experiment_data.bag

# Record specific topics
rosbag record /joint_states /tf /spot/camera/frontleft/image

# Playback
rosbag play experiment_data.bag
```

## Common Issues and Solutions

### Robot Won't Stand

**Issue**: Robot fails to stand up

**Solution**:
1. Check E-stop is released
2. Verify battery charge > 20%
3. Check lease acquisition:
   ```bash
   rostopic echo /spot/status
   ```

### Arm Won't Move

**Issue**: Arm trajectory execution fails

**Solution**:
1. Unlock arm control:
   ```bash
   rosservice call /spot/unlock_arm
   ```
2. Check joint limits in `/spot/joint_states`
3. Verify MoveIt planning succeeds before execution

### Navigation Failure

**Issue**: Robot won't navigate to goal

**Solution**:
1. Check localization is converged (RViz)
2. Verify goal is reachable (not in obstacle)
3. Check cost map visualization
4. Increase goal tolerance if needed

### Camera Images Not Received

**Issue**: No images on camera topics

**Solution**:
1. Verify Spot driver is running
2. Check camera names:
   ```bash
   rostopic list | grep camera
   ```
3. Ensure robot is powered on and standing
