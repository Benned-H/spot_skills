#!/bin/bash

# Launch the appropriate Docker service for the current development environment
#   If the service depends on an image not available locally, pull or build it

# Move to the directory of this script
cd $(dirname "$0")

# Import a utility function to identify the local environment
source ros_docker/scripts/identify_env.sh
env_type=$(identify_env)
echo "Detected local environment as ${env_type}."

# Import up-to-date Docker service names from separate Bash file
# Provides a map (env_to_service) from environment types to Docker services
source current_services.sh
serviceName="${env_to_service[$env_type]}"
echo "Selected Docker service: '${serviceName}'"

# Attempt to enter the selected Docker service
# Reference: https://docs.docker.com/reference/cli/docker/compose/up/
docker compose up --pull missing --remove-orphans --detach "$serviceName"

if [[ $? -ne 0 ]]; then
    echo "Could not pull the corresponding image. Building locally..."
    docker compose --progress plain build "$serviceName"
    docker compose up "$serviceName"
fi

# Attempt to attach the terminal to the launched Docker service
docker compose exec "$serviceName" bash
