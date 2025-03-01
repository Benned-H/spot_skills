
import time
from geometry_msgs.msg import Transform, Pose
from geometry_msgs.msg import PoseStamped, TransformStamped
from spot_skills_py.obj_loc_db import ObjectLocationDB
from spot_skills.srv import NavigateToPoseRequest, NavigateToPoseResponse, NavigateToPose
from spot_skills.srv import NavigateToLandmark, NavigateToLandmarkResponse, NavigateToLandmarkRequest
import actionlib
from typing import Tuple, Union
import rospy
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from tf.transformations import quaternion_from_euler, euler_from_quaternion
import numpy as np

import tf2_ros


def get_dist(pose: Union[Pose, Transform], goal_pose: Union[Pose, Transform]):
    pose_xy = [pose.position.x, pose.position.y] if isinstance(pose, Pose) else [pose.translation.x, pose.translation.y]
    goal_xy = [goal_pose.position.x, goal_pose.position.y] if isinstance(goal_pose, Pose) else [goal_pose.translation.x, goal_pose.translation.y]

    if isinstance(pose, Pose):
        yaw_pose = euler_from_quaternion([pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w])[2]
    else:
        yaw_pose = euler_from_quaternion([pose.rotation.x, pose.rotation.y, pose.rotation.z, pose.rotation.w])[2]
    if isinstance(goal_pose, Pose):
        yaw_goal = euler_from_quaternion([goal_pose.orientation.x, goal_pose.orientation.y, goal_pose.orientation.z, goal_pose.orientation.w])[2]
    else:
        yaw_goal = euler_from_quaternion([goal_pose.rotation.x, goal_pose.rotation.y, goal_pose.rotation.z, goal_pose.rotation.w])[2]
    yaw_diff = np.abs(yaw_pose - yaw_goal) / np.pi * 180
    return np.linalg.norm(np.array(pose_xy) - np.array(goal_xy)), yaw_diff


def goal_reached(
        curr_pose: Union[Pose, Transform], goal_pose: Union[Pose, Transform], 
        position_threshold: float = 0.1, 
        orientation_threshold: float = 0.1
    ):
    dist, yaw_diff = get_dist(curr_pose, goal_pose)

    print("dist:", dist, "yaw_diff:", yaw_diff)

    return dist < 0.15 and yaw_diff < 5


class NavigationServer:
    def __init__(self, location_db: ObjectLocationDB=None):
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)

        self.has_task = False
        self.curr_task_id = None

        self._sdk_go_to_topic = rospy.Publisher(
            "/spot/go_to_pose2",
            PoseStamped,
            queue_size=1
        )
        self._move_base_client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        
        self._navigate_to_pose_srv = rospy.Service(
            '/spot/navigate_to_pose_adv',
            NavigateToPose,
            self.handle_navigate_to_pose
        )
        self._navigate_to_pose_topic = rospy.Subscriber(
            '/spot/navigate_to_pose_adv',
            PoseStamped,
            self.handle_navigate_to_pose_topic
        )

        if location_db is None:
            location_db = ObjectLocationDB()
        else:
            self.location_db = location_db


    def handle_navigate_to_landmark(self, request_msg: NavigateToLandmarkRequest) -> NavigateToLandmarkResponse:
        """
        Handle navigation to a goal.

        Returns feedback of whether the action is successful
        """
        landmark_name = request_msg.landmark_name
        print("received message to navigate to landmark", landmark_name)
        pose: Pose = self.location_db.get_object_location(landmark_name)
        pose_stamped = PoseStamped(pose=pose)
        pose_stamped.header.frame_id = "map"
        pose_stamped.header.stamp = rospy.Time.now() + rospy.Duration(10.0)
        
        # credit: chatgpt
        # Wait for the action server to start
        self._move_base_client.wait_for_server()
        rospy.loginfo("Connected to move_base action server")

        # Create a goal to send to the action server
        goal = MoveBaseGoal()

        # Set the goal position and orientation (pose)
        goal.target_pose.header.stamp = rospy.Time.now() + rospy.Duration(10.0)
        goal.target_pose.header.frame_id = "map"

        succ, msg = self.navigate_to_pose(pose_stamped)
        return NavigateToLandmarkResponse(
            success=succ,
            message=msg
        )

    def handle_navigate_to_pose_topic(self, msg: PoseStamped):
        print("received message to navigate to pose topic")
        pose = msg

        succ, msg = self.navigate_to_pose(pose)

        if not succ:
            rospy.logerr("Failed to navigate to pose. Error: %s", msg)
        else:
            rospy.loginfo("Successfully navigated to pose. Message: %s", msg)


    def handle_navigate_to_pose(self, request_msg: NavigateToPoseRequest) -> NavigateToPoseResponse:
        print("received message to navigate")
        pose = request_msg.target_base_pose

        succ, msg = self.navigate_to_pose(pose)

        return NavigateToPoseResponse(
            success=succ,
            message=msg
        )


    def navigate_to_pose(self, pose: PoseStamped) -> Tuple[bool, str]:
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
        pose.header.frame_id = "map"
        # Send the goal to move_base
        rospy.loginfo("Sending goal to move_base...")
        self._move_base_client.send_goal(goal)

        # Wait for the result of the action
        self._move_base_client.wait_for_result()

        # Check if the goal was reached successfully in move_base. if not, return.
        if not self._move_base_client.get_state() == actionlib.GoalStatus.SUCCEEDED:
            print(pose)
            rospy.loginfo("The robot failed to move to the goal.")
            rospy.loginfo("MoveBase failed with state: %s", self._move_base_client.get_state())
            rospy.loginfo("MoveBase failed with text: %s", self._move_base_client.get_goal_status_text())

            curr_transform: TransformStamped = self.tf_buffer.lookup_transform(
                "map", "base_link", rospy.Time(0))
            if not goal_reached(curr_transform.transform, pose.pose, position_threshold=2, orientation_threshold=1):
                return False, "MoveBase failed: " + self._move_base_client.get_goal_status_text()
            else:
                rospy.loginfo("The robot is close to goal. Will use spot sdk go_to_pose to reach it.")
        rospy.loginfo("The robot has successfully moved to the goal using move_base.")

        # fine-grained control using /spot/go_to_pose
        print("Sending final goal to spot...", pose.pose.position.x, pose.pose.position.y, 
              euler_from_quaternion([pose.pose.orientation.x, pose.pose.orientation.y, pose.pose.orientation.z, pose.pose.orientation.w])[2] * 180 / np.pi
        )
        pose.header.stamp = rospy.Time.now() + rospy.Duration(5.0)
        self._sdk_go_to_topic.publish(pose)
        begin_time = time.time()
        while rospy.Time() < pose.header.stamp and time.time() - begin_time < 10:
            time.sleep(0.1)
            curr_transform: TransformStamped = self.tf_buffer.lookup_transform(
                "map", "base_link", rospy.Time(0))
            if goal_reached(curr_transform.transform, pose.pose):
                rospy.loginfo("Goal reached!")
                return True, "goal reached"
            
            # resend goal if not reached
            pose.header.stamp = rospy.Time.now() + rospy.Duration(5.0)
            self._sdk_go_to_topic.publish(pose)
            # elif False:
            #     pass
            # print("goal not reached yet. Dist:", 
            #         np.linalg.norm(np.array([curr_transform.transform.translation.x, curr_transform.transform.translation.y]) - 
            #         np.array([pose.pose.position.x, pose.pose.position.y])))
        
        # TODO cancel go to pose
        rospy.Time.now().secs, pose.header.stamp.nsecs, 
        if rospy.Time.now() < pose.header.stamp:
            rospy.loginfo(f"Goal not reached. Timeout. request time: {pose.header.stamp.secs}, current time: {rospy.Time.now().secs}")
        elif time.time() - begin_time >= 10:
            rospy.loginfo("Timeout. Goal not reached.")
        curr_transform: TransformStamped = self.tf_buffer.lookup_transform(
                "map", "base_link", rospy.Time(0))
        return False, "timeout. goal not reached"
