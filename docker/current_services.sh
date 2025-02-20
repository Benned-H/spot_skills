#!/usr/bin/env bash

# Specify the latest Docker image for each supported development environment
declare -A env_to_service

env_to_service["LINUX"]="spot-tamp-V2"
env_to_service["LINUX_NVIDIA"]="spot-tamp-gpu-V2"
env_to_service["MACOS"]="spot-tamp-mac-V2"
