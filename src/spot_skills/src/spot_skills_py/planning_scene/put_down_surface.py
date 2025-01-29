"""Define a dataclass representing a surface onto which objects can be placed."""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from spot_skills_py.tamp.geometry.real_range import RealRange


@dataclass
class PutDownSurface:
    """A surface onto which objects can be placed."""

    height_m: float  # Height (m) of the surface in its reference frame
    x_extent: RealRange  # Range of x-values defining the surface's extent
    y_extent: RealRange  # Range of y-values defining the surface's extent
    frame: str  # Name of the surface object's reference frame

    @classmethod
    def valid_surface_type(cls, object_type: str) -> bool:
        """Return whether or not the given object type is a valid put-down surface."""
        return object_type in ["table"]
