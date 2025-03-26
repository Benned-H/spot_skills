#!/usr/bin/env python

"""Send ROS service requests to drive the real-robot Spot-MoveIt demo."""

import time

import rospy
from transform_utils.ros.services import trigger_service


def main() -> None:
    """Set up the robot to conduct the real-world MoveIt-Spot demo."""
    rospy.init_node("spot_moveit_demo_driver")

    # First, request that Spot stands up until the service succeeds
    stood_up = False
    while not stood_up:
        stood_up = trigger_service("spot/stand")
        time.sleep(3)

    # Then, permit ROS control of Spot's arm (i.e., begin executing motion plans)
    trigger_service("spot/unlock_arm")

    rospy.spin()


if __name__ == "__main__":
    main()
