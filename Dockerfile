# The host's GPU driver version must support the container's CUDA version
#   To find your GPU driver version, run `nvidia-smi` and read "Driver Version"
#   To find which CUDA toolkit versions your driver supports, see Table 2:
#       https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
#
# For reference, Benned's driver version (535.183.01) supports CUDA toolkit 12.2.2
ARG CUDA_VERSION=12.2.2

# Enable overriding the base image for non-GPU machines (default uses GPU)
ARG BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-base-ubuntu20.04

## Stage 0: Install Git onto the base image (Ubuntu 20.04 LTS)
FROM ${BASE_IMAGE} AS ubuntu-git

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends git && \
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

## Stage A1: Install ROS 1 Noetic (Desktop-Full) onto the Ubuntu-Git image
FROM ubuntu-git AS noetic
ENV ROS_DISTRO=noetic

# Ensure that any failure in a pipe (|) causes the stage to fail
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install ROS Noetic, using the standard instructions (without sudo)
# Reference: https://wiki.ros.org/noetic/Installation/Ubuntu
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends lsb-release curl gnupg && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > \
        /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | \
        apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        # Allow ROS Noetic to implicitly select its own global Python version (3.8)
        ros-noetic-desktop-full \
        python3-rosdep \
        python3-rosinstall \
        python3-rosinstall-generator \
        python3-wstool \
        build-essential \
        # MoveIt's source build requires the following dependency (provides catkin build)
        # Reference: https://moveit.ai/install/source/
        python3-catkin-tools && \
        # TODO: Delete this comment if ros-noetic-catkin turns out to be unneeded
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

RUN rosdep init && \
    rosdep update

# Source ROS in all terminals
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

## Stage A2: Install MoveIt 1 for ROS Noetic from source (includes moveit_tutorials and panda_moveit_config)
FROM noetic AS noetic-moveit

# Build MoveIt from source in a new workspace within the container
# Reference: https://moveit.ai/install/source/
WORKDIR /moveit_ws
RUN wstool init src && \
    wstool merge -t src https://raw.githubusercontent.com/moveit/moveit/master/moveit.rosinstall && \
    wstool update -t src && \
    rosdep install -y --from-paths src --ignore-src --rosdistro "${ROS_DISTRO}"
RUN catkin config --extend "/opt/ros/${ROS_DISTRO}" --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin build
VOLUME /moveit_ws

# Source the MoveIt workspace in all terminals
RUN echo "source /moveit_ws/devel/setup.bash" >> ~/.bashrc

# Finalize the default working directory for the image
WORKDIR /spot_skills

## Stage B1: Install the Spot SDK and its dependencies onto the Ubuntu-Git image
FROM ubuntu-git as spot-sdk
ARG SPOT_SDK_VERSION

# Clone the Spot SDK from GitHub
WORKDIR /spot_sdk
RUN git clone --depth 1 --branch "v${SPOT_SDK_VERSION}" \
        https://github.com/boston-dynamics/spot-sdk.git
    # Add back if needed: git config --global http.sslVerify "false" then afterwards "true" 
VOLUME /spot_sdk

# Install the Boston Dynamics Python packages (needed to work with Spot)
RUN python3 -m pip install \
    bosdyn-client==${SPOT_SDK_VERSION} \
    bosdyn-mission==${SPOT_SDK_VERSION} \
    bosdyn-choreography-client==${SPOT_SDK_VERSION} \
    bosdyn-orbit==${SPOT_SDK_VERSION}

# Catch-all: Final `apt-get install` for any tools needed to work with Spot (saves rebuild time)
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends iputils-ping && \
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

# Finalize the default working directory for the image
WORKDIR /spot_sdk
