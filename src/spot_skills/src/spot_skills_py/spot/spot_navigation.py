"""Define a class to manage navigation services for Spot."""

from __future__ import annotations

import threading
from pathlib import Path
from typing import TYPE_CHECKING

import rospy
from geometry_msgs.msg import Twist
from robotics_utils.kinematics import DEFAULT_FRAME, Pose2D, Waypoints
from robotics_utils.robots.mobile_robot import MobileRobot
from robotics_utils.ros.msg_conversion import pose_from_msg
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.transform_manager import TransformManager

from spot_skills.srv import (
    NameService,
    NameServiceRequest,
    NameServiceResponse,
    NavigateToPose,
    NavigateToPoseRequest,
    NavigateToPoseResponse,
)
from spot_skills_py.spot.spot_graph_nav import SpotGraphNav

if TYPE_CHECKING:
    from robotics_utils.skills.skill import SkillResult

    from spot_skills_py.spot.spot_manager import SpotManager


class SpotNavigationServer(MobileRobot):
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(self, manager: SpotManager, base_frame: str = "body") -> None:
        """Initialize the ROS services provided by this class.

        :param manager: SpotManager object used to control Spot through the Spot SDK
        """
        self._manager = manager
        self._graph_nav = SpotGraphNav(self._manager)
        self.base_frame = base_frame

        self._nav_to_pose_srv = rospy.Service(
            "/spot/navigation/to_pose",
            NavigateToPose,
            self.handle_pose,
        )

        self._nav_to_waypoint_srv = rospy.Service(
            "/spot/navigation/to_waypoint",
            NameService,
            self.handle_waypoint,
        )

        # Provide a service to create new waypoints at Spot's current base pose
        self._new_waypoint_srv = rospy.Service(
            "/spot/navigation/create_waypoint",
            NameService,
            self.handle_create_waypoint,
        )

        # Load waypoint locations from a YAML file specified via ROS param
        waypoints_yaml_path = get_ros_param("/spot/navigation/waypoints_yaml", Path)
        self._waypoints = Waypoints.from_yaml(waypoints_yaml_path)

        rospy.loginfo(f"Loaded {len(self._waypoints)} named waypoints from YAML.")

        # Load thresholds for when Spot is considered "close to a goal" from ROS params
        self.close_to_goal_m = get_ros_param("/spot/navigation/close_to_goal_m", float)
        self.close_to_goal_rad = get_ros_param("/spot/navigation/close_to_goal_rad", float)
        self.timeout_s = get_ros_param("/spot/navigation/timeout_s", float)

        # Subscribe to a topic providing body-frame velocity commands
        self._cmd_vel_sub = rospy.Subscriber("cmd_vel", Twist, self.handle_cmd_vel, queue_size=1)

        self._CMD_VEL_DURATION_S = 1.0  # Duration (seconds) to execute each velocity command

        self._tf_publisher_thread = threading.Thread(target=self._publish_waypoints_tf_loop)
        self._tf_publisher_thread.daemon = True  # Thread exits when main process does
        self._tf_publisher_thread.start()

    @property
    def current_base_pose(self) -> Pose2D:
        """Retrieve the robot's current base pose."""
        pose_w_r = TransformManager.lookup_transform(self.base_frame, DEFAULT_FRAME, rospy.Time(0))
        if pose_w_r is None:
            raise RuntimeError("Unable to find Spot's base pose.")
        return pose_w_r.to_2d()

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
        self._waypoints[new_name] = curr_2d_pose

        success = new_name in self._waypoints
        if success:
            message = f"Added waypoint named '{new_name}' at {curr_2d_pose}."
        else:
            message = f"Failed to add waypoint named '{new_name}' at {curr_2d_pose}."

        return NameServiceResponse(success=success, message=message)

    def handle_pose(self, request: NavigateToPoseRequest) -> NavigateToPoseResponse:
        """Handle a ROS service request for Spot to navigate to a given pose.

        :param request: Request specifying a pose to navigate to
        :return: Response specifying whether the navigation succeeded
        """
        self._manager.log_info("Handling 'NavigateToPose' request...")

        target_base_pose_2d = pose_from_msg(request.target_base_pose).to_2d()
        success, message = self.navigate_to_pose(target_base_pose_2d, self.timeout_s)
        return NavigateToPoseResponse(success, message)

    def handle_waypoint(self, request: NameServiceRequest) -> NameServiceResponse:
        """Handle a ROS service request for Spot to navigate to a named waypoint.

        :param request: Request specifying a waypoint to navigate to
        :return: Response specifying whether the navigation succeeded
        """
        if request.name not in self._waypoints:
            available_waypoints = list(self._waypoints.keys())
            message = (
                f"Cannot navigate to unknown waypoint '{request.name}'.\n "
                f"Available waypoints: {available_waypoints}"
            )
            return NameServiceResponse(success=False, message=message)

        self._manager.log_info(
            f"Handling 'NavigateToWaypoint' request for waypoint '{request.name}'...",
        )
        target_pose = self._waypoints[request.name]
        self._manager.log_info(f"Waypoint '{request.name}' has target pose: {target_pose}.")

        success, message = self.navigate_to_pose(target_pose, self.timeout_s)
        return NameServiceResponse(success, message)

    def navigate_to_pose(self, goal_pose: Pose2D, timeout_s: float) -> SkillResult:
        """Navigate using graph nav when available, fallback to global path planning.

        :param goal_pose: Target base pose for the robot (in DEFAULT_FRAME/"map")
        :param timeout_s: Total duration (seconds) after which navigation will time out
        :return: Tuple containing Boolean success and an outcome message
        """
        success, message = self._graph_nav.navigate_to_pose(goal_pose, timeout_s)
        meta_message = "GraphNav successful: " if success else "GraphNav unsuccessful: "
        return success, f"{meta_message}{message}"

    def go_to_pose(self, base_pose: Pose2D, timeout_s: float) -> SkillResult:
        """Move directly to the specified base pose.

        :param base_pose: Target base pose for the robot
        :param timeout_s: Timeout (seconds) for the movement command
        :return: Tuple containing Boolean success and an outcome message
        """
        self._manager.ensure_control(take_by_force=True)  # Forcefully ensure control of Spot

        if not self._manager.has_control:
            return False, "Could not obtain control of Spot using the SpotManager."

        success = self._manager.move_to_base_pose(base_pose, self, timeout_s)
        message = "Movement was successful." if success else "Movement failed."

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

    def _publish_waypoints_tf_loop(self) -> None:
        """Publish the defined waypoints' poses in a loop."""
        try:
            rate_hz = rospy.Rate(TransformManager.LOOP_HZ)
            while not rospy.is_shutdown():
                for name, pose in self._waypoints.items():
                    TransformManager.broadcast_transform(name, pose.to_3d())

                rate_hz.sleep()
        except rospy.ROSInterruptException as ros_exc:
            rospy.logwarn(f"[_publish_waypoints_tf_loop] {ros_exc}")
