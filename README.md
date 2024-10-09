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

This repository uses Docker to standardize its workspace across machines. The `compose.yaml` defines a Docker service for several development use cases, varying across the inclusion or exclusion of ROS 1 Noetic and MoveIt 1, the Spot SDK, and GPU support:
- *ROS 1 Noetic with MoveIt 1 (without GPU)* - `noetic-moveit`
- *GPU-enabled ROS 1 Noetic with MoveIt 1* - `noetic-moveit-gpu`
- *Spot SDK* - `spot-sdk`

To select a service, set the `SERVICE_NAME` environment variable accordingly, for example:

```bash
export SERVICE_NAME=spot-sdk
```

To create, start, and enter the selected container, run the commands:

```bash
docker compose up --detach --pull missing $SERVICE_NAME
xhost +local:docker
docker compose exec $SERVICE_NAME bash
```

To enter the running container in another terminal, set the `SERVICE_NAME` variable and then run the command:

```bash
export SERVICE_NAME=spot-sdk
docker compose exec $SERVICE_NAME bash
```

## Working with the Spot ROS 1 Driver

Before launching the Spot driver, navigate to `/docker/spot_skills` in the container, then run:
```bash
rosdep install -y --from-paths src --ignore-src --rosdistro noetic
pip3 install -e src/spot_ros/spot_wrapper/
```

Then, run each of these commands:
```bash
catkin clean
catkin build
source devel/setup.bash
```
