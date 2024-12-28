"""Implement a fake controller for the gripper of a simulated robot."""

from __future__ import annotations

import sys

import numpy as np
import rospy
from actionlib import SimpleActionServer
from control_msgs.msg import GripperCommandAction, GripperCommandGoal, GripperCommandResult
from moveit_commander import MoveGroupCommander, RobotCommander, roscpp_initialize
from sensor_msgs.msg import JointState


class FakeGripperActionServer:
    """An action server for controlling the gripper of a simulated robot."""

    def __init__(self) -> None:
        """Initialize the action server using actionlib."""
        self._server = SimpleActionServer(
            "/gripper_controller/gripper_action",
            GripperCommandAction,
            self.execute_command,
            auto_start=False,
        )
        self._server.start()

        roscpp_initialize(sys.argv)
        self._move_group = MoveGroupCommander("gripper", wait_for_servers=180)

        self._gripper_joint_name = "arm_f1x"  # Single joint in the move group

        robot: RobotCommander = RobotCommander()
        joint_model = robot.get_joint(self._gripper_joint_name)
        min_bound_rad, max_bound_rad = joint_model.bounds()

        self._joint_min_rad = min_bound_rad
        self._joint_max_rad = max_bound_rad
        self._wiggle_room_rad = 0.1

    def execute_command(self, goal: GripperCommandGoal) -> None:
        """Simulate the execution of the given gripper command by logging its data to ROS."""
        position = goal.command.position
        max_effort = goal.command.max_effort

        rospy.loginfo(f"Received gripper command: position={position}, max-effort={max_effort}")

        if position < self._joint_min_rad:  # Add wiggle room on joint limits
            if np.abs(position - self._joint_min_rad) > self._wiggle_room_rad:
                return
            position = self._joint_min_rad

        if position > self._joint_max_rad:
            if np.abs(position - self._joint_max_rad) > self._wiggle_room_rad:
                return
            position = self._joint_max_rad

        joint_goal = JointState()
        joint_goal.name.append("arm_f1x")  # Single joint in the move group
        joint_goal.position.append(position)

        self._move_group.go(joint_goal, wait=True)
        self._move_group.stop()

        result = GripperCommandResult()
        self._server.set_succeeded(result)


if __name__ == "__main__":
    rospy.init_node("fake_gripper_action_server")
    server = FakeGripperActionServer()
    rospy.spin()
