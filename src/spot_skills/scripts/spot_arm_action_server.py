#!/usr/bin/env python

"""Create an action server to control Spot's arm using a joint trajectory."""

import rospy
import std_msgs.msg

from spot_skills.follow_trajectory_server import SpotFollowJointTrajectoryServer
from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_arm_controller import SpotArmController
from spot_skills.spot_manager import SpotManager


def robot_ready_callback() -> None:
    """Create the action server for Spot's arm once the robot is ready.

    This function is assigned as a callback on the "spot/robot_ready" ROS topic.
    """
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


def main() -> None:
    """Wait to create the action server until notified that Spot is ready."""
    rospy.init_node("spot_follow_joint_trajectory")

    ready_sub = rospy.Subscriber(
        "spot/robot_ready",
        std_msgs.msg.Bool,
        robot_ready_callback,
    )

    rospy.spin()


if __name__ == "__main__":
    main()
