# Spot Move Base

## Installation

```
sudo apt install ros-noetic-move-base
```

Also make sure all the dependencies of `rtabmap` are installed. see README.md in `spot_rtabmap` for more info.

## Running

- Modify `spot_ros/spot_viz/rviz/robot.rviz` .
- Change rviz/SetGoal to the following:

```
 - Class: rviz/SetGoal
 - Topic: /rtabmap/goal
```

- run

```
roslaunch spot_move_base spot_navigation.launch
```

will start both rtabmap and move_base.
