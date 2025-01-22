"""Define a class to manage setting and reading transforms from the /tf tree."""

from __future__ import annotations

from typing import TYPE_CHECKING

import rospy
from geometry_msgs.msg import TransformStamped
from tf2_ros import Buffer, TransformBroadcaster, TransformException, TransformListener

from spot_skills.kinematics.kinematics_ros import (
    pose_from_tf_stamped_msg,
    pose_msg_to_tf_msg,
    pose_to_transform_msg,
)

if TYPE_CHECKING:
    from moveit_msgs.msg import CollisionObject

    from spot_skills.kinematics.kinematics import Pose3D


class TransformManager:
    """A static class used to manage and read from the /tf tree."""

    loop_hz = 10.0  # Frequency (Hz) of any transform request/send loops

    # Delay initialization of TF2 objects until they're needed
    _tf_broadcaster: TransformBroadcaster | None = None
    _tf_buffer: Buffer | None = None
    _tf_listener: TransformListener | None = None

    @staticmethod
    def tf_broadcaster() -> TransformBroadcaster:
        """Retrieve the transform broadcaster, initializing it if necessary.

        :return: Transform broadcaster used to send transforms to the TF2 server
        """
        if TransformManager._tf_broadcaster is None:
            TransformManager._tf_broadcaster = TransformBroadcaster()
        return TransformManager._tf_broadcaster

    @staticmethod
    def tf_buffer() -> Buffer:
        """Retrieve the transform buffer, initializing it if necessary.

        :return: Transform buffer used to store known transforms
        """
        if TransformManager._tf_buffer is None:
            TransformManager._tf_buffer = Buffer()
        return TransformManager._tf_buffer

    @staticmethod
    def tf_listener() -> TransformListener:
        """Retrieve the transform listener, initializing it if necessary.

        :return: Transform listener used to request transforms from the TF2 server
        """
        if TransformManager._tf_listener is None:
            TransformManager._tf_listener = TransformListener(TransformManager.tf_buffer())
        return TransformManager._tf_listener

    @staticmethod
    def broadcast_transform(frame_name: str, pose: Pose3D) -> None:
        """Broadcast the given transform for the named frame into /tf.

        :param frame_name: Name of the reference frame to be updated
        :param pose: Transform of the frame relative to some other frame
        """
        tf_msg = TransformStamped()
        tf_msg.header.stamp = rospy.Time.now()
        tf_msg.header.frame_id = pose.frame
        tf_msg.child_frame_id = frame_name
        tf_msg.transform = pose_to_transform_msg(pose)

        TransformManager.tf_broadcaster().sendTransform(tf_msg)

    @staticmethod
    def lookup_transform(source_frame: str, target_frame: str, when: rospy.Time) -> Pose3D:
        """Look up the transform to convert from one frame into another using /tf.

        Frame abbreviations:
            Frame implied by some data (d)
            Source frame (s)
            Target frame (t)

        Say our input data originates in the source frame: pose_s_d ("data in the source frame").
        This method outputs transform_t_s ("source relative to target"), which lets us compute:

            transform_t_s @ pose_s_d = pose_t_d ("data in the target frame")

        :param source_frame: Frame where the data originated
        :param target_frame: Frame to which the data should be transformed
        :param when: Timestamp at which the relative transform is found
        :return: Pose3D representing transform (i.e., pose_t_s)
        """
        rate_hz = rospy.Rate(TransformManager.loop_hz)
        rate_hz.sleep()
        while not rospy.is_shutdown_requested():
            try:
                transform_msg: TransformStamped = TransformManager.tf_buffer().lookup_transform(
                    target_frame=target_frame,
                    source_frame=source_frame,
                    time=when,
                    timeout=(2.0 * rate_hz.sleep_dur),
                )
                break
            except TransformException as t_exc:
                rospy.logwarn(f"[TransformManager.lookup_transform] {t_exc}")
                rate_hz.sleep()

        pose_t_s = pose_from_tf_stamped_msg(transform_msg)

        assert pose_t_s.frame == target_frame, (
            f"Expected result in frame '{target_frame}' but found frame '{pose_t_s.frame}'."
        )

        return pose_t_s

    @staticmethod
    def convert_to_frame(pose: Pose3D, new_frame: str) -> Pose3D:
        """Convert the given pose into the named reference frame.

        Frame notation:
            Frame implied by the given pose (p)
            Current reference frame (c)
            New reference frame (n)

        Input: pose_c_p (pose w.r.t. current frame)
        Output: pose_n_p (pose w.r.t. new frame)

        :param pose: 3D pose w.r.t. some reference frame
        :param new_frame: Reference frame of the returned pose
        :return: Pose3D relative to the named reference frame (i.e., pose_n_p)
        """
        current_frame = pose.frame
        if current_frame == new_frame:
            return pose

        pose_c_p = pose  # Notation: "transform from the current frame (c) to the 'pose' frame (p)"
        pose_n_c = TransformManager.lookup_transform(current_frame, new_frame, rospy.Time.now())

        return pose_n_c @ pose_c_p

    @staticmethod
    def broadcast_subframes(obj_msg: CollisionObject) -> None:
        """Broadcast the subframes of the given moveit_msgs/CollisionObject message."""
        assert len(obj_msg.subframe_names) == len(obj_msg.subframe_poses)

        for sf_name, sf_pose in zip(obj_msg.subframe_names, obj_msg.subframe_poses):
            subframe_tf = TransformStamped()
            subframe_tf.header.stamp = rospy.Time.now()
            subframe_tf.header.frame_id = obj_msg.id  # Subframe is w.r.t. object
            subframe_tf.child_frame_id = f"{obj_msg.id}/{sf_name}"
            subframe_tf.transform = pose_msg_to_tf_msg(sf_pose)

            TransformManager.tf_broadcaster().sendTransform(subframe_tf)
