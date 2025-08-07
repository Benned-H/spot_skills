#!/usr/bin/env bash

WRAPPER_DIR="/docker/spot_skills/src/spot_ros/spot_wrapper"

# Install spot_wrapper if not already installed
if ! python3 -c "import spot_wrapper"; then
    pip install -e $WRAPPER_DIR || {
        echo "Failed to install spot_wrapper."
        exit 1
    }
else
    echo "spot_wrapper is already installed."
fi

# Install the project's Python packages (and their dependencies)
# Reference: https://stackoverflow.com/a/35064498/10278033
python3 -m pip install --upgrade pip
pip install -e /docker/spot_skills
pip install -e /docker/spot_skills/src/spot_skills/src/robotics_utils
