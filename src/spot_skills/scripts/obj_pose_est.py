#!/usr/bin/env python

import rospy
import tf
import tf2_ros
import tf.transformations as tft
from geometry_msgs.msg import PoseStamped
import numpy as np

def main():
    rospy.init_node('object_pose_estimator')

    # Create a tf listener to get the transform between frames.
    tf_listener = tf.TransformListener()
    # give TF a moment to fill its buffer
    rospy.sleep(1.0)
    tf_broadcaster = tf.TransformBroadcaster()
    camera_frames = ["frontleft_fisheye", "frontright_fisheye"]


    # Define the static transform from marker to object.
    # For example: object frame is 0.1m above marker frame.
    marker_to_object_translation = (0.32, 0.24, 0.18)
    marker_to_object_quaternion = (0.0, 0.0, 0.0, 1.0)  # identity rotation

    rate = rospy.Rate(10.0)
    while not rospy.is_shutdown():
        for camera_frame in camera_frames:
            try:
                marker_frame = "ar_marker_1"       # as broadcast by AR Track Alvar

                # Wait and lookup the transform from camera frame to marker frame.
                now = rospy.Time(0)
                tf_listener.waitForTransform(camera_frame, marker_frame, now, rospy.Duration(1.0))
                (trans, rot) = tf_listener.lookupTransform(camera_frame, marker_frame, now)

                # Convert the obtained transform to a homogeneous transformation matrix.
                # T_camera_to_marker
                T_camera_to_marker = tft.quaternion_matrix(rot)
                T_camera_to_marker[0:3, 3] = np.array(trans)

                # Create homogeneous transformation for marker-to-object.
                T_marker_to_object = tft.quaternion_matrix(marker_to_object_quaternion)
                T_marker_to_object[0:3, 3] = np.array(marker_to_object_translation)

                # Compute the object's transformation in the camera frame.
                T_camera_to_object = np.dot(T_camera_to_marker, T_marker_to_object)

                # Extract translation and rotation (as quaternion) for the object.
                object_translation = tft.translation_from_matrix(T_camera_to_object)
                object_quaternion = tft.quaternion_from_matrix(T_camera_to_object)

                # broadcast the object frame (child) in the camera_frame (parent)
                tf_broadcaster.sendTransform(
                    object_translation,               # translation [x,y,z]
                    object_quaternion,                # rotation [x,y,z,w]
                    rospy.Time.now(),                 # timestamp
                    f"cabinet_frame_{camera_frame}",  # unique child per camera
                    camera_frame                      # parent frame id
                )


                # Optionally, create a PoseStamped message for further processing or publishing.
                object_pose = PoseStamped()
                object_pose.header.stamp = rospy.Time.now()
                object_pose.header.frame_id = camera_frame
                object_pose.pose.position.x = object_translation[0]
                object_pose.pose.position.y = object_translation[1]
                object_pose.pose.position.z = object_translation[2]
                object_pose.pose.orientation.x = object_quaternion[0]
                object_pose.pose.orientation.y = object_quaternion[1]
                object_pose.pose.orientation.z = object_quaternion[2]
                object_pose.pose.orientation.w = object_quaternion[3]

                rospy.loginfo("Object Pose: position: %s, orientation: %s", 
                            object_translation, object_quaternion)

            except (
                tf.LookupException,
                tf.ConnectivityException,
                tf.ExtrapolationException,
                tf2_ros.TransformException
            ) as e:
                rospy.logwarn("TF error: %s", e)

        rate.sleep()

if __name__ == '__main__':
    main()
