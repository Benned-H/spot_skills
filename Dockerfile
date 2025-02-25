# The host's GPU driver version must support the container's CUDA version
#   To find your GPU driver version, run `nvidia-smi` and read "Driver Version"
#   To find which CUDA toolkit versions your driver supports, see Table 2:
#       https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
#
# For reference, Benned's driver version (570.86.15) supports CUDA toolkit 12.8 GA
ARG CUDA_VERSION=12.8.0

# Enable overriding the base image for non-GPU machines (default uses GPU)
ARG BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-base-ubuntu20.04

# Enable overriding the image onto which the Spot SDK is installed
ARG INSTALL_SPOT_SDK_ONTO=ubuntu-git-py

## Stage 0: Install Git, Python, and pip onto the base image (Ubuntu 20.04 LTS)
FROM ${BASE_IMAGE} AS ubuntu-git-py

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends git python3 python3-pip && \
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

## Stage A1: Install ROS 1 Noetic (Desktop-Full) and MoveIt 1 onto the Ubuntu-Git image
FROM ubuntu-git-py AS noetic-moveit
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
        python3-catkin-tools \
        ros-noetic-moveit

RUN rosdep init && \
    rosdep update

# Source ROS in all terminals
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Finalize the default working directory for the image
WORKDIR /docker/spot_skills

# For the next stage, renew the ARG specifying the image onto which the Spot SDK is installed
ARG INSTALL_SPOT_SDK_ONTO

## Stage B1/A2: Install the Spot SDK and its dependencies onto the selected image (default is Ubuntu-Git)
FROM ${INSTALL_SPOT_SDK_ONTO} AS spot-sdk
ARG SPOT_SDK_VERSION

# Clone the Spot SDK from GitHub
WORKDIR /docker/spot_sdk
RUN git config --global http.sslVerify "false" && \
    git clone --depth 1 --branch "v${SPOT_SDK_VERSION}" \
        https://github.com/boston-dynamics/spot-sdk.git && \
    git config --global http.sslVerify "true"
VOLUME /docker/spot_sdk

# Install the Boston Dynamics Python packages (needed to work with Spot)
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install \
    bosdyn-client==${SPOT_SDK_VERSION} \
    bosdyn-mission==${SPOT_SDK_VERSION} \
    bosdyn-choreography-client==${SPOT_SDK_VERSION} \
    bosdyn-orbit==${SPOT_SDK_VERSION}

# Catch-all: Final `apt-get install` for any tools needed to work with Spot
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends iputils-ping

# Set up the entrypoint script
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

# Finalize the default working directory for the image
WORKDIR /docker/spot_skills

## Stage A3: Clone rtabmap_ros from GitHub, then build it
FROM spot-sdk AS spot-rtabmap

WORKDIR /docker/rtabmap_ws/src
RUN git config --global http.sslVerify "false" && \
    git clone --depth 1 --branch noetic-devel https://github.com/introlab/rtabmap_ros && \
    git config --global http.sslVerify "true"

WORKDIR /docker/rtabmap_ws
RUN rosdep install -y --from-paths src --ignore-src --rosdistro "${ROS_DISTRO}" && \
    catkin config --extend "/opt/ros/${ROS_DISTRO}" --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin build rtabmap_ros -DRTABMAP_SYNC_MULTI_RGBD=ON
VOLUME /docker/rtabmap_ws

# Source the rtabmap workspace in all terminals
RUN echo "source /docker/rtabmap_ws/devel/setup.bash" >> ~/.bashrc

## Final Stage: Installs for TAMP experiments with Spot
FROM spot-rtabmap AS spot-tamp-v2

RUN apt-get install -y \
    ros-noetic-trac-ik-kinematics-plugin \
    ros-noetic-trac-ik-python

# Finalize the default working directory for the image
WORKDIR /docker/spot_skills
