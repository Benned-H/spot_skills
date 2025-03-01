#!/usr/bin/env python3
import rospy

from spot_skills_py.spot_navigation import NavigationServer

if __name__ == "__main__":
    node = rospy.init_node("spot_navigation_server")
    server = NavigationServer()
    rospy.loginfo("Spot Navigation server is ready.")
    rospy.spin()
