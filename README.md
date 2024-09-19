# spot_skills

Motion-planning-based skills for Boston Dynamics' Spot robot

## Docker Commands

This repository uses Docker to standardize its workspace setup and dependencies across machines. The Docker Compose file `compose.yaml` specifies services for various use cases in the project, including:
 - GPU-enabled container (ROS 1 Noetic) - Service name `noetic-nvidia`
 - GPU-less container (ROS 1 Noetic) - Service name `noetic-no-gpu`
 - Spot driver from BDAI (ROS 2 Humble) - Service name `spot-ros2`

To select a service, set the `SERVICE_NAME` environment variable accordingly:
```bash
export SERVICE_NAME=noetic-nvidia   # Noetic container with NVIDIA GPU support
export SERVICE_NAME=noetic-no-gpu   # Noetic container without GPU support
export SERVICE_NAME=spot-ros2       # ROS 2 driver for the Spot robot
```

To build and start the selected container, run the command:
```bash
docker compose up --build --detach $SERVICE_NAME
```

Then, to enter the container, run the following commands:
```bash
xhost +local:docker
docker compose attach $SERVICE_NAME
```

To enter the running container in another terminal, set the `SERVICE_NAME` variable and then run the command:
```bash
docker compose exec $SERVICE_NAME bash
```
