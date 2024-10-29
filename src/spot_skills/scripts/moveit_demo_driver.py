#!/usr/bin/env python

"""Send ROS service requests to drive the MoveIt demo."""

import rospy

from spot_skills.ros_utilities import trigger_service


def main() -> None:
    """Set up the robot to conduct the real-world MoveIt-Spot demo."""
    rospy.init_node("moveit_demo_driver")

    # First, request that Spot stands up
    trigger_service("spot/stand")

    # Then, permit ROS control of Spot's arm (i.e., begin executing motion plans)
    trigger_service("spot/unlock_arm")

    rospy.spin()


if __name__ == "__main__":
    main()
