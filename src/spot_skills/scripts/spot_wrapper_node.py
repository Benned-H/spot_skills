#!/usr/bin/env python

"""Create a node to own Spot's lease, providing a ROS interface to control Spot."""

import rospy
from spot_skills_py.spot.spot_ros_wrapper import SpotROS1Wrapper


def main() -> None:
    """Start ROS service and action servers requiring the lease to control Spot."""
    rospy.init_node("spot_wrapper_node")
    ros_wrapper = SpotROS1Wrapper(take_control=True)

    rospy.on_shutdown(ros_wrapper.shutdown)
    rospy.spin()


if __name__ == "__main__":
    main()
