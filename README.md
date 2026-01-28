# Spot Skills - Task and Motion Planning Framework

A comprehensive motion-planning-based robotic skills framework for Boston Dynamics' Spot robot, integrating high-level task planning (PDDL), low-level motion planning, and real-world robot control via the Spot SDK and ROS 1 Noetic.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Architecture](#architecture)
- [Documentation](#documentation)
- [Key Components](#key-components)
- [Dependencies](#dependencies)
- [Development](#development)
- [Resources](#resources)

## Overview

**spot_skills** enables complex long-horizon robotic tasks by combining:
- **High-level task planning**: PDDL/PPDDL symbolic planning domains
- **Low-level motion planning**: Trajectory generation, arm control, navigation
- **ROS 1 integration**: Action servers, services, and topic-based control
- **TMP3 integration**: Task and Motion Policies for stochastic environments
- **Real robot control**: Direct integration with Spot SDK v5.0.1

### Key Features

- Motion-based skills (navigation, manipulation, door opening, surface probing)
- GraphNav-based visual SLAM navigation
- MoveIt-based arm motion planning
- RTAB-Map SLAM and mapping
- Synchronized RGB-D image capture
- Force control during manipulation
- Trajectory recording and playback
- Stochastic task and motion planning with TMP3

## Quick Start

### Docker Setup

```bash
# Enable X11 forwarding for GUI applications
xhost +local:docker

# Launch the container
docker compose up spot-tamp-v3.1 --detach
docker compose exec spot-tamp-v3.1 bash

# Inside container: Setup Python environment
uv venv --system-site-packages --python 3.8
source .venv/bin/activate
uv pip install -e .

# Build ROS workspace
catkin build
source devel/setup.bash
```

### Running Demos

**MoveIt Arm Control** (simulated):
```bash
roslaunch spot_skills moveit_spot_demo.launch
```

**MoveIt with Real Robot**:
```bash
roslaunch spot_skills moveit_spot_demo.launch real_robot:=true spot_name:=<robot_name>
```

**Navigation Demo**:
```bash
roslaunch spot_skills spot_nav_demo.launch spot_name:=<robot_name>
```

**Door Opening Demo**:
```bash
roslaunch spot_skills open_door_demo.launch spot_name:=<robot_name>
```

**See**: [Demos and Examples](docs/demos-and-examples.md) for complete demo documentation.

## Architecture

### Layer Stack

```
┌─────────────────────────────────────────────┐
│  Layer 7: Application / User Interface      │
│  - Launch files, ROS services/actions       │
├─────────────────────────────────────────────┤
│  Layer 6: Task Planning (TMP3)              │
│  - PDDL domain/problem, Policy generation   │
├─────────────────────────────────────────────┤
│  Layer 5: Motion Planning                   │
│  - MoveIt, RTAB-Map, move_base              │
├─────────────────────────────────────────────┤
│  Layer 4: Skill Implementation              │
│  - Navigation, Manipulation, Perception     │
├─────────────────────────────────────────────┤
│  Layer 3: ROS 1 Wrapper                     │
│  - spot_ros_wrapper (action/service layer)  │
├─────────────────────────────────────────────┤
│  Layer 2: Spot SDK                          │
│  - bosdyn-client (Python SDK)               │
├─────────────────────────────────────────────┤
│  Layer 1: Robot Hardware                    │
│  - Spot robot (arm, gripper, cameras, etc.) │
└─────────────────────────────────────────────┘
```

### Directory Structure

```
spot_skills/
├── src/spot_skills/               # Main package
│   ├── src/spot_skills_py/        # Core Python library
│   │   ├── spot/                  # Spot robot control modules
│   │   ├── planners/              # Planning scene management
│   │   ├── samplers/              # Pose and trajectory sampling
│   │   └── [utilities]            # Joint trajectories, transforms, etc.
│   ├── src/robotics_utils/        # Reusable robotics abstractions (submodule)
│   ├── src/transform_utils/       # Transform management utilities
│   ├── config/                    # Configuration files (env, objects, markers)
│   ├── launch/                    # ROS launch files
│   ├── scripts/                   # Executable ROS nodes
│   ├── msg/                       # Custom message definitions
│   ├── srv/                       # Service definitions
│   └── tests/                     # Unit tests
├── src/TMP3/                      # Task and Motion Planning package
├── src/spot_ros/                  # Spot SDK ROS driver (submodule)
├── src/spot_move_base/            # Navigation configuration
├── src/spot_rtabmap/              # RTAB-Map SLAM integration
├── src/spot_moveit_config/        # MoveIt arm planning config
├── src/rtabmap_ros/               # RTAB-Map package (submodule)
├── src/object_detection_msgs/     # Object detection messages
├── src/pose_estimation_msgs/      # Pose estimation messages
├── docker/                        # Docker infrastructure
├── docs/                          # Documentation
├── Dockerfile                     # Container image definition
├── compose.yaml                   # Docker Compose services
└── pyproject.toml                 # Python project configuration
```

## Documentation

### Core Documentation

- **[Spot Skills Reference](docs/spot-skills-reference.md)** - Complete inventory of all robot skills, utilities, and configurations
- **[TMP3 Guide](docs/tmp3-guide.md)** - Task and Motion Planning overview and workflow
- **[TMP3 Input Specifications](docs/tmp3-input-specs.md)** - PDDL, ActionConfig, and environment YAML formats
- **[TMP3 Patterns](docs/tmp3-patterns.md)** - Generator, Predicate, and Executor patterns for custom domains
- **[API Reference](docs/api-reference.md)** - ROS services, actions, topics, and Python API
- **[Configuration Guide](docs/configuration.md)** - Environment setup, objects, markers, trajectories
- **[Demos and Examples](docs/demos-and-examples.md)** - Launch files, scripts, and real-world workflows
- **[Development Guide](docs/development.md)** - Building, testing, and contributing

### Specialized Guides

- **[navigation-demo.md](docs/navigation-demo.md)** - GraphNav-based navigation
- **[mapping-demo.md](docs/mapping-demo.md)** - SLAM mapping with RTAB-Map
- **[object-pose-estimation-demo.md](docs/object-pose-estimation-demo.md)** - Pose estimation setup

## Key Components

### Spot Skills Inventory

The [spot_skills package](docs/spot-skills-reference.md) provides comprehensive robot control:

**Navigation**: GraphNav, waypoint navigation, mobile base control
**Manipulation**: Arm control, door opening, force control, erasing
**Perception**: RGB-D imaging, LiDAR, surface probing
**Infrastructure**: Trajectory management, transforms, time sync

**See**: [Spot Skills Reference](docs/spot-skills-reference.md) for complete details.

### TMP3 Task and Motion Planner

[TMP3](docs/tmp3-guide.md) implements planning for stochastic environments:

**Key Concept**: Generates executable *policies* (not just plans) that handle multiple contingencies and stochastic action outcomes.

**Workflow**:
1. Define PDDL domain and problem (abstract task)
2. Create ActionConfig (maps abstract → concrete actions)
3. Run TMP3 planner → generates refined policy tree
4. Execute policy on real robot

**Example Domains**:
- **SpotTAMP**: Erase, open-door, open-drawer, pick-from-drawer
- **SpotPickAndPlace**: Pick and place objects
- **DelicateCan**: Stochastic manipulation with failure modes

**See**: [TMP3 Guide](docs/tmp3-guide.md) for architecture and usage.

### ROS Packages

**Core Packages**:
- **spot_skills** - Main package with robot skills
- **TMP3** - Task and Motion Planning
- **spot_ros** - Spot SDK ROS driver (submodule)
- **spot_moveit_config** - MoveIt arm planning
- **spot_rtabmap** - RTAB-Map SLAM
- **spot_move_base** - Navigation stack

**See**: [API Reference](docs/api-reference.md) for ROS services and topics.

## ROS Services and APIs

### Key Services

| Service | Type | Description |
|---------|------|-------------|
| `/spot/navigate_to_pose` | NavigateToPose | Navigate to target pose |
| `/spot/open_door` | OpenDoor | Open door with parameters |
| `/spot/playback_trajectory` | PlaybackTrajectory | Execute recorded trajectory |
| `/spot/get_rgbd_pairs` | GetRGBDPairs | Get RGB-D image pairs |

### Action Servers

| Action | Type | Description |
|--------|------|-------------|
| `arm_controller/follow_joint_trajectory` | FollowJointTrajectoryAction | MoveIt arm control |
| `gripper_controller/gripper_action` | GripperCommandAction | Gripper control |

**See**: [API Reference](docs/api-reference.md) for complete API documentation.

## Dependencies

### System Dependencies
- ROS 1 Noetic (ros-noetic-desktop-full)
- RTAB-Map (compiled with MULTI_RGBD support)
- MoveIt (motion planning framework)
- OpenCV (computer vision)

### Python Dependencies
- bosdyn-client == 5.0.1 (Spot SDK)
- numpy >= 1.20
- scipy >= 1.5
- transforms3d
- opencv-python
- robotics_utils[vision] (submodule)
- tmp3 (workspace member)

### Build System
- catkin (ROS 1 build tool)
- uv (Python package manager)
- hatchling (Python build backend)

## Development

### Building the Workspace

```bash
# Inside Docker container
catkin build
source devel/setup.bash
```

### Python Development

```bash
# Install in editable mode
uv pip install -e .

# Run type checking
mypy src/spot_skills/src/spot_skills_py

# Run linting
ruff check src/spot_skills/src/spot_skills_py
```

### Testing

```bash
# Python tests
pytest src/spot_skills/tests/

# ROS tests
catkin build --catkin-make-args run_tests
catkin_test_results
```

**See**: [Development Guide](docs/development.md) for detailed development instructions.

### Git Submodules

```bash
# Update all submodules
git submodule update --init --recursive

# Pull latest changes
./docker/git_pull_all.sh
```

**Submodules**:
- `src/spot_ros` - Spot ROS driver
- `src/robotics_utils` - Robotics utilities library
- `src/rtabmap_ros` - RTAB-Map packages
- `docker/ros_docker` - Docker infrastructure

## Docker Infrastructure

**Service**: `spot-tamp-v3.1`

**Features**:
- X11 forwarding for GUI applications
- Network host mode for ROS communication
- Volume mounts for code persistence
- Privileged mode for hardware access

**Launch**:
```bash
docker compose up spot-tamp-v3.1 --detach
docker compose exec spot-tamp-v3.1 bash
```

## Project Status

**Current Branch**: `icra_wyc`
**Main Branch**: `main`

**Recent Updates**:
- TMP3 integration with perception-based grasping
- SciLi erase board TAMP sequence
- RSS and ICRA demonstration support
- GraphNav navigation improvements

## Resources

- **Spot SDK Documentation**: https://dev.bostondynamics.com/
- **ROS Noetic**: http://wiki.ros.org/noetic
- **MoveIt**: https://moveit.ros.org/
- **RTAB-Map**: http://introlab.github.io/rtabmap/
- **TMP3 Paper**: https://aair-lab.github.io/atam/atam_full_version.pdf

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

See [LICENSE](LICENSE) file.

---

*This README provides a high-level overview. For detailed information, see the [documentation](docs/) directory.*
