"""Define a class encapsulating the GraphNav service on the Spot robot."""

from __future__ import annotations

import contextlib
import time

from bosdyn.api.graph_nav import graph_nav_pb2
from bosdyn.client.exceptions import ResponseError
from bosdyn.client.math_helpers import Quat, SE3Pose
from robotics_utils.kinematics import Pose2D
from robotics_utils.ros import TransformManager

from spot_skills_py.spot.spot_manager import SpotManager


class SpotGraphNav:
    """An interface for the GraphNav service on Spot."""

    def __init__(self, manager: SpotManager) -> None:
        """Initialize the GraphNav interface by storing a SpotManager instance."""
        self._manager = manager

    def check_localized(self) -> bool:
        """Check whether Spot is currently localized using GraphNav."""
        with contextlib.suppress(Exception):
            localization_state = self._manager.graph_nav_client.get_localization_state()
            return bool(localization_state.localization.waypoint_id)

        return False

    def check_finished(self, command_id: int | None) -> bool:
        """Check whether the specified graph navigation command has finished."""
        if command_id is None:
            return False

        with contextlib.suppress(Exception):
            status = self._manager.graph_nav_client.navigation_feedback(command_id).status
            return status in {
                graph_nav_pb2.NavigationFeedbackResponse.STATUS_REACHED_GOAL,
                graph_nav_pb2.NavigationFeedbackResponse.STATUS_LOST,
                graph_nav_pb2.NavigationFeedbackResponse.STATUS_STUCK,
                graph_nav_pb2.NavigationFeedbackResponse.STATUS_ROBOT_IMPAIRED,
            }

        return False

    def navigate_to_pose(self, target_pose: Pose2D, timeout_s: float = 30.0) -> tuple[bool, str]:
        """Navigate to the given base pose using GraphNav.

        :param target_pose: Target base pose for navigation
        :param timeout_s: Duration (seconds) after which navigation times out, defaults to 30 s
        :return: Tuple containing Boolean success and an outcome message
        """
        if not self._manager.ensure_control(take_by_force=False):
            return False, "SpotManager doesn't have control of the robot."

        if not self.check_localized():
            return False, "Could not get localization state from Spot."

        target_pose = TransformManager.convert_to_frame(target_pose, target_frame="seed").to_2d()

        quat = Quat.from_yaw(target_pose.yaw_rad)
        target_se3_pose = SE3Pose(x=target_pose.x, y=target_pose.y, z=0, rot=quat)
        target_proto = target_se3_pose.to_proto()

        nav_to_cmd_id: int | None = None
        is_finished = False
        end_time = time.time() + timeout_s

        self._manager.log_info(f"Starting GraphNav navigation to: {target_pose}")

        while not is_finished and time.time() < end_time:
            try:
                nav_to_cmd_id = self._manager.graph_nav_client.navigate_to_anchor(
                    target_proto,
                    cmd_duration=1.0,
                    command_id=nav_to_cmd_id,
                )
            except ResponseError as re:
                return False, f"Error during navigation: {re}"

            time.sleep(0.5)  # Sleep for half a second to allow for command execution

            # Poll the robot for feedback to determine if the navigation command is complete
            is_finished = self.check_finished(nav_to_cmd_id)

        if not is_finished:
            return False, f"Navigation timed out after {timeout_s} seconds."

        if nav_to_cmd_id is not None:  # Check the final status of the navigation
            status = self._manager.graph_nav_client.navigation_feedback(nav_to_cmd_id).status
            if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_REACHED_GOAL:
                return True, "Successfully completed graph navigation!"
            if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_LOST:
                return False, "Robot got lost during navigation."
            if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_STUCK:
                return False, "Robot got stuck during navigation."
            if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_ROBOT_IMPAIRED:
                return False, "Robot is impaired."
            return False, f"Navigation command did not complete successfully (status {status})"

        return False, "Navigation failed for unknown reason."
