#!/bin/bash

# Check whether the images for the currently supported Docker services can be pulled

# Move to the directory of this script
cd $(dirname "$0")
source current_services.sh

exitCode=0
for serviceName in "${env_to_service[@]}"; do
    imageName=$(docker compose config "$serviceName" | grep "image" | xargs | cut -c 8-)
    echo "Docker service '${serviceName}' uses image '${imageName}'"

    manifestOut=$(docker manifest inspect "$imageName")
    if [[ $? -ne 0 ]]; then
        echo "Could not pull Docker manifest for image: '${imageName}'"
        exitCode=1
    else
        echo "Found manifest: ${manifestOut}"
    fi
done
exit $exitCode
