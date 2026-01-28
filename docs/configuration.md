# Configuration Guide

Guide to configuring the spot_skills environment, objects, markers, and trajectories.

## Environment Configuration

**File**: [../src/spot_skills/config/env.yaml](../src/spot_skills/config/env.yaml)

Defines the environment for planning and execution.

### Structure

```yaml
room:
  dimensions:
    x: 10.0  # meters
    y: 8.0
    z: 3.0

objects:
  table1:
    type: surface
    position: [2.0, 1.0, 0.0]  # x, y, z
    dimensions: [1.2, 0.8, 0.75]  # length, width, height

  wall1:
    type: obstacle
    position: [0.0, 0.0, 0.0]
    dimensions: [10.0, 0.1, 3.0]

surfaces:
  - name: table1
    height: 0.75
    bounds:
      x_min: 1.4
      x_max: 2.6
      y_min: 0.6
      y_max: 1.4
```

### Usage

```python
from spot_skills_py.planners import EnvironmentConfig

config = EnvironmentConfig.from_yaml('config/env.yaml')
room_dims = config.room_dimensions
objects = config.objects
```

## Known Objects Database

**File**: [../src/spot_skills/config/known_objects.yaml](../src/spot_skills/config/known_objects.yaml)

Database of known objects with physical properties.

### Structure

```yaml
eraser:
  dimensions:
    length: 0.15
    width: 0.05
    height: 0.03
  mass: 0.05  # kg
  mesh: "package://spot_skills/meshes/eraser.stl"
  grasp:
    approach_distance: 0.1
    retreat_distance: 0.1
    min_grasp_width: 0.04
    max_grasp_width: 0.06

can:
  dimensions:
    radius: 0.03
    height: 0.12
  mass: 0.35
  mesh: "package://spot_skills/meshes/can.stl"
  fragile: true
  grasp:
    preferred_orientation: "vertical"
    approach_distance: 0.15
```

### Usage

```python
from spot_skills_py.planners import ObjectDatabase

db = ObjectDatabase.from_yaml('config/known_objects.yaml')
eraser = db.get_object('eraser')
print(f"Eraser dimensions: {eraser.dimensions}")
print(f"Mesh path: {eraser.mesh}")
```

## Fiducial Markers

**File**: [../src/spot_skills/config/markers.yaml](../src/spot_skills/config/markers.yaml)

Defines fiducial markers for localization.

### Structure

```yaml
markers:
  # ArUco markers
  aruco_1:
    type: aruco
    id: 1
    size: 0.15  # meters
    location:  # Optional: if known
      frame: map
      position: [2.0, 1.5, 1.2]
      orientation: [0.0, 0.0, 0.0, 1.0]  # quaternion

  aruco_2:
    type: aruco
    id: 2
    size: 0.15

  # AprilTag markers
  tag_10:
    type: apriltag
    family: tag36h11
    id: 10
    size: 0.20
```

### Usage

Markers are automatically detected by the Spot SDK and used for GraphNav localization.

## Map Configuration

**File**: [../src/spot_skills/config/map_to_seed.yaml](../src/spot_skills/config/map_to_seed.yaml)

Maps navigation maps to initial seed waypoints.

### Structure

```yaml
lab_floor2:
  seed_waypoint: "entrance"
  initial_localization_fiducial: 1

office:
  seed_waypoint: "main_door"
  initial_localization_fiducial: 10
```

## Recorded Trajectories

**Directory**: [../src/spot_skills/config/trajectories/](../src/spot_skills/config/trajectories/)

YAML files containing recorded arm trajectories.

### Recording Trajectories

```bash
# Start recording transforms
rosrun spot_skills record_transforms.py output_trajectory.yaml

# Move the robot arm (via teach pendant, MoveIt, or teleoperation)
# Transforms are recorded at 10 Hz

# Stop recording (Ctrl+C)
```

### Trajectory File Format

```yaml
joint_names:
  - arm_sh0
  - arm_sh1
  - arm_el0
  - arm_el1
  - arm_wr0
  - arm_wr1
  - arm_f1x

points:
  - positions: [0.0, -1.57, 0.0, 1.57, 0.0, 0.0, 0.0]
    velocities: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    time_from_start: 0.0

  - positions: [0.5, -1.2, 0.3, 1.4, 0.1, 0.2, 0.5]
    velocities: [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
    time_from_start: 2.0

  - positions: [1.0, -0.8, 0.6, 1.0, 0.2, 0.4, 1.0]
    velocities: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    time_from_start: 4.0
```

### Playing Back Trajectories

```bash
# Via service call
rosservice call /spot/playback_trajectory "yaml_path: '/path/to/trajectory.yaml'"
```

```python
# Via Python
import rospy
from spot_skills.srv import PlaybackTrajectory

rospy.init_node('playback_client')
playback = rospy.ServiceProxy('/spot/playback_trajectory', PlaybackTrajectory)
result = playback('/docker/spot_skills/config/trajectories/pick_motion.yaml')
print(f"Playback result: {result.success}")
```

## Erase Trajectory Configuration

**File**: [../src/spot_skills/config/erase_traj.yaml](../src/spot_skills/config/erase_traj.yaml)

Defines erasing task trajectories with force control.

### Structure

```yaml
erase_patterns:
  horizontal_sweep:
    pattern_type: "sweep"
    direction: [1.0, 0.0, 0.0]  # x-direction
    distance: 0.5
    num_passes: 3
    force: 20.0  # Newtons
    velocity: 0.1  # m/s

  circular:
    pattern_type: "circle"
    radius: 0.15
    num_rotations: 2
    force: 15.0
    angular_velocity: 0.5  # rad/s
```

## ROS Parameter Configuration

Parameters can be set via launch files or command line.

### Setting Parameters in Launch Files

```xml
<launch>
  <param name="spot_name" value="SpotCBR123" />
  <param name="max_velocity" value="1.0" />
  <param name="goal_tolerance" value="0.1" />

  <rosparam file="$(find spot_skills)/config/env.yaml" command="load" />
</launch>
```

### Setting Parameters via Command Line

```bash
# Set individual parameter
rosparam set spot_name "SpotCBR123"

# Load from file
rosparam load config/env.yaml

# Get parameter value
rosparam get spot_name

# List all parameters
rosparam list
```

## MoveIt Configuration

**Directory**: [../src/spot_moveit_config/](../src/spot_moveit_config/)

MoveIt configuration generated via MoveIt Setup Assistant.

### Key Files

- `config/spot.srdf` - Semantic robot description (groups, poses, collision)
- `config/joint_limits.yaml` - Joint velocity and acceleration limits
- `config/kinematics.yaml` - IK solver configuration
- `config/ompl_planning.yaml` - OMPL planner parameters

### Modifying Planning Parameters

Edit [../src/spot_moveit_config/config/ompl_planning.yaml](../src/spot_moveit_config/config/ompl_planning.yaml):

```yaml
planner_configs:
  RRTConnect:
    type: geometric::RRTConnect
    range: 0.0  # Max step distance (0 = auto)

  RRT:
    type: geometric::RRT
    range: 0.0
    goal_bias: 0.05

arm:  # Planning group
  default_planner_config: RRTConnect
  planner_configs:
    - RRTConnect
    - RRT
  projection_evaluator: joints(arm_sh0,arm_sh1)
  longest_valid_segment_fraction: 0.005
```

## Navigation Configuration

**Directory**: [../src/spot_move_base/config/](../src/spot_move_base/config/)

Navigation stack parameters.

### Cost Map Configuration

Edit global and local cost map parameters:

```yaml
global_costmap:
  global_frame: map
  robot_base_frame: base_link
  update_frequency: 1.0
  publish_frequency: 0.5
  static_map: true
  width: 10.0
  height: 10.0
  resolution: 0.05

local_costmap:
  global_frame: odom
  robot_base_frame: base_link
  update_frequency: 5.0
  publish_frequency: 2.0
  static_map: false
  rolling_window: true
  width: 3.0
  height: 3.0
  resolution: 0.025
```

### Planner Configuration

Edit planner-specific parameters:

```yaml
DWAPlannerROS:
  max_vel_x: 1.0
  min_vel_x: -0.5
  max_vel_theta: 1.5
  min_vel_theta: -1.5

  acc_lim_x: 0.5
  acc_lim_theta: 1.0

  xy_goal_tolerance: 0.1
  yaw_goal_tolerance: 0.1
```
