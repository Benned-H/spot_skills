"""Define a class providing a ROS 1 interface to the Spot robot."""

from copy import deepcopy
from pathlib import Path

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
from robotics_utils.ros.trajectory_replayer import RelativeTrajectoryConfig, TrajectoryReplayer
from ros_numpy import msgify
from sensor_msgs.msg import Image as ImageMsg
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse

from spot_skills.msg import RGBDPair
from spot_skills.srv import (
    GetRGBDPairs,
    GetRGBDPairsRequest,
    GetRGBDPairsResponse,
    PlaybackTrajectory,
    PlaybackTrajectoryRequest,
    PlaybackTrajectoryResponse,
)
from spot_skills_py.joint_trajectory import JointTrajectory
from spot_skills_py.perception.object_detection_client import DetectObjectClient
from spot_skills_py.spot.spot_arm_controller import (
    ArmCommandOutcome,
    GripperCommandOutcome,
    SpotArmController,
)
from spot_skills_py.spot.spot_image_client import ImageFormat, SpotImageClient
from spot_skills_py.spot.spot_manager import SpotManager
from spot_skills_py.spot.spot_navigation import SpotNavigationServer
from spot_skills_py.spot.spot_open_door import SpotDoorOpener


class SpotROS1Wrapper:
    """A ROS 1 interface for the Spot robot."""

    def __init__(self) -> None:
        """Initialize the ROS interface by creating an internal SpotManager."""
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
        spot_rosparam_values: list[str] = [rospy.get_param(par) for par in spot_rosparams]
        spot_hostname, spot_username, spot_password = spot_rosparam_values

        self._manager = SpotManager(
            client_name="SpotROS1Manager",
            hostname=spot_hostname,
            username=spot_username,
            password=spot_password,
        )

        max_segment_len = 30  # Limit the points/segment in ArmController trajectories
        self._arm_controller = SpotArmController(self._manager, max_segment_len)
        self._arm_locked = True  # Begin without ROS control of Spot's arm

        self._door_opener = SpotDoorOpener(self._manager)

        # Only take immediate control of Spot if requested via rosparam
        immediate_control: bool = rospy.get_param("/spot/immediate_control", default=False)

        if immediate_control:
            self._manager.take_control(force=True)

        # Initialize all ROS services provided by the class
        self._stand_service = rospy.Service("spot/stand", Trigger, self.handle_stand)
        self._sit_service = rospy.Service("spot/sit", Trigger, self.handle_sit)
        self._shutdown_service = rospy.Service("spot/shutdown", Trigger, self.handle_shutdown)
        self._unlock_arm_service = rospy.Service("spot/unlock_arm", Trigger, self.handle_unlock_arm)
        self._stow_arm_service = rospy.Service("spot/stow_arm", Trigger, self.handle_stow_arm)
        self._open_door_service = rospy.Service("spot/open_door", Trigger, self.handle_open_door)
        self._playback_trajectory_service = rospy.Service(
            "spot/playback_trajectory",
            PlaybackTrajectory,
            self.handle_playback_trajectory,
        )

        traj_config = RelativeTrajectoryConfig(
            ee_frame="arm_link_wr1",
            body_frame="body",
            move_group_name="arm",
        )
        self.trajectory_replayer = TrajectoryReplayer(traj_config)

        self._get_rgbd_pairs_service = rospy.Service(
            "spot/get_rgbd_pairs",
            GetRGBDPairs,
            self.handle_get_rgbd_pairs,
        )

        # If needed, create a client to request object detections
        object_detection_active = rospy.get_param("/spot/object_detection/active", default=False)
        if object_detection_active:
            self.detect_object_client = DetectObjectClient(["door handle"])
        else:
            rospy.loginfo("Skipping initialization of DetectObjectClient...")

        navigation_active = rospy.get_param("/spot/navigation/active", default=False)
        if navigation_active:
            rospy.loginfo("Now initializing the SpotNavigationServer...")
            self._navigation_server = SpotNavigationServer(manager=self._manager)
        else:
            rospy.loginfo("Skipping initialization of SpotNavigationServer...")

    def handle_stand(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param _: Message representing a request for Spot to stand (unused)
        :return: Response conveying whether Spot has successfully stood up
        """
        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        stood_up = self._manager.stand_up(20) if has_control else False
        message = "Spot is now standing." if stood_up else "Could not make Spot stand."

        return TriggerResponse(stood_up, message)

    def handle_sit(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to make Spot sit.

        :param _: ROS message representing a request that Spot sits (unused)
        :return: Response conveying whether Spot has successfully sat down
        """
        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        sit_success = self._manager.sit_down(20) if has_control else False
        message = "Spot is now sitting." if sit_success else "Spot could not sit."

        return TriggerResponse(sit_success, message)

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
        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        if has_control:
            self._arm_locked = False
            self._arm_controller.unlock_arm()
            message = "Spot's arm is now unlocked."
        else:
            message = "Could not gain control of Spot; leaving Spot's arm locked."

        return TriggerResponse(has_control, message)

    def handle_stow_arm(self, request_msg: TriggerRequest) -> TriggerResponse:
        """Handle a service request to stow Spot's arm.

        TODO: If Spot is believed to be holding something, prevent stowing.

        :param request_msg: Message representing a request to stow Spot's arm
        :return: Response conveying whether Spot's arm has been stowed
        """
        del request_msg

        if self._arm_locked:
            message = "Spot's arm was not stowed because Spot's arm remains locked."
            return TriggerResponse(success=False, message=message)

        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        arm_stowed = self._manager.stow_arm() if has_control else False
        message = "Spot's arm has been stowed." if arm_stowed else "Could not stow Spot's arm."

        return TriggerResponse(arm_stowed, message)

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

    def handle_open_door(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to open a door in front of Spot.

        :param _: ROS message representing a request to open a door (unused)
        :return: Response conveying whether Spot was able to open the door
        """
        if self._arm_locked:
            message = "Could not open door because Spot's arm remains locked."
            return TriggerResponse(success=False, message=message)

        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        if not has_control:
            message = "Could not open door because SpotManager could not take control of Spot."
            return TriggerResponse(success=False, message=message)

        # Call the operations needed for door-opening, step-by-step
        side_by_side_image = self._door_opener.capture_side_by_side_image()
        side_by_side_msg = msgify(ImageMsg, side_by_side_image, encoding="rgb8")

        response_msg = self.detect_object_client.call_on_image(side_by_side_msg)
        if response_msg is None:
            message = "Cannot open door because object detection returned None."
            return TriggerResponse(success=False, message=message)
        rospy.loginfo("Received response for the door handle photo.")

        pixel_point_msg = response_msg.pixels[0]
        handle_xy = (pixel_point_msg.x, pixel_point_msg.y)
        self._door_opener.set_handle_xy(handle_xy)
        rospy.loginfo("Successfully saved door handle pixel in SpotDoorOpener.")

        door_opened = self._door_opener.open_door(open_door_timeout_s=120)

        message = "Spot opened the door." if door_opened else "Could not open the door."

        return TriggerResponse(door_opened, message)

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

        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        relative_poses = self.trajectory_replayer.load_relative_trajectory(yaml_path)
        cartesian_plan = self.trajectory_replayer.compute_cartesian_plan(relative_poses)
        self.trajectory_replayer.move_group.execute(cartesian_plan, wait=True)

        message = f"Successfully executed trajectory loaded from file: {yaml_path}"
        return PlaybackTrajectoryResponse(success=True, message=message)

    def arm_action_callback(self, goal: FollowJointTrajectoryGoal, delay_s: float = 0.25) -> None:
        """Handle a new goal for the FollowJointTrajectory action server.

        If Spot's arm is unlocked, trajectories sent to this server will be executed.

        Reference: https://tinyurl.com/FollowJointTrajectory

        :param goal: Joint trajectory to be followed
        :param delay_s: Delay (seconds) to wait after any successful command execution
        """
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

        result = FollowJointTrajectoryResult()
        result.error_code = -1  # Default error code: INVALID_GOAL

        if self._arm_locked:
            result.error_string = "Could not follow trajectory because Spot's arm remains locked."
            self._manager.log_info(f"[{self._arm_action_name}] {result.error_string}")
            self._arm_action_server.set_aborted(result)
            return

        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        if not has_control:
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

        if self._arm_locked:
            gripper_command_result.reached_goal = False
            self._gripper_action_server.set_aborted(gripper_command_result)
            return

        goal_position_rad = goal.command.position  # Ignoring goal.command.max_effort

        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control()

        outcome = GripperCommandOutcome.FAILURE
        if has_control:
            outcome = self._arm_controller.command_gripper(goal_position_rad)
            rospy.sleep(delay_s)

        if outcome == GripperCommandOutcome.FAILURE:
            gripper_command_result.reached_goal = False
            self._gripper_action_server.set_aborted(gripper_command_result)
        else:
            gripper_command_result.reached_goal = outcome == GripperCommandOutcome.REACHED_SETPOINT
            gripper_command_result.stalled = outcome == GripperCommandOutcome.STALLED

            self._gripper_action_server.set_succeeded(gripper_command_result)
