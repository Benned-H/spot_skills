#!/usr/bin/env python

"""Launch a ROS node to multiplex between different sources of joint states."""

import rospy
from spot_skills_py.joint_state_mux import JointStateMux


def main() -> None:
    """Create a JointStateMux instance and let it spin."""
    rospy.init_node("joint_state_mux")

    mux = JointStateMux()
    mux.spin()


if __name__ == "__main__":
    main()
