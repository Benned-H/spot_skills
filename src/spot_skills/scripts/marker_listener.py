#!/usr/bin/env python3

import rospy
import time
import actionlib
import tf2_ros
from geometry_msgs.msg import TransformStamped
from spot_skills_py.ros_utilities import trigger_service
from control_msgs.msg import GripperCommandAction, GripperCommandGoal
from ar_track_alvar_msgs.msg import AlvarMarkers

br = None

# def open_gripper():
#     """
#     Sends a goal to open the gripper.
#     Fully open gripper is -1.5707 radians (and fully closed is 0 radians).
#     """
#     # Unlock the arm (this should help ensure the gripper can operate)
#     trigger_service("spot/unlock_arm")
#     rospy.loginfo("Waiting for gripper action server...")
#     gripper_client = actionlib.SimpleActionClient("/gripper_controller/gripper_action", GripperCommandAction)
#     gripper_client.wait_for_server()

#     rospy.loginfo("Sending gripper open command...")
#     gripper_goal_msg = GripperCommandGoal()
#     # Set position to -1.5707 for fully open (as in the MoveIt code)
#     gripper_goal_msg.command.position = -1.5707  
#     gripper_goal_msg.command.max_effort = -1.0  # use maximum effort

#     gripper_client.send_goal_and_wait(
#         gripper_goal_msg,
#         execute_timeout=rospy.Duration.from_sec(5.0),
#     )

#     rospy.loginfo("Gripper should be open now.")

def marker_callback(msg):
    global br
    rospy.loginfo(f"Received message with {len(msg.markers)} markers, header: {msg.markers[0].header if msg.markers else 'N/A'}")
    if not msg.markers:
        rospy.loginfo("No markers detected in this frame.")
    else:
        for marker in msg.markers:
            rospy.loginfo(f"Detected Marker ID: {marker.id}")
            
            # Create and broadcast a transform for the detected marker.
            t = TransformStamped()
            # Use the header from the marker's pose; it contains timestamp and reference frame.
            t.header = marker.pose.header  
            # Create a child frame name, for example "ar_marker_42" for marker with id 42.
            t.child_frame_id = f"ar_marker_{marker.id}"
            # Copy the pose from the marker message.
            t.transform.translation.x = marker.pose.pose.position.x
            t.transform.translation.y = marker.pose.pose.position.y
            t.transform.translation.z = marker.pose.pose.position.z
            t.transform.rotation = marker.pose.pose.orientation

            t.header.frame_id = msg.markers[0].header.frame_id  # <- this sets the parent frame correctly

            # Broadcast the transform.
            br.sendTransform(t)


# def marker_callback(msg):
#     global br
#     if not msg.markers:
#         rospy.loginfo("No markers detected in this frame.")
#     else:
#         # Use only the first marker as the bundle pose.
#         marker = msg.markers[0]
#         rospy.loginfo(f"Detected Bundle with Marker ID: {marker.id}")
            
#         t = TransformStamped()
#         # Use the header from the bundle pose
#         t.header = marker.pose.header  
#         # Set a unique child frame name, e.g. "ar_bundle"
#         t.child_frame_id = "ar_bundle"
#         t.transform.translation.x = marker.pose.pose.position.x
#         t.transform.translation.y = marker.pose.pose.position.y
#         t.transform.translation.z = marker.pose.pose.position.z
#         t.transform.rotation = marker.pose.pose.orientation

#         # Ensure the parent frame is set
#         if not t.header.frame_id:
#             t.header.frame_id = msg.markers[0].header.frame_id 

#         br.sendTransform(t)



# def marker_callback_left2(msg):
#     global br
#     if not msg.markers:
#         rospy.loginfo("Left2: No markers detected in this frame.")
#     else:
#         for marker in msg.markers:
#             rospy.loginfo(f"Left2: Detected Marker ID: {marker.id}")
            
#             # Create and broadcast a transform for the detected marker.
#             t = TransformStamped()
#             # Use the header from the marker's pose; it contains timestamp and reference frame.
#             t.header = marker.pose.header  
#             # Create a child frame name, for example "ar_marker_42" for marker with id 42.
#             t.child_frame_id = f"ar_marker_{marker.id}_left2"
#             # Copy the pose from the marker message.
#             t.transform.translation.x = marker.pose.pose.position.x
#             t.transform.translation.y = marker.pose.pose.position.y
#             t.transform.translation.z = marker.pose.pose.position.z
#             t.transform.rotation = marker.pose.pose.orientation

#             t.header.frame_id = msg.markers[0].header.frame_id  # <- this sets the parent frame correctly

#             # Broadcast the transform.
#             br.sendTransform(t)

def main():
    global br
    rospy.init_node("simple_marker_listener", anonymous=True)
    
    # Stand up the robot (keeps trying until it succeeds)
    stood_up = False
    while not stood_up:
        stood_up = trigger_service("spot/stand")
        time.sleep(3)
    
    # open_gripper()  # Open the gripper after the robot is standing
        
    br = tf2_ros.TransformBroadcaster()

    # rospy.Subscriber("/ar_pose_marker", AlvarMarkers, marker_callback)
    rospy.Subscriber("/ar_pose_marker_frontleft", AlvarMarkers, marker_callback)
    # rospy.Subscriber("/ar_pose_marker_frontleft_2", AlvarMarkers, marker_callback_left2)
    rospy.Subscriber("/ar_pose_marker_frontright", AlvarMarkers, marker_callback)

    rospy.loginfo("Marker listener node started. Waiting for markers...")
    rospy.spin()

if __name__ == "__main__":
    main()