"""Define a class providing a ROS 1 interface to the Spot robot."""

from copy import deepcopy
from pathlib import Path

import numpy as np
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
from nav_msgs.msg import OccupancyGrid as OccupancyGridMsg
from robotics_utils.geometry import Point3D
from robotics_utils.motion_planning import DiscreteGrid2D
from robotics_utils.perception import LaserScan2D, OccupancyGrid2D
from robotics_utils.robots import GripperAngleLimits
from robotics_utils.ros import CallLoopThread, TagTracker, TransformManager, get_ros_param
from robotics_utils.ros.msg_conversion import (
    occupancy_grid_to_msg,
    point_from_vector3_msg,
    pointcloud_to_msg,
    pose_to_stamped_msg,
)
from robotics_utils.ros.robots import MoveItManipulator, ROSAngularGripper
from robotics_utils.ros.trajectory_playback import RelativeTrajectoryConfig, TrajectoryPlayback
from robotics_utils.spatial import DEFAULT_FRAME, Pose2D
from robotics_utils.vision.fiducials import FiducialSystem
from sensor_msgs.msg import PointCloud2
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
    NameService,
    NameServiceRequest,
    NameServiceResponse,
    OpenDoor,
    OpenDoorRequest,
    OpenDoorResponse,
    PlaybackTrajectory,
    PlaybackTrajectoryRequest,
    PlaybackTrajectoryResponse,
    PoseLookup,
    PoseLookupRequest,
    PoseLookupResponse,
    ProbeSurface,
    ProbeSurfaceRequest,
    ProbeSurfaceResponse,
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

SPOT_GRIPPER_OPEN_RAD = -1.5707
SPOT_GRIPPER_CLOSED_RAD = 0.0


class SpotROS1Wrapper:
    """A ROS 1 interface for the Spot robot."""

    def __init__(self) -> None:
        """Initialize the ROS interface by creating an internal SpotManager."""
        # Initialize Spot's arm as locked before enabling any of the actions!
        self._arm_locked = True  # Begin without ROS control of Spot's arm
        self._manager_exists = False
        self._arm_controller_exists = False

        self._lidar_active = False
        """Boolean indicating whether we should continually request LiDAR data from Spot."""

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
        self._manager_exists = True

        max_segment_len = 30  # Limit the points/segment in ArmController trajectories
        self._arm_controller = SpotArmController(self._manager, max_segment_len)
        self._arm_controller_exists = True

        gemini_api_key = get_ros_param("~gemini_api_key", str, "NOT SPECIFIED")
        if gemini_api_key == "NOT SPECIFIED":
            gemini_api_key = None
        self._door_opener = SpotDoorOpener(self._manager, gemini_api_key)

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
        self._probe_service = rospy.Service("spot/probe_surface", ProbeSurface, self.handle_probe)
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

        self._pcd_pub = rospy.Publisher("spot/lidar_cloud", PointCloud2, latch=True, queue_size=1)
        self._occ_pub = rospy.Publisher("occupancy_grid", OccupancyGridMsg, queue_size=1)

        self._pose_lookup_srv = rospy.Service("pose_lookup", PoseLookup, self.handle_pose_lookup)
        self._dock_srv = rospy.Service("spot/dock", Trigger, self.handle_dock)
        self._undock_srv = rospy.Service("spot/undock", Trigger, self.handle_undock)
        self._start_map = rospy.Service("spot/start_mapping", Trigger, self.handle_start_mapping)
        self._stop_map = rospy.Service("spot/stop_mapping", Trigger, self.handle_stop_mapping)
        self._save_map = rospy.Service("spot/save_map", Trigger, self.handle_save_map)

        self._pause_est_srv = rospy.Service(
            "spot/pose_estimation/pause",
            NameService,
            self.handle_pause_pose_estimation,
        )
        self._resumse_est_srv = rospy.Service(
            "spot/pose_estimation/resume",
            NameService,
            self.handle_resume_pose_estimation,
        )

        gripper = ROSAngularGripper(
            limits=GripperAngleLimits(
                open_rad=SPOT_GRIPPER_OPEN_RAD,
                closed_rad=SPOT_GRIPPER_CLOSED_RAD,
            ),
            grasping_group="gripper",
            action_name="gripper_controller/gripper_action",
        )
        self.manipulator = MoveItManipulator(
            name="arm",
            robot_name="Spot",
            base_frame="body",
            planning_frame=DEFAULT_FRAME,
            gripper=gripper,
        )

        traj_config = RelativeTrajectoryConfig(
            min_pose_diff_m=0.02,
            min_pose_diff_deg=5,
            plan_ee_step_m=0.015,
        )
        self.trajectory_replayer = TrajectoryPlayback(traj_config, self.manipulator)

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
            self._navigation_server = SpotNavigationServer(self._manager, self._graph_nav)

            rospy.loginfo("Now initializing the SpotNavigationServer...")

        apriltags_active = get_ros_param("/tag_tracker/active", bool, default_value=False)
        if apriltags_active:
            # Create a thread to continually detect AprilTags from Spot's cameras
            markers_yaml_path = get_ros_param("/tag_tracker/markers_yaml_path", Path)
            fiducial_system = FiducialSystem.from_yaml(markers_yaml_path)
            spot_rgb_cameras = [
                SpotRGBCamera(camera_name, self._manager.image_client)
                for camera_name in fiducial_system.camera_names
            ]
            self._manager.log_info(str(spot_rgb_cameras))

            self.tag_tracker = TagTracker(fiducial_system, spot_rgb_cameras)

            # Initialize all objects in the planning scene, then begin syncing in a loop
            self.manipulator.planning_scene.synchronize_state(self.tag_tracker.kinematic_state)
            self.tag_tracker.simulators.append(self.manipulator.planning_scene)

        grid_parameters = DiscreteGrid2D(
            Pose2D(x=-0.5, y=2.5, yaw_rad=0, ref_frame="map"),
            resolution_m=0.1,
            width_cells=100,
            height_cells=100,
        )
        self.occupancy_grid = OccupancyGrid2D(grid=grid_parameters, min_obstacle_depth_m=0.05)
        self._lidar_thread = CallLoopThread(func=self._update_lidar, loop_hz=1.0)
        self._lidar_active = True

    def _update_lidar(self) -> None:
        """Update the occupancy grid with new LiDAR data from Spot."""
        if not self._lidar_active:
            return

        try:
            stamped_cloud = self._manager.lidar_interface.get_stamped_pointcloud()
            if stamped_cloud is None:
                return

            cloud_msg = pointcloud_to_msg(stamped_cloud.cloud, frame_id=stamped_cloud.cloud_frame)
            self._pcd_pub.publish(cloud_msg)

            # Convert the point cloud into a 2D laser scan
            # The point cloud is in the vision frame, so compute ranges and bearings
            #   relative to the sensor position and heading, not the world origin
            sensor_pose_2d = stamped_cloud.sensor_pose.to_2d()
            sensor_x = sensor_pose_2d.x
            sensor_y = sensor_pose_2d.y
            sensor_yaw = sensor_pose_2d.yaw_rad

            x_coords = stamped_cloud.cloud.points[:, 0]
            y_coords = stamped_cloud.cloud.points[:, 1]

            # Vector from sensor to each point
            x_rel = x_coords - sensor_x
            y_rel = y_coords - sensor_y

            ranges_m = np.sqrt(x_rel**2 + y_rel**2)

            # Compute angles in vision frame, then convert to bearings relative to sensor heading
            world_angles_rad = np.arctan2(y_rel, x_rel)
            angles_rad = world_angles_rad - sensor_yaw
            beam_data = np.stack([ranges_m, angles_rad], axis=1).astype(np.float32)  # (r, θ)

            laser_scan = LaserScan2D(
                sensor_pose=stamped_cloud.sensor_pose.to_2d(),
                beam_data=beam_data,
                range_min_m=0.5,
                range_max_m=60,
            )

            self.occupancy_grid.update(laser_scan)

            occupancy_msg = occupancy_grid_to_msg(grid=self.occupancy_grid)
            self._occ_pub.publish(occupancy_msg)

        except Exception as exc:
            self._manager.log_info(f"Exception during LiDAR update: {exc}")

    def handle_stand(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param _: Message representing a request for Spot to stand (unused)
        :return: Response conveying whether Spot has successfully stood up
        """
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
        dock_id = get_ros_param("spot/dock_id", int, default_value=520)
        success = self._manager.dock(dock_id)
        message = "Spot successfully docked." if success else "Spot failed to dock."
        return TriggerResponse(success, message)

    def handle_undock(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to undock Spot.

        :param _: ROS message requesting that Spot be undocked
        :return: Response conveying whether Spot successfully undocked
        """
        outcome = self._manager.undock()
        return TriggerResponse(outcome.success, outcome.message)

    def handle_shutdown(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to shut down the Spot wrapper and manager.

        :param _: ROS message requesting that Spot be shut down (unused)
        :return: Response conveying that shutdown was initiated
        """
        self._manager.shutdown()
        rospy.signal_shutdown("Shutting down Spot ROS wrapper...")

        return TriggerResponse(success=True, message="Spot has been shut down.")

    def handle_unlock_arm(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to enable ROS control of Spot's arm.

        :param _: Message representing a request to unlock Spot's arm (unused)
        :return: Response conveying that Spot's arm has been unlocked
        """
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
        self._lidar_active = False  # Pause LiDAR updates while stowing Spot's arm

        if self._arm_locked:
            message = "Spot's arm was not stowed because Spot's arm remains locked."
            success = False
        else:
            arm_stowed = False
            if self._manager.ensure_control(take_by_force=False):
                arm_stowed = self._manager.stow_arm()

            success = arm_stowed
            message = "Spot's arm has been stowed." if arm_stowed else "Could not stow Spot's arm."

        self._lidar_active = True
        return TriggerResponse(success, message)

    def handle_deploy_arm(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to deploy Spot's arm.

        :param _: Message representing a request to deploy Spot's arm
        :return: Response conveying whether Spot's arm has been deployed
        """
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

        self._manager.log_info("Saving GraphNav map (this may take some time)...")
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

        if not self._manager.ensure_control(take_by_force=False):
            message = "Could not open door because SpotManager could not take control of Spot."
            return OpenDoorResponse(success=False, message=message)

        if self.manipulator.gripper is None:
            return OpenDoorResponse(
                success=False,
                message="Cannot open the door because Spot's gripper was None.",
            )

        self._lidar_active = False  # Pause LiDAR updates while opening the door

        # Navigate to the "open_door" waypoint, if Spot has one
        if "open_door" in self._navigation_server.waypoints:
            open_door_waypoint = self._navigation_server.waypoints["open_door"]
            self._navigation_server.navigate_to_pose(open_door_waypoint, timeout_s=15.0)

        # Call the operations needed for door-opening, step-by-step
        self.manipulator.gripper.open()
        door_image = self._door_opener.capture_door_handle_image(request.body_pitch_rad)

        if self._door_opener.detect_handle_xy(door_image) is None:
            self._lidar_active = True
            return OpenDoorResponse(
                success=False,
                message="Cannot open door because no door handle was detected.",
            )

        rospy.loginfo("SpotDoorOpener successfully detected a door handle.")

        is_pull = bool(request.is_pull)
        hinge_on_left = bool(request.hinge_on_left)

        door_opened = self._door_opener.open_door(
            is_pull=is_pull,
            hinge_on_left=hinge_on_left,
            door_offset_m=request.door_offset_m,
            ray_search_dist_m=request.ray_search_dist_m,
        )

        self._lidar_active = True

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

        self._lidar_active = False  # Pause LiDAR updates during trajectory playback

        relative_poses = self.trajectory_replayer.load_relative_trajectory(yaml_path)
        rospy.loginfo(f"Loaded {len(relative_poses)} poses from YAML file: {yaml_path}.")
        success = self.trajectory_replayer.execute_hybrid_cartesian_sequence(relative_poses)
        message = (
            f"Successfully executed trajectory loaded from file: {yaml_path}"
            if success
            else f"Unable to execute trajectory loaded from file: {yaml_path}"
        )

        self._lidar_active = True

        return PlaybackTrajectoryResponse(success, message)

    def handle_erase_board(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to erase a whiteboard.

        :param _: Message representing a request to erase a board
        :return: Response conveying whether the whiteboard was erased
        """
        if self._arm_locked:
            return TriggerResponse(
                success=False,
                message="Could not erase whiteboard because Spot's arm remains locked.",
            )

        if not self._manager.ensure_control(take_by_force=False):
            return TriggerResponse(success=False, message="Could not erase the whiteboard.")

        self._lidar_active = False  # Pause LiDAR updates while erasing the board

        erase_traj_path = get_ros_param(
            "spot/erase_trajectory_path",
            Path,
            Path("/docker/spot_skills/src/spot_skills/config/erase_traj.yaml"),
        )
        erase_traj = Point3D.load_points_from_yaml(erase_traj_path, collection_name="points")

        erase_board(self._manager, erase_traj)

        self._lidar_active = True

        return TriggerResponse(success=True, message="Erased the whiteboard.")

    def handle_probe(self, request: ProbeSurfaceRequest) -> ProbeSurfaceResponse:
        """Handle a service request to probe for a surface using Spot's gripper.

        :param request: Message configuring the surface probe attempt
        :return: Response with a Boolean success indicator and outcome message
        """
        if not self._manager.has_control:
            return ProbeSurfaceResponse(
                success=False,
                message="Cannot probe for surface; SpotManager doesn't control Spot.",
            )

        self._lidar_active = False  # Pause LiDAR updates while probing

        plane_result = self._arm_controller.force_controller.probe_surface(
            direction=point_from_vector3_msg(request.direction),
            max_distance_m=request.max_distance_m,
            velocity_mps=request.velocity_mps,
            force_threshold_n=request.force_threshold_n,
            force_check_hz=request.force_check_hz,
            num_probes=request.num_probes,
            probe_interval_s=request.probe_interval_s,
        )

        success = plane_result is not None
        message = (
            f"Found surface: {plane_result}"
            if success
            else "Probed for surface but no surface was found."
        )

        self._lidar_active = True

        return ProbeSurfaceResponse(success, message)

    def handle_take_control(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to forcibly take control of Spot.

        :param _: Message representing a request to take control of Spot
        :return: Response conveying whether control was successfully taken
        """
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
            request.child_frame,
            request.parent_frame,
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

    def handle_pause_pose_estimation(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to pause pose estimation for a specified object."""
        object_name = request.name

        # Retrieve the object's current pose estimate and set it as the object's known pose
        curr_pose = self.tag_tracker.get_object_pose(object_name)
        if curr_pose is None:
            return NameServiceResponse(
                success=False,
                message=(
                    f"Unable to pause pose estimation for '{object_name}' "
                    "because no pose estimate is currently available."
                ),
            )

        self.tag_tracker.kinematic_state.object_names.add(object_name)
        self.tag_tracker.kinematic_state.set_object_pose(obj_name=object_name, new_pose=curr_pose)

        return NameServiceResponse(
            success=True,
            message=f"Successfully paused pose estimation for '{object_name}'.",
        )

    def handle_resume_pose_estimation(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to resume pose estimation for a specified object."""
        object_name = request.name

        self.tag_tracker.pose_averager.reset_frame(frame_name=object_name)

        # If the object's pose is known, initialize its estimate accordingly
        if object_name in self.tag_tracker.kinematic_state.object_names:
            known_pose = self.tag_tracker.kinematic_state.clear_object_pose(object_name)
            if known_pose is not None:
                self.tag_tracker.pose_averager.update(object_name, known_pose)
                TransformManager.broadcast_transform(object_name, known_pose)

        return NameServiceResponse(
            success=True,
            message=f"Successfully resumed pose estimation for '{object_name}'.",
        )

    def arm_action_callback(self, goal: FollowJointTrajectoryGoal, delay_s: float = 0.5) -> None:
        """Handle a new goal for the FollowJointTrajectory action server.

        If Spot's arm is unlocked, trajectories sent to this server will be executed.

        Reference: https://tinyurl.com/FollowJointTrajectory

        :param goal: Joint trajectory to be followed
        :param delay_s: Delay (seconds) to wait after any successful command execution
        """
        result = FollowJointTrajectoryResult()
        result.error_code = -1  # Default error code: INVALID_GOAL

        if not (self._manager_exists and self._arm_controller_exists):
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

        self._lidar_active = False  # Pause LiDAR updates while controlling Spot's arm

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

        self._lidar_active = True

    def gripper_action_callback(self, goal: GripperCommandGoal, delay_s: float = 0.25) -> None:
        """Handle a new goal for the GripperCommandAction action server.

        If Spot's arm is unlocked, gripper commands sent to this server will be executed.

        Reference: https://docs.ros.org/en/noetic/api/control_msgs/html/action/GripperCommand.html

        :param goal: Gripper command to be executed
        :param delay_s: Delay (seconds) to wait after command execution has nominally finished
        """
        gripper_command_result = GripperCommandResult()

        if (not self._manager_exists) or (not self._arm_controller_exists) or self._arm_locked:
            gripper_command_result.reached_goal = False
            self._gripper_action_server.set_aborted(gripper_command_result)
            return

        self._lidar_active = False  # Pause LiDAR updates while controlling Spot's gripper

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

        self._lidar_active = True
