#!/usr/bin/env python

"""Define a multiplexer for robot joint states during planning and execution time."""

from __future__ import annotations

import rospy
from sensor_msgs.msg import JointState
from std_msgs.msg import String
from transform_utils.kinematics import Configuration

from spot_skills.srv import SetJointStateMode, SetJointStateModeRequest, SetJointStateModeResponse
import pdb

class JointStateMux:
    """A multiplexer for robot joint states."""

    def __init__(self) -> None:
        """Initialize the multiplexer by setting up relevant subscribers and services."""
        print('Initializing node')
        rospy.loginfo('Initializing node')
        rospy.init_node("joint_state_mux")

        self.valid_modes = ["planning", "real_execution", "sim_execution"]
        
        print('Getting rospyparams')
        rospy.loginfo('Getting rospy params')
        # Required ROS parameter: joint_state_mux/default_mode
        self.mode: str = rospy.get_param("~default_mode")
        print('Getting other params')
        self.real_execution_topic = rospy.get_param("real_joint_states_topic")
        self.sim_execution_topic = rospy.get_param("sim_joint_states_topic")
        self.planning_topic = rospy.get_param("planned_joint_states_topic")
        self.output_topic = rospy.get_param("joint_mux_output_topic")

        #NOTE: sr code
        self.all_joints = ["front_left_hip_x",
    "front_left_hip_y",
    "front_left_knee",
    "front_right_hip_x",
    "front_right_hip_y",
    "front_right_knee",
    "rear_left_hip_x",
    "rear_left_hip_y",
    "rear_left_knee",
    "rear_right_hip_x",
    "rear_right_hip_y",
    "rear_right_knee", 'arm_sh0', 'arm_sh1', 'arm_el0', 'arm_el1', 'arm_wr0', 'arm_wr1','arm_f1x']
        
        print('Setting up subscribers')
        rospy.loginfo('Setting up subscribers')
        # Subscribe to the multiplexed joint state topics
        rospy.Subscriber(self.real_execution_topic, JointState, self.real_execution_callback)
        rospy.Subscriber(self.sim_execution_topic, JointState, self.sim_execution_callback)
        rospy.Subscriber(self.planning_topic, JointState, self.planning_callback)

        print('Publisher')
        rospy.loginfo('Publisher')
        # Publisher for the joint states that MoveIt actually listens to
        self.pub = rospy.Publisher(self.output_topic, JointState, queue_size=10, latch=True)
        self.mode_pub = rospy.Publisher("~current_mode", String, queue_size=5)

        self._pub_rate_hz = 10.0  # Frequency (Hz) at which joint state is republished

        # Define a map from joint state sources to their latest data
        self.latest_joint_states: dict[str, JointState] = {mode:JointState(name=self.all_joints) for mode in self.valid_modes}

        for msg in self.latest_joint_states.values():
            msg.position = [0.0] * len(msg.name)
            msg.velocity = [0.0] * len(msg.name)
            msg.effort = [0.0] * len(msg.name)

        print('Creating rospy service')
        rospy.loginfo('Creating rospy service')
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
        print("PUBLISH MODE")
        rospy.loginfo("PUBLISH MODE")
        msg = String(data=self.mode)
        self.mode_pub.publish(msg)

    def planning_callback(self, msg: JointState) -> None:
        """Process a joint state message from the planning-mode topic.

        :param msg: sensor_msgs/JointState message representing a robot configuration
        """
        name_to_index = {name: i for i, name in enumerate(msg.name)}
        
        for joint in msg.name:
            if joint in self.latest_joint_states["planning"].name:
                idx = name_to_index[joint]
                latest_idx = self.latest_joint_states["planning"].name.index(joint)
                self.latest_joint_states["planning"].position[latest_idx] = msg.position[idx]

    def real_execution_callback(self, msg: JointState) -> None:
        """Process a joint state message from the real-robot execution-mode topic.

        :param msg: sensor_msgs/JointState message representing a robot configuration
        """

        name_to_index = {name: i for i, name in enumerate(msg.name)}
        
        for joint in msg.name:
            if joint in self.latest_joint_states["real_execution"].name:
                idx = name_to_index[joint]
                latest_idx = self.latest_joint_states["real_execution"].name.index(joint)
                self.latest_joint_states["real_execution"].position[latest_idx] = msg.position[idx]

        # self.latest_joint_states["real_execution"] = msg

    def sim_execution_callback(self, msg: JointState) -> None:
        """Process a joint state message from the simulated execution-mode topic.

        :param msg: sensor_msgs/JointState message representing a robot configuration
        """
        name_to_index = {name: i for i, name in enumerate(msg.name)}
        
        for joint in msg.name:
            if joint in self.latest_joint_states["sim_execution"].name:
                idx = name_to_index[joint]
                latest_idx = self.latest_joint_states["sim_execution"].name.index(joint)
                self.latest_joint_states["sim_execution"].position[latest_idx] = msg.position[idx]

        
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
        print("RATE:")
        print(rate_hz)
        rospy.loginfo("RATE:")
        rospy.loginfo(rate_hz)
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
