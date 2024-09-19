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

This repository uses Docker to standardize its workspace setup across machines. The `compose.yaml` defines a Docker service for several development use cases, varying across the inclusion or exclusion of ROS 1 Noetic, the Spot SDK, and GPU support:
- ROS 1 Noetic (without GPU) - `noetic`
- GPU-enabled ROS 1 Noetic - `noetic-nvidia`
- Spot SDK (for API reference) - `spot-sdk`
- ROS 1 Noetic + Spot SDK (without GPU) - `spot-ros1`
- GPU-enabled ROS 1 Noetic + Spot SDK - `spot-ros1-nvidia`

To select a service, set the `SERVICE_NAME` environment variable accordingly, for example:

```bash
export SERVICE_NAME=spot-sdk
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
