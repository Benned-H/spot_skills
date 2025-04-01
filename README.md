# spot_skills

Motion-planning-based skills for Boston Dynamics' Spot robot

## Cloning with Submodules

This repository includes others, such as [`spot_ros`](https://github.com/heuristicus/spot_ros), as nested submodules. To ensure that all submodules are cloned alongside this repository, use the command:

```bash
git clone --recurse-submodules https://github.com/Benned-H/spot_skills.git
```

If you have already cloned the repository, run the following command to ensure that all submodules are up-to-date:

```bash
bash docker/git_pull_all.sh
```

## Docker Commands

This repository uses Docker to standardize its workspace across machines. Ignoring most of the details, you'll only need to know the following:

- To run the Spot skills code, you'll need to enter a Docker container, which has all the dependencies pre-installed.
- The exact Docker container you should enter depends on your local machine: Is it macOS or Ubuntu? Does it have NVIDIA?

Run the following script to select, launch, and then enter the appropriate container for your machine:

```bash
bash docker/launch.sh
```

To enter the running container in another terminal, just run the same script again.

## Working with the Spot ROS 1 Driver

Before launching the Spot driver, navigate to `/docker/spot_skills` in the container, then run:

```bash
rosdep install -y --from-paths src --ignore-src --rosdistro noetic
pip3 install -e src/spot_ros/spot_wrapper/
```

Then, rebuild and source the Catkin workspace by running:

```bash
bash docker/catkin_rebuild.sh
```

## Example Demonstrations

### Docker Demo Setup

All demonstrations should be run from inside the Docker container. Unless otherwise
stated, you need to move to the top-level `spot_skills` folder, build the workspace, and source `devel/setup.bash`. The commands to do this are:

```bash
# Assumes you're inside the Docker container
cd /docker/spot_skills
catkin build
source devel/setup.bash
```

If a demo requires a second or third terminal tab to be opened into Docker, that tab will need to move to the same directiory and source `devel/setup.bash`.

```bash
# For a second, third, etc. terminal tab in Docker
cd /docker/spot_skills
source devel/setup.bash
```

### Long Trajectory Using Spot SDK

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

## Real-Robot Experiments

This section of the README describes the process for running physical experiments with Spot. Note that
the TAMP codebase (`TMP3`) is required to generate and execute TAMP plans involving multiple skills.

### Phase 1 - Mapping

Before any real-world experiment, we use Spot to collect a map of the environment, consisting of a 3D pointcloud
and the poses of any objects that will be manipulated during the experiment.

We begin by collecting a map of the environment using the following steps:

1. Use the tablet to undock Spot and navigate to an area of interest for the experiment. You _do not_ need to release tablet control of Spot.

   - Leave Spot standing, controlled by the tablet, during the next step.

2. Enter the `spot_skills` Docker using the command:

   ```bash
   bash docker/launch.sh
   ```

3. Once you're in the Docker, run the following commands to verify your workspace is set up:

```bash
catkin build
source devel/setup.bash
```

4. Launch the nodes used to map the environment a command of the form:

```bash
roslaunch spot_skills spot_slam_demo.launch spot_name:=NAME_HERE
```

- Specify the name of the Spot you're using (e.g., `spot_name:=breaker`).
- You can modify the output path of the pointcloud map by adding the argument:

```
... rtabmap_database_path:=~/path/goes/here.db
```

You should then see RViz open with a visualization of Spot and the pointcloud map being built.
Use the tablet to navigate Spot around to collect a map of the relevant area. When you are done,
press `Crtl-C` in the terminal used to launch SLAM. RTAB-Map (the package we're
using for SLAM) will save the map to file before it exits. The default output path is
`~/.ros/rtabmap.db` and **any output path will be overwritten if you use it multiple times**. To
prevent this, save the file elsewhere or change its name (and/or the argument-specified name).

<!-- ### Using `spot_move_base`

The Docker container will have handled the installation of any additional dependencies.

To demonstrate Spot's navigation system, run the following command, with the name of the Spot you're using filled in:

```bash
roslaunch spot_skills spot_nav_demo.launch spot_name:=NAME
``` -->
