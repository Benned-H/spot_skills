#!/usr/bin/env python

"""Provide an action server to control Spot's arm using a joint trajectory."""

import rospy

from spot_skills.follow_trajectory_server import SpotFollowJointTrajectoryServer
from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_arm_controller import SpotArmController
from spot_skills.spot_manager import SpotManager


def main() -> None:
    """Create a ROS node for the action server and then spin."""
    rospy.init_node("spot_follow_joint_trajectory")

    # Attempt to load Spot's IP, username, and password from ROS parameters
    spot_ros_params = ["/spot/hostname", "/spot/username", "/spot/password"]
    spot_hostname, spot_username, spot_password = get_ros_params(spot_ros_params)

    spot_manager = SpotManager(
        client_name="FollowJointTrajectoryServer",
        hostname=spot_hostname,
        username=spot_username,
        password=spot_password,
    )

    arm_controller = SpotArmController(spot_manager, 30)  # Limit to 30 points/segment

    server = SpotFollowJointTrajectoryServer(rospy.get_name(), arm_controller)

    rospy.spin()


if __name__ == "__main__":
    main()
