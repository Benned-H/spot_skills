"""Define a ROS node to publish synchronized RGB-D images for rtabmap odometry."""

from __future__ import annotations

import rospy
from rtabmap_msgs.msg import RGBDImage

from spot_skills.srv import GetRGBDPairs, GetRGBDPairsRequest, GetRGBDPairsResponse


class RGBDImagePublisher:
    """A publisher of rtabmap_msgs/RGBDImage messages."""

    def __init__(self, image_service_name: str, camera_names: list[str]) -> None:
        """Initialize a publisher for RGBD images for each of the given cameras.

        :param image_service_name: Name of the ROS service used to request RGBD image pairs
        :param camera_names: Names of the RGBD cameras to publish images from
        """
        self.publishers = {
            camera_name: rospy.Publisher(f"rgbd_image{camera_idx}", RGBDImage, queue_size=10)
            for (camera_idx, camera_name) in enumerate(camera_names)
        }

        rospy.wait_for_service(image_service_name, timeout=60.0)
        self.rgbd_service_caller = rospy.ServiceProxy(image_service_name, GetRGBDPairs)
        self.rgbd_service_name = image_service_name

    @property
    def camera_names(self) -> list[str]:
        """Retrieve the list of cameras whose images are requested by the publisher."""
        return list(self.publishers.keys())

    def publish_rgbd_images_loop(self, pub_frequency_hz: float) -> None:
        """Request and publish RGB-D images for the cameras at a given frequency.

        :param pub_frequency_hz: Frequency (Hz) at which all cameras are queried for RGBD images
        """
        rate = rospy.Rate(pub_frequency_hz)
        while not rospy.is_shutdown():
            request = GetRGBDPairsRequest(camera_names=self.camera_names)

            # Call ROS service to get paired RGB-D images
            try:
                response: GetRGBDPairsResponse = self.rgbd_service_caller(request)
            except rospy.ServiceException as exc:
                rospy.logerr(f"[{self.rgbd_service_name}] Could not call service: {exc}")
            else:
                if response is None:
                    rospy.logerr(f"[{self.rgbd_service_name}] Received None response.")
                else:
                    assert len(response.rgbd_pairs) == len(self.camera_names)

                    for rgbd_pair in response.rgbd_pairs:
                        rgbd_msg = RGBDImage()
                        rgbd_msg.header.frame_id = rgbd_pair.camera_info.header.frame_id
                        rgbd_msg.header.stamp = rgbd_pair.camera_info.header.stamp
                        rgbd_msg.rgb_camera_info = rgbd_pair.camera_info
                        rgbd_msg.depth_camera_info = rgbd_pair.camera_info
                        rgbd_msg.rgb = rgbd_pair.rgb
                        rgbd_msg.depth = rgbd_pair.depth

                        self.publishers[rgbd_pair.camera_name].publish(rgbd_msg)

            rate.sleep()


def main() -> None:
    """Publish RGB-D images from all cameras listed in the relevant ROS parameter."""
    rospy.init_node("rgbd_image_publisher")

    # Get the list of camera names from the ROS parameter server
    cameras_str = rospy.get_param("~rgbd_camera_names")
    cameras = [c.strip() for c in cameras_str.split(",")]
    assert cameras, "Cannot publish RGB-D images without any cameras!"

    pub_frequency_hz = rospy.get_param("~pub_frequency", 5.0)

    image_service_name = "/spot/get_rgbd_pairs"

    rgbd_pub = RGBDImagePublisher(image_service_name, cameras)
    rgbd_pub.publish_rgbd_images_loop(pub_frequency_hz)

    rospy.spin()


if __name__ == "__main__":
    main()
