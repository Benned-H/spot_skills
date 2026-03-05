# Object Pose Estimation Demo

_Prerequisite_: First, map your environment using the [Mapping Demo](mapping-demo.md).

To collect object poses relative to the collected map, perform the following steps:

1. (**On Tablet**) - Undock Spot and navigate to the area that was previously mapped. _Do not_ release tablet control of Spot.

2. (**On Computer**) - Enter the Docker using the [standard procedure](../README.md#docker-commands). You'll need two terminal tabs in the Docker for the following steps.

3. (**Docker Tab 1**) - Launch the Spot skills bringup by running the following command, replacing `NAME_HERE` with the name of the Spot you're using (e.g., `spot_name:=poser`):

```bash
roslaunch spot_skills bringup_spot_skills.launch spot_name:=NAME_HERE
```

- To start a new map for debugging purposes, add the arguments: `rtabmap_database_path:=/docker/spot_skills/temp.db localization_mode:=false start_new_map:=true`

4. (**On Tablet**) - Use the tablet to walk Spot around the environment until RTAB-Map successfully localizes Spot.

   - Look for the simulated Spot to "match" the real-world robot's position in the world, as visualized by the simulated robot and pointcloud in RViz.

5. Once Spot has localized, you can alternate between the following steps:

   - (**On Tablet**) - Use the tablet to navigate Spot to view AR markers on objects in the environment. These tags will show up in RViz once they've been detected.

   - (**Docker Tab 2**) - You can visualize an environment model in RViz by running:

   ```bash
   rosparam set /environment_yaml /docker/spot_skills/.../PATH_TO_YAML
   rosrun spot_skills planning_scene_manager_node.py
   ```

   - (**Docker Tab 2**) - Once all fiducial markers have been observed, you can export the estimated object poses to file by running the command:

   ```bash
   rosservice call /fiducial_tracker_node/output_to_yaml {}
   ```
