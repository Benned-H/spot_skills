"""Define a ROS node to publish synchronized RGB-D images for rtabmap odometry."""

from concurrent.futures import ThreadPoolExecutor

import rospy
from rtabmap_msgs.msg import RGBDImage

from spot_skills.srv import GetPairedRGBD, GetPairedRGBDRequest, GetPairedRGBDResponse


def publish_rgbd_image(
    camera_name: str,
    camera_idx: int,
    rgbd_service_caller: rospy.ServiceProxy,
    pub_freq_hz: float,
) -> None:
    """Request and publish RGB-D images for a single camera at a given frequency.

    :param camera_name: Name of the camera from which to request RGB-D images
    :param camera_idx: Index of the camera among all used for rtabmap odometry
    :param rgbd_service_caller: Service proxy used to call the GetPairedRGBD service
    :param pub_freq_hz: Frequency (Hz) at which to request/publish images
    """
    pub = rospy.Publisher(f"rgbd_image{camera_idx}", RGBDImage, queue_size=10)

    rate = rospy.Rate(pub_freq_hz)
    while not rospy.is_shutdown():
        request = GetPairedRGBDRequest(camera_name)

        # Call ROS service to get paired RGB-D images
        try:
            response: GetPairedRGBDResponse = rgbd_service_caller(request)
        except rospy.ServiceException as exc:
            rospy.logerr(f"[{camera_name}] Could not call service: {exc}")
        else:
            if response is None:
                rospy.logerr(f"[{camera_name}] Received None response.")
            else:
                rgbd_msg = RGBDImage()
                rgbd_msg.header.frame_id = response.info.header.frame_id
                rgbd_msg.header.stamp = response.info.header.stamp
                rgbd_msg.rgb_camera_info = response.info
                rgbd_msg.depth_camera_info = response.info
                rgbd_msg.rgb = response.rgb
                rgbd_msg.depth = response.depth

                pub.publish(rgbd_msg)

        rate.sleep()


def main() -> None:
    """Publish RGB-D images from all cameras listed in the relevant ROS parameter."""
    rospy.init_node("rgbd_image_publisher")

    # Get the list of camera names from the ROS parameter server
    cameras_str = rospy.get_param("~rgbd_cameras", "")
    cameras = [c.strip() for c in cameras_str.split(",")]

    pub_frequency_hz = rospy.get_param("~pub_frequency", 10.0)

    image_service_name = "/spot/get_paired_rgbd"
    rospy.wait_for_service(image_service_name, timeout=30.0)
    rgbd_service_caller = rospy.ServiceProxy(image_service_name, GetPairedRGBD)

    # Use ThreadPoolExecutor to parallelize image publishing for each camera
    with ThreadPoolExecutor(max_workers=len(cameras)) as executor:
        for camera_idx, camera_name in enumerate(cameras):
            executor.submit(
                publish_rgbd_image,
                camera_name,
                camera_idx,
                rgbd_service_caller,
                pub_frequency_hz,
            )

    rospy.spin()


if __name__ == "__main__":
    main()
