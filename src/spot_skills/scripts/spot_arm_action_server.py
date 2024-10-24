#!/usr/bin/env python

"""Provide an action server to control Spot's arm using a joint trajectory."""

import rospy
import std_msgs.msg

from spot_skills.follow_trajectory_server import SpotFollowJointTrajectoryServer
from spot_skills.ros_utilities import BoolCallbackWrapper, get_ros_params
from spot_skills.spot_arm_controller import SpotArmController
from spot_skills.spot_manager import SpotManager


def main() -> None:
    """Create a ROS node for the action server once Spot is ready, then spin."""
    rospy.init_node("spot_follow_joint_trajectory")

    # Wait for the signal that Spot is ready to be controlled
    wait_for_bool = BoolCallbackWrapper("spot/robot_ready")
    loop_rate = rospy.Rate(5)  # Loop at 5 Hz

    while not (rospy.is_shutdown() or wait_for_bool.received_true):
        loop_rate.sleep()

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

    spot_manager.log_info("Manager and ArmController now created.")

    _ = SpotFollowJointTrajectoryServer(rospy.get_name(), arm_controller)

    rospy.on_shutdown(spot_manager.shutdown)
    rospy.spin()


if __name__ == "__main__":
    main()
