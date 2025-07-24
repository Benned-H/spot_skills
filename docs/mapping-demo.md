# Mapping Using RTAB-Map on Spot

Before any real-world experiment, we use Spot to collect a map of the environment, consisting of a 3D pointcloud and the poses of any objects to be manipulated during the experiment.

You can collect a map of the environment using the following steps:

1. (**On Tablet**) - Undock Spot and navigate to the area of interest for the experiment. _Do not_ release tablet control of Spot.

   - _Leave Spot standing_, controlled by the tablet, during the following steps.

2. (**On Computer**) - Enter the Docker using the [standard procedure](../README.md#docker-commands). You'll need one terminal tab for the following steps.

3. (**In Docker**) - Assuming you've [built and sourced](../README.md#docker-demo-setup) the catkin workspace, launch the nodes used for SLAM by running the following command, replacing `NAME_HERE` with the name of the Spot you're using (e.g., `spot_name:=breaker`).

```bash
roslaunch spot_skills spot_slam_demo.launch spot_name:=NAME_HERE
```

- You can modify the output path of the pointcloud map by adding the argument:

  ```
  ... rtabmap_database_path:=~/path/here.db
  ```

You should then see RViz open with a visualization of the Spot and the pointcloud map being built. Use the tablet to navigate around to collect a map of the relevant area. When you're done, type `Ctrl-C` to stop the mapping code and save the map.

RTAB-Map (the package we're using for SLAM) will save the map to file before it exits. The default output path is `~/.ros/rtabmap.db` and **any output path will be overwritten if you use it multiple times**. To prevent this, copy the saved map elsewhere or change the argument-specified name the next time you collect a map.
