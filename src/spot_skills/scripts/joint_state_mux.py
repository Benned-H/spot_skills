#!/usr/bin/env python

"""Define a multiplexer for robot joint states during planning and execution time."""

from __future__ import annotations

import rospy
from sensor_msgs.msg import JointState
from std_msgs.msg import String

from spot_skills.srv import SetJointStateMode, SetJointStateModeRequest, SetJointStateModeResponse


class JointStateMux:
    """A multiplexer for robot joint states."""

    def __init__(self) -> None:
        """Initialize the multiplexer by setting up relevant subscribers and services."""
        rospy.init_node("joint_state_mux")

        self.valid_modes = ["planning", "real_execution", "sim_execution"]

        # Required ROS parameter: joint_state_mux/default_mode
        self.mode: str = rospy.get_param("~default_mode")

        self.real_execution_topic = rospy.get_param("real_joint_states_topic")
        self.sim_execution_topic = rospy.get_param("sim_joint_states_topic")
        self.planning_topic = rospy.get_param("planned_joint_states_topic")
        self.output_topic = rospy.get_param("joint_mux_output_topic")

        # Subscribe to the multiplexed joint state topics
        rospy.Subscriber(self.real_execution_topic, JointState, self.real_execution_callback)
        rospy.Subscriber(self.sim_execution_topic, JointState, self.sim_execution_callback)
        rospy.Subscriber(self.planning_topic, JointState, self.planning_callback)

        # Publisher for the joint states that MoveIt actually listens to
        self.pub = rospy.Publisher(self.output_topic, JointState, queue_size=10, latch=True)
        self.mode_pub = rospy.Publisher("~current_mode", String, queue_size=5)

        self._pub_rate_hz = 10.0  # Frequency (Hz) at which joint state is republished

        # Define a map from joint state sources to their latest data
        self.latest_joint_states: dict[str, JointState] = {}

        # Provide a ROS service to switch modes
        self.service = rospy.Service("set_joint_mode", SetJointStateMode, self.set_mode_callback)
        rospy.loginfo(f"JointStateMux initialized in '{self.mode}' mode.")

    @property
    def mode(self) -> str:
        """Retrieve the current mode of the joint state multiplexer."""
        return self._mode

    @mode.setter
    def mode(self, new_mode: str) -> None:
        """Set the mode of the joint state multiplexer.

        :param new_mode: New mode of joint states to publish
        """
        self._mode = new_mode
        assert self._mode in self.valid_modes, f"Invalid mode: {self._mode}"

    def publish_state(self) -> None:
        """Publish the current joint state according to the multiplexer's current mode."""
        mode_joint_state = self.latest_joint_states.get(self.mode)

        if mode_joint_state is not None:
            now_stamp = rospy.Time.now()
            mode_joint_state.header.stamp = now_stamp
            rospy.loginfo(f"[JointStateMux] Publishing JointState with timestamp: {now_stamp}")

            self.pub.publish(mode_joint_state)

    def publish_mode(self) -> None:
        """Publish the current mode of the joint state multiplexer."""
        msg = String(data=self.mode)
        self.mode_pub.publish(msg)

    def planning_callback(self, msg: JointState) -> None:
        """Process a joint state message from the planning-mode topic.

        :param msg: sensor_msgs/JointState message representing a robot configuration
        """
        self.latest_joint_states["planning"] = msg

    def real_execution_callback(self, msg: JointState) -> None:
        """Process a joint state message from the real-robot execution-mode topic.

        :param msg: sensor_msgs/JointState message representing a robot configuration
        """
        self.latest_joint_states["real_execution"] = msg

    def sim_execution_callback(self, msg: JointState) -> None:
        """Process a joint state message from the simulated execution-mode topic.

        :param msg: sensor_msgs/JointState message representing a robot configuration
        """
        self.latest_joint_states["sim_execution"] = msg

    def set_mode_callback(self, request: SetJointStateModeRequest) -> SetJointStateModeResponse:
        """Handle a request to set the mode of the joint state multiplexer.

        :param request: ROS message containing a string naming the new mode
        :return: Response message indicating whether or not the request succeeded
        """
        self.mode = request.new_mode
        message = f"Switched mode to '{self.mode}'."
        rospy.loginfo(message)

        return SetJointStateModeResponse(success=True, message=message)

    def spin(self) -> None:
        """Continually republish the joint state when not handling messages or service requests."""
        rate_hz = rospy.Rate(self._pub_rate_hz)
        while not rospy.is_shutdown():
            self.publish_state()
            self.publish_mode()
            rate_hz.sleep()


if __name__ == "__main__":
    try:
        node = JointStateMux()
        node.spin()
    except rospy.ROSInterruptException:
        pass
