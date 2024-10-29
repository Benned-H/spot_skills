"""Define a class providing a minimal ROS 1 interface to the Spot robot."""

import rospy
import std_srvs.srv
from actionlib import SimpleActionServer
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryActionGoal,
    FollowJointTrajectoryActionResult,
)

from spot_skills.joint_trajectory import JointTrajectory
from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_arm_controller import ArmCommandOutcome, SpotArmController
from spot_skills.spot_manager import SpotManager


class SpotROS1Wrapper:
    """A ROS 1 interface for the Spot robot."""

    def __init__(self) -> None:
        """Initialize the ROS interface by creating an internal SpotManager."""
        spot_ros_params = ["/spot/hostname", "/spot/username", "/spot/password"]
        spot_hostname, spot_username, spot_password = get_ros_params(spot_ros_params)

        self._manager = SpotManager(
            client_name="SpotROS1Manager",
            hostname=spot_hostname,
            username=spot_username,
            password=spot_password,
        )

        max_segment_len = 30  # Limit the points/segment in ArmController trajectories
        self._arm_controller = SpotArmController(self._manager, max_segment_len)
        self._arm_locked = True  # Begin without ROS control of Spot's arm

        self._manager.log_info("Manager and ArmController created. Taking lease...")
        self._manager.take_control()

        # Initialize all ROS services provided by the class
        self._stand_service = rospy.Service(
            "spot/stand",
            std_srvs.srv.Trigger,
            self.handle_stand,
        )

        self._unlock_arm_service = rospy.Service(
            "spot/unlock_arm",
            std_srvs.srv.Trigger,
            self.handle_unlock_arm,
        )

        self._stow_arm_service = rospy.Service(
            "spot/stow_arm",
            std_srvs.srv.Trigger,
            self.handle_stow_arm,
        )

        # Initialize all ROS action servers provided by the class
        self._arm_action_name = "spot_arm_controller/follow_joint_trajectory"
        self._arm_action_server = SimpleActionServer(
            self._arm_action_name,
            FollowJointTrajectoryAction,
            execute_cb=self.arm_action_callback,
            auto_start=False,
        )
        self._arm_action_server.start()
        rospy.loginfo(f"[{self._arm_action_name}] Action server has started.")

    def shutdown(self) -> None:
        """Shut-down the ROS wrapper to Spot by safely powering off Spot."""
        self._manager.shutdown()  # TODO: Don't stow the arm if holding something!

    def handle_stand(
        self,
        request_msg: std_srvs.srv.TriggerRequest,
    ) -> std_srvs.srv.TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param      request_msg     Message representing a request for Spot to stand

        :returns    Response conveying whether Spot has successfully stood up
        """
        del request_msg
        self._manager.stand_up(20)
        return std_srvs.srv.TriggerResponse(True, "Spot is now standing.")

    def handle_unlock_arm(
        self,
        request_msg: std_srvs.srv.TriggerRequest,
    ) -> std_srvs.srv.TriggerResponse:
        """Handle a service request to enable ROS control of Spot's arm.

        :param      request_msg     Message representing a request to unlock Spot's arm

        :returns    Response conveying that Spot's arm has been unlocked
        """
        del request_msg
        self._arm_locked = False
        return std_srvs.srv.TriggerResponse(True, "Spot's arm is now unlocked.")

    def handle_stow_arm(
        self,
        request_msg: std_srvs.srv.TriggerRequest,
    ) -> std_srvs.srv.TriggerResponse:
        """Handle a service request to stow Spot's arm.

        TODO: If Spot is believed to be holding something, prevent stowing.

        :param      request_msg     Message representing a request to stow Spot's arm

        :returns    Response conveying whether Spot's arm has been stowed
        """
        del request_msg
        stow_arm = not self._arm_locked

        if stow_arm:
            self._manager.stow_arm()
            message = "Spot's arm has been stowed."
        else:
            message = "Spot's arm was not stowed because Spot's arm remains locked."

        return std_srvs.srv.TriggerResponse(stow_arm, message)

    def arm_action_callback(self, goal: FollowJointTrajectoryActionGoal) -> None:
        """Handle a new goal for the FollowJointTrajectory action server.

        If Spot's arm is unlocked, trajectories sent to this server will be executed.

        Reference: https://tinyurl.com/FollowJointTrajectory

        :param      goal        Joint trajectory to be followed
        """
        # Extract all fields of the received action goal message
        trajectory = JointTrajectory.from_ros_msg(goal.trajectory)

        # TODO: Could use the joint tolerances to enforce within-bounds trajectory
        #   execution. Similar logic would allow the action server to publish feedback.
        # Currently, we're ignoring these variables in the received trajectory:
        #   path_tolerance, goal_tolerance, goal_time_tolerance

        # Log information about the received trajectory
        first_rel_time_s = trajectory.points[0].time_from_start_s
        last_rel_time_s = trajectory.points[-1].time_from_start_s
        traj_duration_s = last_rel_time_s - first_rel_time_s

        rospy.loginfo(
            f"[{self._arm_action_name}] Received trajectory of length "
            f"{len(trajectory.points)}, lasting {traj_duration_s} seconds.",
        )

        # Attempt to send the trajectory using the SpotArmController
        outcome = self._arm_controller.command_trajectory(
            trajectory,
            self._arm_action_server,
        )

        # Update the ROS action server based on the outcome of the trajectory
        if outcome == ArmCommandOutcome.SUCCESS:
            result = FollowJointTrajectoryActionResult(outcome, "Success!")
            self._arm_action_server.set_succeeded(result)

        elif outcome == ArmCommandOutcome.INVALID_START:
            result = FollowJointTrajectoryActionResult(
                -1,  # Represents INVALID_GOAL error code
                (
                    "Trajectory could not be executed because it did not begin "
                    "from the current configuration of Spot's arm."
                ),
            )
            self._arm_action_server.set_aborted(result)

        elif outcome == ArmCommandOutcome.ARM_LOCKED:
            result = FollowJointTrajectoryActionResult(
                -1,  # Represents INVALID_GOAL error code
                ("Trajectory could not be executed because Spot's arm remains locked."),
            )
            self._arm_action_server.set_aborted(result)

        elif outcome == ArmCommandOutcome.PREEMPTED:
            self._arm_action_server.set_preempted()
