"""Define a class providing a ROS interface to MoveIt motion planning."""

import rospy
import std_srvs.srv
from moveit_commander import MoveGroupCommander, PlanningSceneInterface, RobotCommander
from std_srvs.srv import Trigger as TriggerMsg
from std_srvs.srv import TriggerRequest as TriggerRequestMsg
from std_srvs.srv import TriggerResponse as TriggerResponseMsg


class MoveItWrapper:
    """A ROS interface for MoveIt motion planning."""

    def __init__(self, move_group_name: str) -> None:
        """Initialize MoveIt commanders for the specified move group.

        :param      move_group_name      Name of the move group to be controlled
        """
        self._move_group_name = move_group_name

        # RobotCommander Reference: https://tinyurl.com/noetic-robot-commander
        self._robot = RobotCommander()

        self._scene = PlanningSceneInterface()

        # MoveGroupCommander Reference: https://tinyurl.com/move-group-commander
        self._move_group = MoveGroupCommander(move_group_name, wait_for_servers=60)

        # Ensure that the move group expects poses in Spot's body frame
        self._ref_frame_name = "body"
        self._move_group.set_pose_reference_frame(self._ref_frame_name)

        # Initialize a ROS service to create motion plans given end-effector poses
        self._ee_pose_service = rospy.Service(
            "spot/plan_to_gripper_pose",
            TriggerMsg,
            self.handle_ee_pose,
        )

    def handle_ee_pose(self, request_msg: TriggerRequestMsg) -> TriggerResponseMsg:
        """Handle a service request to motion plan to the given end-effector pose.

        :param      request_msg     Message representing an end-effector command pose
        """
