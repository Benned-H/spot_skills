# API Reference

Complete reference for ROS services, actions, topics, and Python APIs.

## ROS Services

All services are under the `/spot/` namespace:

| Service | Type | Description | Request | Response |
|---------|------|-------------|---------|----------|
| `/spot/navigation/to_waypoint` | NameService | Navigate to named waypoint | name: string | success: bool, message: string |
| `/spot/navigation/create_waypoint` | NameService | Create waypoint at current pose | name: string | success: bool, message: string |
| `/spot/navigate_to_pose` | NavigateToPose | Navigate to target pose with timeout | pose: PoseStamped, timeout_s: float | success: bool, message: string |
| `/spot/open_door` | OpenDoor | Open door with parameters | pitch: float, is_pull: bool, hinge_on_left: bool, offset: float, search_dist: float | success: bool, message: string |
| `/spot/playback_trajectory` | PlaybackTrajectory | Execute recorded arm trajectory | yaml_path: string | success: bool, message: string |
| `/spot/get_rgb_images` | GetRGBImages | Get RGB images from all cameras | - | images: RGBImage[] |
| `/spot/get_rgbd_pairs` | GetRGBDPairs | Get synchronized RGB-D pairs | - | pairs: RGBDPair[] |
| `/spot/probe_surface` | ProbeSurface | Probe surface with force control | position: Point, force: float | contact_info: ... |
| `/spot/pose_lookup` | PoseLookup | Lookup object pose by name | object_name: string | pose: ObjectPose |
| `/spot/unlock_arm` | NameService | Unlock ROS control of arm | - | success: bool, message: string |
| `/spot/lock_arm` | NameService | Lock ROS control of arm | - | success: bool, message: string |

## ROS Action Servers

### Arm Control

**Server**: `arm_controller/follow_joint_trajectory`
**Type**: `control_msgs/FollowJointTrajectoryAction`

Execute arm trajectories with MoveIt compatibility.

**Goal**:
```python
trajectory: trajectory_msgs/JointTrajectory
path_tolerance: JointTolerance[]
goal_tolerance: JointTolerance[]
goal_time_tolerance: duration
```

**Result**:
```python
error_code: int32
error_string: string
```

**Feedback**:
```python
header: std_msgs/Header
joint_names: string[]
desired: JointTrajectoryPoint
actual: JointTrajectoryPoint
error: JointTrajectoryPoint
```

### Gripper Control

**Server**: `gripper_controller/gripper_action`
**Type**: `control_msgs/GripperCommandAction`

Control gripper open/close.

**Goal**:
```python
command:
  position: float64  # 0.0 = closed, 1.0 = open
  max_effort: float64
```

**Result**:
```python
position: float64
effort: float64
stalled: bool
reached_goal: bool
```

## ROS Topics

### Subscribed Topics

| Topic | Type | Description |
|-------|------|-------------|
| `/cmd_vel` | geometry_msgs/Twist | Mobile base velocity commands |
| `/spot/camera/frontleft/image` | sensor_msgs/Image | Front left camera image |
| `/spot/camera/frontright/image` | sensor_msgs/Image | Front right camera image |
| `/spot/lidar/points` | sensor_msgs/PointCloud2 | LiDAR point cloud |

### Published Topics

| Topic | Type | Description |
|-------|------|-------------|
| `/joint_states` | sensor_msgs/JointState | Arm and gripper joint states |
| `/odom` | nav_msgs/Odometry | Base odometry |
| `/tf` | tf2_msgs/TFMessage | Dynamic transforms |
| `/tf_static` | tf2_msgs/TFMessage | Static transforms |
| `/spot/point_cloud` | sensor_msgs/PointCloud2 | Processed LiDAR data |

## Custom Message Types

### ObjectPose.msg
```
string object_name
geometry_msgs/PoseStamped pose
```

**Usage**: Object pose lookup results

### RGBImage.msg
```
sensor_msgs/Image image
sensor_msgs/CameraInfo camera_info
string camera_name
```

**Usage**: RGB image with calibration info

### RGBDPair.msg
```
sensor_msgs/Image rgb
sensor_msgs/Image depth
sensor_msgs/CameraInfo rgb_info
sensor_msgs/CameraInfo depth_info
string camera_name
```

**Usage**: Synchronized RGB-D image pair

## Python API

### Service Client Example

```python
import rospy
from spot_skills.srv import NavigateToPose, OpenDoor
from geometry_msgs.msg import PoseStamped

# Initialize ROS node
rospy.init_node('my_spot_client')

# Navigate to pose
nav_service = rospy.ServiceProxy('/spot/navigate_to_pose', NavigateToPose)
target = PoseStamped()
target.header.frame_id = "map"
target.pose.position.x = 1.0
target.pose.position.y = 0.5
target.pose.orientation.w = 1.0
result = nav_service(target, timeout_s=30.0)
print(f"Navigation result: {result.success}, {result.message}")

# Open door
door_service = rospy.ServiceProxy('/spot/open_door', OpenDoor)
result = door_service(
    pitch=0.0,
    is_pull=True,
    hinge_on_left=True,
    offset=0.0,
    search_dist=0.5
)
print(f"Door opening result: {result.success}")
```

### Action Client Example

```python
import rospy
import actionlib
from control_msgs.msg import FollowJointTrajectoryAction, FollowJointTrajectoryGoal
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

rospy.init_node('arm_client')

# Create action client
client = actionlib.SimpleActionClient(
    'arm_controller/follow_joint_trajectory',
    FollowJointTrajectoryAction
)
client.wait_for_server()

# Create trajectory
goal = FollowJointTrajectoryGoal()
goal.trajectory = JointTrajectory()
goal.trajectory.joint_names = [
    'arm_sh0', 'arm_sh1', 'arm_el0',
    'arm_el1', 'arm_wr0', 'arm_wr1', 'arm_f1x'
]

# Add trajectory point
point = JointTrajectoryPoint()
point.positions = [0.0, -1.57, 0.0, 1.57, 0.0, 0.0, 0.0]
point.time_from_start = rospy.Duration(2.0)
goal.trajectory.points.append(point)

# Send goal and wait
client.send_goal_and_wait(goal)
result = client.get_result()
print(f"Execution result: {result.error_code}")
```

### Topic Subscriber Example

```python
import rospy
from sensor_msgs.msg import JointState

def joint_state_callback(msg):
    print(f"Joint positions: {msg.position}")
    print(f"Joint names: {msg.name}")

rospy.init_node('joint_listener')
rospy.Subscriber('/joint_states', JointState, joint_state_callback)
rospy.spin()
```

### Topic Publisher Example

```python
import rospy
from geometry_msgs.msg import Twist

rospy.init_node('teleop')
pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

rate = rospy.Rate(10)  # 10 Hz
while not rospy.is_shutdown():
    cmd = Twist()
    cmd.linear.x = 0.5  # Move forward at 0.5 m/s
    cmd.angular.z = 0.0
    pub.publish(cmd)
    rate.sleep()
```

## TF Frame Hierarchy

```
map
├── odom
│   └── base_link
│       ├── body
│       │   ├── arm_link_sh0
│       │   │   └── arm_link_sh1
│       │   │       └── arm_link_el0
│       │   │           └── arm_link_el1
│       │   │               └── arm_link_wr0
│       │   │                   └── arm_link_wr1
│       │   │                       └── arm_link_fngr
│       │   ├── front_left_camera
│       │   ├── front_right_camera
│       │   ├── left_camera
│       │   ├── right_camera
│       │   └── back_camera
│       ├── front_left_leg
│       ├── front_right_leg
│       ├── rear_left_leg
│       └── rear_right_leg
└── [objects]
    ├── object1
    ├── object2
    └── ...
```

## Parameters

### Robot Configuration

- `spot_name` (string): Robot identifier/hostname
- `username` (string): Spot SDK username
- `password` (string): Spot SDK password

### Navigation

- `max_velocity` (float): Maximum base velocity (m/s)
- `max_angular_velocity` (float): Maximum angular velocity (rad/s)
- `goal_tolerance` (float): Position tolerance for navigation goals (m)

### Arm Control

- `arm_joint_names` (string[]): List of arm joint names
- `trajectory_execution_timeout` (float): Timeout for trajectory execution (s)

### Perception

- `camera_names` (string[]): List of camera identifiers
- `depth_range_min` (float): Minimum depth value (m)
- `depth_range_max` (float): Maximum depth value (m)
