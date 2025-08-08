# spot_skills

Motion-planning-based skills for Boston Dynamics' Spot robot

## Cloning with Submodules

This repository includes others, such as [`spot_ros`](https://github.com/heuristicus/spot_ros), as nested submodules. To ensure that all submodules are cloned alongside this repository, use the command:

```bash
git clone --recurse-submodules git@github.com:Benned-H/spot_skills.git
```

If you have already cloned the repository, run the following command to ensure that all submodules are up-to-date:

```bash
cd spot_skills/
bash docker/git_pull_all.sh
```

## Installing Docker

If you do not already have Docker on your system, you will need to follow these steps:

- Install Docker using apt [LINK](https://docs.docker.com/engine/install/linux-postinstall/)
- Enable non-sudo Docker [LINK](https://docs.docker.com/engine/install/linux-postinstall/)

You then need to set up the drivers to allow docker to interface with the GPU:

- Install the NVIDIA Container Toolkit [LINK](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
- Configure for Docker [LINK](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-docker)

Pull the Docker container using the command:

```bash
docker compose pull spot-tamp-v3.1
```

## Docker Commands

This repository uses Docker to standardize its workspace across machines. To run the Spot skills code, you'll need to enter the Docker container. You can launch Docker using either _A)_ VS Code or _B)_ the command-line. Either way, first run the command:

```bash
xhost +local:docker
```

- This allows ROS to open visualizations/GUIs from within the Docker.

_A) Launch Docker via VS Code_ - Opens the Docker and connects it with VS Code, enabling better analysis/type-annotation.

0. Install the **Dev Containers** VS Code extension on your local machine.
1. Open a VS Code window to the top-level `spot_skills` folder (i.e., the folder containing this `README` file).
2. In VS Code, press `Ctrl-Shift-P` and begin to type "**Dev Containers: Open Folder in Container...**".
3. Select that option, navigate to the same top-level `spot_skills` folder, and press _Open_.

Once the container is launched and VS Code is attached, you should see "_Dev Container: Spot Skills Dev Container_" in the bottom-left blue bar in VS Code.

_B) Launch Docker via CLI_ - You can launch the Docker and attach a terminal into it from the command-line:

1. Open a terminal and navigate to the top-level `spot_skills` folder.
2. Run the following commands to launch the Docker container and then attach the terminal into the container:

```bash
# Launch the Spot skills Docker container
docker compose up spot-tamp-v3.1 --detach
# Attach the terminal to the running Docker
docker compose exec spot-tamp-v3.1 bash
```

If you've launched the container using the command-line, you can still attach VS Code to that container using the process described above. Similarly, if you launched the Docker using VS Code, you can still use the second above command to attach another terminal into the running container.

_Troubleshooting_:

1. If the launch script isn't working, check that you've successfully pulled all submodules. Use:
   - `git submodule update --init --recursive`

## Example Demonstrations

### Docker Demo Setup

All demonstrations should be run from inside the Docker container. Unless otherwise
stated, you need to move to the top-level `spot_skills` folder, build the workspace, and source `devel/setup.bash`. The commands to do this are:

```bash
# Assumes you're inside the Docker container
cd /docker/spot_skills
catkin build
source devel/setup.bash
bash docker/source_all.sh
```

If a demo requires a second or third terminal tab to be opened into Docker, move to the same directory and source `devel/setup.bash`.

```bash
# For a second, third, etc. terminal tab in Docker
cd /docker/spot_skills
source devel/setup.bash
```

### Long Trajectory Using Spot SDK (Real-World)

In this real-world demonstration, Spot will use its arm to follow a 20-second trajectory. To run the demo, perform the following steps:

1. Use the tablet to teleoperate Spot to an open area free of obstacles.
   Make sure there's space in front of Spot for Spot's arm to fully extend.

2. Use the tablet to make Spot sit, which may be hidden under the _Stand_ menu. Then,
   release tablet control of Spot by entering the _Power Button_ menu (top of the
   screen), then tapping _Advanced_, and selecting **Release Control**.

   - _Check_: Are Spot's front lights now flashing rainbow?

3. On your computer, make sure you've followed the **Docker Demo Setup** instructions above.

4. To begin the demo, run the following command, with `NAME_HERE` replaced by the name of the Spot you're using (e.g., `spot_name:=barker`):

```bash
roslaunch spot_skills spot_sdk_demo.launch spot_name:=NAME_HERE
```

Spot should power on, stand up, deploy its arm, and begin executing the trajectory.
Once the trajectory is complete, Spot should stow its arm, sit down, power off, and the demo driver will end by saying:

```
[INFO] [...]: Finished running the long joint trajectory.
```

### Control Spot's Arm using MoveIt

In this demonstration, we use MoveIt to move Spot's arm left-and-right in a repeating path.
The demo can be run in simulation (default) or on the real robot.

**Simulated Version** - To run this demo in simulation, open a terminal into Docker and follow
the **Docker Demo Setup** instructions above. Then, run the command:

```bash
roslaunch spot_skills moveit_spot_demo.launch
```

RViz should open, showing a simulated Spot, as shown below.

![Simulated Spot moving its arm to an end-effector target (shown as RGB axes).](images/sim-moveit-spot.png "Spot's Arm Moving to an End-Effector Target")

A target pose for Spot's end-effector should soon be displayed as RGB axes. As this target pose moves
back-and-forth, MoveIt creates motion plans to the target, which are then used to
control the simulated Spot's arm.

**Real Robot Version** - To run this demo using a real robot, perform the following steps:

1. Use the tablet to teleoperate Spot to an open area free of obstacles.
   Make sure there's space in front of Spot for Spot's arm to fully extend.

2. Use the tablet to make Spot sit, which may be hidden under the _Stand_ menu. Then,
   release tablet control of Spot by entering the _Power Button_ menu (top of the
   screen), then tapping _Advanced_, and selecting **Release Control**.

   - _Check_: Are Spot's front lights now flashing rainbow?

3. On your computer, make sure you've followed the **Docker Demo Setup** instructions above.
   We will need two terminal tabs opened into Docker.
4. We will need to tell ROS which Spot we're using. Note the name of the Spot robot you're using (e.g., `snouter`).
5. Now, launch the real-robot demo using the following command, replacing `NAME_HERE` with your Spot's name (e.g., `spot_name:=barker`):

```bash
roslaunch spot_skills moveit_spot_demo.launch real_robot:=true spot_name:=NAME_HERE
```

6. In the second Docker terminal tab, source `devel/setup.bash`, and then run:

```bash
rosrun spot_skills spot_moveit_demo.py
```

### Spot Navigation Demo

See the [Navigation Demo](docs/navigation-demo.md) instructions.

### `OpenDoor` Demo

In this real-world demonstration, we'll use ROS to trigger Spot's off-the-shelf skill to open a door.

1. Use the tablet to walk Spot to stand in front of the door, facing the door. To verify that Spot is
   correctly positioned, enter **Stand** mode on the tablet and tilt Spot's body up using the right
   joystick. The door handle should be visible through Spot's front body camera(s).

2. Use the tablet to make Spot sit, which may be hidden under the _Stand_ menu. Then,
   release tablet control of Spot by entering the _Power Button_ menu (top of the
   screen), then tapping _Advanced_, and selecting **Release Control**.

   - _Check_: Are Spot's front lights now flashing rainbow?

3. On your computer, launch the `spot_skills` Docker and the `pose` Docker using their respective instructions.

4. In the `pose` Docker tab, launch the pose estimation and object detection server:

   ```bash
   sh /docker/pose/run_service.sh
   ```

5. In the `spot_skills` Docker tab, launch the nodes for the demo using the following commands, replacing
   `NAME_HERE` with the name of the Spot you're using (e.g., `spot_name:=opener`):

   ```bash
   bash docker/pip_install.sh
   roslaunch spot_skills open_door_demo.launch spot_name:=NAME_HERE
   ```

   - Wait until ROS has "settled" and output messages of the form:

     ```
     You can start planning now!

     [INFO] [...]: Pose estimation is currently inactive for all objects.
     ```

6. In another window in the `spot_skills` Docker, source `devel/setup.bash` and launch the `OpenDoor` skill using the commands:

   ```bash
   rosservice call /spot/unlock_arm "{}"
   rosservice call /spot/open_door "{}"
   ```

### Recording an End-Effector Relative Trajectory

Run the following command in the container after sourcing `devel/setup.bash` and running `source_all.bash`. Replace `NAME_HERE` with the name of the Spot you're using:

```bash
roslaunch spot_skills spot_driver_bringup.launch rviz:=true load_robot_description:=true spot_name:=NAME_HERE
```

When you're ready to begin recording transforms, run the following in another Docker terminal tab (after sourcing):

```bash
rosrun spot_skills record_transforms.py recorded-tfs.yaml
```

To stop the recording, kill the node by typing `Ctrl-C` in that terminal tab.

- The recorded transforms will be output to the specified file, here `recorded-tfs.yaml`. If that file already exists, the script will refuse to overwrite it by default.
- To enable overwriting the output path, you can append the flag: `--overwrite true`

### Playing Back an End-Effector Relative Trajectory

Open two terminal tabs into Docker and source the typical things. In the first tab, run:

```bash
roslaunch spot_skills playback_trajectory_demo.launch spot_name:=NAME_HERE
```

Once the printouts have settled, run the following commands in succession in the second tab:

```bash
rosservice call /spot/unlock_arm
rosservice call /spot/playback_trajectory "yaml_path: 'YAML_FILEPATH'"
```

- Make sure to use the _absolute path_ to the YAML file (e.g., `/docker/spot_skills/recorded-tfs.yaml`).

## Real-Robot Experiments

This section of the README describes the process for running physical experiments with Spot. Note that
the TAMP codebase (`TMP3`) is required to generate and execute TAMP plans involving multiple skills.

### Phase 1 - Mapping

See the [Mapping Demo](docs/mapping-demo.md) instructions.
