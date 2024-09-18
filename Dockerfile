# The host's GPU driver version must support the container's CUDA version
#   To find your GPU driver version, run `nvidia-smi` and read "Driver Version"
#   To find which CUDA toolkit versions your driver supports, see Table 2:
#       https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
#
# For reference, Benned's driver version (535.183.01) supports CUDA toolkit 12.2.2
ARG CUDA_VERSION=12.2.2

# Enable overriding the base image for non-GPU machines (default uses GPU)
ARG BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-base-ubuntu20.04

## Stage 1: Up-to-date Ubuntu 20.04 (possibly with CUDA support)
FROM ${BASE_IMAGE} AS ubuntu20.04

# Update and upgrade all packages (and their dependencies)
RUN apt-get update && apt-get -y dist-upgrade && apt-get clean

## Stage 2: Install ROS 1 Noetic (Desktop-Full) onto Ubuntu 20.04
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

# Source ROS in all terminals
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

## Stage 3: Install MoveIt 1 for ROS Noetic from source (includes moveit_tutorials and panda_moveit_config)
# Reference: http://moveit.ros.org/install/source/
FROM noetic AS noetic-moveit

# Install required catkin build tools and Git
RUN apt-get -y install ros-noetic-catkin python3-catkin-tools git

# Download MoveIt's source code into a new workspace, install its dependencies, and build
WORKDIR /moveit_ws
RUN wstool init src && \
    wstool merge -t src https://raw.githubusercontent.com/moveit/moveit/master/moveit.rosinstall && \
    wstool update -t src
RUN rosdep install -y --from-paths src --ignore-src --rosdistro ${ROS_DISTRO}
RUN catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release
RUN catkin build

VOLUME /moveit_ws

# Source MoveIt in all terminals
RUN echo "source /moveit_ws/devel/setup.bash" >> ~/.bashrc

# Finalize the intended working directory for the image
WORKDIR /spot_skills

## Stage 4: Install Spot ROS 1 driver and the Spot SDK
FROM noetic-moveit AS spot-moveit

# The Spot Python SDK says it supports Ubuntu 18.04 LTS and Python 3.6-3.8
#   However, to keep things uniform across the repo, try a newer version
# Reference: https://dev.bostondynamics.com/docs/python/quickstart
ARG PYTHON_VERSION=3.12

# Ensure Python and pip are installed
RUN apt-get -y install python${PYTHON_VERSION} python3-pip

# Install the Boston Dynamics SDK (needed to work with Spot)
# Maybe need: --break-system-packages \
RUN pip install --upgrade \
    bosdyn-client bosdyn-mission bosdyn-choreography-client bosdyn-orbit

# Ensure that all submodules are updates, and install their dependencies
RUN git submodule update --init --recursive && \
    rosdep install --from-paths src --ignore-src -r -y

# Pip-install the Spot ROS driver's wrapper for Python
WORKDIR /spot_skills/src/spot_ros
RUN pip install -e spot_wrapper

# Clone the Spot SDK from GitHub
WORKDIR /spot_sdk
RUN git clone https://github.com/boston-dynamics/spot-sdk.git --depth 1
VOLUME /spot_sdk

# Catch-all: Additional tools needed to work with Spot
RUN apt-get -y install iputils-ping

# Finalize the intended working directory for the image
WORKDIR /spot_skills
