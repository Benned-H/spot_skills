"""Define a class to manage navigation services for Spot."""

from __future__ import annotations

import threading
from pathlib import Path
from typing import TYPE_CHECKING

import rospy
from actionlib import GoalStatus, SimpleActionClient
from geometry_msgs.msg import Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from transform_utils.kinematics import DEFAULT_FRAME, Pose3D
from transform_utils.kinematics_ros import pose_from_msg, pose_to_stamped_msg
from transform_utils.math.distances import absolute_yaw_error_rad, euclidean_distance_2d_m
from transform_utils.transform_manager import TransformManager
from transform_utils.world_model.known_landmarks import KnownLandmarks2D

from spot_skills.srv import (
    NavigateToLandmark,
    NavigateToLandmarkRequest,
    NavigateToLandmarkResponse,
    NavigateToPose,
    NavigateToPoseRequest,
    NavigateToPoseResponse,
    ObjectNameService,
    ObjectNameServiceRequest,
    ObjectNameServiceResponse,
)

if TYPE_CHECKING:
    from geometry_msgs.msg import PoseStamped
    from transform_utils.kinematics import Pose2D

    from spot_skills_py.spot.spot_manager import SpotManager


class SpotNavigationServer:
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the ROS services provided by this class.

        :param manager: SpotManager object used to control Spot through the Spot SDK
        """
        self._manager = manager

        self._nav_to_pose_srv = rospy.Service(
            "/spot/navigation/to_pose",
            NavigateToPose,
            self.handle_pose,
        )

        self._nav_to_landmark_srv = rospy.Service(
            "/spot/navigation/to_landmark",
            NavigateToLandmark,
            self.handle_landmark,
        )

        # Provide a service to create new landmarks at Spot's current base pose
        self._new_landmark_srv = rospy.Service(
            "/spot/navigation/create_landmark",
            ObjectNameService,
            self.handle_create_landmark,
        )

        # Load landmark locations from a YAML file specified via ROS param
        landmarks_yaml_path = Path(rospy.get_param("/spot/navigation/known_landmarks_yaml"))
        known_landmarks = KnownLandmarks2D.from_yaml(landmarks_yaml_path)
        self._landmarks: dict[str, Pose2D] = known_landmarks.landmarks

        rospy.loginfo(f"Loaded {len(self._landmarks)} named landmarks from YAML.")

        # Wait for the move_base action server to become available
        self._move_base_client = SimpleActionClient("move_base", MoveBaseAction)
        self._move_base_client.wait_for_server(timeout=rospy.Duration.from_sec(60.0))

        # Load thresholds for when Spot is considered "close to a goal" from ROS params
        self.close_to_goal_m = rospy.get_param("/spot/navigation/close_to_goal_m")
        self.close_to_goal_rad = rospy.get_param("/spot/navigation/close_to_goal_rad")
        self.timeout_s = rospy.get_param("/spot/navigation/timeout_s")

        # Subscribe to a topic providing body-frame velocity commands
        self._cmd_vel_sub = rospy.Subscriber("cmd_vel", Twist, self.handle_cmd_vel, queue_size=1)

        self._CMD_VEL_DURATION_S = 1.0  # Duration (seconds) to execute each velocity command

        self._tf_publisher_thread = threading.Thread(target=self._publish_landmarks_tf_loop)
        self._tf_publisher_thread.daemon = True  # Thread exits when main process does
        self._tf_publisher_thread.start()

    def check_close_to_goal(self, target_pose_2d: Pose2D) -> bool:
        """Check whether Spot is currently "close" to a goal pose, using the stored thresholds.

        :param target_pose_2d: Target base pose for Spot
        :return: True if Spot is "close" to the given target pose, else False
        """
        now = rospy.Time.now()
        curr_pose = TransformManager.lookup_transform("body", target_pose_2d.ref_frame, now)
        if curr_pose is None:
            rospy.logfatal(f"Could not look up body pose in frame '{target_pose_2d.ref_frame}'.")
            return False

        distance_2d_m = euclidean_distance_2d_m(target_pose_2d, curr_pose)
        abs_yaw_error_rad = absolute_yaw_error_rad(target_pose_2d, curr_pose)

        return distance_2d_m < self.close_to_goal_m and abs_yaw_error_rad < self.close_to_goal_rad

    def handle_create_landmark(
        self,
        request: ObjectNameServiceRequest,
    ) -> ObjectNameServiceResponse:
        """Handle a ROS service request to create a new landmark at Spot's current base pose.

        :param request: Request specifying the landmark name to be used
        :return: Response specifying whether the landmark was successfully created
        """
        curr_base_pose = TransformManager.lookup_transform("body", DEFAULT_FRAME)
        if curr_base_pose is None:
            message = f"Could not look up the transform from 'body' to '{DEFAULT_FRAME}'."
            return ObjectNameServiceResponse(success=False, message=message)

        new_name = request.object_name
        curr_2d_pose = curr_base_pose.to_2d()
        self._landmarks[new_name] = curr_2d_pose

        success = new_name in self._landmarks
        if success:
            message = f"Added landmark named '{new_name}' at {curr_2d_pose}."
        else:
            message = f"Failed to add landmark named '{new_name}' at {curr_2d_pose}."

        return ObjectNameServiceResponse(success=success, message=message)

    def handle_pose(self, request: NavigateToPoseRequest) -> NavigateToPoseResponse:
        """Handle a ROS service request for Spot to navigate to a given pose.

        :param request: Request specifying a pose to navigate to
        :return: Response specifying whether the navigation succeeded
        """
        success, message = self.navigate_to_pose(request.target_base_pose)
        return NavigateToPoseResponse(success, message)

    def handle_landmark(self, request: NavigateToLandmarkRequest) -> NavigateToLandmarkResponse:
        """Handle a ROS service request for Spot to navigate to a known landmark.

        :param request: Request specifying a landmark to navigate to
        :return: Response specifying whether the navigation succeeded
        """
        if request.landmark_name not in self._landmarks:
            message = f"Cannot navigate to unknown landmark '{request.landmark_name}'."
            return NavigateToLandmarkResponse(success=False, message=message)

        target_pose = self._landmarks[request.landmark_name]
        pose_stamped_msg = pose_to_stamped_msg(target_pose)
        success, message = self.navigate_to_pose(pose_stamped_msg)
        return NavigateToLandmarkResponse(success, message)

    def navigate_to_pose(self, pose_msg: PoseStamped) -> tuple[bool, str]:
        """Control Spot to navigate to the given pose (treated as if it were 2D).

        :param pose_msg: ROS message representing a target body pose for Spot
        :return: Boolean success indicator (True if action succeeds) and message explaining why
        """
        has_control = self._manager.check_control()  # Only take control of Spot once necessary
        if not has_control:
            has_control = self._manager.take_control(force=True)  # Forcefully take control of Spot

        if not has_control:
            return False, "Could not obtain control of Spot using the SpotManager."

        duration_timeout = rospy.Duration.from_sec(self.timeout_s)

        action_goal = MoveBaseGoal(target_pose=pose_msg)
        self._move_base_client.send_goal_and_wait(action_goal, execute_timeout=duration_timeout)

        result_state = self._move_base_client.get_state()
        result_text = self._move_base_client.get_goal_status_text()

        target_pose_2d = pose_from_msg(pose_msg).to_2d()

        # If move_base didn't bring Spot sufficiently close to the goal, give up
        if result_state != GoalStatus.SUCCEEDED:
            rospy.loginfo(f"MoveBase failed with state {result_state} and text '{result_text}'.")

            if not self.check_close_to_goal(target_pose_2d):
                return (False, f"Move base failed with message: {result_text}")

        rospy.loginfo("Spot has successfully moved 'close' to the goal using move_base.")

        success = self._manager.navigate_to_base_pose(target_pose_2d, self.timeout_s)
        message = "Navigation was successful." if success else "Navigation failed."

        return success, message

    def handle_cmd_vel(self, msg: Twist) -> None:
        """Handle a body-frame velocity command.

        :param msg: Twist message specifying the commanded velocity
        """
        self._manager.send_velocity_command(
            linear_x_mps=msg.linear.x,
            linear_y_mps=msg.linear.y,
            angular_z_radps=msg.angular.z,
            duration_s=self._CMD_VEL_DURATION_S,
        )

    def _publish_landmarks_tf_loop(self) -> None:
        """Publish the known landmarks' poses in a loop."""
        try:
            rate_hz = rospy.Rate(TransformManager.loop_hz)
            while not rospy.is_shutdown():
                for name, pose in self._landmarks.items():
                    TransformManager.broadcast_transform(frame_name=name, pose=Pose3D.from_2d(pose))

                rate_hz.sleep()
        except rospy.ROSInterruptException as ros_exc:
            rospy.logwarn(f"[_publish_landmarks_tf_loop] {ros_exc}")
