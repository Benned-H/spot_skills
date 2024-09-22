# The host's GPU driver version must support the container's CUDA version
#   To find your GPU driver version, run `nvidia-smi` and read "Driver Version"
#   To find which CUDA toolkit versions your driver supports, see Table 2:
#       https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html
#
# For reference, Benned's driver version (535.183.01) supports CUDA toolkit 12.2.2
ARG CUDA_VERSION=12.2.2

# Enable overriding the base image for non-GPU machines (default uses GPU)
ARG BASE_IMAGE=nvidia/cuda:${CUDA_VERSION}-base-ubuntu20.04

# Enable overriding the base image for the Spot SDK service (skips ROS stages)
ARG SPOT_BASE_IMAGE=noetic-moveit

## Stage 1: Install ROS 1 Noetic (Desktop-Full) onto the base image (Ubuntu 20.04 LTS)
FROM ${BASE_IMAGE} AS noetic
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
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

RUN rosdep init && \
    rosdep update

# Source ROS in all terminals
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

## Stage 2: Install MoveIt 1 (from binary) and its tutorials (from source)
# TODO: Fix versions for all of these installs, once working
FROM noetic AS noetic-moveit

# Install MoveIt 1 from binary (Reference: https://moveit.ai/install/)
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends ros-noetic-moveit \
        # These dependencies come from MoveIt's "Getting Started" tutorial
        ros-noetic-catkin \
        python3-catkin-tools \
        git && \
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

# Build the MoveIt tutorials from source in a new workspace in the container
# Reference: https://moveit.github.io/moveit_tutorials/doc/getting_started/getting_started.html
WORKDIR /moveit_ws/src
RUN wstool init . && \
    git clone https://github.com/moveit/moveit_tutorials.git -b master && \
    git clone https://github.com/moveit/panda_moveit_config.git -b noetic-devel && \
    rosdep install -y --from-paths . --ignore-src --rosdistro "${ROS_DISTRO}"

WORKDIR /moveit_ws
RUN catkin config --extend "/opt/ros/${ROS_DISTRO}" --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin build

VOLUME /moveit_ws

# Source the MoveIt tutorials workspace in all terminals
RUN echo "source /moveit_ws/devel/setup.bash" >> ~/.bashrc

# Finalize the default working directory for the image
ARG DEFAULT_WORKDIR=/spot_skills
WORKDIR ${DEFAULT_WORKDIR}

## Stage 3: Install the Boston Dynamics Python packages and the Spot SDK
#   Build on the noetic-moveit image by default (but ARG enables override)
FROM ${SPOT_BASE_IMAGE} AS spot-sdk
ARG PYTHON_VERSION
ARG SPOT_SDK_VERSION

# Clone the Spot SDK from GitHub
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends git curl && \
    # Clean up layer after using apt-get update
    rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /spot_sdk
RUN git config --global http.sslVerify "false" && \
    git clone --depth 1 --branch "v${SPOT_SDK_VERSION}" \
        https://github.com/boston-dynamics/spot-sdk.git && \
    git config --global http.sslVerify "true" 
VOLUME /spot_sdk

# Ensure that any failure in a pipe (|) causes the stage to fail
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Pyenv to manage multiple Python versions
RUN curl https://pyenv.run | bash && \
    pyenv update && \
    pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION} && \
    echo "$(pyenv init -)" >> ~/.bashrc && \
    echo "$(pyenv virtualenv-init -)" >> ~/.bashrc

RUN python3 -m venv "py_${PYTHON_VERSION}_env" && \
    source "py_${PYTHON_VERSION}_env"/bin/activate && \
    # Install the Boston Dynamics Python packages within the virtual environment
    python3 -m pip install bosdyn-client==${SPOT_SDK_VERSION} \
        bosdyn-mission==${SPOT_SDK_VERSION} \
        bosdyn-choreography-client==${SPOT_SDK_VERSION} \
        bosdyn-orbit==${SPOT_SDK_VERSION} && \
    deactivate

# Catch-all: Install any final tools needed to work with Spot (saves rebuild time)
# RUN export DEBIAN_FRONTEND=noninteractive && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends iputils-ping && \
#     # Clean up layer after using apt-get update
#     rm -rf /var/lib/apt/lists/* && apt-get clean

# Finalize the default working directory for the image
ARG DEFAULT_WORKDIR=/spot_skills
WORKDIR ${DEFAULT_WORKDIR}
