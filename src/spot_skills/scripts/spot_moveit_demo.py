#!/usr/bin/env python

"""Send ROS service requests to drive the real-robot Spot-MoveIt demo."""

import time

import rospy
from robotics_utils.ros.services import trigger_service


def main() -> None:
    """Set up the robot to conduct the real-world MoveIt-Spot demo."""
    rospy.init_node("spot_moveit_demo_driver")

    took_control = False
    while not took_control:
        took_control = trigger_service("spot/take_control")
        if not took_control:
            rospy.logwarn("Failed to take control of Spot.")

    rospy.loginfo("Successfully took control of Spot.")

    # First, request that Spot stands up until the service succeeds
    stood_up = False
    while not stood_up:
        stood_up = trigger_service("spot/stand")
        time.sleep(3)
        if not stood_up:
            rospy.logwarn("Failed to make Spot stand.")

    # Then, permit ROS control of Spot's arm (i.e., begin executing motion plans)
    trigger_service("spot/unlock_arm")

    rospy.spin()


if __name__ == "__main__":
    main()
