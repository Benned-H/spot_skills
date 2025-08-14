from moveit_commander import MoveGroupCommander
import rospy
from std_srvs.srv import Trigger
from transform_utils.kinematics import Pose3D
from transform_utils.kinematics_ros import pose_to_stamped_msg
from spot_skills.srv import NavigateToPose, NavigateToPoseRequest
import sys
import os
from typing import Dict, List, Tuple, Optional
from pathlib import Path
from capture_img_service import ImageCapturer
from transform_utils.ros.services import trigger_service


ZIYI_DEPLOYED_ARM_CONFIG = {
    "arm_sh0": -0.3948547840118408,
    "arm_sh1": -1.0508015155792236,
    "arm_el0": 2.347215414047241,
    "arm_el1": -0.43893003463745117,
    "arm_wr0": -0.03280067443847656,
    "arm_wr1": -0.488569974899292,
    # "arm_f1x": -0.4537029266357422,
}

IMAGE_ROOT = Path(".")

pose = Pose3D.from_list([0, 0, 0, 0, 0, 0], ref_frame="")
USING_GRIPPER_CAM_POSE_STAMPED = pose_to_stamped_msg(pose)

LOC_TO_POSE = {
    "FarDrawer": {'x':1.6185776551346573, 'y':4.351615016108794, 'yaw_rad':1.5767166962871992},
    "NearDrawer":{'x':1.6962928228511267, 'y':5.324740652801458, 'yaw_rad':1.5800258763906496},
    "Door": {'x':-0.9466865082753808, 'y':5.748536851563401, 'yaw_rad':1.6079377047012806},
    "Whiteboard":{'x':-3.671084041944143, 'y':10.21919214184345, 'yaw_rad':0.00196145772676737},
}

LOC_TO_CAM={
    "Door": "Front",
    "NearDrawer": "Gripper",
    "FarDrawer": "Front",
    "Board": "Front"
}

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

def _deploy_arm(move_group, arm_or_pose):
    """
    Deploys Spot arm to specified joint configuration.
    """

    rospy.wait_for_service('/spot/unlock_arm')

    try:
        trigger_srv = rospy.ServiceProxy('/spot/unlock_arm', Trigger)
        resp = trigger_srv()  # For Trigger, no request args
        rospy.loginfo(f"Success: {resp.success}, Message: {resp.message}")
    except rospy.ServiceException as e:
        rospy.logerr(f"Service call failed: {e}")


    if arm_or_pose == ZIYI_DEPLOYED_ARM_CONFIG:
        move_group.set_joint_value_target(arm_or_pose)
    else:
        move_group.set_pose_target(pose=arm_or_pose, end_effector_link="arm_link_wr1")

    suc, robot_trajectory, _, _ = move_group.plan()
    move_group.execute(robot_trajectory, wait=True)  # Blocks until done 
    move_group.stop()  # Ensure there's no residual movement


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


def _take_init_imgs(capturer, move_group: MoveGroupCommander) -> Dict:
    """
    Takes initial images. 1 at each location. Using front or gripper camera. If front cam, without gripper in frame.
    """
    dir = IMAGE_ROOT / "init_imgs"

    if not os.path.exists(dir):
        os.makedirs(dir)

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
        capturer.capture_and_stitch(Path(img_path_pre), cam_type) # init state before skill execution
        init_paths_pre[loc] = img_path_pre

        if arm_deployed:
            _stow_arm()
            arm_deployed = False

    return init_paths_pre


if __name__ == "__main__":
    move_group = MoveGroupCommander("arm")
    capturer = ImageCapturer(robot=None)
    init_paths_pre = _take_init_imgs(capturer, move_group) #dict {"Door": Path, ...}





