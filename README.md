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

- **ROS 1 Noetic with MoveIt 1 (w/o GPU)** - `noetic-moveit`
- **GPU-enabled ROS 1 Noetic with MoveIt 1** - `noetic-moveit-gpu`
- **Spot SDK** - `spot-sdk`
- **Spot SDK with ROS 1 Noetic and MoveIt 1 (w/o GPU)** - `spot-moveit`

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

## Example Demonstrations

### Long Trajectory Using Spot SDK

This demonstration executes a long (20-second) trajectory on Spot's arm using the Spot SDK. Before starting this demo, use the tablet to move Spot to an open area, sit Spot, and then release control of Spot from the tablet. Then, run the command:

```bash
roslaunch spot_skills arm_long_trajectory_demo.launch
```

In another tab within Docker, run the following command from `/docker/spot_skills` after sourcing `devel/setup.bash`:

```bash
rosrun spot_skills arm_long_trajectory_demo.py
```

### Control Spot's Arm using MoveIt

By default, this demonstration runs in simulation. To do so, run the following command after sourcing `devel/setup.bash` in the `/docker/spot_skills` directory:

```bash
roslaunch spot_skills moveit_spot_demo.launch
```

To launch the demonstration on the real robot, complete the following steps:

1. Using the tablet, teleoperate Spot to an open area free of obstacles.
2. Verify that you can ping Spot using the following command, with `<SPOT_IP>` filled in using the `hostname` value from the corresponding file in `spot_skills/secrets`.

```bash
ping <SPOT_IP>
```

Check that almost all packages are being received, such as:

```
5 packets transmitted, 5 received, 0% packet loss, time 4006ms
```

3. In the tablet's **Motor Status** menu, select _Release Control_.

4. Launch the real-robot demo using the following command, updated with the name of the Spot you're using (e.g., `snouter`):

```bash
roslaunch spot_skills moveit_spot_demo.launch real_robot:=true spot_name:=doggie
```
