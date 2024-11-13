"""Define a class for interfacing with MoveIt's PlanningSceneInterface."""

from __future__ import annotations

from typing import TYPE_CHECKING

import rospy
import yaml
from geometry_msgs.msg import Point, Pose, Transform, TransformStamped, Vector3
from moveit_commander import PlanningSceneInterface
from moveit_msgs.msg import CollisionObject
from shape_msgs.msg import Mesh, MeshTriangle
from tf2_ros import TransformBroadcaster
from trimesh.transformations import compose_matrix

from spot_skills.make_geometry_msgs import create_pose
from spot_skills.mesh_utilities import find_top_subframes, load_normalized_mesh
from spot_skills.ros_utilities import resolve_package_path

if TYPE_CHECKING:
    from pathlib import Path

    from trimesh import Trimesh


class SceneHandler:
    """A wrapper for managing objects in MoveIt's planning scene."""

    def __init__(self, scene_yaml: Path | None):
        """Initialize a Python interface for MoveIt's planning scene.

        :param scene_yaml: Optional path to a YAML file specifying the scene's objects
        """
        self._scene = PlanningSceneInterface()
        self._broadcaster = TransformBroadcaster()

        rospy.sleep(3)  # Allow time for the scene to initialize

        if scene_yaml is not None:
            self.load_scene_from_yaml(scene_yaml)

        self.rate_hz = rospy.Rate(1)  # Define rate (Hz) for transform broadcasting

        # Loop forever, broadcasting the frames of all objects in the planning scene
        while not rospy.is_shutdown():
            self.broadcast_frames()
            self.rate_hz.sleep()

    def pose_to_transform(self, pose: Pose) -> Transform:
        """Convert a geometry_msgs/Pose message to a geometry_msgs/Transform."""
        translation = Vector3(pose.position.x, pose.position.y, pose.position.z)
        return Transform(translation, pose.orientation)

    def broadcast_frames(self) -> None:
        """Broadcast the frames and subframes for all objects in the planning scene."""
        scene_objects_dict = self._scene.get_objects()

        for obj_id, obj_msg in scene_objects_dict.items():
            rospy.loginfo(f"Scene contains object with ID '{obj_id}'")

            obj_tf = TransformStamped()
            obj_tf.header.stamp = rospy.Time.now()
            obj_tf.header.frame_id = obj_msg.header.frame_id

            obj_tf.child_frame_id = obj_id
            obj_tf.transform = self.pose_to_transform(obj_msg.pose)
            self._broadcaster.sendTransform(obj_tf)

            assert len(obj_msg.subframe_names) == len(obj_msg.subframe_poses)

            for subframe_name, subframe_pose in zip(
                obj_msg.subframe_names,
                obj_msg.subframe_poses,
            ):
                rospy.loginfo(f"Object {obj_id} has the subframe '{subframe_name}'")
                subframe_tf = TransformStamped()
                subframe_tf.header.stamp = rospy.Time.now()
                subframe_tf.header.frame_id = obj_id  # Subframe is w.r.t. object

                subframe_tf.child_frame_id = f"{obj_id}/{subframe_name}"
                subframe_tf.transform = self.pose_to_transform(subframe_pose)
                self._broadcaster.sendTransform(subframe_tf)

    def create_collision_object_msg(
        self,
        object_id: str,
        object_type: str,
        mesh: Trimesh,
        relative_frame: str,
        object_pose: Pose,
    ) -> CollisionObject:
        """Create and return a moveit_msgs/CollisionObject message.

        Note: This method sets the CollisionObject's `operation` field to ADD.

        :param object_id: Unique identifier for the object
        :param object_type: Type of the object
        :param mesh: Mesh defining the object's collision geometry
        :param relative_frame: Frame w.r.t. which the object's pose is defined
        :param object_pose: Pose for the object in the global frame

        :returns: moveit_msgs/CollisionObject based on the given inputs.
        """
        collision_object = CollisionObject()
        collision_object.header.frame_id = relative_frame
        collision_object.pose = object_pose  # Subframes are defined relative to this

        collision_object.id = object_id

        # TODO: How do object_recognition_msgs/ObjectType messages work?
        collision_object.type.key = object_type

        mesh_msg = self.mesh_to_msg(mesh)
        collision_object.meshes = [mesh_msg]
        collision_object.mesh_poses = [object_pose]

        collision_object.operation = CollisionObject.ADD

        return collision_object

    def add_collision_object(self, collision_object: CollisionObject) -> None:
        """Add the given collision object to the planning scene."""
        self._scene.add_object(collision_object)
        rospy.loginfo(f"Added object with ID '{collision_object.id}' to the scene.")
        self.broadcast_frames()

    def mesh_to_msg(self, mesh: Trimesh) -> Mesh:
        """Convert a trimesh.Trimesh into a shape_msgs/Mesh message.

        :param mesh: Object containing a triangular 3D mesh

        :returns: A shape_msgs/Mesh message containing the mesh geometry.
        """
        mesh_msg = Mesh()
        mesh_msg.triangles = [
            MeshTriangle(vertex_indices=list(triangle)) for triangle in mesh.faces
        ]
        mesh_msg.vertices = [Point(v[0], v[1], v[2]) for v in mesh.vertices]

        return mesh_msg

    def load_scene_from_yaml(self, yaml_path: Path) -> None:
        """Load a scene of collision objects specified as a path to a YAML file.

        :param yaml_path: Path to the YAML file describing the planning scene
        """
        if not yaml_path.exists():
            rospy.logerr(f"The YAML path {yaml_path} doesn't exist!")
            return

        try:
            with yaml_path.open() as yaml_file:
                scene_data = yaml.safe_load(yaml_file)
                rospy.loginfo(f"Loaded scene data from YAML file: {yaml_path}")
        except Exception as e:
            rospy.logerr(f"Failed to load YAML file: {yaml_path}.\nError: {e}")
            return

        for obj in scene_data:
            for obj_id, obj_data in obj.items():
                obj_type = obj_data["type"]

                # If the relative frame is unspecified, assume the map frame
                relative_frame = obj_data.get("frame", "map")
                pose_data = obj_data.get("pose", [0, 0, 0, 0, 0, 0])

                # Resolve the package-relative filepath as an absolute path
                relative_mesh_filepath = obj_data["mesh_filepath"]
                mesh_filepath = resolve_package_path(relative_mesh_filepath)

                # If the mesh adjustment is unspecified, assume no transformation
                adjustment = obj_data.get("adjust_mesh", [0, 0, 0, 0, 0, 0])
                adjust_matrix = compose_matrix(
                    angles=adjustment[3:],
                    translate=adjustment[:3],
                )

                mesh = load_normalized_mesh(mesh_filepath, adjust_matrix)

                xyz = tuple(pose_data[:3])
                r_rad, p_rad, y_rad = pose_data[3:]
                pose = create_pose(xyz, r_rad, p_rad, y_rad)

                collision_obj_msg = self.create_collision_object_msg(
                    obj_id,
                    obj_type,
                    mesh,
                    relative_frame,
                    pose,
                )

                # Add subframes for the top corners of any table-typed objects
                if obj_type == "table":  # TODO: Better represent "surface"-y types
                    subframes = find_top_subframes(mesh)

                    for subframe_name, subframe_xyz in subframes.items():
                        subframe_pose = create_pose(subframe_xyz)

                        collision_obj_msg.subframe_names.append(subframe_name)
                        collision_obj_msg.subframe_poses.append(subframe_pose)

                # Add each imported object to the planning scene
                self.add_collision_object(collision_obj_msg)
