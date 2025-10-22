# Mapping Using GraphNav

Before any real-world experiment, we use Spot to collect a map of the environment, consisting of navigation waypoints and traversable edges.

You can collect a map of the environment using the following steps:

1. (**On Tablet**) - Undock Spot and navigate to the area of interest for the experiment. _Do not_ release tablet control of Spot.

   - _Leave Spot standing_, controlled by the tablet, during the following steps.

2. (**On Computer**) - Enter the Docker using the [standard procedure](../README.md#docker-commands). You'll need two terminal tabs for the following steps.
3. (**Docker Tab 1**) - Assuming you've [built and sourced](../README.md#docker-demo-setup) the catkin workspace, launch the nodes for mapping by running the following command, replacing `NAME_HERE` with the name of the Spot you're using (e.g., `spot_name:=mapper`).

```bash
roslaunch spot_skills spot_graphnav_demo.launch spot_name:=NAME_HERE
```

- You can modify the output directory of the map by adding the argument:

  ```
  ... map_path:=~/path/here
  ```

4. (**On Tablet**) - Use the tablet to navigate around to collect a map of the relevant area. Make sure to walk to any locations you want Spot to be able to navigate to.

5. (**Docker Tab 2**) - When you're done, run the following command in the second terminal to save the map to file:

```
rosservice call /spot/save_map
```

Note that **the output path may be overwritten if reused multiple times**. To prevent this, copy the saved map elsewhere or use a different argument-specified name next time.
