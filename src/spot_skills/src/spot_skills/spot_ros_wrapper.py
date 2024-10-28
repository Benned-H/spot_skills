"""Define a class providing a minimal ROS 1 interface to the Spot robot.

References:
    https://wiki.ros.org/ROS/Tutorials/WritingServiceClient%28python%29
    https://wiki.ros.org/Services

"""

from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse

from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_arm_controller import SpotArmController
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

        self._manager.log_info("Manager and ArmController created. Taking lease...")
        self._manager.take_control()

    def shutdown(self) -> None:
        """Shut-down the ROS wrapper to Spot by safely powering off Spot."""
        self._manager.shutdown()  # TODO: Don't stow the arm if holding something!

    def handle_stand(self, request_msg: TriggerRequest) -> TriggerResponse:
        """Handle a service request to have Spot stand up.

        :param      request_msg     Message representing a request for Spot to stand

        :returns    Reponse indicating whether Spot was able to stand and why
        """
        self._manager.stand_up(20)


# TODO: arm_server = SpotFollowJointTrajectoryServer(rospy.get_name(), arm_controller)
