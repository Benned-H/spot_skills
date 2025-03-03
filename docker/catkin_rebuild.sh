#!/usr/bin/env bash

# Clean and then build the Catkin workspace

catkin clean

# Source the rtabmap_ros workspace as an "underlay" of the spot_skills workspace
# Reference: https://wiki.ros.org/catkin/Tutorials/workspace_overlaying
source /docker/rtabmap_ws/devel/setup.bash
catkin build
source devel/setup.bash
