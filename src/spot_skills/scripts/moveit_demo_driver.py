#!/usr/bin/env python

"""Initialize and shut-down the real robot for the MoveIt demo."""

import rospy
import std_msgs.msg

from spot_skills.ros_utilities import get_ros_params
from spot_skills.spot_manager import SpotManager


def main() -> None:
    """Set up the robot to conduct the real-world MoveIt-Spot demo."""
    rospy.init_node("moveit_demo_driver")
    ready_pub = rospy.Publisher("spot/robot_ready", std_msgs.msg.Bool, queue_size=1)

    # Use a Spot manager to power on and stand up Spot
    spot_ros_params = ["/spot/username", "/spot/password", "/spot/hostname"]
    spot_username, spot_password, spot_hostname = get_ros_params(spot_ros_params)

    spot_manager = SpotManager(
        client_name="MoveItDemoDriver",
        hostname=spot_hostname,
        username=spot_username,
        password=spot_password,
    )
    spot_manager.take_control()  # Take lease and ensure Spot is powered on
    spot_manager.stand_up(20)
    spot_manager.deploy_arm()
    spot_manager.release_control()

    # Alert the action server that the physical robot is ready
    ready_msg = std_msgs.msg.Bool(data=True)
    ready_pub.publish(ready_msg)

    # Set up a shutdown hook and then spin (maintains ROS node topology for debugging)
    rospy.on_shutdown(spot_manager.shutdown)
    rospy.spin()


if __name__ == "__main__":
    main()
