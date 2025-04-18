#!/usr/bin/env python

"""Create a node to own Spot's lease, providing a ROS interface to control Spot."""

import rospy
from spot_skills_py.spot.spot_ros_wrapper import SpotROS1Wrapper
from transform_utils.transform_manager import TransformManager


def main() -> None:
    """Start ROS service and action servers requiring the lease to control Spot."""
    TransformManager.init_node("spot_wrapper_node")
    _ = SpotROS1Wrapper()

    rospy.spin()


if __name__ == "__main__":
    main()
