"""Define a class to manage navigation services for Spot."""

from __future__ import annotations

from pathlib import Path
from typing import TYPE_CHECKING

import rospy
from geometry_msgs.msg import Twist
from robotics_utils.kinematics import Waypoints
from robotics_utils.motion_planning.navigation_goal import NavigationGoal
from robotics_utils.robots import MobileRobot
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.transform_manager import TransformManager
from robotics_utils.skills import Outcome
from robotics_utils.spatial import DEFAULT_FRAME, Pose2D

from spot_skills.srv import (
    NameService,
    NameServiceRequest,
    NameServiceResponse,
)

if TYPE_CHECKING:
    from robotics_utils.parallelism import ResourceManager

    from spot_skills_py.spot.spot_graph_nav import SpotGraphNav
    from spot_skills_py.spot.spot_manager import SpotManager


class SpotNavigationServer(MobileRobot):
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(
        self,
        manager: SpotManager,
        graph_nav: SpotGraphNav,
        resource_manager: ResourceManager,
    ) -> None:
        """Initialize the ROS services provided by this class.

        :param manager: SpotManager object used to control Spot through the Spot SDK
        """
        self._manager = manager
        self._graph_nav = graph_nav
        self._resource_manager = resource_manager
        self.base_frame = "body"

        # Provide a service to create new waypoints at Spot's current base pose
        self._new_waypoint_srv = rospy.Service(
            "/spot/navigation/create_waypoint",
            NameService,
            self.handle_create_waypoint,
        )

        # Load waypoint locations from a YAML file specified via ROS param
        self.waypoints_yaml_path = get_ros_param("/spot/navigation/waypoints_yaml", Path)
        self.waypoints = Waypoints.from_yaml(self.waypoints_yaml_path)

        rospy.loginfo(f"Loaded {len(self.waypoints)} named waypoints from YAML.")

        # Load thresholds for when Spot is considered "close to a goal" from ROS params
        self.close_to_goal_m = get_ros_param("/spot/navigation/close_to_goal_m", float)
        self.close_to_goal_rad = get_ros_param("/spot/navigation/close_to_goal_rad", float)

        # Ensure that we can access this ROS parameter, which we'll look up online later
        get_ros_param("/spot/navigation/timeout_s", float)

        # Subscribe to a topic providing body-frame velocity commands
        self._cmd_vel_sub = rospy.Subscriber("cmd_vel", Twist, self.handle_cmd_vel, queue_size=1)

        self._CMD_VEL_DURATION_S = 1.0  # Duration (seconds) to execute each velocity command

        # Broadcast the navigation waypoints as static transforms to TF
        #   This makes them available for any timestamp query, preventing TF extrapolation errors
        for name, pose in self.waypoints.items():
            TransformManager.broadcast_static_transform(name, pose.to_3d())

    @property
    def current_base_pose(self) -> Pose2D:
        """Retrieve the robot's current base pose."""
        pose_w_r = TransformManager.lookup_transform(self.base_frame, DEFAULT_FRAME)
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
        self.waypoints[new_name] = curr_2d_pose

        success = new_name in self.waypoints
        if success:
            message = f"Added waypoint named '{new_name}' at {curr_2d_pose}."
        else:
            message = f"Failed to add waypoint named '{new_name}' at {curr_2d_pose}."

        return NameServiceResponse(success=success, message=message)

    def compute_navigation_plan(self, initial: Pose2D, goal: Pose2D) -> list[Pose2D] | None:
        """Compute a navigation plan between the two given robot base poses.

        :param initial: Robot base pose from which the plan begins
        :param goal: Target base pose to be reached by the navigation plan
        :return: Navigation plan (list of base pose waypoints), or None if no plan is found
        """
        # TODO: Replicate what SimulatedRobotBase does

    def execute_navigation_plan(self, nav_plan: list[Pose2D], timeout_s: float = 60.0) -> Outcome:
        """Execute the given navigation plan on the mobile robot.

        :param nav_plan: Navigation plan of 2D base pose waypoints
        :param timeout_s: Duration (seconds) after which the plan times out (default: 60 seconds)
        :return: Boolean success indicator and explanatory message
        """
        if not nav_plan:
            return Outcome(success=False, message="Cannot execute an empty navigation plan.")

        final_pose = nav_plan[-1]
        return self.navigate_to_pose(goal_pose=final_pose, timeout_s=timeout_s)

    def navigate_to_pose(self, goal_pose: Pose2D, timeout_s: float | None = None) -> Outcome:
        """Navigate using GraphNav to the given target base pose in the seed frame.

        :param goal_pose: Target base pose for the robot
        :param timeout_s: Optional duration (seconds) after which navigation times out
        :return: Boolean success indicator and an outcome message
        """
        if timeout_s is None:
            timeout_s = get_ros_param("/spot/navigation/timeout_s", float)

        # # DEBUG: Log the input goal pose and converted goal
        # rospy.loginfo(f"[NAV DEBUG] Input goal_pose: {goal_pose}")

        goal_wrt_seed = TransformManager.convert_to_frame(goal_pose, target_frame="seed")
        # rospy.loginfo(f"[NAV DEBUG] goal_wrt_seed: {goal_wrt_seed}")

        # # DEBUG: Log current body pose in map and seed frames
        # body_in_map = TransformManager.lookup_transform(
        #     child_frame="body",
        #     parent_frame=DEFAULT_FRAME,
        # )
        # if body_in_map is not None:
        #     rospy.loginfo(f"[NAV DEBUG] Current body in map: {body_in_map.to_2d()}")

        body_in_seed = TransformManager.lookup_transform(child_frame="body", parent_frame="seed")
        if body_in_seed is None:
            return Outcome(False, "Unable to find current transform from map frame to body frame.")
        body_z_m = body_in_seed.position.z
        # rospy.loginfo(f"[NAV DEBUG] Current body in seed: {body_in_seed.to_2d()}")

        # # DEBUG: Log the seed-to-map transform
        # seed_in_map = TransformManager.lookup_transform(
        #     child_frame="seed",
        #     parent_frame=DEFAULT_FRAME,
        # )
        # if seed_in_map is not None:
        #     rospy.loginfo(f"[NAV DEBUG] seed frame in map: {seed_in_map.to_2d()}")

        with self._resource_manager.priority() as got_priority:
            if not got_priority:
                rospy.logwarn(f"Navigating to pose {goal_wrt_seed} without RPC priority...")

            # nav_outcome = self._graph_nav.navigate_to_pose(goal_wrt_seed, body_z_m, timeout_s)
            return self.go_to_pose(base_pose=goal_pose, timeout_s=timeout_s)

        # success = nav_outcome.success
        # message = nav_outcome.message

        # # If the Spot SDK thought Spot was stuck, but we're close enough, mark as successful
        # nav_goal = NavigationGoal(
        #     goal_wrt_seed,
        #     self._manager.goal_reached_m,
        #     self._manager.goal_yaw_tolerance_rad,
        # )
        # if self.goal_reached(nav_goal, change_frames=True):
        #     success = True
        #     message = "Spot has reached the navigation goal."
        #     meta_message = "GraphNav successful: " if success else "GraphNav unsuccessful: "
        #     return Outcome(success, f"{meta_message}{message}")

        # return self.go_to_pose(base_pose=goal_pose, timeout_s=timeout_s)

    def go_to_pose(self, base_pose: Pose2D, timeout_s: float) -> Outcome:
        """Move directly to the specified base pose.

        :param base_pose: Target base pose for the robot
        :param timeout_s: Timeout (seconds) for the movement command
        :return: Boolean success indicator and an outcome message
        """
        self._manager.ensure_control(take_by_force=True)  # Forcefully ensure control of Spot

        if not self._manager.has_control:
            return Outcome(False, "Could not obtain control of Spot using the SpotManager.")

        success = self._manager.move_to_base_pose(base_pose, self, timeout_s)
        message = "Movement was successful." if success else "Movement failed."

        return Outcome(success, message)

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
