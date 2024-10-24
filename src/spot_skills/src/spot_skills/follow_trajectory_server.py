"""Define a control_msgs/FollowJointTrajectory action server for Spot's arm.

Reference:
https://docs.ros.org/en/noetic/api/control_msgs/html/action/FollowJointTrajectory.html
"""

from actionlib import SimpleActionServer
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryActionGoal,
    FollowJointTrajectoryActionResult,
)
from rospy import loginfo

from spot_skills.joint_trajectory import JointTrajectory
from spot_skills.spot_arm_controller import ArmCommandOutcome, SpotArmController


class SpotFollowJointTrajectoryServer:
    """An action server that controls Spot's arm to follow a trajectory."""

    def __init__(self, action_name: str, arm_controller: SpotArmController) -> None:
        """Initialize the ROS node for the FollowJointTrajectory action server.

        :param    action_name       Name used to access the action server through ROS
        :param    arm_controller    Interface used to control Spot's arm
        """
        self._action_name = action_name
        self._arm_controller = arm_controller
        self._result = None

        self._action_server = SimpleActionServer(
            self._action_name,
            FollowJointTrajectoryAction,
            execute_cb=self.execute_callback,
            auto_start=False,
        )
        self._action_server.start()

        loginfo(f"{self._action_name}: Action server has started.")

    def execute_callback(self, goal: FollowJointTrajectoryActionGoal) -> None:
        """Execute the action by controlling Spot's arm to follow the given trajectory.

        :param      goal        Joint trajectory to be followed
        """
        # Extract all fields of the received action goal message
        trajectory = JointTrajectory.from_ros_msg(goal.trajectory)

        # TODO: The ArmController could use the below joint tolerances to enforce safe
        #   execution of the trajectory, within some position/velocity tolerance.
        # The same logic would allow the server to publish feedback to its client(s)
        joint_tolerances = goal.path_tolerance
        goal_tolerance = goal.goal_tolerance
        completion_time_tolerance_s = goal.goal_time_tolerance

        # Log information about the received trajectory
        num_points = len(trajectory.points)
        first_rel_time_s = trajectory.points[0].time_from_start_s
        last_rel_time_s = trajectory[-1].time_from_start_s

        loginfo(
            f"{self._action_name}: Received trajectory of length {num_points} "
            f"lasting {last_rel_time_s - first_rel_time_s} seconds.",
        )

        # Attempt to send the trajectory using the stored SpotArmController
        outcome = self._arm_controller.command_trajectory(
            trajectory,
            self._action_server,
        )

        # Update the ROS action server based on the outcome of the trajectory
        if outcome == ArmCommandOutcome.SUCCESS:
            self._result = FollowJointTrajectoryActionResult(outcome, "Success!")
            self._action_server.set_succeeded(self._result)

        elif outcome == ArmCommandOutcome.INVALID_START:
            self._result = FollowJointTrajectoryActionResult(
                outcome,
                (
                    "Trajectory could not be executed because it did not begin "
                    "from the current configuration of Spot's arm."
                ),
            )
            self._action_server.set_aborted(self._result)

        elif outcome == ArmCommandOutcome.PREEMPTED:
            self._result = None
            self._action_server.set_preempted()
