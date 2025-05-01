"""Define a class to manage navigation services for Spot."""

from __future__ import annotations

import threading
import time
from dataclasses import dataclass
from pathlib import Path
from typing import TYPE_CHECKING

import rospy
from actionlib import GoalStatus, SimpleActionClient
from geometry_msgs.msg import Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from transform_utils.filesystem.export_to_yaml import output_yaml_data_to_path
from transform_utils.kinematics import DEFAULT_FRAME, Pose3D
from transform_utils.kinematics_ros import pose_from_msg, pose_to_stamped_msg
from transform_utils.logging import log_info
from transform_utils.math.distances import absolute_yaw_error_rad, euclidean_distance_2d_m
from transform_utils.transform_manager import TransformManager
from transform_utils.world_model.known_landmarks import KnownLandmarks2D

from spot_skills.srv import (
    StringRequestService,
    StringRequestServiceRequest,
    StringRequestServiceResponse,
)

if TYPE_CHECKING:
    from geometry_msgs.msg import PoseStamped
    from transform_utils.kinematics import Pose2D

    from spot_skills_py.spot.spot_manager import SpotManager


@dataclass
class GoalReachedThresholds:
    """Thresholds specifying when Spot is considered to have reached a goal pose."""

    distance_m: float  # Distance (meters) from the goal base pose
    abs_angle_rad: float  # Absolute angle (radians) from the yaw of the base pose


def check_reached_goal(target_pose_2d: Pose2D, thresholds: GoalReachedThresholds) -> bool:
    """Check whether Spot is considered to have reach a goal pose.

    :param target_pose_2d: Target base pose for Spot
    :param thresholds: Thresholds specifying when Spot is considered to have reached the goal
    :return: True if Spot is sufficiently close to the target pose, else False
    """
    pose_lookup_duration_s = 5  # How long should we allow pose lookup to fail/retry?
    end_time_s = time.time() + pose_lookup_duration_s

    curr_pose = None
    while time.time() < end_time_s:
        curr_pose = TransformManager.lookup_transform(
            "body",
            target_pose_2d.ref_frame,
            timeout_s=0.1,
        )

    if curr_pose is None:
        rospy.logfatal(f"Could not look up body pose in frame '{target_pose_2d.ref_frame}'.")
        return False

    distance_2d_m = euclidean_distance_2d_m(target_pose_2d, curr_pose)
    abs_yaw_error_rad = absolute_yaw_error_rad(target_pose_2d, curr_pose)

    log_info(f"Current distance from goal: {distance_2d_m} m")
    log_info(f"Current angle error from goal: {abs_yaw_error_rad} abs. rad")

    distance_reached = distance_2d_m < thresholds.distance_m
    angle_reached = abs_yaw_error_rad < thresholds.abs_angle_rad

    return distance_reached and angle_reached


class SpotNavigationServer:
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the ROS services provided by this class.

        :param manager: SpotManager object used to control Spot through the Spot SDK
        """
        self._manager = manager

        # Provide a service to create new landmarks at Spot's current base pose
        self._new_landmark_srv = rospy.Service(
            "/spot/navigation/create_landmark",
            StringRequestService,
            self.handle_create_landmark,
        )

        self._output_srv = rospy.Service(
            "/spot/navigation/output_to_yaml",
            StringRequestService,
            self.handle_output_to_yaml,
        )

        # Load landmark locations from a YAML file specified via ROS param
        landmarks_yaml_path = Path(rospy.get_param("/spot/navigation/known_landmarks_yaml"))
        self.known_landmarks = KnownLandmarks2D.from_yaml(landmarks_yaml_path)

        rospy.loginfo(f"Loaded {len(self.known_landmarks.landmarks)} named landmarks from YAML.")

        # Wait for the move_base action server to become available
        self._move_base_client = SimpleActionClient("move_base", MoveBaseAction)
        self._move_base_client.wait_for_server(timeout=rospy.Duration.from_sec(60.0))

        # Load ROS params specifying when Spot is considered to have reached its goal
        self.goal_reached_thresholds = GoalReachedThresholds(
            distance_m=rospy.get_param("/spot/navigation/reached_goal_m"),
            abs_angle_rad=rospy.get_param("/spot/navigation/reached_goal_rad"),
        )

        self.timeout_s = rospy.get_param("/spot/navigation/timeout_s")
        self.adjustment_timeout_s = rospy.get_param("/spot/navigation/adjustment_timeout_s")

        self.CMD_VEL_DURATION_S = 1.0  # Duration (seconds) to execute each velocity command

        self._tf_publisher_thread = threading.Thread(target=self._publish_landmarks_tf_loop)
        self._tf_publisher_thread.daemon = True  # Thread exits when main process does
        self._tf_publisher_thread.start()

    def handle_create_landmark(
        self,
        request: StringRequestServiceRequest,
    ) -> StringRequestServiceResponse:
        """Handle a ROS service request to create a new landmark at Spot's current base pose.

        :param request: Request specifying the landmark name to be used
        :return: Response specifying whether the landmark was successfully created
        """
        curr_base_pose = TransformManager.lookup_transform("body", DEFAULT_FRAME)
        if curr_base_pose is None:
            message = f"Could not look up the transform from 'body' to '{DEFAULT_FRAME}'."
            return StringRequestServiceResponse(success=False, message=message)

        new_name = request.data
        curr_2d_pose = curr_base_pose.to_2d()
        self.known_landmarks.landmarks[new_name] = curr_2d_pose

        success = new_name in self.known_landmarks.landmarks
        if success:
            message = f"Added landmark named '{new_name}' at {curr_2d_pose}."
        else:
            message = f"Failed to add landmark named '{new_name}' at {curr_2d_pose}."

        return StringRequestServiceResponse(success=success, message=message)

    def handle_output_to_yaml(
        self,
        req: StringRequestServiceRequest,
    ) -> StringRequestServiceResponse:
        """Handle a ROS service request to output the current landmarks to a YAML file.

        :param req: Request specifying the desired YAML output path
        :return: Response specifying whether the output succeeded
        """
        output_path = Path(req.data)
        if output_path.suffix not in {".yaml", ".yml"}:
            message = f"Cannot output YAML to non-YAML path '{output_path}'."
            return StringRequestServiceResponse(success=False, message=message)

        yaml_data = {"known_landmarks": self.known_landmarks.to_yaml_dict()}
        success = output_yaml_data_to_path(yaml_data, yaml_path=output_path)

        message = (
            f"Output known landmarks to path {output_path}."
            if success
            else f"Failed to output landmarks to path {output_path}."
        )

        return StringRequestServiceResponse(success=success, message=message)

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
            message = f"MoveBase failed with state {result_state} and text '{result_text}'."
            return (False, message)

        self._manager.log_info("move_base has navigated to the approximate target base pose.")

        success = self._manager.navigate_to_base_pose(
            target_pose_2d,
            self.goal_reached_thresholds,
            self.adjustment_timeout_s,
        )
        message = "Navigation was successful." if success else "Navigation failed."

        return success, message

    def _publish_landmarks_tf_loop(self) -> None:
        """Publish the known landmarks' poses in a loop."""
        try:
            rate_hz = rospy.Rate(TransformManager.loop_hz)
            while not rospy.is_shutdown():
                for name, pose in self.known_landmarks.landmarks.items():
                    TransformManager.broadcast_transform(frame_name=name, pose=Pose3D.from_2d(pose))

                rate_hz.sleep()
        except rospy.ROSInterruptException as ros_exc:
            rospy.logwarn(f"[_publish_landmarks_tf_loop] {ros_exc}")
