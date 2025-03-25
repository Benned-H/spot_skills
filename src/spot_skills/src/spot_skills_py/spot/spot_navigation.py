"""Define a class to manage navigation services for Spot."""

from __future__ import annotations

import rospy
from actionlib import GoalStatus, SimpleActionClient
from geometry_msgs.msg import PoseStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal

from spot_skills.srv import (
    NavigateToLandmark,
    NavigateToLandmarkRequest,
    NavigateToLandmarkResponse,
    NavigateToPose,
    NavigateToPoseRequest,
    NavigateToPoseResponse,
)


class SpotNavigationServer:
    """A wrapper for ROS services controlling Spot's navigation."""

    def __init__(self) -> None:
        """Initialize the ROS services provided by this class."""
        self._nav_to_pose_srv = rospy.Service(
            "/spot/navigate_to_pose",
            NavigateToPose,
            self.handle_pose,
        )

        self._nav_to_landmark_srv = rospy.Service(
            "/spot/navigate_to_landmark",
            NavigateToLandmark,
            self.handle_landmark,
        )

        self._move_base_client = SimpleActionClient("move_base", MoveBaseAction)

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
        # TODO: Lookup pose imported from YAML
        pose_msg = PoseStamped()
        success, message = self.navigate_to_pose(pose_msg)

    def navigate_to_pose(self, pose_msg: PoseStamped, timeout_s: float) -> tuple[bool, str]:
        """Control Spot to navigate to the given pose (treated as if it were 2D).

        :param pose_msg: ROS message representing a target body pose for Spot
        :param timeout_s: Duration (seconds) after which the action will time out
        :return: Boolean indicating success (True) or failure (False) and a string message
        """
        duration_timeout = rospy.Duration.from_sec(timeout_s)

        action_goal = MoveBaseGoal(target_pose=pose_msg)
        self._move_base_client.send_goal_and_wait(action_goal, execute_timeout=duration_timeout)

        result_state = self._move_base_client.get_state()
        result_text = self._move_base_client.get_goal_status_text()

        if result_state != GoalStatus.SUCCEEDED:
            rospy.loginfo(f"MoveBase failed with state {result_state} and text '{result_text}'.")

            # TODO: If sufficiently close to goal, use SDK to try to reach it
            # Otherwise, exit with failure

        # Use the Spot SDK for fine-grained control
        # TODO: Where is `go_to_pose2` being used? Why aren't we using that directly?

        # TODO: Continue with integration
