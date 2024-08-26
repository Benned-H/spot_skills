# The host's GPU driver version must support the container's CUDA version
#   To find your GPU driver version, run `nvidia-smi` and read "Driver Version"
#   To find which CUDA toolkit versions your driver supports, see Table 2:
#       https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
#
# For reference, Benned's driver version (535.183.01) supports CUDA toolkit 12.2.2
ARG CUDA_VERSION=12.2.2

# Enable overriding the base image for non-GPU machines (default uses GPU)
ARG BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-base-ubuntu20.04

# Stage 1: Up-to-date Ubuntu 20.04 (possibly with CUDA support)
FROM ${BASE_IMAGE} AS ubuntu20.04

# Update and upgrade all packages (and their dependencies)
RUN apt-get update && apt-get -y dist-upgrade && apt-get clean

# Stage 2: Install ROS 1 Noetic (Desktop-Full) onto Ubuntu 20.04
FROM ubuntu20.04 AS noetic
ENV ROS_DISTRO=noetic

# Install ROS Noetic, using the standard instructions (without sudo)
RUN apt-get -y install lsb-release curl gnupg && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt-get update && \
    apt-get clean
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install ros-noetic-desktop-full
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential && \
    apt-get clean && \
    rosdep init && \
    rosdep update

# Stage 3: Add MoveIt and its tutorials into the image
FROM noetic AS noetic-moveit

# Install MoveIt 1 for ROS Noetic, alongside other tools, then source ROS
RUN apt-get -y install ros-noetic-moveit ros-noetic-catkin python3-catkin-tools python3-wstool git && \
    echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Clone and build the MoveIt tutorials in a dedicated workspace
# Reference: https://moveit.github.io/moveit_tutorials/doc/getting_started/getting_started.html
RUN mkdir -p /ws_moveit/src && \
    cd /ws_moveit/src && \
    git clone https://github.com/moveit/moveit_tutorials.git -b master --depth 1 && \
    git clone https://github.com/moveit/panda_moveit_config.git -b noetic-devel --depth 1 && \
    rosdep -y install --from-paths . --ignore-src --rosdistro noetic
RUN cd /ws_moveit && \
    catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin build && \
    echo "source /ws_moveit/devel/setup.bash" >> ~/.bashrc

VOLUME /ws_moveit