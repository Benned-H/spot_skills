### Extract Gripper Transforms from Recorded Rosbag Files

Run the python script `rosbag_to_tranforms.py` and then play the rosbag. The script will automatically read from the `/tf` messages and calculate transforms of 'arm_link_wr1' from the initial state to the later states, visualize them, and saveall transforms in `transform.npy`.