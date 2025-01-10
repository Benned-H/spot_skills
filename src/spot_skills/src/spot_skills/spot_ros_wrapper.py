"""Define a class providing a ROS 1 interface to the Spot robot."""

import rospy
from actionlib import SimpleActionServer
from control_msgs.msg import (
    FollowJointTrajectoryAction,
    FollowJointTrajectoryGoal,
    FollowJointTrajectoryResult,
    GripperCommandAction,
    GripperCommandGoal,
    GripperCommandResult,
)
from geometry_msgs.msg import PoseStamped
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse
from bosdyn.client import math_helpers
import tf2_ros

from spot_skills.joint_trajectory import JointTrajectory
from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_arm_controller import (
    ArmCommandOutcome,
    GripperCommandOutcome,
    SpotArmController,
)
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
            Trigger,
            self.handle_stand,
        )

        self._unlock_arm_service = rospy.Service(
            "spot/unlock_arm",
            Trigger,
            self.handle_unlock_arm,
        )

        self._stow_arm_service = rospy.Service(
            "spot/stow_arm",
            Trigger,
            self.handle_stow_arm,
        )

        self._go_to_service = rospy.Service(
            "spot/go_to_pose",
            PoseStamped,
            self.trajectory_callback
        )

        # Initialize all ROS action servers provided by the class
        self._arm_action_name = "arm_controller/follow_joint_trajectory"
        self._arm_action_server = SimpleActionServer(
            self._arm_action_name,
            FollowJointTrajectoryAction,
            execute_cb=self.arm_action_callback,
            auto_start=False,
        )
        self._arm_action_server.start()
        rospy.loginfo(f"[{self._arm_action_name}] Action server has started.")

        self._gripper_action_name = "gripper_controller/gripper_action"
        self._gripper_action_server = SimpleActionServer(
            self._gripper_action_name,
            GripperCommandAction,
            execute_cb=self.gripper_action_callback,
            auto_start=False,
        )
        self._gripper_action_server.start()
        rospy.loginfo(f"[{self._gripper_action_name}] Action server has started.")

        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)


    def shutdown(self) -> None:
        """Shut-down Spot's ROS wrapper by safely powering off Spot."""
        self._manager.shutdown()

    
    ####### BEGIN Navigation ##########
    def _transform_pose_to_body_frame(self, pose: PoseStamped) -> PoseStamped:
        """Transform a pose to the body frame.

        Args:
            pose: PoseStamped to transform

        Raises: tf2_ros.LookupException if the transform lookup fails

        Returns: Transformed pose in body frame if given pose is not in the body frame,
            or the original pose if it is in the body frame.

        """
        if pose.header.frame_id == "body":
            return pose

        body_to_fixed = self.tf_buffer.lookup_transform(
            "body",
            pose.header.frame_id,
            rospy.Time(),
        )

        pose_in_body = tf2_geometry_msgs.do_transform_pose(pose, body_to_fixed)
        pose_in_body.header.frame_id = "body"

        return pose_in_body
    
    def _send_trajectory_command(self, pose, duration, precise=True):
        """Send a trajectory command to the robot.

        Args:
            pose: Pose the robot should go to. Must be in the body frame
            duration: After this duration, the command will time out and the robot will stop
            precise: If true, the robot will position itself precisely at the target pose, otherwise it will end up
                     near (within ~0.5m, rotation optional) the requested location

        Returns: (bool, str) tuple indicating whether the command was successfully sent, and a message

        """
        if False and not self.robot_allowed_to_move():
            # TODO WYC: not implemented
            rospy.logerr("send trajectory was called but motion is not allowed.")
            return None

        if pose.header.frame_id != "body":
            rospy.logerr("Trajectory command poses must be in the body frame")
            return None

        return self._manager.trajectory_cmd(
            goal_x=pose.pose.position.x,
            goal_y=pose.pose.position.y,
            goal_heading=math_helpers.Quat(
                w=pose.pose.orientation.w,
                x=pose.pose.orientation.x,
                y=pose.pose.orientation.y,
                z=pose.pose.orientation.z,
            ).to_yaw(),
            cmd_duration=duration.to_sec(),
            precise_position=precise,
        )
    
    def trajectory_callback(self, msg: PoseStamped) -> None:
        """Handle a callback from the trajectory topic requesting to go to a location.

        The trajectory will time out after 5 seconds

        Args:
            msg: PoseStamped containing desired pose

        """
        if False and not self.robot_allowed_to_move():
            # TODO WYC: copied from the original code base and robot_allowed_to_move is not implemented
            rospy.logerr(
                "Trajectory topic received a message but the robot is not allowed to move.",
            )
            return

        try:
            self._send_trajectory_command(
                self._transform_pose_to_body_frame(msg),
                rospy.Duration(5),
            )
        except tf2_ros.LookupException as e:
            rospy.logerr(str(e))

    def handle_stand(self, request_msg: TriggerRequest) -> TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param request_msg: Message representing a request for Spot to stand

        :returns    Response conveying whether Spot has successfully stood up
        """
        del request_msg
        stood_up = self._manager.stand_up(20)
        message = "Spot is now standing." if stood_up else "Spot could not stand up."

        return TriggerResponse(stood_up, message)

    def handle_unlock_arm(self, request_msg: TriggerRequest) -> TriggerResponse:
        """Handle a service request to enable ROS control of Spot's arm.

        :param request_msg: Message representing a request to unlock Spot's arm

        :returns    Response conveying that Spot's arm has been unlocked
        """
        del request_msg
        self._arm_locked = False
        self._arm_controller.unlock_arm()

        return TriggerResponse(True, "Spot's arm is now unlocked.")

    def handle_stow_arm(self, request_msg: TriggerRequest) -> TriggerResponse:
        """Handle a service request to stow Spot's arm.

        TODO: If Spot is believed to be holding something, prevent stowing.

        :param request_msg: Message representing a request to stow Spot's arm

        :returns    Response conveying whether Spot's arm has been stowed
        """
        del request_msg

        if self._arm_locked:
            message = "Spot's arm was not stowed because Spot's arm remains locked."
            return TriggerResponse(False, message)

        success = self._manager.stow_arm()
        message = "Spot's arm has been stowed." if success else "Could not stow Spot's arm."

        return TriggerResponse(success, message)

    def arm_action_callback(self, goal: FollowJointTrajectoryGoal) -> None:
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

        result = FollowJointTrajectoryResult()
        result.error_code = -1  # Default error code: INVALID_GOAL

        # Attempt to send the trajectory using the SpotArmController
        outcome = self._arm_controller.command_trajectory(
            trajectory,
            self._arm_action_server,
        )

        # Update the ROS action server based on the outcome of the trajectory
        if outcome == ArmCommandOutcome.SUCCESS:
            result.error_code = int(outcome)
            result.error_string = "Success!"
            self._arm_action_server.set_succeeded(result)

        elif outcome == ArmCommandOutcome.INVALID_START:
            result.error_string = (
                "Could not follow trajectory because it did not begin "
                "from the current configuration of Spot's arm."
            )

            self._arm_action_server.set_aborted(result)

        elif outcome == ArmCommandOutcome.ARM_LOCKED:
            result.error_string = "Could not follow trajectory because Spot's arm remains locked."

            self._arm_action_server.set_aborted(result)

        elif outcome == ArmCommandOutcome.PREEMPTED:
            self._arm_action_server.set_preempted()

    def gripper_action_callback(self, goal: GripperCommandGoal) -> None:
        """Handle a new goal for the GripperCommandAction action server.

        If Spot's arm is unlocked, gripper commands sent to this server will be executed.

        Reference: https://docs.ros.org/en/noetic/api/control_msgs/html/action/GripperCommand.html

        :param goal: Gripper command to be executed
        """
        goal_position_rad = goal.command.position  # Ignoring goal.command.max_effort

        gripper_command_result = GripperCommandResult()

        outcome = self._arm_controller.command_gripper(goal_position_rad)

        if outcome == GripperCommandOutcome.FAILURE:
            gripper_command_result.reached_goal = False
            self._gripper_action_server.set_aborted(gripper_command_result)
        else:
            gripper_command_result.reached_goal = outcome == GripperCommandOutcome.REACHED_SETPOINT
            gripper_command_result.stalled = outcome == GripperCommandOutcome.STALLED

            self._gripper_action_server.set_succeeded(gripper_command_result)
