#!/usr/bin/env python3

import numpy as np
import rospy
import sensor_msgs.point_cloud2 as pc2
import tf
from scipy.spatial import KDTree
from sensor_msgs.msg import PointCloud2, PointField

# Parameters
sphere_radius = 1.0  # Radius of the sphere in meters
moving_frame = "base_link"  # Replace with the name of your moving frame


def update_transform():
    global latest_transform
    try:
        # Continuously update the latest transform
        (trans, rot) = listener.lookupTransform(
            moving_frame,
            "sensor_origin_velodyne-point-cloud",
            rospy.Time(0),
        )
        latest_transform = (np.array(trans), np.array(rot))
    except (
        tf.Exception,
        tf.LookupException,
        tf.ConnectivityException,
        tf.ExtrapolationException,
    ) as e:
        rospy.logwarn(f"TF Error during update: {e}")


def pointcloud_callback(msg):
    global latest_transform
    if latest_transform is None:
        rospy.logwarn("SKipping this frame.")
        return
    try:
        # Get the transform from the pointcloud frame to the moving frame
        # listener.waitForTransform(
        #     moving_frame,
        #     msg.header.frame_id,
        #     rospy.Time(0),
        #     rospy.Duration(1.0),
        # )
        trans, rot = latest_transform
        # (trans, rot) = listener.lookupTransform(
        #     # moving_frame,
        #     msg.header.frame_id,
        #     moving_frame,
        #     rospy.Time(0),
        # )

        # Transform the origin of the sphere to the pointcloud frame
        T = tf.transformations.compose_matrix(
            translate=trans,
            angles=tf.transformations.euler_from_quaternion(rot),
        )
        sphere_origin_world = np.dot(T, np.array([0.0, 0.0, 0.0, 1.0]))[:3]

        # Extract points from the point cloud
        points = np.array([p[:3] for p in pc2.read_points(msg, skip_nans=True)])

        # Build a KD-Tree for fast spatial searching
        kdtree = KDTree(points)

        # Query points within the sphere radius
        indices = kdtree.query_ball_point(sphere_origin_world, sphere_radius)

        # Filter points
        mask = np.ones(len(points), dtype=bool)
        mask[indices] = False
        filtered_points = points[mask]

        # Convert the filtered points back to PointCloud2
        fields = msg.fields
        header = msg.header
        filtered_msg = pc2.create_cloud(header, fields, filtered_points)

        # Publish the filtered PointCloud2
        filtered_pointcloud_pub.publish(filtered_msg)

    except (
        tf.Exception,
        tf.LookupException,
        tf.ConnectivityException,
        tf.ExtrapolationException,
    ) as e:
        rospy.logerr(f"TF Error: {e}")


if __name__ == "__main__":
    rospy.init_node("pointcloud_sphere_filter")

    sphere_radius = rospy.get_param("~sphere_radius", 1.0)
    moving_fram = rospy.get_param("~moving_frame", "base_link")

    # TF listener
    listener = tf.TransformListener()

    # Subscribing to input PointCloud2 topic
    pointcloud_sub = rospy.Subscriber(
        "/spot/lidar/points",
        PointCloud2,
        pointcloud_callback,
    )

    tf_update_rate = 50.0
    rospy.Timer(
        rospy.Duration(1.0 / tf_update_rate),
        lambda event: update_transform(),
    )
    # Publisher for the filtered PointCloud2
    filtered_pointcloud_pub = rospy.Publisher(
        "/filtered_pointcloud_sphere",
        PointCloud2,
        queue_size=100,
    )

    rospy.spin()
