#!/usr/bin/env python

"""Create a ROS node to own the lease for Spot's arm and gripper."""

import rospy

from spot_skills.follow_trajectory_server import SpotFollowJointTrajectoryServer
from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_arm_controller import SpotArmController
from spot_skills.spot_manager import SpotManager


def main() -> None:
    """Start ROS action servers requiring the lease for Spot's arm and gripper."""
    rospy.init_node("spot_arm_node")

    # Attempt to load Spot's IP, username, and password from ROS parameters
    spot_ros_params = ["/spot/hostname", "/spot/username", "/spot/password"]
    spot_hostname, spot_username, spot_password = get_ros_params(spot_ros_params)

    spot_manager = SpotManager(
        client_name="SpotArmNode",
        hostname=spot_hostname,
        username=spot_username,
        password=spot_password,
    )

    arm_controller = SpotArmController(spot_manager, 30)  # Limit to 30 points/segment

    spot_manager.log_info("Manager and ArmController now created. Taking arm lease...")
    spot_manager.take_control("full-arm")

    arm_server = SpotFollowJointTrajectoryServer(rospy.get_name(), arm_controller)

    rospy.on_shutdown(spot_manager.shutdown)
    rospy.spin()


if __name__ == "__main__":
    main()
