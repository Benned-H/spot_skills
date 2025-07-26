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
from robotics_utils.filesystem.yaml_utils import export_yaml_data
from robotics_utils.kinematics import DEFAULT_FRAME
from robotics_utils.kinematics.poses import Pose2D
from robotics_utils.kinematics.waypoints import Waypoints
from robotics_utils.math.distances import angle_difference_rad, euclidean_distance_2d_m
from robotics_utils.ros.msg_conversion import pose_from_msg, pose_to_stamped_msg
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.transform_manager import TransformManager

from spot_skills.srv import (
    NameService,
    NameServiceRequest,
    NameServiceResponse,
    YAMLPathService,
    YAMLPathServiceRequest,
    YAMLPathServiceResponse,
)

if TYPE_CHECKING:
    from geometry_msgs.msg import PoseStamped

    from spot_skills_py.spot.spot_manager import SpotManager


@dataclass
class GoalReachedThresholds:
    """Thresholds specifying when Spot is considered to have reached a navigation goal pose."""

    distance_m: float  # Distance (meters) from the goal base pose
    abs_yaw_rad: float  # Absolute angle (radians) from the yaw of the base pose

    def is_goal_reached(self, target_pose_2d: Pose2D, lookup_timeout_s: float = 5.0) -> bool:
        """Check whether Spot has reached the given goal pose, according to the thresholds.

        :param target_pose_2d: Target base pose for Spot
        :param lookup_timeout_s: Timeout (seconds) after which pose lookup is abandoned
        :return: True if Spot is sufficiently close to the target pose, else False
        """
        end_time_s = time.time() + lookup_timeout_s

        curr_pose = None  # Body pose in same reference frame as the target pose
        while time.time() < end_time_s:
            curr_pose = TransformManager.lookup_transform(
                "body",
                target_pose_2d.ref_frame,
                timeout_s=0.1,
            )

        if curr_pose is None:
            rospy.logfatal(f"Could not look up body pose in frame '{target_pose_2d.ref_frame}'.")
            return False

        distance_2d_m = euclidean_distance_2d_m(
            target_pose_2d,
            curr_pose.to_2d(),
            change_frames=False,
        )
        abs_yaw_error_rad = angle_difference_rad(target_pose_2d.yaw_rad, curr_pose.yaw_rad)

        rospy.loginfo(f"Current distance from goal: {distance_2d_m} m")
        rospy.loginfo(f"Current yaw error from goal: {abs_yaw_error_rad} abs. rad")

        return distance_2d_m < self.distance_m and abs_yaw_error_rad < self.abs_yaw_rad


class SpotNavigationServer:
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the ROS services provided by this class.

        :param manager: SpotManager object used to control Spot through the Spot SDK
        """
        self._manager = manager

        # Provide a service to create new waypoints at Spot's current base pose
        self._new_waypoint_srv = rospy.Service(
            "/spot/navigation/create_waypoint",
            NameService,
            self.handle_create_waypoint,
        )

        self._output_srv = rospy.Service(
            "/spot/navigation/output_to_yaml",
            YAMLPathService,
            self.handle_output_to_yaml,
        )

        # Load waypoint locations from a YAML file specified via ROS param
        waypoints_yaml_path = get_ros_param("/spot/navigation/waypoints_yaml", Path)
        self.waypoints = Waypoints.from_yaml(waypoints_yaml_path)

        rospy.loginfo(f"Loaded {len(self.waypoints)} named waypoints from YAML.")

        # Wait for the move_base action server to become available
        self._move_base_client = SimpleActionClient("move_base", MoveBaseAction)
        self._move_base_client.wait_for_server(timeout=rospy.Duration.from_sec(10))

        # Load ROS parameters specifying when Spot is considered to have reached its goal
        self.goal_reached_thresholds = GoalReachedThresholds(
            distance_m=get_ros_param("/spot/navigation/reached_goal_m", float),
            abs_yaw_rad=get_ros_param("/spot/navigation/reached_goal_rad", float),
        )

        self.timeout_s = get_ros_param("/spot/navigation/timeout_s", float)
        self.adjustment_timeout_s = get_ros_param("/spot/navigation/adjustment_timeout_s", float)

        self.CMD_VEL_DURATION_S = 1.0  # Duration (seconds) to execute each velocity command

        self._tf_publisher_thread = threading.Thread(target=self._publish_waypoints_tf_loop)
        self._tf_publisher_thread.daemon = True  # Thread exits when main process does
        self._tf_publisher_thread.start()

    def handle_create_waypoint(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a ROS service request to create a new waypoint at Spot's current base pose.

        :param request: Request specifying the waypoint name to be used
        :return: Response specifying whether the waypoint was successfully created
        """
        curr_base_pose = TransformManager.lookup_transform("body", DEFAULT_FRAME)
        if curr_base_pose is None:
            message = f"Could not look up the transform from 'body' to '{DEFAULT_FRAME}'."
            return NameServiceResponse(success=False, message=message)

        new_name: str = request.name
        curr_2d_pose = curr_base_pose.to_2d()
        self.waypoints[new_name] = curr_2d_pose

        success = new_name in self.waypoints
        if success:
            message = f"Added waypoint named '{new_name}' at {curr_2d_pose}."
        else:
            message = f"Failed to add waypoint named '{new_name}' at {curr_2d_pose}."

        return NameServiceResponse(success=success, message=message)

    def handle_output_to_yaml(self, req: YAMLPathServiceRequest) -> YAMLPathServiceResponse:
        """Handle a ROS service request to output the current waypoints to a YAML file.

        :param req: Request specifying the desired YAML output path
        :return: Response specifying whether the output succeeded
        """
        output_path = Path(req.yaml_path)
        if output_path.suffix not in {".yaml", ".yml"}:
            message = f"Cannot output YAML to non-YAML path '{output_path}'."
            return YAMLPathServiceResponse(success=False, message=message)

        yaml_data = {"waypoints": self.waypoints.to_yaml_data(default_frame=DEFAULT_FRAME)}
        export_yaml_data(yaml_data, output_path)

        success = output_path.exists()
        message = (
            f"Waypoints were exported to path {output_path}."
            if success
            else f"Failed to export waypoints to path {output_path}."
        )
        return YAMLPathServiceResponse(success=success, message=message)

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
            self.timeout_s,
            retry_duration_s=self.adjustment_timeout_s,
        )
        message = "Navigation was successful." if success else "Navigation failed."

        return success, message

    def _publish_waypoints_tf_loop(self) -> None:
        """Publish the defined waypoints' poses in a loop."""
        try:
            rate_hz = rospy.Rate(TransformManager.LOOP_HZ)
            while not rospy.is_shutdown():
                for name, pose in self.waypoints.items():
                    TransformManager.broadcast_transform(name, pose.to_3d())

                rate_hz.sleep()
        except rospy.ROSInterruptException as ros_exc:
            rospy.logwarn(f"[_publish_waypoints_tf_loop] {ros_exc}")
