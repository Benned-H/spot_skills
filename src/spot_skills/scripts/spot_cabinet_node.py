#!/usr/bin/env python

"""Define a ROS node to execute an 'Open Cabinet' trajectory on Spot."""

import rospy
from spot_skills_py.spot.spot_trajectory_replay import SpotTrajReplay
from transform_utils.transform_manager import TransformManager


def main() -> None:
    """Create a SpotTrajReplay instance and then spin."""
    TransformManager.init_node("spot_cabinet_node")

    _ = SpotTrajReplay()

    rospy.spin()


if __name__ == "__main__":
    main()
