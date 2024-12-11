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

## Methods of local planning
### move_base: global + local
In `spot_move_base/launch/include/move_base.launch`, comment out this line:
```
<remap from="cmd_vel" to="/null/cmd_vel" />
```

It will activate the local planner and directly send vel to spot. Depending on the latency, it may or may not work very smoothly.


### move_base global planner only + send pose to spot
Start `spot_navigation.launch` as documented above.
Also run this script to send the 60th point in the global planner trajectory to `/spot/go_to_pose`:
```
rosrun spot_move_base send_traj.py
```

It's not perfect, but it seems a bit smoother than the method above over WiFi.

### custom python planner given the cost map
TODO.
