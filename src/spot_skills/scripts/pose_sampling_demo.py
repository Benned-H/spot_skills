"""Sample and visualize pick-up and put-down poses for example meshes."""

import sys

import moveit_commander
import numpy as np
import rospy
from geometry_msgs.msg import PoseArray
from spot_skills_py.planning_scene.scene_handler import SceneHandler
from spot_skills_py.samplers.grasp_pose_sampler import GraspPoseSampler
from spot_skills_py.samplers.put_down_pose_sampler import PutDownPoseSampler
from spot_skills_py.samplers.real_range import RealRange
from transform_utils.kinematics_ros import pose_to_msg


def main() -> None:
    """Identify the meshes loaded from YAML and sample poses for them."""
    moveit_commander.roscpp_initialize(sys.argv)
    rospy.init_node("pose_sampling_demo")

    put_down_pose_pub = rospy.Publisher("/putdown_poses", PoseArray, queue_size=10)
    grasp_pose_pub = rospy.Publisher("/grasp_poses", PoseArray, queue_size=10)

    scene_handler = SceneHandler.initialize_from_rosparam("meshes_yaml")

    num_samples = 30

    # Create a sampler for put-down poses
    surface_name = "table1"
    table_surface = scene_handler.surfaces[surface_name]
    avoid_table_edge_m = 0.05
    put_down_sampler = PutDownPoseSampler(
        table_surface,
        avoid_table_edge_m,
        rng_seed=42,
        sample_limit=num_samples,
    )

    # Create a sampler for grasp poses
    grasped_object_name = "mug1"
    radius_m = 0.1  # 10 cm radius
    z_range_m = RealRange(0.03, 0.07)
    yaw_range_rad = RealRange(np.pi / 4.0, 7.0 * np.pi / 4.0)

    grasp_sampler = GraspPoseSampler(
        radius_m,
        z_range_m,
        yaw_range_rad,
        43,
        num_samples,
    )

    # Wait for the relevant frames to become available from tf
    put_down_frame_id = surface_name  # Surfaces use the same frame as their object
    grasp_frame_id = grasped_object_name  # Grasp poses are w.r.t. the object

    scene_handler.wait_for_frame(put_down_frame_id, loop_hz=5)
    scene_handler.wait_for_frame(grasp_frame_id, loop_hz=5)

    # Create arrays of sampled poses, then publish each
    put_down_poses = PoseArray()
    put_down_poses.header.frame_id = put_down_frame_id
    put_down_poses.header.stamp = rospy.Time.now()

    for _ in range(num_samples):
        pose_msg = pose_to_msg(put_down_sampler.next())
        put_down_poses.poses.append(pose_msg)

    grasp_poses = PoseArray()
    grasp_poses.header.frame_id = grasp_frame_id
    grasp_poses.header.stamp = rospy.Time.now()

    for _ in range(num_samples):
        pose_msg = pose_to_msg(grasp_sampler.next())
        grasp_poses.poses.append(pose_msg)

    # Alternate publishing the pose arrays and the planning scene frames
    rate_hz = rospy.Rate(10)
    while not rospy.is_shutdown():
        put_down_pose_pub.publish(put_down_poses)
        grasp_pose_pub.publish(grasp_poses)

        scene_handler.broadcast_frames()
        rate_hz.sleep()


if __name__ == "__main__":
    main()
