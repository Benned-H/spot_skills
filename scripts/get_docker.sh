#!/bin/bash

# Identify the OS of the local environment (Reference: https://stackoverflow.com/a/3466183)
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="Unsupported:${unameOut}"
esac
echo "Detected local environment as ${machine}."

if [[ $machine == Unsupported:* ]]; then
    echo "Your environment is not supported. Please use a Linux or macOS machine."
    exit 1
fi

# Check for NVIDIA GPU on any Linux host machine
if [[ $machine == "Linux" ]]; then
    lshwOut="$(lshw -C display)"
    nvidiaGPU="$(expr "${lshwOut}" == *NVIDIA*)"
    if [[ $nvidiaGPU ]]; then
        smiOut="$(nvidia-smi)"
        smiStatus="$?"
        if [[ $smiStatus -eq 0 ]]; then
            echo "Exit status of nvidia-smi was $smiStatus; OK"
        else
            echo "Error: Exit status of nvidia-smi was $smiStatus"
            echo "$smiOut"
            exit 1
        fi
    fi
else
    nvidiaGPU=false # macOS don't support NVIDIA GPUs
fi

# Select Docker service based on identified environment details
