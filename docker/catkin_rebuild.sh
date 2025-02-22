#!/usr/bin/env bash

# Clean and then build the Catkin workspace

catkin clean
catkin build rtabmap_ros -DRTABMAP_SYNC_MULTI_RGBD=ON
catkin build
source devel/setup.bash