#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple
import rospy
from spot_skills.srv import NavigateToPose, NavigateToPoseRequest
from moveit_commander import MoveGroupCommander
# import transformations as tf
from transform_utils.ros.services import trigger_service
from spot_skills.srv import TakePicture, TakePictureRequest

import sys
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

# 1. Add path for the 'Manipulator' import (your original code)
module_root_path = os.path.join(script_dir, '../../src/tmp3')
sys.path.insert(0, module_root_path)

# 2. Add path for the 'Pose3D' import (the new code)
kinematics_module_path = os.path.abspath(os.path.join(script_dir, "../../../../../spot_skills/src/spot_skills/src/transform_utils/src"))
sys.path.insert(0, kinematics_module_path)

# --- Now you can import both modules successfully ---
from transform_utils.kinematics import Pose3D
from transform_utils.kinematics_ros import pose_to_stamped_msg

from std_msgs.msg import String
import yaml

import sys
import os
import copy

# Get the absolute path to the directory containing tamp_executor.py
tamp_executor_path = os.path.join(os.path.dirname(__file__), '..')
sys.path.append(tamp_executor_path)
# from tamp_executor import run_skill_tamp

###############################################################################
# User‑adjustable parameters                                                   #
###############################################################################
os.chdir("/docker/spot_skills")
YAML_PATH = Path("src/spot_skills/scripts/skill_chaining/skill_sequences.yaml")
IMAGE_ROOT = Path("src/spot_skills/scripts/skill_chaining/")
IMAGE_ROOT.mkdir(parents=True, exist_ok=True)
START_LOC = "FarDrawer"

Skill = Tuple[str, bool]  # (skill_string, success_flag)
Seq = List[Skill]

#TODO replace with real experiment sequences
SEQUENCES: List[Seq] = [
    #debug
    [
        "OpenDoor()",
        "EraseBoard()",
    ],
    # seq 1
    [
        "GoTo(Door)",
        "Open(Door)",
        "GoTo(Table)",
        "Pick(Eraser)",
        "GoTo(Cabinet)",
        "Open(Cabinet)",
        "Pick(Eraser)",
        "Close(Cabinet)",
        "GoTo(WhiteBoard)",
        "Erase(Eraser, WhiteBoard)",
    ],
    # seq 2
    [
        ("GoTo(Cabinet)", True),
        ("Open(Cabinet)", True),
        ("Erase(Eraser, WhiteBoard)", False),
        ("Pick(Eraser)", True),
        ("Close(Cabinet)", False),
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
    # seq 3
    [
        ("Open(Cabinet)", False),
        ("OpenDoor(Door)", False),
        ("Close(Cabinet)", False),
        ("GoTo(Door)", True),
        ("GoTo(Table)", True),
        ("Close(Cabinet)", False),
        ("Open(Cabinet)", False),
        ("Pick(Eraser)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
    # seq 4
    [
        ("GoTo(Table)", True),
        ("GoTo(Cabinet)", True),
        ("Close(Cabinet)", False),
        ("Pick(Eraser)", False),
        ("Open(Cabinet)", True),
        ("Pick(Eraser)", True),
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", False),
        ("GoTo(WhiteBoard)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
    # seq 5
    [
        ("Close(Cabinet)", False),
        ("GoTo(Table)", True),
        ("Open(Cabinet)", False),
        ("Close(Cabinet)", False),
        ("GoTo(Cabinet)", True),
        ("Open(Cabinet)", True),
        ("Pick(Eraser)", True),
        ("Close(Cabinet)", False),
        ("GoTo(Door)", True),
        ("OpenDoor(Door)", False),
        ("Erase(Eraser, WhiteBoard)", False),
    ],
]

REFINED_TREE_PATHS = {
    "OpenDoor": "test_domains/SpotPickAndPlace/Tasks/OpenDoorSkill/refined_tree.pkl",
    "OpenDrawer": "",
    #TODO add paths for other skills
}

LOC_TO_CAM={
    "Door": "Front",
    "NearDrawer": "Gripper",
    "FarDrawer": "Front",
    "Whiteboard": "Front"
}

LOC_TO_POSE = {
    # "Door": {'x':-2.551946893788989, 'y':-3.9969687054171574, 'yaw_rad':-1.5174806343024052},
    "FarDrawer": {'x':-4.55887296632496, 'y':-3.5433156792805565, 'yaw_rad':-1.63045600343705},
    "Door": {'x':-2.079424112544328, 'y':-4.382491836694199, 'yaw_rad':-1.6030232601628331},
    "NearDrawer":{'x':-4.573109184001097, 'y':-4.4492154938777055, 'yaw_rad':-1.646244845583943},
    "Whiteboard":{'x':0.11682090388171185, 'y':-8.976598643052844, 'yaw_rad':3.1017425112797765},
}

LOC_ID_TO_LOC = {
    0: "Door",
    1: "NearDrawer",
    2: "FarDrawer",
    3: "Whiteboard"
}

SKILL_TO_LOC_ID={
    "OpenDoor":[0],
    "OpenDrawer": [1, 2],
    "PickFromDrawer": [1, 2],
    "EraseBoard": [3],
}

# LOC_TO_SKILLS={
#     "Door": ["OpenDoor"],
#     "NearDrawer": ["OpenDrawer", "PickFromDrawer"],
#     "FarDrawer": ["OpenDrawer", "PickFromDrawer"],
#     "Whiteboard": ["EraseBoard"]
# }

#ziyi's preferred deployed arm configuration to get the gripper in the front camera frame
ZIYI_DEPLOYED_ARM_CONFIG = {
    "arm_sh0": -0.3948547840118408,
    "arm_sh1": -1.0508015155792236,
    "arm_el0": 2.347215414047241,
    "arm_el1": -0.43893003463745117,
    "arm_wr0": -0.03280067443847656,
    "arm_wr1": -0.488569974899292,
    # "arm_f1x": -0.4537029266357422,
}

#the ee pose of when the gripper camera is being used to take a picture
#TODO get the actual 6D EE pose
pose = Pose3D.from_list([0, 0, 0, 0, 0, 0], ref_frame="")
USING_GRIPPER_CAM_POSE_STAMPED = pose_to_stamped_msg(pose)

#TODO make dict of loc to ee pose for locs that need to use gripper cam

###############################################################################
# YAML persistence                                                             #
###############################################################################

#tested
def _load_yaml() -> Dict:
    if YAML_PATH.exists():
        with open(YAML_PATH, "r") as f:
            return yaml.safe_load(f) or {}
    return {}

#tested
def _save_yaml(data: Dict) -> None:
    with open(YAML_PATH, "w") as f:
        yaml.safe_dump(data, f, sort_keys=False, default_flow_style=True)
###############################################################################
# Progress helpers                                                             #
###############################################################################

#tested
def _find_resume_point(data: Dict) -> Tuple[int, int]:
    """
    Return (seq_idx, step_idx) to resume from (both 0‑based).
    """
    
    for s_idx, seq in enumerate(SEQUENCES):
        task_key = f"seq_{s_idx+1}"
        if task_key not in data:
            return s_idx, 0
        steps = data[task_key]
        # If step not yet logged, resume there
        for st_idx in range(len(seq) + 1):  # +1 for step 0
            if str(st_idx) not in steps:
                return s_idx, st_idx
    return len(SEQUENCES), 0  # done


def _stand():
    rospy.wait_for_service('spot/stand')
    rospy.loginfo("Now taking a picture...")
    try:
        result = trigger_service("/spot/stand")
        if result:
            rospy.loginfo("Stood successfully!")
        else:
            rospy.logwarn("Service call failed (returned False).")
    except Exception as exc:
        rospy.logerr(f"Error during service call: {exc}")

#tested
def _deploy_arm(move_group, arm_or_pose):
    """
    Deploys Spot arm to specified joint configuration.
    """

    rospy.wait_for_service('/spot/unlock_arm')
    rospy.loginfo("Now deploying arm...")
    try:
        result = trigger_service("/spot/unlock_arm")
        if result:
            rospy.loginfo("Arm deployed successfully!")
        else:
            rospy.logwarn("Service call failed (returned False).")
    except Exception as exc:
        rospy.logerr(f"Error during service call: {exc}")


    if arm_or_pose == ZIYI_DEPLOYED_ARM_CONFIG:
        move_group.set_joint_value_target(arm_or_pose)
    else:
        move_group.set_pose_target(pose=arm_or_pose, end_effector_link="arm_link_wr1")

    suc, robot_trajectory, _, _ = move_group.plan()
    move_group.execute(robot_trajectory, wait=True)  # Blocks until done 
    move_group.stop()  # Ensure there's no residual movement

#tested
def _stow_arm():
    rospy.wait_for_service('spot/stow_arm')
    rospy.loginfo("Now taking a picture...")
    try:
        result = trigger_service("/spot/stow_arm")
        if result:
            rospy.loginfo("Arm stowed successfully!")
        else:
            rospy.logwarn("Service call failed (returned False).")
    except Exception as exc:
        rospy.logerr(f"Error during service call: {exc}")

#tested
def _take_pic_via_service(img_path: str, cam_type: str):
    """
    Calls the /spot/take_picture service with the given arguments.
    """

    rospy.wait_for_service('/spot/take_picture')
    rospy.loginfo("Now taking a picture...")
    try:
        # result = trigger_service("/spot/take_picture")
         # Create a service proxy
        take_picture_service = rospy.ServiceProxy('/spot/take_picture', TakePicture)
        
        # Create a request object and populate it with the arguments
        request = TakePictureRequest(img_path=img_path, cam_type=cam_type)
        
        # Call the service
        response = take_picture_service(request)
        if response.success:
            rospy.loginfo("Picture taken successfully!")
        else:
            rospy.logwarn("Service call failed (returned False).")
    except Exception as exc:
        rospy.logerr(f"Error during service call: {exc}")

#tested
def _start_nav_service() -> rospy.ServiceProxy:
    rospy.loginfo("Waiting for /spot/navigation/to_pose service...")
    try:
        rospy.wait_for_service('/spot/navigation/to_pose', timeout=10.0)
    except rospy.ROSException as e:
        rospy.logerr(f"Service not available: {e}")
        sys.exit(1) # Exit if the core service is not running

    try:
        navigate_to = rospy.ServiceProxy(
            '/spot/navigation/to_pose',
            NavigateToPose
        )
    except rospy.ServiceException as e:
        rospy.logerr(f"Failed to create service proxy: {e}")
        sys.exit(1)
    
    return navigate_to

#tested
def _go_to_loc(loc: str, navigate_to: rospy.ServiceProxy) -> None:
    """
    Navigates to specified string location.
    """

    try:
        x, y, yaw = LOC_TO_POSE[loc]['x'], LOC_TO_POSE[loc]['y'], LOC_TO_POSE[loc]['yaw_rad']
        pose = Pose3D.from_xyz_rpy(x=x, y=y, yaw_rad=yaw)
        pose_stamped = pose_to_stamped_msg(pose)
        request = NavigateToPoseRequest(pose_stamped)

        # Call the service and get the response
        response = navigate_to(request)
        if response.success:
            rospy.loginfo(f"Successfully navigated to '{loc}'.")
        else:
            rospy.logwarn(f"Navigation to '{loc}' failed: {response.message}")
    
    except rospy.ServiceException as e:
        rospy.logerr(f"Service call to navigate to '{loc}' failed: {e}")

#tested
def _take_init_imgs(move_group: MoveGroupCommander) -> Dict:
    """
    Takes initial images. 1 at each location. Using front or gripper camera. If front cam, without gripper in frame.
    """
    dir = IMAGE_ROOT / "init_imgs"

    dir.mkdir(parents=True, exist_ok=True)

    navigate_to = _start_nav_service()

    arm_deployed = False
    init_paths_pre = {}
    for loc in LOC_TO_POSE.keys():
        rospy.loginfo(f"Requesting navigation to landmark: '{loc}'")
        
        print(f"NAVIGATING TO {loc}...")
        _go_to_loc(loc, navigate_to)
        print(f"REACHED {loc}!")
        
        cam_type = LOC_TO_CAM[loc]
        if cam_type == "Gripper":
            print("DEPLOYING ARM...")
            # _deploy_arm(move_group,USING_GRIPPER_CAM_POSE_STAMPED)
            _deploy_arm(move_group,ZIYI_DEPLOYED_ARM_CONFIG) #delete later, for debugging
            arm_deployed = True

        img_path_pre = dir / (loc + "_pre.jpg")
        _take_pic_via_service(str(img_path_pre), cam_type) # init state before skill execution
        init_paths_pre[loc] = img_path_pre

        if arm_deployed:
            _stow_arm()
            arm_deployed = False

    return init_paths_pre

#tested
def _prepare_state_for_next(curr_state_img_paths, skill_str, changed_locs, post_skill_state_img_paths):
    """
    Prepares the environment state for the next step in sequence by changing the location observations to what they would look like at the next step
    """
    
    for changed_loc in changed_locs:
        curr_state_img_paths[changed_loc] = post_skill_state_img_paths[frozenset({changed_loc, skill_str})]
    
    return curr_state_img_paths

#tested
def get_skill_states(skill_name: str, yaml_path: Path) -> List[Dict[str, Any]]:
    """
    Finds all states before and after a specific skill is executed in a sequences YAML file.

    Args:
        skill_name: The name of the skill to search for (e.g., "OpenDoor").
        yaml_path: The path to the skill sequences YAML file.

    Returns:
        A list of dictionaries, where each pair of dictionaries represents
        the state before and the state after the skill was executed.
    """
    if not yaml_path.exists():
        rospy.logerr(f"Error: YAML file not found at {yaml_path}")
        return []

    with open(yaml_path, "r") as f:
        data = yaml.safe_load(f)

    if not data:
        return []

    if skill_name in [None, "None"]:
        print("ENTER AN ACTUAL SKILL, NOT THE INTIAL 'SKILL' NONE")
        return []

    all_results = {}
    for seq_key, seq_data in data.items():
        seq_results = []
        # The steps are keyed by strings "0", "1", "2", ...
        # We need to sort them to process in order.
        sorted_step_keys = sorted(seq_data.keys(), key=int)

        for i, step_key in enumerate(sorted_step_keys):
            step_info = seq_data[step_key]

            # The skill at step 0 is always None, so we start from index 1.
            if i > 0 and step_info.get("skill") == skill_name:
                # Found the skill. The state "after" is this step's info.
                # The state "before" is the previous step's info.
                before_step_key = sorted_step_keys[i - 1]
                before_state = seq_data[before_step_key]
                after_state = step_info

                before_after = {"before": before_state, "after": after_state}

                seq_results.append(before_after)
        
        all_results[seq_key] = seq_results
    
    return all_results


###############################################################################
# Main routine                                                                 #
###############################################################################

def main():
    # rospy.loginfo(f"Current working directory: {os.getcwd()}") 
    
    _stand()          
    
    #NOTE: If we use TMP3 to take pics, need to tell the photo-taker which skill we're in
    #NOTE: If we use TMP3 to take pics, uncomment the next 2 lines
    # rospy.init_node('skill_info_publisher')                      
    # pub = rospy.Publisher('skill_info', String, queue_size=10, latch=True)      
    
    # cam_types = rospy.get_param('~cam_types')
    move_group = MoveGroupCommander("arm")   
    
    #TODO make a Type of what is returned by this fun
    init_paths_pre = _take_init_imgs(move_group) #dict {"Door": Path, ...}
    
    # init_paths_pre = { #for debugging
    #     "Door": "src/spot_skills/scripts/skill_chaining/init_imgs/Door_pre.jpg",
    #     "NearDrawer": "src/spot_skills/scripts/skill_chaining/init_imgs/NearDrawer_pre.jpg",
    #     "FarDrawer": "src/spot_skills/scripts/skill_chaining/init_imgs/FarDrawer_pre.jpg",
    #     "Whiteboard": "src/spot_skills/scripts/skill_chaining/init_imgs/Whiteboard_pre.jpg"
    # }

    data = _load_yaml()
    seq_i, step_i = _find_resume_point(data) #finds resume point of sequence and skill
    if seq_i >= len(SEQUENCES):
        print("All sequences complete! Nothing to do.")
        return

    for s_idx in range(seq_i, len(SEQUENCES)):
        curr_state_img_paths = copy.deepcopy(init_paths_pre)
        #TODO replace "task" var name with "seq"
        task_key = f"seq_{s_idx+1}"
        seq = SEQUENCES[s_idx]
        data.setdefault(task_key, {})

        print(f"\n=== Starting {task_key} ===")
        # ─── make a folder for this sequence ───
        sequence_dir = IMAGE_ROOT / "skill_images" / task_key
        sequence_dir.mkdir(parents=True, exist_ok=True)
        for st_idx in range((step_i if s_idx == seq_i else 0), len(seq) + 1):

            # step 0 has no skill string / success flag from list
            if st_idx == 0:
                skill_str = None
                success: Optional[bool] = None
            else:
                skill_str = seq[st_idx - 1]
                rospy.loginfo(f"CURRENT SKILL: {skill_str}")
                success = input("Enter skill success (True/False): ").strip().lower() == "true"
            
            step_dict = {}

            print(f"\n[{task_key} | step {st_idx}] Skill: {skill_str if skill_str else 'INITIAL'} | success label: {success}")

            img_name = f"{task_key}_skill{st_idx}"
            img_path = sequence_dir / (img_name + ".jpg")
            
            changed_locs = []
            post_skill_state_img_paths = {}
            # ─── run the skill then take a pic ─────────────────────────────────────────────
            if st_idx == 0:
                #before sequence starts (no skill)
                
                #deploy arm before pic to Ziyi arm config
                _deploy_arm(move_group, ZIYI_DEPLOYED_ARM_CONFIG)
                
                navigate_to=_start_nav_service()
                _go_to_loc(START_LOC, navigate_to)
                _take_pic_via_service(str(img_path), cam_type=LOC_TO_CAM[START_LOC])

                curr_state_img_paths[START_LOC] = str(img_path) #update the path for img
                changed_locs.append(START_LOC)
                post_skill_state_img_paths[frozenset({START_LOC, skill_str})] = str(init_paths_pre[START_LOC])
            else:
                # refined_tree_path = REFINED_TREE_PATHS[skill_str.split('(')[0]]
                # run_skill_tamp(refined_tree_path) #goes to the location of the skill and does it

                # base = Path("src/tmp3")

                skill_str = skill_str.split('(')[0]
                for view_id in SKILL_TO_LOC_ID[skill_str]:
                    loc = LOC_ID_TO_LOC[view_id]
                    _go_to_loc(loc, navigate_to) #navigate to pic location
                    changed_locs.append(loc)
                    cam_type = LOC_TO_CAM[loc]

                    #post skill pics with arm stowed (to be used when robot no longer at location) and arm deployed (to show gripper state such as holding an object)
                    for arm_state in ["undeployed", "deployed"]:
                        #assumption: every location is mapped to only one cam type and cam type for a location can't change within a sequence (e.g. door loc uses front cam at both t_1 and t_5)
                        if arm_state == "undeployed" and cam_type not in ["Gripper"]: #e.g. front cam
                            _stow_arm()
                            #what the location will look like after the skill is executed and the robot leaves
                            img_path = img_path.with_name(img_name + f"_{loc}_" + "post_skill_undeployed_robot_leaves.jpg") 
                            post_skill_state_img_paths[frozenset({loc, skill_str})] = str(img_path) #NOTE 1: either this or NOTE 2 happens
                        elif arm_state == "deployed":
                            if cam_type == "Gripper": # NOTE: Only this case will run if Gripper camera (TODO: Separate gripper case vs arm deployed case)
                                #take pic with realsense attached to gripper. 
                                _deploy_arm(move_group, USING_GRIPPER_CAM_POSE_STAMPED)
                                img_path = img_path.with_name(img_name + f"_{loc}_" +  "post_skill_deployed_robot_leave.jpg") #only ever used for state of location after skill has been executed and robot has left the location
                                post_skill_state_img_paths[frozenset({loc, skill_str})] = str(img_path) #NOTE 2: either this or NOTE 1 happens
                            else: #e.g. front cam
                                _deploy_arm(move_group, ZIYI_DEPLOYED_ARM_CONFIG)
                                img_path = img_path.with_name(img_name + f"_{loc}_" + "post_skill_deployed_robot_there.jpg") #used for the state of the location after the skill has been executed and the robot is at the location
                                curr_state_img_paths[loc] = str(img_path)


                        #NOTE: for now we aren't using tmp3 for pics. uncomment the below section only if pics are taken via tmp3 and comment out the take pic service function call below. tmp3 pic taking may be broken and may need to be tested
                        #### --- MAY USE SECTION ---####
                        # ─── publish img path and skill info to ROS topic in order for img to be taken ────────────
                        # payload = {
                        #     'img_paths': str(img_path), 
                        #     'cam_type': cam_type,
                        #     'skill_str': skill_str,      
                        #     'seq': s_idx                        
                        # }
                        
                        # yaml_str = yaml.dump(payload)
                        # pub.publish(String(data=yaml_str))
                        #### --- MAY USE SECTION ---####

                        #take picture
                        _take_pic_via_service(str(img_path), cam_type)

                        if arm_state == "deployed":
                            #stow the arm at the end
                            _stow_arm()
                    
            # record to dict
            step_dict['images(state)'] = [str(p) for p in curr_state_img_paths.values()]
            step_dict["skill"] = skill_str
            step_dict["success"] = success
            data[task_key][str(st_idx)] = step_dict
            _save_yaml(data)
            print("Step saved. YAML checkpoint updated.")
            
            #reset gripper in view and gripper cam holding imgs to no gripper in view and no holding for the necessary locations for next step
            curr_state_img_paths = _prepare_state_for_next(curr_state_img_paths, skill_str, changed_locs, post_skill_state_img_paths)

        step_i = 0  # reset for next sequence
        print(f"=== Finished {task_key} ===\n")

    print("\nAll sequences finished! Data stored in", YAML_PATH)


if __name__ == "__main__":
    try:
        main()
        # states = get_skill_states("OpenDoor", YAML_PATH)
    except KeyboardInterrupt:
        print("\nInterrupted – progress saved to YAML. Bye!")