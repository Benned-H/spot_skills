# Spot Skills - Complete Reference

This document provides a comprehensive reference for all skills and components in the `spot_skills` package.

## Core Robot Control (`src/spot_skills_py/spot/`)

### Connection and Management

**[spot_manager.py](../src/spot_skills/src/spot_skills_py/spot/spot_manager.py)**
- Robot connection establishment and lease management
- Power control (stand up, sit down, power on/off)
- E-stop integration
- Time synchronization with robot
- Core SDK client initialization

**[spot_ros_wrapper.py](../src/spot_skills/src/spot_skills_py/spot/spot_ros_wrapper.py)**
- Main ROS 1 interface providing action servers and services
- Bridges Spot SDK to ROS ecosystem
- Manages ROS node lifecycle
- Provides unified interface for all robot capabilities

### Navigation Skills

**[spot_graph_nav.py](../src/spot_skills/src/spot_skills_py/spot/spot_graph_nav.py)**
- GraphNav-based navigation using visual SLAM
- Waypoint-based navigation on recorded maps
- Localization to fiducial markers
- Map upload and management
- Visual features for robust localization

**[spot_navigation.py](../src/spot_skills/src/spot_skills_py/spot/spot_navigation.py)**
- Navigation server with waypoint management
- Create, store, and navigate to named waypoints
- Navigate to arbitrary poses in base frame
- Timeout handling and navigation status reporting

**[spot_mobile_base.py](../src/spot_skills/src/spot_skills_py/spot/spot_mobile_base.py)**
- Mobile base velocity control
- Subscribes to `cmd_vel` for teleoperation
- Integration with ROS navigation stack

### Manipulation Skills

**[spot_arm_controller.py](../src/spot_skills/src/spot_skills_py/spot/spot_arm_controller.py)**
- Arm trajectory execution and control
- MoveIt-compatible `FollowJointTrajectory` action server
- Joint position, velocity, and effort control
- Gripper action server (open/close commands)
- Trajectory validation and execution monitoring

**[spot_open_door.py](../src/spot_skills/src/spot_skills_py/spot/spot_open_door.py)**
- Autonomous door opening skill
- Handles pull/push doors with configurable hinge side
- Vision-based door handle detection
- Force control during door manipulation
- Parameterized approach and manipulation

**[spot_force_controller.py](../src/spot_skills/src/spot_skills_py/spot/spot_force_controller.py)**
- Force-controlled manipulation
- Compliant interaction with environment
- Used in door opening and surface contact tasks

**[spot_erase.py](../src/spot_skills/src/spot_skills_py/spot/spot_erase.py)**
- Whiteboard/surface erasing skill
- Trajectory-based erasing motion
- Configurable erase patterns

### Perception Skills

**[spot_image_client.py](../src/spot_skills/src/spot_skills_py/spot/spot_image_client.py)**
- Image capture from Spot's 5 cameras
- RGB and RGB-D image acquisition
- Synchronized multi-camera capture
- Camera calibration info access
- Service interface for perception pipelines

**[spot_lidar.py](../src/spot_skills/src/spot_skills_py/spot/spot_lidar.py)**
- LiDAR point cloud processing
- 3D perception for navigation and mapping
- Integration with SLAM systems

**Surface Probing** (via services)
- Contact detection with environment
- Force-controlled surface exploration
- Position and force feedback

### Utilities and Infrastructure

**[joint_trajectory.py](../src/spot_skills/src/spot_skills_py/spot/joint_trajectory.py)**
- Trajectory dataclasses and conversions
- Spot SDK ↔ ROS message translation
- JointTrajectory, JointTrajectoryPoint, JointState conversions
- Time-stamped trajectory management

**[spot_configuration.py](../src/spot_skills/src/spot_skills_py/spot/spot_configuration.py)**
- Joint names and configuration constants
- Arm and gripper joint definitions
- Robot-specific parameters

**[spot_conversion.py](../src/spot_skills/src/spot_skills_py/spot/spot_conversion.py)**
- Unit conversions (meters, radians, etc.)
- Coordinate frame transformations
- Quaternion and rotation conversions

**[spot_sync.py](../src/spot_skills/src/spot_skills_py/spot/spot_sync.py)**
- Time synchronization with robot clock
- ROS time ↔ Spot time conversions
- Ensures temporal consistency across systems

**[visualize_graphnav.py](../src/spot_skills/src/spot_skills_py/spot/visualize_graphnav.py)**
- GraphNav map visualization in RViz
- Waypoint and edge rendering
- Navigation path display

**[joint_state_mux.py](../src/spot_skills/src/spot_skills_py/spot/joint_state_mux.py)**
- Multiplexes joint state from multiple sources
- Merges real robot state with planned trajectories
- Provides unified joint state topic

**[segment_schedule.py](../src/spot_skills/src/spot_skills_py/spot/segment_schedule.py)**
- Trajectory segmentation and scheduling
- Breaks long trajectories into executable segments
- Timing and synchronization management

**[time_stamp.py](../src/spot_skills/src/spot_skills_py/spot/time_stamp.py)**
- Timestamp management utilities
- ROS time handling
- Time conversion helpers

## Planning and Sampling

**[put_down_surface.py](../src/spot_skills/src/spot_skills_py/planners/put_down_surface.py)**
- Surface modeling for object placement
- Collision-free placement planning
- Planning scene integration

**[put_down_pose_sampler.py](../src/spot_skills/src/spot_skills_py/samplers/put_down_pose_sampler.py)**
- Samples valid object placement poses
- Collision checking during sampling
- Configurable sampling strategies

**[sampler.py](../src/spot_skills/src/spot_skills_py/samplers/sampler.py)**
- Base sampler class for pose and trajectory sampling
- Abstract interface for custom samplers

**[real_range.py](../src/spot_skills/src/spot_skills_py/samplers/real_range.py)**
- Real number range sampling
- Uniform and non-uniform distributions

## Transform Management

**[transform_manager.py](../src/spot_skills/src/transform_utils/transform_manager.py)**
- TF2 broadcaster/listener wrapper
- Simplified transform lookup and publishing
- ROS transform tree management

**[kinematics.py](../src/spot_skills/src/transform_utils/kinematics.py)**
- Kinematic data structures
- Pose and transform representations

**[kinematics_ros.py](../src/spot_skills/src/transform_utils/kinematics_ros.py)**
- ROS-TF conversions
- Geometry message conversions

## Robotics Utilities (Submodule)

A comprehensive library of reusable robotics abstractions at [src/robotics_utils/](../src/spot_skills/src/robotics_utils/):

- **abstractions/**: High-level task planning (PDDL, operators, effects, predicates)
- **collision_models/**: Collision checking (primitive shapes, meshes, point clouds)
- **geometry/**: Geometric utilities (points, planes, AABB, polygons)
- **kinematics/**: Forward/inverse kinematics solvers
- **motion_planning/**: Motion planning queries and navigation goals
- **perception/**: Occupancy grids, laser scans, point cloud processing
- **planning/**: Planning abstractions and interfaces
- **robots/**: Robot model abstractions
- **ros/**: ROS utilities (transform manager, message conversions)
- **skills/**: Skill outcome definitions and result handling
- **spatial/**: 2D/3D pose representations, SE(2)/SE(3) operations
- **vision/**: Computer vision (fiducials, reconstruction, camera models)
- **state_estimation/**: State estimation modules

## Configuration Files

**[config/env.yaml](../src/spot_skills/config/env.yaml)**
- Environment configuration (room dimensions, object locations)
- Planning scene setup

**[config/known_objects.yaml](../src/spot_skills/config/known_objects.yaml)**
- Object database (names, dimensions, properties)
- Object mesh file references

**[config/markers.yaml](../src/spot_skills/config/markers.yaml)**
- Fiducial marker definitions (ArUco, AprilTag)
- Marker IDs and sizes

**[config/map_to_seed.yaml](../src/spot_skills/config/map_to_seed.yaml)**
- Navigation seed mapping
- Map-specific configuration

**[config/erase_traj.yaml](../src/spot_skills/config/erase_traj.yaml)**
- Erasing task trajectory definitions
- Whiteboard erasing patterns

**[config/trajectories/](../src/spot_skills/config/trajectories/)**
- Recorded arm trajectories (YAML format)
- Playback-ready motion sequences

## Message and Service Definitions

### Messages

**[msg/ObjectPose.msg](../src/spot_skills/msg/ObjectPose.msg)**
```
string object_name
geometry_msgs/PoseStamped pose
```

**[msg/RGBImage.msg](../src/spot_skills/msg/RGBImage.msg)**
```
sensor_msgs/Image image
sensor_msgs/CameraInfo camera_info
string camera_name
```

**[msg/RGBDPair.msg](../src/spot_skills/msg/RGBDPair.msg)**
```
sensor_msgs/Image rgb
sensor_msgs/Image depth
sensor_msgs/CameraInfo rgb_info
sensor_msgs/CameraInfo depth_info
string camera_name
```

### Services

All services in [srv/](../src/spot_skills/srv/):

- **NavigateToPose.srv**: Navigate to target pose with timeout
- **OpenDoor.srv**: Door opening with parameters (pitch, hinge side, offset)
- **PlaybackTrajectory.srv**: Execute recorded trajectory from YAML
- **GetRGBDPairs.srv**: Get synchronized RGB-D image pairs
- **GetRGBImages.srv**: Get RGB images from cameras
- **ProbeSurface.srv**: Probe surface for contact detection
- **PoseLookup.srv**: Lookup object poses by name
- **NameService.srv**: Generic name-based service interface
