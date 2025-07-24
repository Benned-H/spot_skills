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
