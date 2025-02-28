#!/usr/bin/env python3

import time
from geometry_msgs.msg import Transform, Pose
from geometry_msgs.msg import PoseStamped, TransformStamped
from spot_skills.srv import NavigateToPoseRequest, NavigateToPoseResponse, NavigateToPose
import actionlib
from typing import Union
import rospy
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
import tf
import numpy as np

import tf2_ros



def goal_reached(
        curr_pose: Union[Pose, Transform], goal_pose: Union[Pose, Transform], 
        position_threshold: float = 0.1, 
        orientation_threshold: float = 0.1
    ):
    point1 = curr_pose.position if isinstance(curr_pose, Pose) else curr_pose.translation
    point2 = goal_pose.position if isinstance(goal_pose, Pose) else goal_pose.translation
    pose_xy = [point1.x, point1.y]
    goal_xy = [point2.x, point2.y]
    is_position_close = np.isclose(pose_xy, goal_xy, atol=position_threshold).all()
    
    q = curr_pose.orientation if isinstance(curr_pose, Pose) else curr_pose.rotation
    goal_q = goal_pose.orientation if isinstance(goal_pose, Pose) else goal_pose.rotation
    q1 = [q.x, q.y, q.z, q.w]
    q2 = [goal_q.x, goal_q.y, goal_q.z, goal_q.w]
    dot_product = np.dot(q1, q2)
    is_orientation_close = (dot_product > (1.0 - orientation_threshold))

    rospy.logdebug("distance:", np.abs(np.subtract(pose_xy, goal_xy)), "angle dot prod:", dot_product)

    return is_position_close and is_orientation_close


class NavigationServer:
    def __init__(self):
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)

        self.has_task = False
        self.curr_task_id = None

        self._sdk_go_to_topic = rospy.Publisher(
            "go_to_pose2",
            PoseStamped,
            queue_size=1
        )
        self._move_base_client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        
        self._navigate_to_pose_srv = rospy.Service(
            'navigate_to_pose',
            NavigateToPose,
            self.handle_navigate_to
        )


    def handle_navigate_to(self, request_msg: NavigateToPoseRequest) -> NavigateToPoseResponse:
        """
        Handle navigation to a goal.

        Returns feedback of whether the action is successful
        """
        print("received message to navigate to")
        pose = request_msg.target_base_pose
        
        # credit: chatgpt
        # Wait for the action server to start
        self._move_base_client.wait_for_server()
        rospy.loginfo("Connected to move_base action server")

        # Create a goal to send to the action server
        goal = MoveBaseGoal()

        # Set the goal position and orientation (pose)
        goal.target_pose.header.stamp = rospy.Time.now() + rospy.Duration(10.0)
        goal.target_pose.header.frame_id = "map"  # You can change this frame if needed

        # Specify the position
        goal.target_pose = pose
        # Send the goal to move_base
        rospy.loginfo("Sending goal to move_base...")
        self._move_base_client.send_goal(goal)

        # Wait for the result of the action
        self._move_base_client.wait_for_result()

        # Check if the goal was reached successfully in move_base. if not, return.
        if not self._move_base_client.get_state() == actionlib.GoalStatus.SUCCEEDED:
            rospy.loginfo("The robot failed to move to the goal.")
            return NavigateToPoseResponse(
                success=False, message="Movebase failed to move to the destination"
            )
        rospy.loginfo("The robot has successfully moved to the goal using move_base.")

        # fine-grained control using /spot/go_to_pose
        self._sdk_go_to_topic.publish(pose)
        begin_time = time.time()
        while rospy.Time() < request_msg.target_base_pose.header.stamp and time.time() - begin_time < 5:
            time.sleep(0.1)
            curr_transform: TransformStamped = self.tf_buffer.lookup_transform(
                "base_link", "map", rospy.Time(0))
            if goal_reached(curr_transform.transform, request_msg.target_base_pose.pose):
                return NavigateToPoseResponse(
                    success=True, message="Spot reached the goal."
                )
            # elif False:
            #     pass
            # print("goal not reached yet. Dist:", 
            #         np.linalg.norm(np.array([curr_transform.transform.translation.x, curr_transform.transform.translation.y]) - 
            #         np.array([pose.pose.position.x, pose.pose.position.y])))
        
        # TODO cancel go to pose
        return NavigateToPoseResponse(
            success=False, message="Timed out."
        )


if __name__ == "__main__":
    node = rospy.init_node("spot_navigation_server")
    server = NavigationServer()
    rospy.loginfo("Spot Navigation server is ready.")
    rospy.spin()
