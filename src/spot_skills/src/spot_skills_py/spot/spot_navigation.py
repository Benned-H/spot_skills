"""Define a class to manage navigation services for Spot."""

from __future__ import annotations

from pathlib import Path
from typing import TYPE_CHECKING

import rospy
from geometry_msgs.msg import Twist
from nav_msgs.msg import Path as PathMsg
from robotics_utils.kinematics import Waypoints
from robotics_utils.motion_planning import (
    NavigationQuery,
    PurePursuitConfig,
    PurePursuitFollower,
    plan_se2_path,
)
from robotics_utils.robots import MobileRobot
from robotics_utils.ros.msg_conversion import path_to_msg
from robotics_utils.ros.params import get_ros_param
from robotics_utils.ros.transform_manager import TransformManager
from robotics_utils.skills import Outcome
from robotics_utils.spatial import DEFAULT_FRAME, Pose2D

from spot_skills.srv import (
    NameService,
    NameServiceRequest,
    NameServiceResponse,
)
from spot_skills_py.spot.spot_conversion import SPOT_FOOTPRINT

if TYPE_CHECKING:
    from robotics_utils.parallelism import ResourceManager
    from robotics_utils.perception import OccupancyGrid2D

    from spot_skills_py.spot.spot_graph_nav import SpotGraphNav
    from spot_skills_py.spot.spot_manager import SpotManager


class SpotNavigationServer(MobileRobot):
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(
        self,
        manager: SpotManager,
        graph_nav: SpotGraphNav,
        resource_manager: ResourceManager,
        occupancy_grid: OccupancyGrid2D | None = None,
    ) -> None:
        """Initialize the ROS services provided by this class.

        :param manager: SpotManager object used to control Spot through the Spot SDK
        :param graph_nav: SpotGraphNav object for GraphNav localization
        :param resource_manager: Resource manager for RPC priority
        :param occupancy_grid: Optional occupancy grid for path planning
        """
        self._manager = manager
        self._graph_nav = graph_nav
        self._resource_manager = resource_manager
        self.base_frame = "body"

        # Path planning infrastructure
        self._occupancy_grid = occupancy_grid
        self._robot_footprint = SPOT_FOOTPRINT

        # Pure pursuit configuration
        self._lookahead_distance_m = 2.0  # Look 2 m ahead on the path
        self._min_pursuit_cmd_duration_s = 3.0  # Min. duration (s) of each trajectory command
        self._max_speed_mps = 0.5  # Maximum speed (meters/second) during pure pursuit

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

        # Subscribe to a topic providing body-frame velocity commands
        self._cmd_vel_sub = rospy.Subscriber("cmd_vel", Twist, self.handle_cmd_vel, queue_size=1)

        # Publisher to visualize planned paths in RViz
        self._path_pub = rospy.Publisher("/spot/navigation/planned_path", PathMsg, queue_size=1)

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

        Uses A* path planning on the occupancy grid to find a collision-free path.

        :param initial: Robot base pose from which the plan begins
        :param goal: Target base pose to be reached by the navigation plan
        :return: Navigation plan (list of base pose waypoints), or None if no plan is found
        """
        if self._occupancy_grid is None:
            rospy.logwarn("No occupancy grid available; returning direct path.")
            return [initial, goal]

        grid_frame = self._occupancy_grid.grid.origin.ref_frame

        try:
            start_in_grid_frame = TransformManager.convert_to_frame(initial, grid_frame)
            goal_in_grid_frame = TransformManager.convert_to_frame(goal, grid_frame)
        except RuntimeError as e:
            rospy.logerr(f"Frame conversion failed during path planning: {e}")
            return None

        query = NavigationQuery(
            start_pose=start_in_grid_frame,
            goal_pose=goal_in_grid_frame,
            occupancy_grid=self._occupancy_grid,
            robot_footprint=self._robot_footprint,
        )

        rospy.loginfo("About to call plan_se2_path...")

        start_time = rospy.get_time()

        path = plan_se2_path(query)

        end_time = rospy.get_time()
        planning_duration_s = end_time - start_time

        rospy.loginfo(f"Path planning using A* took {planning_duration_s:.2f} seconds.")

        if path is None:
            rospy.logwarn(
                f"A* planner found no path from {start_in_grid_frame} to {goal_in_grid_frame}",
            )
            return None

        rospy.loginfo(f"A* planner found path with {len(path)} waypoints")

        # Publish the planned path for RViz visualization
        path_msg = path_to_msg(path)
        self._path_pub.publish(path_msg)

        return path

    def execute_navigation_plan(self, nav_plan: list[Pose2D], timeout_s: float = 60.0) -> Outcome:
        """Execute the given navigation plan using pure pursuit.

        :param nav_plan: Navigation plan of 2D base pose waypoints
        :param timeout_s: Duration (seconds) after which the plan times out (default: 60 seconds)
        :return: Boolean success indicator and explanatory message
        """
        if not nav_plan:
            return Outcome(success=False, message="Cannot execute an empty navigation plan.")

        # Initialize pure pursuit follower
        pursuit_config = PurePursuitConfig(
            lookahead_distance_m=self._lookahead_distance_m,
            goal_tolerance_m=self.close_to_goal_m,
        )
        follower = PurePursuitFollower(path=nav_plan, config=pursuit_config)

        start_time = rospy.get_time()
        iteration = 0
        max_iterations = 2000  # Safety limit

        while iteration < max_iterations:
            iteration += 1

            elapsed_s = rospy.get_time() - start_time
            if elapsed_s >= timeout_s:
                self._manager.stop_walking()
                return Outcome(
                    success=False,
                    message=f"Path following timed out after {elapsed_s:.1f} seconds.",
                )

            try:
                current_pose = self.current_base_pose
            except RuntimeError as e:
                return Outcome(success=False, message=f"Lost localization: {e}")

            # Convert to path frame for pure pursuit
            grid_frame = nav_plan[0].ref_frame
            current_in_grid = TransformManager.convert_to_frame(current_pose, grid_frame)

            # Get target from pure pursuit
            target_pose, is_complete = follower.get_target_pose(current_in_grid)

            if is_complete:
                rospy.loginfo("Pure pursuit: Reached goal")
                # Final approach to exact goal pose
                remaining_time_s = timeout_s - elapsed_s
                return self.go_to_pose(
                    base_pose=nav_plan[-1],
                    timeout_s=min(10.0, remaining_time_s),
                )

            rospy.logdebug(f"Pure pursuit target: {target_pose}.")

            # Send trajectory command to the lookahead target (non-blocking)
            max_speed_cmd_duration_s = self._lookahead_distance_m / self._max_speed_mps + 1.0
            cmd_duration_s = max(self._min_pursuit_cmd_duration_s, max_speed_cmd_duration_s)

            self._manager.send_trajectory_command(
                pose=target_pose,
                duration_s=cmd_duration_s,
                max_speed_mps=self._max_speed_mps,
            )

            rospy.sleep(0.01)

        return Outcome(success=False, message="Path following exceeded maximum iterations")

    def navigate_to_pose(self, goal_pose: Pose2D, timeout_s: float = 120.0) -> Outcome:
        """Navigate to the given target base pose using A* path planning and pure pursuit.

        Falls back to direct navigation if path planning fails.

        :param goal_pose: Target base pose for the robot
        :param timeout_s: Duration (seconds) after which navigation times out (default: 120 s)
        :return: Boolean success indicator and an outcome message
        """
        # Get current pose for path planning
        try:
            current_pose = self.current_base_pose
        except RuntimeError as e:
            return Outcome(success=False, message=f"Unable to get current pose: {e}")

        # Compute path using A* planner
        rospy.loginfo(f"Now planning a path to pose: {goal_pose}")
        nav_plan = self.compute_navigation_plan(current_pose, goal_pose)

        if nav_plan is None:
            return Outcome(success=False, message=f"Unable to plan a path to pose: {goal_pose}")

            # rospy.logwarn("Path planning failed; attempting direct navigation as fallback")
            # with self._resource_manager.priority() as got_priority:
            #     if not got_priority:
            #         rospy.logwarn(f"Navigating to pose {goal_pose} without RPC priority...")
            #     return self.go_to_pose(base_pose=goal_pose, timeout_s=timeout_s)

        # Execute the planned path using pure pursuit
        with self._resource_manager.priority() as got_priority:
            if not got_priority:
                rospy.logwarn("Executing navigation plan without RPC priority...")
            return self.execute_navigation_plan(nav_plan, timeout_s=timeout_s)

    def go_to_pose(self, base_pose: Pose2D, timeout_s: float) -> Outcome:
        """Move directly to the specified base pose and stop the robot after reaching it.

        :param base_pose: Target base pose for the robot
        :param timeout_s: Timeout (seconds) for the movement command
        :return: Boolean success indicator and an outcome message
        """
        self._manager.ensure_control(take_by_force=True)

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
