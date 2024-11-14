"""Define utility functions to compute mesh properties (e.g., subframes)."""

from __future__ import annotations

from argparse import ArgumentParser
from pathlib import Path
from typing import TYPE_CHECKING

import numpy as np
import trimesh

if TYPE_CHECKING:
    Coordinate3D = tuple[float, float, float]


def print_geometric_info(name: str, mesh: trimesh.Trimesh) -> None:
    """Print geometric information about the given mesh to aid debugging."""
    print(f"\nInfo about the '{name}' Mesh:")
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

    print()


def load_normalized_mesh(
    mesh_path: str,
    adjustment_matrix: np.ndarray | None = None,
) -> trimesh.Trimesh:
    """Load a mesh from file and transform it to a normalized frame.

    The mesh is transformed to be centered in X/Y and have a minimum Z of zero.

    :param mesh_path: Path to the mesh file to be imported
    :param adjustment_matrix: Transform applied to the mesh after it's normalized

    :returns: Trimesh object transformed to a normalized and axis-aligned frame.
    """
    mesh = trimesh.load(mesh_path, force="mesh")
    if type(mesh) is not trimesh.Trimesh:
        raise TypeError(f"{mesh_path} imported as unexpected type: {type(mesh)}.")

    # mesh.show()  # Visualize the mesh; helps debugging

    mesh = mesh.convert_units("meters", guess=True)
    (min_x, min_y, min_z), (max_x, max_y, _) = mesh.bounds

    x_size = max_x - min_x
    y_size = max_y - min_y

    translate_by = np.array([-min_x - x_size / 2.0, -min_y - y_size / 2.0, -min_z])
    normalized_mesh: trimesh.Trimesh = mesh.apply_translation(translate_by)

    if adjustment_matrix is not None:
        normalized_mesh = normalized_mesh.apply_transform(adjustment_matrix)

    return normalized_mesh


def find_top_subframes(mesh: trimesh.Trimesh) -> dict[str, Coordinate3D]:
    """Compute subframes for the top, and top corners, of the given mesh."""
    (min_x, min_y, _), (max_x, max_y, max_z) = mesh.bounds

    return {
        "top": (0, 0, max_z),
        "top_min_xy": (min_x, min_y, max_z),
        "top_max_xy": (max_x, max_y, max_z),
    }


def main() -> None:
    """Demo/debug the utility functions without involving ROS."""
    parser = ArgumentParser(prog="Find Mesh Top Corners")
    parser.add_argument("mesh_filepath", type=Path)
    args = parser.parse_args()

    normalized_mesh = load_normalized_mesh(args.mesh_filepath)
    print_geometric_info("Normalized Mesh", normalized_mesh)

    subframes = find_top_subframes(normalized_mesh)
    for name, (x, y, z) in subframes.items():
        print(f"Frame '{name}' coordinates: {x:.2f} {y:.2f} {z:.2f}")


if __name__ == "__main__":
    main()
