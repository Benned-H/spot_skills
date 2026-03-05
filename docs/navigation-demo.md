# Spot Navigation Demo

In this real-world demonstration, we load in a previously collected map, specify named waypoints relative to the map, and command Spot to navigate between those waypoints.

**Prerequisite**: Collect a map of the environment using the [Mapping Demo](./mapping-demo.md) instructions.

To run the navigation demo, perform the following steps:

1. (**On Tablet**) - Undock Spot and navigate to the mapped area. Ensure that Spot can see at least one visual fiducial compatible with GraphNav.

   - _Do not_ release tablet control of Spot. Leave Spot standing.

2. (**On Computer**) - Enter the Docker using the [standard procedure](../README.md#docker-commands). You'll need two terminal tabs in the Docker for the following steps.

3. (**Docker Tab 1**) - Launch the navigation demo by running the following, replacing `NAME_HERE` with the name of the Spot you're using (e.g., `spot_name:=hopper`):

```bash
roslaunch spot_skills spot_nav_demo.launch spot_name:=NAME_HERE
```

- You can specify the import path to the previously collected map using the argument:

  ```
  ... map_path:=~/path/here
  ```

4. (**Docker Tab 1**) - Wait until the printouts in the terminal indicate that Spot has successfully localized.

5. (**Docker Tab 2**) - Create a collection of named waypoints, then command Spot to navigate to those locations, as follows:

   - To define a new named waypoint at Spot's current base pose, run the command:

   ```bash
   rosservice call /spot/navigation/create_waypoint "name: 'NAME_HERE'"
   ```

   - You can continue to use the tablet to move Spot around and create new waypoints at new poses.

   - Once you've created all desired waypoints, command Spot to navigate to one by running:

   ```bash
   rosservice call /spot/navigation/to_waypoint "name: 'NAME_HERE'"
   ```

After you command Spot to navigate to a waypoint for the first time, you'll no longer be able to control Spot using the tablet.
