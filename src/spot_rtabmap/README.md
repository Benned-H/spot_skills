# Spot_RTABMAP

## Installation

Spot has a stereo camera. Thus, it is necessary to compile a rtabmap that supports multiple cameras.

### Dependencies of rtabmap-ros

The easiest way to get all them (Qt, PCL, VTK, OpenCV, g2o, gtsam ...) is to install _AND THEN_ uninstall rtabmap binaries:

```
sudo apt install ros-$ROS_DISTRO-rtabmap*
sudo apt remove ros-$ROS_DISTRO-rtabmap*
```

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

Install point_cloud2_filter in src for filtering the raw point cloud from lidar. You will also need to install the (sensor_filters)[http://wiki.ros.org/sensor_filters] dependency.

The min and max height of the point cloud can be set in `config/spot_cloud_filter.yaml`
