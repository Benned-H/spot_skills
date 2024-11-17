"""Define a class for interfacing with MoveIt's PlanningSceneInterface."""

from __future__ import annotations

from pathlib import Path
from typing import TYPE_CHECKING

import geometry_msgs.msg
import rospy
from moveit_commander import PlanningSceneInterface
from tf2_ros import Buffer, TransformBroadcaster, TransformException, TransformListener

from spot_skills.make_geometry_msgs import pose_to_transform

from .load_meshes import (
    load_objects_dict_from_yaml,
    load_surface_from_fields,
    make_collision_object_msg,
)
from .put_down_surface import PutDownSurface

if TYPE_CHECKING:
    from moveit_msgs.msg import CollisionObject as CollisionObjectMsg


class SceneHandler:
    """A wrapper for managing objects in MoveIt's planning scene."""

    def __init__(self, scene_yaml: Path | None):
        """Initialize a Python interface for MoveIt's planning scene.

        :param scene_yaml: Optional path to a YAML file specifying the scene's objects
        """
        self._scene = PlanningSceneInterface()
        self._broadcaster = TransformBroadcaster()
        self._tf_buffer = Buffer()
        self._tf_listener = TransformListener(self._tf_buffer)
        self.surfaces = {}  # Dictionary from surface IDs to their models

        rospy.sleep(3)  # Allow time for the scene to initialize

        if scene_yaml is not None:
            for obj_id, obj_fields in load_objects_dict_from_yaml(scene_yaml).items():
                collision_object_msg = make_collision_object_msg(obj_fields)
                self.add_collision_object(collision_object_msg)

                object_type = obj_fields["type"]

                if PutDownSurface.valid_surface_type(object_type):
                    self.surfaces[obj_id] = load_surface_from_fields(obj_fields)

    @classmethod
    def initialize_from_rosparam(cls, yaml_rosparam: str) -> SceneHandler | None:
        """Construct a SceneHandler by importing a planning scene from a YAML file.

        :param yaml_rosparam: Name of the ROS parameter used to find the YAML filepath
        :returns: SceneHandler with a planning scene populated from the YAML file
        """
        if not rospy.has_param(yaml_rosparam):
            rospy.logfatal(f"Cannot find '{yaml_rosparam}' rosparam.")
            return None

        yaml_path_str = rospy.get_param(yaml_rosparam)
        rospy.loginfo(f"Found rosparam '{yaml_rosparam}': {yaml_path_str}")
        yaml_path = Path(yaml_path_str)

        return SceneHandler(yaml_path)

    def broadcast_tf_loop(self, loop_hz: float) -> None:
        """Broadcast the frames of all objects in the planning scene, forever.

        :param loop_hz: Rate (Hz) at which to re-broadcast scene object transforms
        """
        rate_hz = rospy.Rate(loop_hz)

        while not rospy.is_shutdown():
            self.broadcast_frames()
            rate_hz.sleep()

    def broadcast_frames(self) -> None:
        """Broadcast the frames and subframes for all objects in the planning scene."""
        scene_objects_dict = self._scene.get_objects()

        for obj_id, obj_msg in scene_objects_dict.items():
            rospy.loginfo(f"Scene contains object with ID '{obj_id}'")

            obj_tf = geometry_msgs.msg.TransformStamped()
            obj_tf.header.stamp = rospy.Time.now()
            obj_tf.header.frame_id = obj_msg.header.frame_id

            obj_tf.child_frame_id = obj_id
            obj_tf.transform = pose_to_transform(obj_msg.pose)
            self._broadcaster.sendTransform(obj_tf)

            assert len(obj_msg.subframe_names) == len(obj_msg.subframe_poses)

            for subframe_name, subframe_pose in zip(
                obj_msg.subframe_names,
                obj_msg.subframe_poses,
            ):
                rospy.loginfo(f"Object '{obj_id}' has the subframe '{subframe_name}'")

                subframe_tf = geometry_msgs.msg.TransformStamped()
                subframe_tf.header.stamp = rospy.Time.now()
                subframe_tf.header.frame_id = obj_id  # Subframe is w.r.t. object

                subframe_tf.child_frame_id = f"{obj_id}/{subframe_name}"
                subframe_tf.transform = pose_to_transform(subframe_pose)
                self._broadcaster.sendTransform(subframe_tf)

    def add_collision_object(self, collision_object: CollisionObjectMsg) -> None:
        """Add the given collision object to the planning scene."""
        self._scene.add_object(collision_object)
        rospy.loginfo(f"Added object with ID '{collision_object.id}' to the scene.")
        self.broadcast_frames()

    def wait_for_frame(self, frame_id: str, loop_hz: int) -> None:
        """Broadcast transforms while waiting until the given tf frame becomes available.

        :param frame_id: Name of the tf frame to lookup
        :param loop_hz: Rate (Hz) at which to re-lookup and re-broadcast transforms
        """
        rospy.loginfo(f"Waiting for frame '{frame_id}' to become available...")

        rate_hz = rospy.Rate(loop_hz)
        while not rospy.is_shutdown():
            try:
                self._tf_buffer.lookup_transform(
                    "map",
                    frame_id,
                    rospy.Time(0),
                    rospy.Duration(1.0),
                )
                rospy.loginfo(f"Frame '{frame_id}' is now available.")
                break
            except TransformException:
                rospy.logwarn(f"Frame '{frame_id}' is not yet available.")
                self.broadcast_frames()
                rate_hz.sleep()
