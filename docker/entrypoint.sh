#!/bin/bash

# Set directory paths
WRAPPER_DIR="/docker/spot_skills/src/spot_ros"
SKILLS_DIR="/docker/spot_skills"
REQUIREMENTS_TXT="/docker/spot_skills/src/spot_skills/requirements.txt"

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

# Install the Python requirements in the specified requirements.txt file
install_requirements() {
    local filepath="$1"

    if [[ -f "$filepath" ]]; then
        echo "$filepath found. Installing packages..."
        pip3 install --upgrade -r "$filepath"
    else
        echo "Error: $filepath not found."
    fi
}


# Check required directories
check_directory "$WRAPPER_DIR"
check_directory "$SKILLS_DIR"

# Execute installation functions
apt-get update >/dev/null 2>&1
install_spot_wrapper
install_ros_dependencies
install_requirements "$REQUIREMENTS_TXT"

# Run the main process specified as CMD in the Dockerfile
exec "$@"
