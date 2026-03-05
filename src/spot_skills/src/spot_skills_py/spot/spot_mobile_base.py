"""Define an interface used by TMP3 to control Spot's base."""

from __future__ import annotations

from robotics_utils.robots import MobileRobot
from robotics_utils.ros import ServiceCaller, TransformManager
from robotics_utils.ros.msg_conversion import pose_to_stamped_msg
from robotics_utils.skills import Outcome
from robotics_utils.spatial import DEFAULT_FRAME, Pose2D

from spot_skills.srv import NavigateToPose, NavigateToPoseRequest, NavigateToPoseResponse


class SpotMobileBase(MobileRobot):
    """A ROS-service-based interface for Spot's mobile base (for non-Spot-SDK nodes)."""

    def __init__(self, *, robot_name: str, base_frame: str) -> None:
        """Initialize the mobile base interface."""
        self.robot_name = robot_name
        self.base_frame = base_frame

        self._navigate_caller = ServiceCaller[NavigateToPoseRequest, NavigateToPoseResponse](
            "/spot/navigation/to_pose",
            NavigateToPose,
        )

    @property
    def current_base_pose(self) -> Pose2D:
        """Retrieve the robot's current base pose."""
        base_pose = TransformManager.lookup_transform(
            child_frame=self.base_frame,
            parent_frame=DEFAULT_FRAME,
        )
        if base_pose is None:
            raise RuntimeError(
                f"Unable to look up base pose (frame '{self.base_frame}') of robot '{self.robot_name}'.",
            )
        return base_pose.to_2d()

    def compute_navigation_plan(self, initial: Pose2D, goal: Pose2D) -> list[Pose2D] | None:
        """Compute a navigation plan between the two given robot base poses.

        :param initial: Robot base pose from which the plan begins
        :param goal: Target base pose to be reached by the navigation plan
        :return: Navigation plan (list of base pose waypoints), or None if no plan is found
        """
        return None  # TODO: Use the implementation to be written in SimulatedMobileBase

    def execute_navigation_plan(self, nav_plan: list[Pose2D], timeout_s: float = 60.0) -> Outcome:
        """Execute the given navigation plan on Spot.

        :param nav_plan: Navigation plan of 2D base pose waypoints
        :param timeout_s: Duration (seconds) after which the plan times out (default: 60 seconds)
        :return: Boolean success indicator and explanatory message
        """
        if not nav_plan:
            return Outcome(success=False, message="Cannot execute an empty navigation plan.")

        final_pose_3d = nav_plan[-1].to_3d()
        target_pose_msg = pose_to_stamped_msg(final_pose_3d)
        request = NavigateToPoseRequest(target_pose_msg, timeout_s)

        response = self._navigate_caller(request)
        if response is None:
            return Outcome(success=False, message="NavigateToPose response was None.")

        return Outcome(success=response.success, message=response.message)
