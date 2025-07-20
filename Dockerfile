### Minimal Dockerfile for ROS 1 Noetic + Spot dependencies ###

# Begin from a fixed version of the official ROS 1 Noetic Docker image
FROM ros:noetic-perception@sha256:ef5fdebeaa881604208c067f96d42b61331825309e559c093e24e9e89c7d3d2e AS spot-tamp-v3

# Install dependencies not included in the base image
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        git \
        python3-catkin-tools \
        ros-noetic-moveit \
        ros-noetic-trac-ik \
        ros-noetic-sensor-filters \
        ros-noetic-navigation \
        ros-noetic-rtabmap && \
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

# Source ROS in all terminals
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

WORKDIR /docker/rtabmap_ws/src
RUN git clone --depth 1 --branch noetic-devel https://github.com/introlab/rtabmap_ros

# Build RTAB-Map with the RTABMAP_SYNC_MULTI_RGBD flag
# Reference: https://github.com/introlab/rtabmap_ros/issues/453
WORKDIR /docker/rtabmap_ws

RUN catkin config --extend "/opt/ros/noetic" --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin build rtabmap_ros -DRTABMAP_SYNC_MULTI_RGBD=ON
VOLUME /docker/rtabmap_ws

# Source the rtabmap workspace in all terminals
RUN echo "source /docker/rtabmap_ws/devel/setup.bash" >> ~/.bashrc

RUN python3 -m pip install bosdyn-client==5.0.0 transforms3d==0.4.2

CMD ["bash"]

# Finalize the default working directory for the image
WORKDIR /docker/spot_skills

# TODO: I should pip install: bosdyn-client==5.0.0
# TODO: I haven't apt-get installed: iputils-ping
