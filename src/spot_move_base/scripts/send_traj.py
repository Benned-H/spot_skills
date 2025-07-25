#!/usr/bin/env python3

from threading import Lock

import rospy
from geometry_msgs.msg import PoseStamped
from nav_msgs.msg import Path


class TrajectoryFollower:
    def __init__(self):
        rospy.init_node("trajectory_follower", anonymous=True)

        # Rate limiter (2 Hz = every 0.5 seconds)
        self.rate = rospy.Rate(2)

        # Lock for thread safety when updating latest_goal
        self.lock = Lock()
        self.latest_goal = None

        # Publisher for go_to_pose
        self.pose_pub = rospy.Publisher(
            "/spot/go_to_pose",
            PoseStamped,
            queue_size=1,
        )

        # Subscribe to global plan
        self.trajectory_sub = rospy.Subscriber(
            "/move_base/TrajectoryPlannerROS/global_plan",
            Path,
            self.trajectory_callback,
        )

        # Start publishing thread
        self.start_publisher()

        rospy.loginfo("Trajectory follower node initialized")

    def trajectory_callback(self, msg):
        """Callback for receiving new trajectory. Selects the 40th or last waypoint."""
        if not msg.poses:
            rospy.logwarn("Received empty trajectory")
            return

        # Select either the 40th point or the last point if trajectory is shorter
        target_index = min(60 - 1, len(msg.poses) - 1)  # 39 for 0-based indexing

        # Store the selected goal pose
        with self.lock:
            self.latest_goal = msg.poses[target_index]

        rospy.loginfo(
            f"Received trajectory with {len(msg.poses)} points. Using point {target_index + 1}"
        )

    def start_publisher(self):
        """Start a thread that publishes goals at the specified rate"""

        def publish_loop():
            while not rospy.is_shutdown():
                with self.lock:
                    if self.latest_goal is not None:
                        self.pose_pub.publish(self.latest_goal)
                self.rate.sleep()

        # Start the publishing thread
        import threading

        self.publisher_thread = threading.Thread(target=publish_loop)
        self.publisher_thread.daemon = True  # Thread will close with the program
        self.publisher_thread.start()


def main():
    try:
        follower = TrajectoryFollower()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass


if __name__ == "__main__":
    main()
