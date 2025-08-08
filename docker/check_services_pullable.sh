#!/bin/bash

# Check whether the image for the current Docker service can be pulled
SERVICE_NAME="spot-tamp-v3.1"

# Move to the directory of this script
cd $(dirname "$0")

imageName=$(docker compose config "$SERVICE_NAME" | grep "image" | xargs | cut -c 8-)
echo "Docker service '${SERVICE_NAME}' uses image '${imageName}'"

manifestOut=$(docker manifest inspect "$imageName")
if [[ $? -ne 0 ]]; then
    echo "Could not pull Docker manifest for image: '${imageName}'"
    exit 1
else
    echo "Found manifest: ${manifestOut}"
fi
