#!/bin/bash

WRAPPER_DIR="/docker/spot_skills/src/spot_ros"
SKILLS_DIR="/docker/spot_skills"
PIP_INSTALL_SH="/docker/spot_skills/docker/pip_install.sh"

# Check if a directory exists, and if not, warn the user and exit
check_directory() {
    if [ ! -d "$1" ]; then
        echo "Error: Directory $1 does not exist."
        exit 1
    fi
}

# Install spot_wrapper if not already installed
install_spot_wrapper() {
    echo "Checking for spot_wrapper installation..."
    if ! python3 -c "import spot_wrapper"; then
        echo "spot_wrapper not found. Installing..."
        pip3 install -e "$WRAPPER_DIR/spot_wrapper" || {
            echo "Failed to install spot_wrapper."
            exit 1
        }
    else
        echo "spot_wrapper is already installed."
    fi
}

# Install ROS dependencies with rosdep if not already installed
install_ros_dependencies() {
    echo "Checking for ROS dependencies..."
    cd "$SKILLS_DIR" || exit 1
    if rosdep check --from-paths src --ignore-src >/dev/null 2>&1; then
        echo "ROS dependencies are already installed."
    else
        echo "Installing ROS dependencies..."
        rosdep install --from-paths src --ignore-src -y || {
            echo "Failed to install ROS dependencies"
            exit 1
        }
    fi
}

# Check required directories
check_directory "$WRAPPER_DIR"
check_directory "$SKILLS_DIR"

# Execute installation functions
apt-get update >/dev/null 2>&1
install_spot_wrapper
install_ros_dependencies
bash "$PIP_INSTALL_SH"

# Run the main process specified as CMD in the Dockerfile
exec "$@"