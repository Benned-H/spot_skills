#!/usr/bin/env bash

WRAPPER_DIR="/docker/spot_skills/src/spot_ros/spot_wrapper"
RTABMAP_WS_SOURCE="/docker/rtabmap_ws/devel/setup.bash"

# Source everything nodes/scripts might need
cd /docker/spot_skills
source devel/setup.bash

if [[ -f "${RTABMAP_WS_SOURCE}" ]]; then
    source "${RTABMAP_WS_SOURCE}"
else
    echo "Could not find RTAB-Map ROS workspace."
fi

# Install spot_wrapper if not already installed
if ! python3 -c "import spot_wrapper"; then
    pip install -e $WRAPPER_DIR || {
        echo "Failed to install spot_wrapper."
        exit 1
    }
else
    echo "spot_wrapper is already installed."
fi
