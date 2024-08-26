# spot_skills

Motion-planning-based skills for Boston Dynamics' Spot robot

## Docker Commands

This repository uses Docker to manage dependencies. Docker Compose is used to configure the necessary images and containers, supporting both a GPU-enabled and GPU-less container.

### GPU-enabled Container

The Docker Compose configuration for this repository supports a container for machines with an NVIDIA GPU. To build and start the GPU-enabled container, run the command:
```bash
docker compose up --build --detach noetic-nvidia
```

Then, to enter the container, run the following commands:
```bash
xhost +local:docker
docker compose attach noetic-nvidia
```

To enter the running container in another terminal, run the command:
```bash
docker compose exec noetic-nvidia bash
```

### GPU-less Container

The Docker Compose configuration for this repository also supports a container for machines without an NVIDIA GPU. To build and start the GPU-less container, run the command:
```bash
docker compose up --build --detach noetic-no-gpu
```

Then, to enter the container, run the following commands:
```bash
xhost +local:docker
docker compose attach noetic-no-gpu
```

## One-Off Commands

To re-generate Spot's URDF, run the following commands from the repo-level `spot_skills` directory:
```bash
export SPOT_ARM=1       # Include Spot's arm in the generated URDF
xacro src/spot_ros/spot_description/urdf/spot.urdf.xacro > src/spot_skills/urdf/spot_with_arm.urdf
```