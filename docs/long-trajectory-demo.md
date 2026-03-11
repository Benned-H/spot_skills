# Long Trajectory using Spot SDK (Real-World Demo)

In this real-world demonstration, Spot uses its arm to follow a 20-second trajectory. To run the demo, perform the following steps:

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
