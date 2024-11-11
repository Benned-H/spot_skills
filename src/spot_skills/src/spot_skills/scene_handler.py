"""Define a class for interfacing with MoveIt's PlanningSceneInterface."""

from pathlib import Path

import rospy
import yaml
from geometry_msgs.msg import Point, Pose
from moveit_commander import PlanningSceneInterface
from moveit_msgs.msg import CollisionObject
from shape_msgs.msg import Mesh, MeshTriangle
from trimesh import Trimesh, load_mesh

from spot_skills.make_geometry_msgs import create_pose
from spot_skills.mesh_utilities import find_top_subframes
from spot_skills.ros_utilities import resolve_package_path


class SceneHandler:
    """A wrapper for adding and removing objects from MoveIt's planning scene."""

    def __init__(self):
        """Initialize a Python interface for MoveIt's planning scene."""
        self._scene = PlanningSceneInterface()
        rospy.sleep(2)  # Allow time for the scene to initialize

    def create_collision_object_msg(
        self,
        object_id: str,
        object_type: str,
        mesh_path: str,
        relative_frame: str,
        object_pose: Pose,
    ) -> CollisionObject:
        """Create and return a moveit_msgs/CollisionObject message.

        Note: This method sets the CollisionObject's `operation` field to ADD.

        :param object_id: Unique identifier for the object
        :param object_type: Type of the object
        :param mesh_path: Filepath to a mesh defining the object's collision geometry
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

        mesh_msg = self.load_mesh_msg(mesh_path)
        collision_object.meshes = [mesh_msg]
        collision_object.mesh_poses = [object_pose]

        collision_object.operation = CollisionObject.ADD

        return collision_object

    def add_collision_object(self, collision_object: CollisionObject) -> None:
        """Add the given collision object to the planning scene."""
        self._scene.add_object(collision_object)
        rospy.loginfo(f"Added object with ID '{collision_object.id}' to the scene.")

    def load_mesh_msg(self, mesh_path: str) -> Mesh:
        """Load a shape_msgs/Mesh message from a mesh filepath using trimesh.

        :param mesh_path: Filepath to a mesh file (STL, OBJ, DAE, etc.)

        :returns: A shape_msgs/Mesh message containing the mesh geometry.
        """
        mesh: Trimesh = load_mesh(mesh_path)

        mesh_msg = Mesh()
        mesh_msg.triangles = [MeshTriangle(*triangle) for triangle in mesh.faces]
        mesh_msg.vertices = [Point(*vertex) for vertex in mesh.vertices]

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
                relative_frame = obj_data.get("frame", "world")
                pose_data = obj_data["pose"]

                # Resolve the package-relative filepath as an absolute path
                relative_mesh_filepath = obj_data["mesh_filepath"]
                mesh_filepath = resolve_package_path(relative_mesh_filepath)

                xyz = tuple(pose_data[:3])
                r_rad, p_rad, y_rad = pose_data[3:]
                pose = create_pose(xyz, r_rad, p_rad, y_rad)

                collision_obj_msg = self.create_collision_object_msg(
                    obj_id,
                    obj_type,
                    mesh_filepath,
                    relative_frame,
                    pose,
                )

                # Add subframes for the top corners of any table-typed objects
                if obj_type == "table":
                    subframes = find_top_subframes(mesh_filepath)

                    for subframe_name, subframe_xyz in subframes.items():
                        subframe_pose = create_pose(subframe_xyz)

                        collision_obj_msg.subframe_names.append(subframe_name)
                        collision_obj_msg.subframe_poses.append(subframe_pose)

                # Add each imported object to the planning scene
                self.add_collision_object(collision_obj_msg)
