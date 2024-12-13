# Spot_RTABMAP

## Installation

Spot has a stereo camera. Thus, it is necessary to compile a rtabmap that supports multiple cameras.

### Dependencies of rtabmap-ros

To install any missing ROS dependencies of `rtabmap_ros`, ensure that all submodules are up-to-date
and then use `rosdep` to install their dependencies:

```bash
git submodule update --init --recursive
rosdep install --from-paths src --ignore-src -y
```

To build the package, run `catkin build` with the `-DRTABMAP_SYNC_MULTI_RGBD` flag:

```bash
catkin build -DRTABMAP_SYNC_MULTI_RGBD=ON
```

This ensures that RTAB-Map sync multi is on.

### Compiling Rtabmap

In the docker, run

```
mkdir /docker/spot_skill/repo/
cd /docker/spot_skill/repo/

git clone https://github.com/introlab/rtabmap.git rtabmap
cd rtabmap/build
cmake ..  [<---double dots included]
make -j6
sudo make install
```

### Catkin Build Rtabmap

Remember to specify rtabmap sync multi to be on.

```bash
git submodule update --init --recursive

catkin build -DRTABMAP_SYNC_MULTI_RGBD=ON
```

### Add Passthrough Filter

Install point_cloud2_filter in src for filtering the raw point cloud from lidar. You will also need to install the [sensor_filters](http://wiki.ros.org/sensor_filters) dependency.

The min and max height of the point cloud can be set in `config/spot_cloud_filter.yaml`.

NOTE: The filtering is not perfect. We need to filter at least three parts of the point cloud: The part higher than the door, the part close to the ground (the annoying circles), and the trajectories of Spot's own arm. For now, we are only filtering out the first and the second but not the third. The filtering of the arm trjectory will be implemented soon.
