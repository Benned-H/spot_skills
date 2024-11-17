"""Define functions for loading collision meshes from file."""

from __future__ import annotations

from argparse import ArgumentParser
from pathlib import Path
from typing import Any

import geometry_msgs.msg
import numpy as np
import rospy
import yaml
from moveit_msgs.msg import CollisionObject as CollisionObjectMsg
from shape_msgs.msg import Mesh as MeshMsg
from shape_msgs.msg import MeshTriangle as MeshTriangleMsg
from trimesh import Trimesh
from trimesh import load as trimesh_load
from trimesh.transformations import compose_matrix

from spot_skills.make_geometry_msgs import create_pose
from spot_skills.planning_scene.put_down_surface import PutDownSurface
from spot_skills.ros_utilities import resolve_package_path
from spot_skills.tamp.geometry.real_range import RealRange


class ImportedMeshTypeError(Exception):
    """An error reflecting an unexpected type from a Trimesh import."""

    def __init__(self, mesh_path: Path, mesh_type: type):
        """Initialize the error with the path and type of the imported mesh."""
        super().__init__(f"{mesh_path} imported as unexpected type: {mesh_type}.")


def load_normalized_mesh(
    mesh_path: Path,
    adjustment_matrix: np.ndarray | None = None,
) -> Trimesh:
    """Load a mesh from file and transform it to a normalized frame.

    A "normalized" mesh means:
        - The mesh is centered in its x-coordinate and y-coordinate (before adjusting)
        - The mesh has a minimum z-coordinate of zero (i.e., z = 0 is the mesh bottom)
        - The mesh uses meters as its units

    :param mesh_path: Path to the mesh file to be imported
    :param adjustment_matrix: Transform applied to the mesh after it's normalized

    :returns: Trimesh object transformed to a normalized and axis-aligned frame.
    """
    mesh = trimesh_load(mesh_path, force="mesh")
    if type(mesh) is not Trimesh:
        raise ImportedMeshTypeError(mesh_path, type(mesh))

    # mesh.show()  # Optionally visualize the mesh

    mesh = mesh.convert_units("meters", guess=True)
    (min_x, min_y, min_z), (max_x, max_y, _) = mesh.bounds

    x_size = max_x - min_x
    y_size = max_y - min_y

    translate_by = np.array([-min_x - x_size / 2.0, -min_y - y_size / 2.0, -min_z])
    normalized_mesh: Trimesh = mesh.apply_translation(translate_by)

    if adjustment_matrix is not None:
        normalized_mesh = normalized_mesh.apply_transform(adjustment_matrix)

    return normalized_mesh


def make_collision_object_msg(object_fields: dict[str, Any]) -> CollisionObjectMsg:
    """Create a moveit_msgs/CollisionObject message from an object's YAML data.

    Note: This method sets the CollisionObject's `operation` field to ADD.

    :param object_fields: Dictionary from YAML field names to field data
    :returns: Constructed moveit_msgs/CollisionObject ROS message
    """
    collision_object = CollisionObjectMsg()

    # If the relative frame is unspecified, default to "map"
    collision_object.header.frame_id = object_fields.get("frame", "map")

    pose_xyz_rpy = object_fields.get("pose", [0] * 6)  # Default to identity pose
    xyz = tuple(pose_xyz_rpy[:3])
    r_rad, p_rad, y_rad = pose_xyz_rpy[3:]

    # Subframes are defined relative to the object's pose
    collision_object.pose = create_pose(xyz, r_rad, p_rad, y_rad)

    collision_object.id = object_fields["ID"]

    object_type = object_fields["type"]
    collision_object.type.key = object_type  # Ignore 'db' field of message

    # Resolve the mesh's package-relative filepath as an absolute path
    relative_mesh_path = object_fields["mesh_filepath"]
    mesh_path = resolve_package_path(relative_mesh_path)

    # Check if the mesh should be adjusted during normalization
    # Example: We may want to axis-align a table mesh within its frame
    adjustment = object_fields.get("adjust_mesh")
    if adjustment is None:
        mesh = load_normalized_mesh(mesh_path)
    else:
        adjust_matrix = compose_matrix(
            translate=adjustment[:3],
            angles=adjustment[3:],
        )
        mesh = load_normalized_mesh(mesh_path, adjust_matrix)

    collision_object.meshes = [trimesh_to_msg(mesh)]
    collision_object.mesh_poses = [geometry_msgs.msg.Pose()]  # Mesh frame = Object's

    # Create subframes visualizing the bounds of any "placement surface" objects
    if PutDownSurface.valid_surface_type(object_type):
        for subframe_name, subframe_pose in get_subframes(mesh).items():
            collision_object.subframe_names.append(subframe_name)
            collision_object.subframe_poses.append(subframe_pose)

    collision_object.operation = CollisionObjectMsg.ADD

    return collision_object


def trimesh_to_msg(mesh: Trimesh) -> MeshMsg:
    """Convert a trimesh.Trimesh into a shape_msgs/Mesh message.

    :param mesh: Object containing a triangular 3D mesh

    :returns: A shape_msgs/Mesh message containing the mesh geometry.
    """
    mesh_msg = MeshMsg()
    mesh_msg.triangles = [
        MeshTriangleMsg(vertex_indices=list(triangle)) for triangle in mesh.faces
    ]
    mesh_msg.vertices = [
        geometry_msgs.msg.Point(v[0], v[1], v[2]) for v in mesh.vertices
    ]

    return mesh_msg


def get_subframes(mesh: Trimesh) -> dict[str, geometry_msgs.msg.Pose]:
    """Compute relevant subframes for the given object's mesh."""
    (min_x, min_y, _), (max_x, max_y, max_z) = mesh.bounds

    return {
        "top": create_pose((0, 0, max_z)),
        "top_min_xy": create_pose((min_x, min_y, max_z)),
        "top_max_xy": create_pose((max_x, max_y, max_z)),
    }


def load_objects_dict_from_yaml(yaml_path: Path) -> dict[str, dict[str, dict]]:
    """Load a dictionary of object data from the given YAML file.

    :param yaml_path: Path to the YAML file describing the scene of objects
    :returns: Dictionary mapping {obj_id: obj_data}, where obj_data maps {field: data}
    """
    if not yaml_path.exists():
        rospy.logerr(f"The YAML path {yaml_path} doesn't exist!")
        return {}

    try:
        with yaml_path.open() as yaml_file:
            objects_list = yaml.safe_load(yaml_file)
            rospy.loginfo(f"Loaded scene data from YAML file: {yaml_path}")
    except yaml.YAMLError as error:
        rospy.logerr(f"Failed to load YAML file: {yaml_path}.\nError: {error}")
        return {}

    # Create a dictionary mapping object IDs to their collection of fields
    objects_dict = {}
    for object_data in objects_list:
        assert len(object_data) == 1, "Expected each object list entry to have one ID."

        object_id = next(iter(object_data.keys()))
        object_fields: dict[str, Any] = next(iter(object_data.values()))
        object_fields["ID"] = object_id

        objects_dict[object_id] = object_fields

    return objects_dict


def load_surface_from_fields(object_fields: dict[str, Any]) -> PutDownSurface:
    """Create a PutDownSurface based on a scene object's YAML fields data.

    :param object_fields: Dictionary from YAML field names to field data
    :returns: Geometric model of the put-down surface
    """
    object_id = object_fields["ID"]

    # Resolve the mesh's package-relative filepath as an absolute path
    relative_mesh_path = object_fields["mesh_filepath"]
    mesh_path = resolve_package_path(relative_mesh_path)

    # Check if the mesh should be adjusted during normalization
    # Example: We may want to axis-align a table mesh within its frame
    adjustment = object_fields.get("adjust_mesh")
    if adjustment is None:
        mesh = load_normalized_mesh(mesh_path)
    else:
        adjust_matrix = compose_matrix(
            translate=adjustment[:3],
            angles=adjustment[3:],
        )
        mesh = load_normalized_mesh(mesh_path, adjust_matrix)

    (min_x, min_y, _), (max_x, max_y, max_z) = mesh.bounds

    return PutDownSurface(
        height_m=max_z,
        x_extent=RealRange(min_x, max_x),
        y_extent=RealRange(min_y, max_y),
        frame=object_id,  # Surface frame = Object frame
    )


def main() -> None:
    """Demo and debug the mesh-loading functions without running ROS."""
    parser = ArgumentParser(prog="Find Mesh Top Corners")
    parser.add_argument("mesh_filepath", type=Path)
    args = parser.parse_args()

    mesh = load_normalized_mesh(args.mesh_filepath)
    print("\nInfo about the normalized mesh:")
    print(f"Mesh units: {mesh.units}")

    (min_x, min_y, min_z), (max_x, max_y, max_z) = mesh.bounds
    print(f"Minimum XYZ coordinates: {min_x:.2f} {min_y:.2f} {min_z:.2f}")
    print(f"Maximum XYZ coordinates: {max_x:.2f} {max_y:.2f} {max_z:.2f}")

    x_size = max_x - min_x
    y_size = max_y - min_y
    z_size = max_z - min_z
    print(f"Size in x-coordinate: {x_size:.2f}")
    print(f"Size in y-coordinate: {y_size:.2f}")
    print(f"Size in z-coordinate: {z_size:.2f}")

    subframes = get_subframes(mesh)
    for name, (x, y, z) in subframes.items():
        print(f"Frame '{name}' coordinates: {x:.2f} {y:.2f} {z:.2f}")


if __name__ == "__main__":
    main()
