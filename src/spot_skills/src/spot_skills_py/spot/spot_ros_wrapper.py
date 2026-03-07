"""Define a class providing a ROS 1 interface to the Spot robot."""

import threading
from copy import deepcopy
from pathlib import Path

import numpy as np
import rospy
from actionlib import SimpleActionServer
from bosdyn.client.frame_helpers import BODY_FRAME_NAME
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryGoal,
    FollowJointTrajectoryResult,
    GripperCommandAction,
    GripperCommandGoal,
    GripperCommandResult,
)
from geometry_msgs.msg import PoseStamped, Twist
from nav_msgs.msg import OccupancyGrid as OccupancyGridMsg
from robotics_utils.geometry import Point3D
from robotics_utils.io import make_unique_path
from robotics_utils.io.yaml_utils import export_yaml_data
from robotics_utils.motion_planning import DiscreteGrid2D, MotionPlanningQuery
from robotics_utils.parallelism import ResourceManager
from robotics_utils.perception import LaserScan2D, OccupancyGrid2D
from robotics_utils.robots import GripperAngleLimits
from robotics_utils.ros import CallLoopThread, TagTracker, TransformManager, get_ros_param
from robotics_utils.ros.msg_conversion import (
    occupancy_grid_to_msg,
    point_from_vector3_msg,
    pointcloud_to_msg,
    pose_from_msg,
    pose_to_stamped_msg,
    poses_to_marker_msg,
)
from robotics_utils.ros.robots import MoveItManipulator, ROSAngularGripper
from robotics_utils.ros.trajectory_playback import RelativeTrajectoryConfig, TrajectoryPlayback
from robotics_utils.skills.protocols.spot_skills import SpotSkillsProtocol
from robotics_utils.spatial import DEFAULT_FRAME, Pose2D, Pose3D, Quaternion
from robotics_utils.states import GraspAttachment, ObjectCentricState, PlacementSurface
from robotics_utils.tamp.generators.place_poses import PlacePosesArgs, PlacePosesGenerator
from robotics_utils.vision.fiducials import FiducialMarker, FiducialSystem
from sensor_msgs.msg import PointCloud2
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse
from visualization_msgs.msg import Marker

from spot_skills.msg import RGBDPair
from spot_skills.msg import RGBImage as RGBImageMsg
from spot_skills.srv import (
    CaptureImageObservation,
    CaptureImageObservationRequest,
    CaptureImageObservationResponse,
    ComputeMotionPlan,
    ComputeMotionPlanRequest,
    ComputeMotionPlanResponse,
    GetRGBDPairs,
    GetRGBDPairsRequest,
    GetRGBDPairsResponse,
    GetRGBImages,
    GetRGBImagesRequest,
    GetRGBImagesResponse,
    NameService,
    NameServiceRequest,
    NameServiceResponse,
    NavigateToPose,
    NavigateToPoseRequest,
    NavigateToPoseResponse,
    OpenDoor,
    OpenDoorRequest,
    OpenDoorResponse,
    PlaceObject,
    PlaceObjectRequest,
    PlaceObjectResponse,
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
from spot_skills_py.spot.spot_conversion import (
    SPOT_GRIPPER_CLOSED_RAD,
    SPOT_GRIPPER_OPEN_RAD,
    pose_from_sdk,
)
from spot_skills_py.spot.spot_erase import (
    erase_board,
    # estimate_whiteboard_depth,  # COMMENTED OUT: using fixed board_y param instead
    generate_zigzag_erase_pattern,
    group_points_into_swaths,
)
from spot_skills_py.spot.spot_graph_nav import SpotGraphNav
from spot_skills_py.spot.spot_image_client import ImageFormat, SpotImageClient, SpotRGBCamera
from spot_skills_py.spot.spot_lidar import StampedPointCloud
from spot_skills_py.spot.spot_manager import SpotManager
from spot_skills_py.spot.spot_navigation import SpotNavigationServer
from spot_skills_py.spot.spot_open_door import SpotDoorOpener
from spot_skills_py.visualize_graphnav import GraphNavRViz


class SpotROS1Wrapper:
    """A ROS 1 interface for the Spot robot."""

    def __init__(self) -> None:
        """Initialize the ROS interface by creating an internal SpotManager."""
        TransformManager.init_node()

        # Initialize Spot's arm as locked before enabling any of the actions!
        self._arm_locked = True  # Begin without ROS control of Spot's arm
        self._manager_exists = False
        self._arm_controller_exists = False

        self._robot_rpc_manager = ResourceManager(grace_period_s=1.0)

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

        self._arm_controller = SpotArmController(self._manager)
        self._arm_controller_exists = True

        gemini_api_key = get_ros_param("~gemini_api_key", str, "NOT SPECIFIED")
        if gemini_api_key == "NOT SPECIFIED":
            gemini_api_key = None
        self._door_opener = SpotDoorOpener(self._manager, gemini_api_key)

        # Only take immediate control of Spot if requested via rosparam
        immediate_control = get_ros_param("/spot/immediate_control", bool, default_value=False)

        if immediate_control:
            self._manager.take_control(force=True)

        self._curr_grasp: GraspAttachment | None = None

        # Initialize all ROS services provided by the class
        self._grasp_srv = rospy.Service("spot/grasp_object", NameService, self.handle_grasp)
        self._release_srv = rospy.Service("spot/release_object", PlaceObject)

        self._place_srv = rospy.Service("spot/place_object", PlaceObject, self.handle_place_object)

        self._hide_object_srv = rospy.Service(
            "spot/moveit/hide_object",
            NameService,
            self.handle_hide_object,
        )
        self._unhide_object_srv = rospy.Service(
            "spot/moveit/unhide_object",
            NameService,
            self.handle_unhide_object,
        )

        self._reset_srv = rospy.Service("spot/reset_state", NameService, self.handle_reset_state)
        self._open_container_srv = rospy.Service(
            "spot/set_container_open",
            NameService,
            self.handle_set_container_open,
        )

        self._stand_service = rospy.Service("spot/stand", Trigger, self.handle_stand)
        self._sit_service = rospy.Service("spot/sit", Trigger, self.handle_sit)
        self._default_pose_srv = rospy.Service(
            "spot/default_body_pose",
            Trigger,
            self.handle_default_body_pose,
        )
        self._body_in_default_pose = False  # Conservatively assume non-default pose

        self._shutdown_service = rospy.Service("spot/shutdown", Trigger, self.handle_shutdown)

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
        self._rviz_pub = rospy.Publisher("visualization_marker", Marker, queue_size=1)

        self._open_drawer_srv = rospy.Service("spot/open_drawer", Trigger, self.handle_open_drawer)

        self._pose_lookup_srv = rospy.Service("pose_lookup", PoseLookup, self.handle_pose_lookup)
        self._dock_srv = rospy.Service("spot/dock", Trigger, self.handle_dock)
        self._undock_srv = rospy.Service("spot/undock", Trigger, self.handle_undock)
        self._start_map = rospy.Service("spot/start_mapping", Trigger, self.handle_start_mapping)
        self._stop_map = rospy.Service("spot/stop_mapping", Trigger, self.handle_stop_mapping)
        self._save_map = rospy.Service("spot/save_map", Trigger, self.handle_save_map)
        self._save_occ_grid = rospy.Service(
            "spot/export_occupancy_grid",
            NameService,
            self.handle_export_occupancy_grid,
        )

        self._nav_to_pose_srv = rospy.Service(
            "/spot/navigation/to_pose",
            NavigateToPose,
            self.handle_navigate_to_pose,
        )

        self._nav_to_waypoint_srv = rospy.Service(
            "/spot/navigation/to_waypoint",
            NameService,
            self.handle_waypoint,
        )

        self._pause_est_srv = rospy.Service(
            "spot/pose_estimation/pause",
            NameService,
            self.handle_pause_pose_estimation,
        )
        self._resume_est_srv = rospy.Service(
            "spot/pose_estimation/resume",
            NameService,
            self.handle_resume_pose_estimation,
        )
        self._pause_lidar_srv = rospy.Service(
            "spot/pause_lidar",
            Trigger,
            self.handle_pause_lidar,
        )
        self._resume_lidar_srv = rospy.Service(
            "spot/resume_lidar",
            Trigger,
            self.handle_resume_lidar,
        )
        self._lidar_paused = False

        self._planning_scene_lock = threading.Lock()
        self._compute_motion_plan_srv = rospy.Service(
            "spot/compute_motion_plan",
            ComputeMotionPlan,
            self.handle_compute_motion_plan,
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
        self._ee_pose_max_vel_mps = 0.4  # Max EE speed for /spot/ee_pose commands (m/s)
        self._ee_pose_min_duration_s = 0.5  # Minimum command duration regardless of distance (s)
        self._ee_velocity_cmd_duration_s = 0.5  # Duration per ee_cmd_vel command (s)
        self._ee_pose_sub = rospy.Subscriber(
            "/spot/ee_pose",
            PoseStamped,
            self.handle_ee_pose,
            queue_size=1,
        )
        self._ee_cmd_vel_sub = rospy.Subscriber(
            "/spot/ee_cmd_vel",
            Twist,
            self.handle_ee_cmd_vel,
            queue_size=1,
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
        self._capoture_image_obs_srv = rospy.Service(
            "spot/capture_image_observation",
            CaptureImageObservation,
            self.handle_capture_image_observation,
        )

        # Create occupancy grid before navigation server so it can be passed in
        # Check if the occupancy grid map should be loaded from file
        occ_grid_yaml = get_ros_param("/spot/navigation/occ_grid_yaml", str, default_value="")
        if occ_grid_yaml:
            self.occupancy_grid = OccupancyGrid2D.from_file(yaml_path=Path(occ_grid_yaml))

            # If we've loaded the occupancy grid from file, "lock in" its values by default
            self._lidar_paused = True
            rospy.loginfo(f"Loaded occupancy grid from file: {occ_grid_yaml} (and paused LiDAR)")

            occupancy_msg = occupancy_grid_to_msg(grid=self.occupancy_grid, z_height_m=-0.55)
            self._occ_pub.publish(occupancy_msg)
        else:
            grid_parameters = DiscreteGrid2D.from_bounds(
                resolution_m=0.05,
                x_min=-1,
                x_max=8,
                y_min=-8,
                y_max=1,
            )
            self.occupancy_grid = OccupancyGrid2D(grid=grid_parameters, min_obstacle_depth_m=0.05)

        self._graph_nav: SpotGraphNav | None = None
        self._navigation_server: SpotNavigationServer | None = None
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
                resource_manager=self._robot_rpc_manager,
            )

            self._graph_nav_rviz = GraphNavRViz(
                self._graph_nav.graph_nav_client,
                resource_manager=self._robot_rpc_manager,
            )

            self._navigation_server = SpotNavigationServer(
                self._manager,
                self._graph_nav,
                self._robot_rpc_manager,
                occupancy_grid=self.occupancy_grid,
            )

            rospy.loginfo("Now initializing the SpotNavigationServer...")

        self.tag_tracker: TagTracker | None = None

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

            self.tag_tracker = TagTracker(
                fiducial_system,
                spot_rgb_cameras,
                resource_manager=self._robot_rpc_manager,
            )

        # Load the initial environment state from YAML and update the MoveIt planning scene
        env_yaml_param = get_ros_param("/spot/env_yaml_path", str)
        rospy.loginfo(f"Loading object-centric state from file: {env_yaml_param}")
        self._env_state = ObjectCentricState.from_yaml(Path(env_yaml_param))

        # Begin synchronizing the environment state with TF in a loop
        self._state_thread = CallLoopThread(func=self._broadcast_frames, loop_hz=5.0)

        self.manipulator.planning_scene.set_state(self._env_state)
        self._planning_scene_thread = CallLoopThread(func=self._sync_planning_scene, loop_hz=5.0)

        self.stamped_cloud: StampedPointCloud | None = None
        self._last_occ_update_timestamp_s: float | None = None

        self._lidar_thread = CallLoopThread(
            func=self._update_lidar,
            loop_hz=5.0,
            name="Spot LiDAR",
            resource_manager=self._robot_rpc_manager,
        )
        self._occupancy_thread = CallLoopThread(
            func=self._update_occupancy,
            loop_hz=5.0,
            name="Occupancy Grid",
            resource_manager=self._robot_rpc_manager,
        )

        self.spot_skills = SpotSkillsProtocol(self.manipulator)

    def _broadcast_frames(self) -> None:
        """Broadcast the current known and estimated reference frames to /tf."""
        # First, synchronize the object-centric state with the current pose estimates
        estimated_poses = {}
        if self.tag_tracker is not None:
            estimated_poses = self.tag_tracker.all_estimated_poses
            self._env_state.update_estimated_poses(estimated_poses)

        # Now publish the pose of each object in the environment
        object_poses = self._env_state.object_poses
        for obj_name, obj_pose in object_poses.items():
            TransformManager.broadcast_transform(frame_name=obj_name, relative_pose=obj_pose)

        # Publish any additional fiducial-estimated frames
        published_frames = set(object_poses.keys())
        est_frame_names = set(estimated_poses.keys())
        unpublished_est_frame_names = est_frame_names.difference(published_frames)

        for frame_name in unpublished_est_frame_names:
            est_pose = estimated_poses[frame_name]
            TransformManager.broadcast_transform(frame_name=frame_name, relative_pose=est_pose)

        if self._navigation_server is not None:  # Publish navigation waypoints (convert 2D to 3D)
            for waypoint_name, pose_2d in self._navigation_server.waypoints.items():
                TransformManager.broadcast_transform(waypoint_name, relative_pose=pose_2d.to_3d())

    def _sync_planning_scene(self) -> None:
        """Synchronize the MoveIt planning scene with the stored environment state."""
        with self._planning_scene_lock:
            if not self.manipulator.planning_scene.set_state(self._env_state):
                rospy.logwarn("Failed to sync the MoveIt planning scene with the current state.")

    def _update_lidar(self) -> None:
        """Update the stored stamped pointcloud using new LiDAR data from Spot."""
        if self._lidar_paused:
            return

        try:
            self.stamped_cloud = self._manager.lidar_interface.get_stamped_pointcloud()
            if self.stamped_cloud is None:
                return

            cloud_msg = pointcloud_to_msg(self.stamped_cloud.cloud, self.stamped_cloud.cloud_frame)
            self._pcd_pub.publish(cloud_msg)

        except Exception as exc:
            self._manager.log_info(f"Exception during LiDAR update: {exc}")

    def _update_occupancy(self) -> None:
        """Update the occupancy grid with the current LiDAR data from Spot (if new)."""
        if (
            self._last_occ_update_timestamp_s is not None
            and self.stamped_cloud is not None
            and self.stamped_cloud.timestamp_s == self._last_occ_update_timestamp_s
        ):
            return

        try:
            if self.stamped_cloud is None:
                return

            # Convert the point cloud into a 2D laser scan in the map frame
            cloud_ref_frame = self.stamped_cloud.cloud_frame
            # rospy.loginfo(f"Original reference frame of stamped point cloud: '{cloud_ref_frame}'.")

            sensor_ref_frame = self.stamped_cloud.sensor_pose.ref_frame
            # rospy.loginfo(f"Original reference frame of LiDAR sensor pose: '{sensor_ref_frame}'.")

            map_t_cloud = TransformManager.lookup_transform(cloud_ref_frame, parent_frame="map")
            if map_t_cloud is None:
                rospy.logerr(f"Unable to look up transform from '{cloud_ref_frame}' to 'map'.")
                return

            cloud_wrt_map = self.stamped_cloud.cloud.transform(pose_t_c=map_t_cloud)

            map_t_sen_ref = TransformManager.lookup_transform(sensor_ref_frame, parent_frame="map")
            if map_t_sen_ref is None:
                rospy.logerr(f"Unable to look up transform from '{sensor_ref_frame}' to 'map'.")
                return
            pose_m_s = map_t_sen_ref @ self.stamped_cloud.sensor_pose

            sensor_pose_2d = pose_m_s.to_2d()
            sensor_x = sensor_pose_2d.x
            sensor_y = sensor_pose_2d.y
            sensor_yaw = sensor_pose_2d.yaw_rad

            x_coords = cloud_wrt_map.points[:, 0]
            y_coords = cloud_wrt_map.points[:, 1]

            # Vector from sensor to each point
            x_rel = x_coords - sensor_x
            y_rel = y_coords - sensor_y

            ranges_m = np.sqrt(x_rel * x_rel + y_rel * y_rel)

            # Compute angles in vision frame, then convert to bearings relative to sensor heading
            world_angles_rad = np.arctan2(y_rel, x_rel)
            angles_rad = world_angles_rad - sensor_yaw
            beam_data = np.stack([ranges_m, angles_rad], axis=1).astype(np.float32)  # (r, θ)

            hits_scan = LaserScan2D(
                sensor_pose=sensor_pose_2d,
                beam_data=beam_data,
                range_min_m=1,
                range_max_m=60,
            )
            clearing_scan = hits_scan.filter_per_angle_bin()

            self.occupancy_grid.update(scan=hits_scan, clearing_scan=clearing_scan)
            self._last_occ_update_timestamp_s = self.stamped_cloud.timestamp_s

            occupancy_msg = occupancy_grid_to_msg(grid=self.occupancy_grid, z_height_m=-0.55)
            self._occ_pub.publish(occupancy_msg)

        except Exception as exc:
            self._manager.log_info(f"Exception during occupancy grid update: {exc}")

    def handle_grasp(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to grasp the named object."""
        object_name = request.name

        if object_name not in self._env_state.object_names:
            return NameServiceResponse(
                success=False,
                message=f"Cannot grasp unknown object: '{object_name}'.",
            )

        outcome = self.manipulator.grasp(object_name=object_name)
        if outcome.output is None:
            return NameServiceResponse(
                success=False,
                message=f"Pose output from grasping '{object_name}' was None.",
            )
        self._curr_grasp = outcome.output

        # Update the object's pose as now dependent on Spot's end-effector
        pose_ee_o = outcome.output.pose_ee_o
        self._env_state.set_known_object_pose(obj_name=object_name, pose=pose_ee_o)

        return NameServiceResponse(success=outcome.success, message=outcome.message)

    def handle_place_object(self, request: PlaceObjectRequest) -> PlaceObjectResponse:
        """Handle a request to place an object onto a surface."""
        failure_message = None

        if request.object_name not in self._env_state.object_names:
            failure_message = f"Cannot place unknown object: '{request.object_name}'."
        elif request.surface_name not in self._env_state.object_names:
            failure_message = f"Cannot place onto unknown surface: '{request.surface_name}'."
        elif self._curr_grasp is None:
            failure_message = "Cannot place; must pick first."

        if failure_message:
            return PlaceObjectResponse(success=False, message=failure_message)

        placed_obj = self._env_state.get_object_kinematic_state(request.object_name)
        if placed_obj is None:
            return PlaceObjectResponse(
                success=False,
                message=f"Unable to retrieve kinematic state of '{request.object_name}'.",
            )

        surface_obj = self._env_state.get_object_kinematic_state(request.surface_name)
        if surface_obj is None:
            return PlaceObjectResponse(
                success=False,
                message=f"Unable to retrieve kinematic state of '{request.surface_name}'.",
            )

        surface = PlacementSurface.from_object_aabb(surface_obj)
        pose_ee_o = self._curr_grasp.pose_ee_o
        place_pose_args = PlacePosesArgs(surface, placed_obj, pose_ee_o, self.manipulator)
        generator = PlacePosesGenerator(place_pose_args)

        for place_poses in generator:
            rospy.loginfo(f"Attempting to motion plan for generator sample {generator.count}...")

            pre_query = MotionPlanningQuery(ee_target=place_poses.preplace_pose)
            place_query = MotionPlanningQuery(ee_target=place_poses.place_pose)
            post_query = MotionPlanningQuery(ee_target=place_poses.postplace_pose)

            with self._planning_scene_lock:
                pre_plan_msg = self.manipulator.planner.compute_motion_plan(pre_query)
            if pre_plan_msg is None:
                continue
            pre_place_success = self.manipulator.execute_trajectory_msg(pre_plan_msg)
            if not pre_place_success:
                message = "Failed to execute pre-place trajectory."
                return PlaceObjectResponse(success=False, message=message)

            with self._planning_scene_lock:
                plan_msg = self.manipulator.planner.compute_motion_plan(place_query)
            if plan_msg is None:
                continue
            place_success = self.manipulator.execute_trajectory_msg(plan_msg)
            if not place_success:
                message = "Failed to execute place trajectory."
                return PlaceObjectResponse(success=False, message=message)

            with self._planning_scene_lock:
                post_plan_msg = self.manipulator.planner.compute_motion_plan(post_query)
            if post_plan_msg is None:
                continue
            post_place_success = self.manipulator.execute_trajectory_msg(post_plan_msg)
            if not post_place_success:
                message = "Failed to execute post-place trajectory."
                return PlaceObjectResponse(success=False, message=message)

            return PlaceObjectResponse(success=True, message="Object has been placed.")

        return PlaceObjectResponse(success=False, message="Unexpectedly exited loop???")

    def handle_hide_object(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to hide an object in the MoveIt planning scene."""
        self._env_state.hide_object(obj_name=request.name)
        success = request.name in self._env_state.hidden_object_names
        message = (
            f"Successfully hid object '{request.name}'."
            if success
            else f"Unable to hide object '{request.name}'."
        )
        return NameServiceResponse(success=success, message=message)

    def handle_unhide_object(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to unhide an object in the MoveIt planning scene."""
        self._env_state.unhide_object(obj_name=request.name)
        success = request.name not in self._env_state.hidden_object_names
        message = (
            f"Successfully unhid object '{request.name}'."
            if success
            else f"Unable to unhide object '{request.name}'."
        )
        return NameServiceResponse(success=success, message=message)

    def handle_compute_motion_plan(
        self,
        request: ComputeMotionPlanRequest,
    ) -> ComputeMotionPlanResponse:
        """Handle a request to compute a motion plan for Spot's arm.

        This centralizes motion planning in SpotROS1Wrapper, which owns the planning scene.
        The lock prevents race conditions with the _sync_planning_scene thread.

        :param request: Request containing target pose, ignored objects, and collision settings
        :return: Response with success status, message, and computed trajectory
        """
        response = ComputeMotionPlanResponse()
        response.success = False

        with self._planning_scene_lock:
            for obj_name in request.ignored_objects:  # Hide ignored objects before planning
                self._env_state.hide_object(obj_name=obj_name)

            # Sync the planning scene with the updated state (objects now hidden)
            self.manipulator.planning_scene.set_state(self._env_state)

            target_pose = pose_from_msg(request.target_pose)
            query = MotionPlanningQuery(
                ee_target=target_pose,
                ignore_all_collisions=request.ignore_all_collisions,
            )
            rospy.loginfo(f"[compute_motion_plan] Planning with query: {query}")

            plan_msg = self.manipulator.planner.compute_motion_plan(query)

            for obj_name in request.ignored_objects:  # Unhide hidden objects after planning
                self._env_state.unhide_object(obj_name=obj_name)

            # Sync again to restore the planning scene
            self.manipulator.planning_scene.set_state(self._env_state)

        if plan_msg is None:
            response.message = "Motion planning failed: no valid plan found."
            return response

        response.success = True
        response.message = "Motion plan computed successfully."
        response.trajectory = plan_msg.joint_trajectory
        return response

    def handle_set_container_open(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request that the named container's state be set as open."""
        self._env_state.open_container(container_name=request.name)
        return NameServiceResponse(success=True, message=f"Successfully opened '{request.name}'.")

    def handle_reset_state(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to reset the environment state based on a YAML file.

        :param request: Service request containing a path to a YAML file
        :return: Response conveying whether the reset succeeded and why
        """
        yaml_path = Path(request.name)

        rospy.loginfo(f"Handling request to reset state per YAML file: {yaml_path}")

        if not self.manipulator.planning_scene.detach_all_objects():
            return NameServiceResponse(
                success=False,
                message="Unable to detach all objects in the MoveIt planning scene.",
            )

        self._env_state = ObjectCentricState.from_yaml(yaml_path)

        message = f"Successfully reset the environment state based on {yaml_path}."
        return NameServiceResponse(success=True, message=message)

    def handle_stand(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param _: Message representing a request for Spot to stand (unused)
        :return: Response conveying whether Spot has successfully stood up
        """
        stood_up = False
        if self._manager.ensure_control(take_by_force=False):
            self._body_in_default_pose = False
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
            self._body_in_default_pose = False
            sit_success = self._manager.sit_down(20)

        message = "Spot is now sitting." if sit_success else "Spot could not sit."

        return TriggerResponse(sit_success, message)

    def handle_default_body_pose(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to bring Spot's body to its default pose.

        :param _: ROS message requesting that Spot's body move to its default pose
        :return: Response conveying whether Spot successfully moved to the pose
        """
        if self._body_in_default_pose:
            return TriggerResponse(success=True, message="Body was already in the default pose.")

        robot_command = self._manager.build_hold_body_pose_command()
        command_id = self._manager.send_robot_command(robot_command)
        if command_id is None:
            return TriggerResponse(success=False, message="Robot command ID was None.")

        success = self._manager.block_until_standing(command_id)
        if success:
            self._body_in_default_pose = True
            rospy.sleep(3)  # Wait 3 seconds to allow transforms to account for Spot's base pose

        message = "Reached default body pose." if success else "Failed to reach default body pose."
        return TriggerResponse(success=success, message=message)

    def handle_dock(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to dock Spot at its default dock.

        :param _: ROS message requesting that Spot be docked (unused)
        :return: Response conveying whether Spot successfully docked
        """
        self._body_in_default_pose = False

        dock_id = get_ros_param("spot/dock_id", int, default_value=520)
        success = self._manager.dock(dock_id)
        message = "Spot successfully docked." if success else "Spot failed to dock."
        return TriggerResponse(success, message)

    def handle_undock(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to undock Spot.

        :param _: ROS message requesting that Spot be undocked
        :return: Response conveying whether Spot successfully undocked
        """
        self._body_in_default_pose = False

        outcome = self._manager.undock()
        return TriggerResponse(outcome.success, outcome.message)

    def handle_navigate_to_pose(self, request: NavigateToPoseRequest) -> NavigateToPoseResponse:
        """Handle a ROS service request for Spot to navigate to a given pose.

        :param request: Request specifying a pose to navigate to
        :return: Response specifying whether the navigation succeeded
        """
        if self._navigation_server is None:
            return NavigateToPoseResponse(
                success=False,
                message="Unable to navigate to pose because SpotNavigationServer is None.",
            )

        self._manager.log_info("Handling 'NavigateToPose' request...")

        # Assume that navigating may leave Spot's body with non-default control settings
        self._body_in_default_pose = False

        target_2d = pose_from_msg(request.target_base_pose).to_2d()
        timeout_s = request.timeout_s

        outcome = self._navigation_server.navigate_to_pose(target_2d, timeout_s)
        return NavigateToPoseResponse(outcome.success, outcome.message)

    def handle_waypoint(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a ROS service request for Spot to navigate to a named waypoint.

        :param request: Request specifying a waypoint to navigate to
        :return: Response specifying whether the navigation succeeded
        """
        if self._navigation_server is None:
            return NameServiceResponse(
                success=False,
                message=f"Cannot navigate to '{request.name}'; SpotNavigationServer is None.",
            )

        if request.name not in self._navigation_server.waypoints:
            available_waypoints = list(self._navigation_server.waypoints.keys())
            message = (
                f"Cannot navigate to unknown waypoint '{request.name}'.\n "
                f"Available waypoints: {available_waypoints}"
            )
            return NameServiceResponse(success=False, message=message)

        self._manager.log_info(
            f"Handling 'NavigateToWaypoint' request for waypoint '{request.name}'...",
        )

        # Assume that navigating may leave Spot's body with non-default control settings
        self._body_in_default_pose = False

        target_pose = self._navigation_server.waypoints[request.name]
        self._manager.log_info(f"Waypoint '{request.name}' has target pose: {target_pose}.")

        # # DEBUG: Log detailed waypoint information
        # rospy.loginfo(f"[WAYPOINT DEBUG] Waypoint '{request.name}' stored: {target_pose}")

        # # DEBUG: Look up waypoint in map and seed frames for comparison
        # waypoint_in_map = TransformManager.lookup_transform(request.name, DEFAULT_FRAME)
        # if waypoint_in_map is not None:
        #     rospy.loginfo(f"[WAYPOINT DEBUG] Waypoint in map (via TF): {waypoint_in_map.to_2d()}")

        # waypoint_in_seed = TransformManager.lookup_transform(request.name, "seed")
        # if waypoint_in_seed is not None:
        #     rospy.loginfo(f"[WAYPOINT DEBUG] Waypoint in seed (via TF): {waypoint_in_seed.to_2d()}")

        # # DEBUG: Log parent frame transform
        # parent_frame = target_pose.ref_frame
        # parent_in_seed = TransformManager.lookup_transform(parent_frame, "seed")
        # if parent_in_seed is not None:
        #     parent_2d = parent_in_seed.to_2d()
        #     rospy.loginfo(f"[WAYPOINT DEBUG] Parent '{parent_frame}' in seed: {parent_2d}")

        outcome = self._navigation_server.navigate_to_pose(target_pose)
        return NameServiceResponse(outcome.success, outcome.message)

    def handle_shutdown(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to shut down the Spot wrapper and manager.

        :param _: ROS message requesting that Spot be shut down (unused)
        :return: Response conveying that shutdown was initiated
        """
        self._manager.shutdown()
        rospy.signal_shutdown("Shutting down Spot ROS wrapper...")

        return TriggerResponse(success=True, message="Spot has been shut down.")

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
            self._body_in_default_pose = False  # Assume that Spot's body may adjust for the arm
            deployed = self._manager.deploy_arm()

        return TriggerResponse(
            success=deployed,
            message=(
                "Spot's arm has been deployed." if deployed else "Could not deploy Spot's arm."
            ),
        )

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

        ok, msg = self._graph_nav.start_mapping()
        return TriggerResponse(ok, msg)

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

        outcome = self._graph_nav.stop_mapping()
        return TriggerResponse(outcome.success, outcome.message)

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
        save_outcome = self._graph_nav.save_map(self._graph_nav.map_path)
        return TriggerResponse(save_outcome.success, save_outcome.message)

    def handle_export_occupancy_grid(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to export the occupancy grid to the specified filepath.

        Exports the occupancy grid as:
        - A 16-bit grayscale PNG image containing the log-odds occupancy values
        - A YAML file containing the grid metadata and image normalization parameters

        :param request: Request containing the base filepath (without extension)
        :return: Response indicating success if both files were created
        """
        base_path = Path(request.name)
        image_path = base_path.with_suffix(".png")
        yaml_path = base_path.with_suffix(".yaml")

        base_path.parent.mkdir(parents=True, exist_ok=True)

        schema = self.occupancy_grid.to_schema(image_path=image_path)
        schema_dict = schema.model_dump(mode="json")
        export_yaml_data(data=schema_dict, filepath=yaml_path)

        # Determine success based on whether both files exist
        image_exists = image_path.exists()
        yaml_exists = yaml_path.exists()
        success = image_exists and yaml_exists

        if success:
            message = f"Exported occupancy grid to {yaml_path} and {image_path}"
        else:
            missing = []
            if not image_exists:
                missing.append(str(image_path))
            if not yaml_exists:
                missing.append(str(yaml_path))
            message = f"Failed to create files: {', '.join(missing)}"

        return NameServiceResponse(success=success, message=message)

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
        if len(request_protos) != len(response_protos):
            rospy.logwarn(
                "GetRGBDPairs service call failed; number of requests != number of responses.",
            )
            return GetRGBDPairsResponse()

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

            d_s = abs(rgb_time_s - depth_time_s)
            if d_s > 0.1:
                rospy.logwarn(
                    f"GetRGBDPairs: Synchronized RGB and depth images differed by {d_s} seconds!",
                )
                return GetRGBDPairsResponse()

            rgb_camera_info = SpotImageClient.extract_camera_info_msg(rgb_response, rgb_ros_time)
            d_camera_info = SpotImageClient.extract_camera_info_msg(depth_response, depth_ros_time)

            # Expect that the camera information is identical, except the header
            d_camera_info_copy = deepcopy(d_camera_info)
            d_camera_info_copy.header = rgb_camera_info.header
            if rgb_camera_info != d_camera_info_copy:
                rospy.logwarn("GetRGBDPairs: Expected identical camera information!")
                return GetRGBDPairsResponse()

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

        if len(request_msg.camera_names) != len(response_protos):
            rospy.logwarn("GetRGBImages: Number of responses != number of requests.")
            return response_msg

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

    def handle_capture_image_observation(
        self,
        request: CaptureImageObservationRequest,
    ) -> CaptureImageObservationResponse:
        """Handle a service request to capture an image and camera pose, then save them to file.

        Captures an ImageObservation (image + camera pose) and exports both:
            - The RGB image to the requested filepath
            - The observation schema (image path + pose) to a YAML file alongside the image

        :param request: ROS message specifying which camera to use and where to save the image
        :return: Response conveying whether the capture succeeded, with path to the YAML schema
        """
        response = CaptureImageObservationResponse(success=False, message="")

        camera_name = request.camera
        ref_frame = request.ref_frame
        image_path = Path(request.image_path)

        # Get a unique filepath if the requested one already exists
        image_path = make_unique_path(image_path)
        if image_path.exists():
            response.message = f"Supposedly unused filepath already exists: {image_path}"
            return response

        try:
            observation = self._manager.image_client.get_image_observation(camera_name, ref_frame)
        except RuntimeError as e:
            response.message = f"Failed to capture image observation from '{camera_name}': {e}"
            return response

        try:
            observation.image.to_file(image_path)
        except (RuntimeError, OSError) as e:
            response.message = f"Failed to save image to '{image_path}': {e}"
            return response

        if not image_path.exists():
            response.message = f"Failed to create image file '{image_path}'."
            return response

        # Export the observation schema (image path + pose) to a YAML file
        yaml_path = image_path.with_suffix(".yaml")
        try:
            schema = observation.to_schema()
            schema_data = schema.model_dump(mode="json")
            export_yaml_data(data=schema_data, filepath=yaml_path)
        except (ValueError, FileNotFoundError) as e:
            response.message = f"Image saved to '{image_path}' but failed to export schema: {e}"
            return response

        response.success = True
        response.message = str(yaml_path)
        return response

    def handle_open_drawer(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a request to have Spot open a draw using trajectory playback."""
        outcome = self.spot_skills.open_drawer()
        return TriggerResponse(success=outcome.success, message=outcome.message)

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

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                return OpenDoorResponse(
                    success=False,
                    message="Could not obtain RPC priority; background threads still active.",
                )

            # Assume that opening a door may leave Spot's body in a non-default pose
            self._body_in_default_pose = False

            # Call the operations needed for door-opening, step-by-step
            self.manipulator.gripper.open()
            door_image = self._door_opener.capture_door_handle_image(request.body_pitch_rad)

            if self._door_opener.detect_handle_xy(door_image) is None:
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

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                return PlaybackTrajectoryResponse(
                    success=False,
                    message="Unable to acquire RPC priority for trajectory playback.",
                )

            relative_poses = self.trajectory_replayer.load_relative_trajectory(yaml_path)
            rospy.loginfo(f"Loaded {len(relative_poses)} poses from YAML file: {yaml_path}.")
            success = self.trajectory_replayer.execute_hybrid_cartesian_sequence(relative_poses)
            message = (
                f"Successfully executed trajectory loaded from file: {yaml_path}"
                if success
                else f"Unable to execute trajectory loaded from file: {yaml_path}"
            )

            return PlaybackTrajectoryResponse(success, message)

    def handle_erase_board(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to erase a whiteboard.

        All coordinates are in map/odom frame to make the erase trajectory
        deterministic regardless of Spot's exact pose after navigation.

        Assumes:
        - Spot navigates to the erase waypoint facing map +y (yaw ≈ π/2)
        - Board surface is at a fixed map y coordinate (configured via ROS param)
        - Erase region is defined in map x (left/right) and map z (up/down)

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

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                return TriggerResponse(success=False, message="Could not obtain RPC priority.")

            # Assume that erasing may tilt Spot's body when compensating for force control
            self._body_in_default_pose = False

            # Update the LiDAR displayed in RViz to clarify what's going on
            lidar_was_paused = self._lidar_paused
            self._lidar_paused = False
            self._update_lidar()
            self._lidar_paused = lidar_was_paused

            # # COMMENTED OUT: LiDAR-based depth estimation (replaced with fixed board_y param)
            # # Estimate the whiteboard depth using RANSAC plane fitting on LiDAR data
            # whiteboard_estimate = estimate_whiteboard_depth(self._manager.lidar_interface)
            # if whiteboard_estimate is None:
            #     return TriggerResponse(
            #         success=False,
            #         message="Failed to estimate whiteboard depth from LiDAR.",
            #     )
            # estimated_depth_m = whiteboard_estimate.depth_m
            # rospy.loginfo(f"Estimated whiteboard depth: {estimated_depth_m:.3f} m.")
            # erase_at_depth_m = estimated_depth_m + 0.05

            # === ERASE PARAMETERS (ABSOLUTE map-frame coordinates) ===
            # Get map→odom transform to convert fixed map coords to odom for execution
            map_to_odom = TransformManager.lookup_transform("map", "odom")
            if map_to_odom is None:
                return TriggerResponse(
                    success=False,
                    message="Could not look up map->odom transform.",
                )

            # Extract the 2D offset: odom = map + offset
            odom_offset_x = map_to_odom.position.x
            odom_offset_y = map_to_odom.position.y

            rospy.loginfo(
                f"Map->odom offset: x={odom_offset_x:.3f}, y={odom_offset_y:.3f}",
            )

            # Board surface y-coordinate in MAP frame (absolute, tune this manually)
            board_y_map = get_ros_param("spot/erase_board_y", float, -3.4)

            # Erase region in MAP frame (absolute coordinates)
            erase_x_min_map = get_ros_param("spot/erase_x_min", float, 6.3)
            erase_x_max_map = get_ros_param("spot/erase_x_max", float, 6.8)
            z_min = get_ros_param("spot/erase_z_min", float, 0.5)
            z_max = get_ros_param("spot/erase_z_max", float, 0.75)
            x_spacing_m = get_ros_param("spot/erase_x_spacing", float, 0.1)
            reachable_half_width_m = get_ros_param("spot/erase_reachable_half_width", float, 0.1)

            # Convert map coords to odom coords for execution
            board_y_odom = board_y_map + odom_offset_y
            erase_x_min_odom = erase_x_min_map + odom_offset_x
            erase_x_max_odom = erase_x_max_map + odom_offset_x

            rospy.loginfo(
                f"Erase region (map): x=[{erase_x_min_map}, {erase_x_max_map}], "
                f"y={board_y_map}, z=[{z_min}, {z_max}]",
            )
            rospy.loginfo(
                f"Erase region (odom): x=[{erase_x_min_odom:.3f}, {erase_x_max_odom:.3f}], "
                f"y={board_y_odom:.3f}",
            )

            # Generate zig-zag erase pattern (x, z) in ODOM frame
            erase_xz_points = generate_zigzag_erase_pattern(
                x_min=erase_x_min_odom,
                x_max=erase_x_max_odom,
                z_min=z_min,
                z_max=z_max,
                x_spacing_m=x_spacing_m,
            )

            # Group points into swaths based on arm reachability
            swaths = group_points_into_swaths(erase_xz_points, reachable_half_width_m)
            rospy.loginfo(f"Erase pattern divided into {len(swaths)} swaths.")

            # Erase parameters (force and timing)
            force_n = get_ros_param("spot/erase_force_n", float, 10.0)
            segment_time_s = get_ros_param("spot/erase_segment_time_s", float, 3.0)

            # Gripper orientation: pointing in odom +y direction (toward board)
            # This is yaw = π/2 in odom frame
            gripper_quat = Quaternion(
                x=0.0,
                y=0.0,
                z=np.sqrt(2) / 2,  # sin(π/4)
                w=np.sqrt(2) / 2,  # cos(π/4)
            )

            # Get initial robot pose for yaw reference and return-to-start
            initial_pose_3d = TransformManager.lookup_transform("body", "odom")
            initial_pose_odom = initial_pose_3d.to_2d() if initial_pose_3d else None
            robot_yaw = initial_pose_odom.yaw_rad if initial_pose_odom else np.pi / 2

            for swath_idx, (target_robot_x_odom, swath_xz_points) in enumerate(swaths):
                rospy.loginfo(
                    f"Swath {swath_idx + 1}/{len(swaths)}: "
                    f"{len(swath_xz_points)} points, target_x_odom={target_robot_x_odom:.3f} m.",
                )

                # Sidestep: move robot to target_robot_x in odom frame
                current_pose_3d = TransformManager.lookup_transform("body", "odom")
                if current_pose_3d is None:
                    rospy.logwarn("Could not look up body->odom transform for sidestep.")
                    continue

                current_pose = current_pose_3d.to_2d()
                sidestep_distance = target_robot_x_odom - current_pose.x

                if abs(sidestep_distance) > 0.01:  # Only sidestep if needed (> 1cm)
                    rospy.loginfo(
                        f"Sidestepping: {current_pose.x:.3f} -> {target_robot_x_odom:.3f} m (odom)",
                    )

                    # Target pose: new x, same y and yaw
                    target_pose = Pose2D(
                        target_robot_x_odom,
                        current_pose.y,
                        robot_yaw,
                        ref_frame="odom",
                    )

                    # Use trajectory command (more robust with network latency)
                    sidestep_duration_s = abs(sidestep_distance) / 0.15 + 1.0  # ~0.15 m/s
                    self._manager.send_trajectory_command(
                        target_pose,
                        sidestep_duration_s,
                        max_speed_mps=0.2,
                    )
                    rospy.sleep(sidestep_duration_s + 0.5)  # Wait for motion to complete

                # Create erase poses in odom frame
                swath_poses_odom = [
                    Pose3D(Point3D(x=odom_x, y=board_y_odom, z=z), gripper_quat, "odom")
                    for odom_x, z in swath_xz_points
                ]

                # Visualize this swath in RViz
                marker_msg = poses_to_marker_msg(swath_poses_odom)
                self._rviz_pub.publish(marker_msg)

                # Erase this swath
                if len(swath_poses_odom) >= 2:
                    erase_board(
                        self._manager,
                        swath_poses_odom,
                        force_n=force_n,
                        segment_time_s=segment_time_s,
                    )

            # Return to starting position
            if initial_pose_odom is not None:
                current_pose_3d = TransformManager.lookup_transform("body", "odom")
                if current_pose_3d:
                    current_x = current_pose_3d.to_2d().x
                    if abs(current_x - initial_pose_odom.x) > 0.01:
                        rospy.loginfo(
                            f"Returning to start x: {current_x:.3f} -> {initial_pose_odom.x:.3f}",
                        )
                        return_duration_s = abs(current_x - initial_pose_odom.x) / 0.15 + 1.0
                        self._manager.send_trajectory_command(
                            initial_pose_odom,
                            return_duration_s,
                            max_speed_mps=0.2,
                        )
                        rospy.sleep(return_duration_s + 0.5)

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

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                return ProbeSurfaceResponse(
                    success=False,
                    message="Could not obtain RPC priority before probing.",
                )

            # Assume that force-controlled probing may tilt Spot's body to compensate forces
            self._body_in_default_pose = False

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

            return ProbeSurfaceResponse(success, message)

    def handle_take_control(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to forcibly take control of Spot.

        :param _: Message representing a request to take control of Spot
        :return: Response conveying whether control was successfully taken
        """
        # Conservatively assume that Spot's body was left in an arbitrary non-default pose
        self._body_in_default_pose = False

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
                message=str(relative_pose.to_schema().model_dump(mode="json")),
                relative_pose=pose_to_stamped_msg(relative_pose),
            )

        response = PoseLookupResponse()  # Otherwise, respond with failure
        response.success = False
        response.message = "Relative pose was None."
        return response

    def handle_pause_lidar(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a request to pause collecting LiDAR data to update the occupancy grid."""
        self._lidar_paused = True
        return TriggerResponse(success=True, message="Paused LiDAR updates.")

    def handle_resume_lidar(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a request to resume collecting LiDAR data to update the occupancy grid."""
        self._lidar_paused = False
        return TriggerResponse(success=True, message="Resumed LiDAR updates.")

    def handle_pause_pose_estimation(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to pause pose estimation for a specified object."""
        object_name = request.name

        if object_name not in self._env_state.object_names:
            return NameServiceResponse(
                success=False,
                message=f"Cannot pause pose estimation for unknown object '{object_name}'.",
            )

        if self.tag_tracker is None:
            return NameServiceResponse(
                success=False,
                message=f"Tag tracker is None; cannot pause pose estimation for '{object_name}'.",
            )

        final_estimated_pose = self.tag_tracker.get_estimated_pose(object_name)
        if final_estimated_pose is None:
            return NameServiceResponse(
                success=False,
                message=(
                    f"Unable to pause pose estimation for '{object_name}' "
                    "because no pose estimate is currently available."
                ),
            )

        # Set the object's final pose estimate as its *known* pose to prevent overwriting
        self._env_state.set_known_object_pose(object_name, final_estimated_pose)

        return NameServiceResponse(
            success=True,
            message=f"Successfully paused pose estimation for '{object_name}'.",
        )

    def handle_resume_pose_estimation(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a request to resume pose estimation for a specified object."""
        object_name = request.name

        if object_name not in self._env_state.object_names:
            return NameServiceResponse(
                success=False,
                message=f"Cannot resume pose estimation for unknown object '{object_name}'.",
            )

        if self.tag_tracker is None:
            return NameServiceResponse(
                success=False,
                message=f"Tag tracker is None; cannot resume pose estimation for '{object_name}'.",
            )

        # Record the parent fiducial marker of the object's pose estimate
        parent_marker_id = self.tag_tracker.frame_to_parent.get(object_name)
        if parent_marker_id is None:  # No parent marker --> Unclear how to pose estimate
            return NameServiceResponse(
                success=False,
                message=f"Object '{object_name}' does not have a parent fiducial marker.",
            )
        parent_frame = FiducialMarker.id_to_frame_name(parent_marker_id)

        # Derive the transform from the world frame to the parent marker, based on the object
        object_t_parent = TransformManager.lookup_transform(parent_frame, object_name)
        world_t_object = TransformManager.lookup_transform(object_name, DEFAULT_FRAME)
        world_t_parent = None
        if object_t_parent is not None and world_t_object is not None:
            world_t_parent = world_t_object @ object_t_parent

        # Clear the environment state for the object and pose averager for its parent marker
        self._env_state.clear_object_pose(obj_name=object_name)
        self.tag_tracker.pose_averager.reset_frame(frame_name=parent_frame)

        # If available, initialize the object's parent marker's pose estimate
        if world_t_parent is not None:
            self.tag_tracker.pose_averager.update(parent_frame, pose=world_t_parent)

        return NameServiceResponse(
            success=True,
            message=f"Successfully resumed pose estimation for '{object_name}'.",
        )

    def handle_ee_pose(self, msg: PoseStamped) -> None:
        """Handle an end-effector pose command from /spot/ee_pose."""
        if self._arm_locked:
            return

        if not self._manager.ensure_control(take_by_force=False):
            rospy.logwarn("Ignoring /spot/ee_pose because Spot control is unavailable.")
            return

        if not msg.header.frame_id:
            rospy.logwarn("Ignoring /spot/ee_pose because PoseStamped.header.frame_id is empty.")
            return

        target_pose = pose_from_msg(msg)
        try:
            target_pose_b_ee = TransformManager.convert_to_frame(
                target_pose,
                self.manipulator.base_frame,
            )
        except RuntimeError as err:
            rospy.logwarn(
                "Ignoring /spot/ee_pose; failed frame conversion into "
                f"'{self.manipulator.base_frame}': {err}",
            )
            return

        try:
            current_sdk_pose = self._manager.get_hand_pose(ref_frame=BODY_FRAME_NAME)
            current_pose_b_ee = pose_from_sdk(current_sdk_pose, ref_frame=BODY_FRAME_NAME)
            diff = target_pose_b_ee.position.to_array() - current_pose_b_ee.position.to_array()
            distance_m = float(np.linalg.norm(diff))
            duration_s = max(distance_m / self._ee_pose_max_vel_mps, self._ee_pose_min_duration_s)
        except Exception as err:
            rospy.logwarn(f"Skipping /spot/ee_pose; failed to read hand pose: {err}")
            return

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                rospy.logwarn("Skipping /spot/ee_pose command because RPC priority is unavailable.")
                return

            success = self._arm_controller.command_end_effector_pose(
                target_pose_b_ee=target_pose_b_ee,
                duration_s=duration_s,
            )

        if not success:
            rospy.logwarn("Failed to command /spot/ee_pose target pose.")

    def handle_ee_cmd_vel(self, msg: Twist) -> None:
        """Handle a body-frame end-effector velocity command from /spot/ee_cmd_vel."""
        if self._arm_locked:
            return

        if not self._manager.ensure_control(take_by_force=False):
            rospy.logwarn("Ignoring /spot/ee_cmd_vel because SpotManager doesn't control Spot.")
            return

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                rospy.logwarn(
                    "Skipping /spot/ee_cmd_vel command because RPC priority is unavailable.",
                )
                return

            success = self._arm_controller.command_end_effector_body_velocity(
                linear_x_mps=msg.linear.x,
                linear_y_mps=msg.linear.y,
                linear_z_mps=msg.linear.z,
                angular_x_radps=msg.angular.x,
                angular_y_radps=msg.angular.y,
                angular_z_radps=msg.angular.z,
                duration_s=self._ee_velocity_cmd_duration_s,
            )

        if not success:
            rospy.logwarn("Failed to command /spot/ee_cmd_vel twist.")

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

        with self._robot_rpc_manager.priority() as got_priority:
            if not got_priority:
                result.error_string = "Could not obtain RPC priority; other threads still active."
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
                result.error_string = "Could not follow trajectory because Spot's arm is locked."
                self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")

                self._arm_action_server.set_aborted(result)

            elif outcome == ArmCommandOutcome.PREEMPTED:
                self._arm_action_server.set_preempted()
