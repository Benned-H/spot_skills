"""Define a class providing a ROS 1 interface to the Spot robot."""

from copy import deepcopy
from pathlib import Path
from typing import Sequence

import rospy
from actionlib import SimpleActionServer
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryGoal,
    FollowJointTrajectoryResult,
    GripperCommandAction,
    GripperCommandGoal,
    GripperCommandResult,
)
from robotics_utils.kinematics import Point3D
from robotics_utils.ros import TagTracker, TransformManager, get_ros_param
from robotics_utils.ros.msg_conversion import pose_to_stamped_msg
from robotics_utils.ros.trajectory_playback import RelativeTrajectoryConfig, TrajectoryPlayback
from robotics_utils.vision.fiducials import FiducialSystem
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse

from spot_skills.msg import RGBDPair
from spot_skills.msg import RGBImage as RGBImageMsg
from spot_skills.srv import (
    GetRGBDPairs,
    GetRGBDPairsRequest,
    GetRGBDPairsResponse,
    GetRGBImages,
    GetRGBImagesRequest,
    GetRGBImagesResponse,
    OpenDoor,
    OpenDoorRequest,
    OpenDoorResponse,
    PlaybackTrajectory,
    PlaybackTrajectoryRequest,
    PlaybackTrajectoryResponse,
    PoseLookup,
    PoseLookupRequest,
    PoseLookupResponse,
)
from spot_skills_py.joint_trajectory import JointTrajectory
from spot_skills_py.spot.spot_arm_controller import (
    ArmCommandOutcome,
    GripperCommandOutcome,
    SpotArmController,
)
from spot_skills_py.spot.spot_erase import erase_board
from spot_skills_py.spot.spot_graph_nav import SpotGraphNav
from spot_skills_py.spot.spot_image_client import ImageFormat, SpotImageClient, SpotRGBCamera
from spot_skills_py.spot.spot_manager import SpotManager
from spot_skills_py.spot.spot_navigation import SpotNavigationServer
from spot_skills_py.spot.spot_open_door import SpotDoorOpener
from spot_skills_py.visualize_graphnav import GraphNavRViz


class SpotROS1Wrapper:
    """A ROS 1 interface for the Spot robot."""

    def __init__(self) -> None:
        """Initialize the ROS interface by creating an internal SpotManager."""
        # Initialize Spot's arm as locked before enabling any of the actions!
        self._arm_locked = True  # Begin without ROS control of Spot's arm

        self._manager = None
        self._arm_controller = None

        TransformManager.init_node()

        # Set up all ROS action servers provided by the class (do this early so MoveIt finds them)
        self._arm_action_name = "arm_controller/follow_joint_trajectory"
        self._arm_action_server = SimpleActionServer(
            self._arm_action_name,
            FollowJointTrajectoryAction,
            execute_cb=self.arm_action_callback,
            auto_start=False,
        )
        self._arm_action_server.start()
        rospy.loginfo(f"[{self._arm_action_name}] Action server has started.")

        self._gripper_action_name = "gripper_controller/gripper_action"
        self._gripper_action_server = SimpleActionServer(
            self._gripper_action_name,
            GripperCommandAction,
            execute_cb=self.gripper_action_callback,
            auto_start=False,
        )
        self._gripper_action_server.start()
        rospy.loginfo(f"[{self._gripper_action_name}] Action server has started.")

        spot_rosparams = ["/spot/hostname", "/spot/username", "/spot/password"]
        spot_rosparam_values = [get_ros_param(par, str) for par in spot_rosparams]
        spot_hostname, spot_username, spot_password = spot_rosparam_values

        self._manager = SpotManager(
            client_name="SpotROS1Manager",
            hostname=spot_hostname,
            username=spot_username,
            password=spot_password,
        )

        max_segment_len = 30  # Limit the points/segment in ArmController trajectories
        self._arm_controller = SpotArmController(self._manager, max_segment_len)

        self._door_opener = SpotDoorOpener(self._manager)

        # Only take immediate control of Spot if requested via rosparam
        immediate_control = get_ros_param("/spot/immediate_control", bool, default_value=False)

        if immediate_control:
            self._manager.take_control(force=True)

        # Initialize all ROS services provided by the class
        self._stand_service = rospy.Service("spot/stand", Trigger, self.handle_stand)
        self._sit_service = rospy.Service("spot/sit", Trigger, self.handle_sit)
        self._shutdown_service = rospy.Service("spot/shutdown", Trigger, self.handle_shutdown)
        self._unlock_arm_service = rospy.Service("spot/unlock_arm", Trigger, self.handle_unlock_arm)
        self._stow_arm_service = rospy.Service("spot/stow_arm", Trigger, self.handle_stow_arm)
        self._deploy_arm_service = rospy.Service("spot/deploy_arm", Trigger, self.handle_deploy_arm)
        self._open_door_service = rospy.Service("spot/open_door", OpenDoor, self.handle_open_door)
        self._playback_trajectory_service = rospy.Service(
            "spot/playback_trajectory",
            PlaybackTrajectory,
            self.handle_playback_trajectory,
        )
        self._erase_service = rospy.Service("spot/erase_board", Trigger, self.handle_erase_board)
        self._take_control_srv = rospy.Service(
            "spot/take_control",
            Trigger,
            self.handle_take_control,
        )
        self._release_control_srv = rospy.Service(
            "spot/release_control",
            Trigger,
            self.handle_release_control,
        )
        self._pose_lookup_srv = rospy.Service("pose_lookup", PoseLookup, self.handle_pose_lookup)
        self._dock_srv = rospy.Service("spot/dock", Trigger, self.handle_dock)
        self._start_map = rospy.Service("spot/start_mapping", Trigger, self.handle_start_mapping)
        self._stop_map = rospy.Service("spot/stop_mapping", Trigger, self.handle_stop_mapping)
        self._save_map = rospy.Service("spot/save_map", Trigger, self.handle_save_map)

        traj_config = RelativeTrajectoryConfig(
            ee_frame="arm_link_wr1",
            body_frame="body",
            move_group_name="arm",
        )
        self.trajectory_replayer = TrajectoryPlayback(traj_config)

        self._get_rgbd_pairs_service = rospy.Service(
            "spot/get_rgbd_pairs",
            GetRGBDPairs,
            self.handle_get_rgbd_pairs,
        )
        self._get_rgb_srv = rospy.Service(
            "spot/get_rgb_images",
            GetRGBImages,
            self.handle_get_rgb_images,
        )

        self._graph_nav: SpotGraphNav | None = None
        graph_nav_active = get_ros_param("/spot/graph_nav/active", bool, default_value=False)
        if graph_nav_active:
            map_path = get_ros_param("/spot/graph_nav/map_path", Path)
            mapping_mode = get_ros_param("/spot/graph_nav/mapping_mode", bool)
            load_map = get_ros_param("/spot/graph_nav/load_map", bool)

            self._graph_nav = SpotGraphNav(
                self._manager,
                map_path,
                mapping_mode=mapping_mode,
                load_map=load_map,
            )

            self._graph_nav_rviz = GraphNavRViz(self._graph_nav.graph_nav_client)

        navigation_active = get_ros_param("/spot/navigation/active", bool, default_value=False)
        if navigation_active:
            rospy.loginfo("Now initializing the SpotNavigationServer...")
            self._navigation_server = SpotNavigationServer(self._manager, self._graph_nav)
        else:
            rospy.loginfo("Skipping initialization of SpotNavigationServer...")

        apriltags_active = get_ros_param("/tag_tracker/active", bool, default_value=False)
        if apriltags_active:
            # Create a thread to continually detect AprilTags from Spot's cameras
            markers_yaml_path = get_ros_param("/tag_tracker/markers_yaml_path", Path)
            fiducial_system = FiducialSystem.from_yaml(markers_yaml_path)
            spot_rgb_cameras = [
                SpotRGBCamera(camera_name, self._manager.image_client)
                for camera_name in fiducial_system.camera_names
            ]
            self.tag_tracker = TagTracker(fiducial_system, spot_rgb_cameras)

    def handle_stand(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param _: Message representing a request for Spot to stand (unused)
        :return: Response conveying whether Spot has successfully stood up
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not make Spot stand.",
            )

        stood_up = False
        if self._manager.ensure_control(take_by_force=False):
            stood_up = self._manager.stand_up(20)

        message = "Spot is now standing." if stood_up else "Could not make Spot stand."

        return TriggerResponse(stood_up, message)

    def handle_sit(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to make Spot sit.

        :param _: ROS message representing a request that Spot sits (unused)
        :return: Response conveying whether Spot has successfully sat down
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not make Spot sit.",
            )

        sit_success = False
        if self._manager.ensure_control(take_by_force=False):
            sit_success = self._manager.sit_down(20)

        message = "Spot is now sitting." if sit_success else "Spot could not sit."

        return TriggerResponse(sit_success, message)

    def handle_dock(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to dock Spot at its default dock.

        :param _: ROS message requesting that Spot be docked (unused)
        :return: Response conveying whether Spot successfully docked
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not make Spot dock.",
            )

        dock_id = get_ros_param("spot/dock_id", int, default_value=520)
        success = self._manager.dock(dock_id)
        message = "Spot successfully docked." if success else "Spot failed to dock."
        return TriggerResponse(success, message)

    def handle_shutdown(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to shut down the Spot wrapper and manager.

        :param _: ROS message requesting that Spot be shut down (unused)
        :return: Response conveying that shutdown was initiated
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not shut down Spot.",
            )

        self._manager.shutdown()
        rospy.signal_shutdown("Shutting down Spot ROS wrapper...")

        return TriggerResponse(success=True, message="Spot has been shut down.")

    def handle_unlock_arm(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to enable ROS control of Spot's arm.

        :param _: Message representing a request to unlock Spot's arm (unused)
        :return: Response conveying that Spot's arm has been unlocked
        """
        if self._manager is None or self._arm_controller is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is not set up; could not unlock Spot's arm.",
            )

        # When unlocking the arm, forcibly take control of Spot if necessary
        has_control = self._manager.ensure_control(take_by_force=True)

        if has_control:
            self._arm_locked = False
            self._arm_controller.unlock_arm()
            message = "Spot's arm is now unlocked."
        else:
            message = "Could not gain control of Spot; leaving Spot's arm locked."

        return TriggerResponse(has_control, message)

    def handle_stow_arm(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to stow Spot's arm.

        TODO: If Spot is believed to be holding something, prevent stowing.

        :param _: Message representing a request to stow Spot's arm
        :return: Response conveying whether Spot's arm has been stowed
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is not set up; could not stow Spot's arm.",
            )

        if self._arm_locked:
            message = "Spot's arm was not stowed because Spot's arm remains locked."
            return TriggerResponse(success=False, message=message)

        arm_stowed = False
        if self._manager.ensure_control(take_by_force=False):
            arm_stowed = self._manager.stow_arm()

        message = "Spot's arm has been stowed." if arm_stowed else "Could not stow Spot's arm."

        return TriggerResponse(arm_stowed, message)

    def handle_deploy_arm(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to deploy Spot's arm.

        :param _: Message representing a request to deploy Spot's arm
        :return: Response conveying whether Spot's arm has been deployed
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is not set up; could not deploy Spot's arm.",
            )

        if self._arm_locked:
            message = "Spot's arm was not deployed because Spot's arm remains locked."
            return TriggerResponse(success=False, message=message)

        deployed = False
        if self._manager.ensure_control(take_by_force=False):
            deployed = self._manager.deploy_arm()

        message = "Spot's arm has been deployed." if deployed else "Could not deploy Spot's arm."

        return TriggerResponse(success=deployed, message=message)

    def handle_start_mapping(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to start mapping using GraphNav.

        :param _: ROS message request to start mapping
        :return: Response conveying whether mapping was started
        """
        if self._graph_nav is None:
            return TriggerResponse(
                success=False,
                message="SpotGraphNav is None; cannot start mapping.",
            )

        success, message = self._graph_nav.start_mapping()
        return TriggerResponse(success, message)

    def handle_stop_mapping(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to stop mapping using GraphNav.

        :param _: ROS message request to stop mapping
        :return: Response conveying whether mapping was stopped
        """
        if self._graph_nav is None:
            return TriggerResponse(
                success=False,
                message="SpotGraphNav is None; cannot stop mapping.",
            )

        success, message = self._graph_nav.stop_mapping()
        return TriggerResponse(success, message)

    def handle_save_map(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to save the GraphNav map to file.

        :param _: ROS message request to save the map to file
        :return: Response conveying whether map was successfully saved
        """
        if self._graph_nav is None:
            return TriggerResponse(
                success=False,
                message="SpotGraphNav is None; cannot save map to file.",
            )

        success, message = self._graph_nav.save_map(self._graph_nav.map_path)
        return TriggerResponse(success, message)

    def handle_get_rgbd_pairs(self, request_msg: GetRGBDPairsRequest) -> GetRGBDPairsResponse:
        """Handle a request to capture RGBD image pairs from the specified camera(s) on Spot.

        :param request_msg: Message specifying the name of the RGBD camera(s) to be used
        :return: Response containing the RGB and depth images, alongside camera info
        """
        request_protos = []

        for camera_name in request_msg.camera_names:
            request_protos.append(
                self._manager.image_client.make_image_request(camera_name, ImageFormat.RGB),
            )
            request_protos.append(
                self._manager.image_client.make_image_request(camera_name, ImageFormat.DEPTH),
            )

        response_protos = self._manager.image_client.get_images(request_protos)
        assert len(response_protos) == len(request_protos)

        response_msg = GetRGBDPairsResponse()
        for camera_idx, camera_name in enumerate(request_msg.camera_names):
            rgb_response = response_protos[2 * camera_idx]
            depth_response = response_protos[2 * camera_idx + 1]

            # Find ROS timestamps of the image responses
            rgb_time_proto = rgb_response.shot.acquisition_time
            rgb_timestamp = self._manager.time_sync.local_timestamp_from_proto(rgb_time_proto)
            rgb_time_s = rgb_timestamp.to_time_s()
            rgb_ros_time = rospy.Time.from_sec(rgb_time_s)

            depth_time_proto = depth_response.shot.acquisition_time
            depth_timestamp = self._manager.time_sync.local_timestamp_from_proto(depth_time_proto)
            depth_time_s = depth_timestamp.to_time_s()
            depth_ros_time = rospy.Time.from_sec(depth_time_s)

            diff_s = rgb_time_s - depth_time_s
            assert diff_s <= 0.1, f"Synchronized RGB and depth images differed by {diff_s} seconds!"

            rgb_camera_info = SpotImageClient.extract_camera_info_msg(rgb_response, rgb_ros_time)
            d_camera_info = SpotImageClient.extract_camera_info_msg(depth_response, depth_ros_time)

            # Expect that the camera information is identical, except the header
            d_camera_info_copy = deepcopy(d_camera_info)
            d_camera_info_copy.header = rgb_camera_info.header
            assert rgb_camera_info == d_camera_info_copy, "Expected identical camera information!"

            rgbd_pair_msg = RGBDPair()
            rgbd_pair_msg.camera_name = camera_name
            rgbd_pair_msg.camera_info = rgb_camera_info
            rgbd_pair_msg.rgb = self._manager.image_client.extract_image_msg(
                rgb_response.shot,
                rgb_ros_time,
            )
            rgbd_pair_msg.depth = self._manager.image_client.extract_image_msg(
                depth_response.shot,
                depth_ros_time,
            )
            response_msg.rgbd_pairs.append(rgbd_pair_msg)

        return response_msg

    def handle_get_rgb_images(self, request_msg: GetRGBImagesRequest) -> GetRGBImagesResponse:
        """Handle a request to capture RGB images from the specified camera(s) on Spot.

        :param request_msg: Message specifying the name of the RGB camera(s) to be used
        :return: Response containing the RGB images and corresponding camera info
        """
        response_msg = GetRGBImagesResponse()
        response_msg.images = []

        if self._manager is None:
            return response_msg

        request_protos = [
            self._manager.image_client.make_image_request(camera_name, ImageFormat.RGB)
            for camera_name in request_msg.camera_names
        ]
        response_protos = self._manager.image_client.get_images(request_protos)

        assert len(request_msg.camera_names) == len(response_protos)
        for camera_name, rgb_response in zip(request_msg.camera_names, response_protos):
            # Find ROS timestamps of the image responses
            rgb_time_proto = rgb_response.shot.acquisition_time
            rgb_timestamp = self._manager.time_sync.local_timestamp_from_proto(rgb_time_proto)
            rgb_time_s = rgb_timestamp.to_time_s()
            rgb_ros_s = rospy.Time.from_sec(rgb_time_s)

            rgb_camera_info = SpotImageClient.extract_camera_info_msg(rgb_response, rgb_ros_s)
            rgb_msg = self._manager.image_client.extract_image_msg(rgb_response.shot, rgb_ros_s)

            response_msg.images.append(
                RGBImageMsg(camera_name=camera_name, camera_info=rgb_camera_info, rgb=rgb_msg),
            )

        return response_msg

    def handle_open_door(self, request: OpenDoorRequest) -> OpenDoorResponse:
        """Handle a service request to open a door in front of Spot.

        :param request: ROS message representing a request to open a door
        :return: Response conveying whether Spot was able to open the door
        """
        if self._arm_locked:
            message = "Could not open door because Spot's arm remains locked."
            return OpenDoorResponse(success=False, message=message)

        if self._manager is None:
            return OpenDoorResponse(
                success=False,
                message="SpotManager is None; could not open the door.",
            )

        if not self._manager.ensure_control(take_by_force=False):
            message = "Could not open door because SpotManager could not take control of Spot."
            return OpenDoorResponse(success=False, message=message)

        # Call the operations needed for door-opening, step-by-step
        door_image = self._door_opener.capture_door_handle_image(request.body_pitch_rad)

        handle_xy = self._door_opener.detect_handle_xy(door_image)
        if handle_xy is None:
            return OpenDoorResponse(
                success=False,
                message="Cannot open door because no door handle was detected.",
            )

        rospy.loginfo("SpotDoorOpener successfully detected a door handle.")

        # detector = ObjectDetector()
        # detected = detector.detect(door_image, queries=["silver door handle"])
        # if not detected.detections:
        #     return OpenDoorResponse(
        #         success=False,
        #         message="Cannot open door because the door handle was not detected.",
        #     )

        # display(detected, "Door handle detection(s) (press any key to exit)")
        # for i, d in enumerate(detected.detections):
        #     cropped = d.bounding_box.crop(door_image, scale_ratio=1.2)
        #     display(cropped, f"Detection {i}/{len(detected.detections)}: '{d.query}'")

        # best_score = max(d.score for d in detected.detections)
        # best_detections = [d for d in detected.detections if d.score == best_score]

        # handle_xy = tuple(best_detections[0].bounding_box.center_pixel)
        # assert len(handle_xy) == 2, "Expected (x,y) pixel coordinates."

        is_pull = bool(request.is_pull)
        hinge_on_left = bool(request.hinge_on_left)

        door_opened = self._door_opener.open_door(
            door_image,
            is_pull=is_pull,
            hinge_on_left=hinge_on_left,
            open_door_timeout_s=120,
        )

        message = "Spot opened the door." if door_opened else "Could not open the door."

        return OpenDoorResponse(door_opened, message)

    def handle_playback_trajectory(
        self,
        request_msg: PlaybackTrajectoryRequest,
    ) -> PlaybackTrajectoryResponse:
        """Handle a service request to play back a trajectory read from file.

        :param request_msg: ROS message specifying a path to a trajectory YAML file
        :return: Response conveying whether Spot was able to play back the trajectory
        """
        if self._manager is None:
            return PlaybackTrajectoryResponse(
                success=False,
                message="SpotManager is None; could not play back a trajectory.",
            )

        yaml_path = Path(request_msg.yaml_path)
        if not yaml_path.exists():
            return PlaybackTrajectoryResponse(
                success=False,
                message=f"Cannot play back trajectory from nonexistent file: {yaml_path}",
            )

        if self._arm_locked:
            message = f"Cannot replay trajectory from {yaml_path} because Spot's arm is locked."
            return PlaybackTrajectoryResponse(success=False, message=message)

        if not self._manager.ensure_control(take_by_force=False):
            message = f"Cannot replay trajectory from {yaml_path} without control of Spot."
            return PlaybackTrajectoryResponse(success=False, message=message)

        relative_poses = self.trajectory_replayer.load_relative_trajectory(yaml_path)
        rospy.loginfo(f"Loaded {len(relative_poses)} poses from YAML file: {yaml_path}.")
        self.trajectory_replayer.execute_hybrid_cartesian_sequence(relative_poses)

        message = f"Successfully executed trajectory loaded from file: {yaml_path}"
        return PlaybackTrajectoryResponse(success=True, message=message)

    def handle_erase_board(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to erase a whiteboard.

        :param _: Message representing a request to erase a board
        :return: Response conveying whether the whiteboard was erased
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not erase the board.",
            )

        if self._arm_locked:
            return TriggerResponse(
                success=False,
                message="Could not erase whiteboard because Spot's arm remains locked.",
            )

        if not self._manager.ensure_control(take_by_force=False):
            return TriggerResponse(success=False, message="Could not erase the whiteboard.")

        erase_traj_path = get_ros_param(
            "spot/erase_trajectory_path",
            Path,
            Path("/docker/spot_skills/src/spot_skills/config/erase_traj.yaml"),
        )
        erase_traj = Point3D.load_points_from_yaml(erase_traj_path, collection_name="points")

        erase_board(self._manager, erase_traj)

        return TriggerResponse(success=True, message="Erased the whiteboard.")

    def handle_take_control(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to forcibly take control of Spot.

        :param _: Message representing a request to take control of Spot
        :return: Response conveying whether control was successfully taken
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not take control of Spot.",
            )

        has_control = self._manager.ensure_control(take_by_force=True)
        message = (
            "SpotManager now controls Spot."
            if has_control
            else "SpotManager could not obtain control of Spot."
        )
        return TriggerResponse(success=has_control, message=message)

    def handle_release_control(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to release control of Spot.

        :param _: Message representing a request to release control of Spot
        :return: Response conveying whether control was successfully released
        """
        if self._manager is None:
            return TriggerResponse(
                success=False,
                message="SpotManager is None; could not release control of Spot.",
            )

        if not self._manager.has_control:
            return TriggerResponse(
                success=True,
                message="SpotManager already doesn't control Spot.",
            )

        self._manager.release_control()

        has_control = self._manager.has_control
        message = (
            "SpotManager still controls Spot."
            if has_control
            else "SpotManager has released control of Spot."
        )

        return TriggerResponse(success=(not has_control), message=message)

    def handle_pose_lookup(self, request: PoseLookupRequest) -> PoseLookupResponse:
        """Handle a request to look up the relative pose between two frames using /tf."""
        relative_pose = TransformManager.lookup_transform(
            request.source_frame,
            request.target_frame,
        )

        if relative_pose is not None:
            return PoseLookupResponse(
                success=True,
                message=str(relative_pose.to_yaml_data()),
                relative_pose=pose_to_stamped_msg(relative_pose),
            )

        response = PoseLookupResponse()  # Otherwise, respond with failure
        response.success = False
        response.message = "Relative pose was None."
        return response

    def arm_action_callback(self, goal: FollowJointTrajectoryGoal, delay_s: float = 0.25) -> None:
        """Handle a new goal for the FollowJointTrajectory action server.

        If Spot's arm is unlocked, trajectories sent to this server will be executed.

        Reference: https://tinyurl.com/FollowJointTrajectory

        :param goal: Joint trajectory to be followed
        :param delay_s: Delay (seconds) to wait after any successful command execution
        """
        result = FollowJointTrajectoryResult()
        result.error_code = -1  # Default error code: INVALID_GOAL

        if self._manager is None or self._arm_controller is None:
            result.error_string = "Could not follow trajectory because SpotManager is not set up."
            rospy.loginfo(f"[{self._arm_action_name}] {result.error_string}")
            self._arm_action_server.set_aborted(result)
            return

        # Extract all fields of the received action goal message
        trajectory = JointTrajectory.from_ros_msg(goal.trajectory)

        # TODO: Could use the joint tolerances to enforce within-bounds trajectory
        #   execution. Similar logic would allow the action server to publish feedback.
        # Currently, we're ignoring these variables in the received trajectory:
        #   path_tolerance, goal_tolerance, goal_time_tolerance

        # Log information about the received trajectory
        first_rel_time_s = trajectory.points[0].time_from_start_s
        last_rel_time_s = trajectory.points[-1].time_from_start_s
        traj_duration_s = last_rel_time_s - first_rel_time_s

        rospy.loginfo(
            f"[{self._arm_action_name}] Received trajectory of length "
            f"{len(trajectory.points)}, lasting {traj_duration_s} seconds.",
        )

        if self._arm_locked:
            result.error_string = "Could not follow trajectory because Spot's arm remains locked."
            self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")
            self._arm_action_server.set_aborted(result)
            return

        if not self._manager.ensure_control(take_by_force=False):
            result.error_string = "Could not obtain control of Spot."
            self._arm_action_server.set_aborted(result)
            return

        # Attempt to send the trajectory using the SpotArmController
        outcome = self._arm_controller.command_trajectory(
            trajectory,
            self._arm_action_server,
        )

        # Update the ROS action server based on the outcome of the trajectory
        if outcome == ArmCommandOutcome.SUCCESS:
            rospy.sleep(delay_s)  # Delay after the end of any successful trajectory

            result.error_code = int(outcome)
            result.error_string = "Success!"
            self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")
            self._arm_action_server.set_succeeded(result)

        elif outcome == ArmCommandOutcome.INVALID_START:
            result.error_string = (
                "Could not follow trajectory because it did not begin "
                "from the current configuration of Spot's arm."
            )

            self._arm_action_server.set_aborted(result)

        elif outcome == ArmCommandOutcome.ARM_LOCKED:
            result.error_string = "Could not follow trajectory because Spot's arm remains locked."
            self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")

            self._arm_action_server.set_aborted(result)

        elif outcome == ArmCommandOutcome.PREEMPTED:
            self._arm_action_server.set_preempted()

    def gripper_action_callback(self, goal: GripperCommandGoal, delay_s: float = 0.25) -> None:
        """Handle a new goal for the GripperCommandAction action server.

        If Spot's arm is unlocked, gripper commands sent to this server will be executed.

        Reference: https://docs.ros.org/en/noetic/api/control_msgs/html/action/GripperCommand.html

        :param goal: Gripper command to be executed
        :param delay_s: Delay (seconds) to wait after command execution has nominally finished
        """
        gripper_command_result = GripperCommandResult()

        if self._manager is None or self._arm_controller is None or self._arm_locked:
            gripper_command_result.reached_goal = False
            self._gripper_action_server.set_aborted(gripper_command_result)
            return

        goal_position_rad = goal.command.position  # Ignoring goal.command.max_effort

        outcome = GripperCommandOutcome.FAILURE
        if self._manager.ensure_control(take_by_force=False):
            outcome = self._arm_controller.command_gripper(goal_position_rad)
            rospy.sleep(delay_s)

        if outcome == GripperCommandOutcome.FAILURE:
            gripper_command_result.reached_goal = False
            self._gripper_action_server.set_aborted(gripper_command_result)
        else:
            gripper_command_result.reached_goal = outcome == GripperCommandOutcome.REACHED_SETPOINT
            gripper_command_result.stalled = outcome == GripperCommandOutcome.STALLED

            self._gripper_action_server.set_succeeded(gripper_command_result)
