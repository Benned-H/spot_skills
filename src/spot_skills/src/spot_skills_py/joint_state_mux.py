"""Define a multiplexer for robot joint states during planning and execution."""

import rospy
from sensor_msgs.msg import JointState
from std_msgs.msg import String
from transform_utils.kinematics import Configuration
from transform_utils.kinematics_ros import config_to_joint_state_msg

from spot_skills.srv import SetJointStateMode, SetJointStateModeRequest, SetJointStateModeResponse


class JointStateMux:
    """A multiplexer for robot joint states."""

    def __init__(self) -> None:
        """Initialize the multiplexer by setting up relevant subscribers and services."""
        self.valid_modes = ["real_execution", "sim_execution", "tamp"]

        rospy.loginfo("Loading rosparams in JointStateMux...")
        self.real_execution_topic = rospy.get_param("real_joint_states_topic")
        self.sim_execution_topic = rospy.get_param("sim_joint_states_topic")
        self.tamp_topic = rospy.get_param("tamp_joint_states_topic")
        self.output_topic = rospy.get_param("joint_mux_output_topic")

        self._mode = self.find_default_mode()  # Look up the default mode from ROS params

        # Subscribe to the multiplexed joint state topics
        rospy.Subscriber(
            self.real_execution_topic,
            JointState,
            self.joint_state_callback,
            callback_args="real_execution",
        )

        rospy.Subscriber(
            self.sim_execution_topic,
            JointState,
            self.joint_state_callback,
            callback_args="sim_execution",
        )

        rospy.Subscriber(
            self.tamp_topic,
            JointState,
            self.joint_state_callback,
            callback_args="tamp",
        )

        # Publisher for the multiplexed joint states
        self.pub = rospy.Publisher(self.output_topic, JointState, queue_size=10, latch=True)
        self.mode_pub = rospy.Publisher("~current_mode", String, queue_size=5)
        self._pub_rate_hz = 10.0  # Frequency (Hz) at which joint state is republished

        # Define a map from joint state modes to their latest configurations
        self.latest_configs: dict[str, Configuration] = {mode: {} for mode in self.valid_modes}

        # Provide a ROS service to switch modes
        self.service = rospy.Service("set_joint_mode", SetJointStateMode, self.handle_set_mode)
        rospy.loginfo(f"JointStateMux initialized in '{self._mode}' mode.")

    @classmethod
    def find_default_mode(cls) -> str:
        """Identify the joint_state_mux default mode based on the available ROS parameters.

        :return: String specifying the identified mode (e.g., "real_execution")
        """
        give_tamp_control = bool(rospy.get_param("~actively_running_tamp"))
        if give_tamp_control:
            return "tamp"

        real_robot = bool(rospy.get_param("~real_robot"))
        return "real_execution" if real_robot else "sim_execution"

    def publish_state(self) -> None:
        """Publish the current joint state according to the multiplexer's current mode."""
        curr_config = self.latest_configs.get(self._mode)

        if curr_config is None:
            error = f"Current joint state mode '{self._mode}' has no available configuration!"
            raise KeyError(error)

        if not curr_config:
            rospy.loginfo(f"Current joint state mode '{self._mode}' has an empty joint state.")
            return

        curr_joint_state = config_to_joint_state_msg(curr_config)
        self.pub.publish(curr_joint_state)

    def publish_mode(self) -> None:
        """Publish the current mode of the joint state multiplexer."""
        msg = String(data=self._mode)
        self.mode_pub.publish(msg)

    def joint_state_callback(self, msg: JointState, relevant_mode: str) -> None:
        """Process a joint state message from the topic of the named mode.

        :param msg: ROS message containing new joint state data
        :param relevant_mode: Name of the mode corresponding to the message data
        """
        if relevant_mode not in self.latest_configs:
            error = f"Unrecognized joint state mode: '{relevant_mode}'."
            raise ValueError(error)

        # Populate the given joint positions into the relevant mode's stored configuration
        for joint_name, joint_position in zip(msg.name, msg.position):
            self.latest_configs[relevant_mode][joint_name] = joint_position

    def handle_set_mode(self, request: SetJointStateModeRequest) -> SetJointStateModeResponse:
        """Handle a request to set the mode of the joint state multiplexer.

        :param request: ROS message containing a string naming the new mode
        :return: Response message indicating whether or not the request succeeded
        """
        if request.new_mode not in self.valid_modes:
            message = f"Cannot set joint state mode to unrecognized mode: '{request.new_mode}'."
            return SetJointStateModeResponse(success=False, message=message)

        self._mode = request.new_mode
        success = self._mode == request.new_mode
        message = f"Switched joint state mode to '{self._mode}'."
        rospy.loginfo(message)

        return SetJointStateModeResponse(success=success, message=message)

    def spin(self) -> None:
        """Continually republish the joint state when not handling messages or service requests."""
        rate_hz = rospy.Rate(self._pub_rate_hz)
        while not rospy.is_shutdown():
            self.publish_state()
            self.publish_mode()
            rate_hz.sleep()
