# spot_skills

Motion-planning-based skills for Boston Dynamics' Spot robot

## Cloning with Submodules

This repository includes others, such as [`spot_ros`](https://github.com/heuristicus/spot_ros), as nested submodules. To ensure that all submodules are cloned alongside this repository, use the command:

```bash
git clone --recurse-submodules https://github.com/Benned-H/spot_skills.git
```

If you have already cloned the repository, run the following command to ensure that the submodules are initialized and updated:

```bash
git submodule update --init --recursive
```

## Docker Commands

This repository uses Docker to standardize its workspace setup and dependencies across machines. The Docker Compose file `compose.yaml` specifies services for various use cases in the project, including:

- GPU-enabled container (ROS 1 Noetic) - Service name `noetic-nvidia`
- GPU-less container (ROS 1 Noetic) - Service name `noetic-no-gpu`
- Spot driver plus GPU support (ROS 1 Noetic) - Service name `spot-ros1`

To select a service, set the `SERVICE_NAME` environment variable accordingly:

```bash
export SERVICE_NAME=noetic-nvidia   # Noetic container with NVIDIA GPU support
export SERVICE_NAME=noetic-no-gpu   # Noetic container without GPU support
export SERVICE_NAME=spot-ros1       # Spot ROS 1 driver plus NVIDIA GPU support
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
