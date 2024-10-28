#!/usr/bin/env python

"""Create a ROS node to own the lease for Spot and provide a ROS interface to Spot."""

import rospy

from spot_skills.spot_ros_wrapper import SpotROS1Wrapper


def main() -> None:
    """Start ROS service and action servers requiring the lease to control Spot."""
    rospy.init_node("spot_arm_node")
    ros_wrapper = SpotROS1Wrapper()

    rospy.on_shutdown(ros_wrapper.shutdown)
    rospy.spin()


if __name__ == "__main__":
    main()
