"""Define dataclasses to represent 3D positions, orientations, and transforms."""

from dataclasses import dataclass

import numpy as np
from tf.transformations import quaternion_from_euler


@dataclass
class Point3D:
    """An (x,y,z) position in 3D space."""

    x: float
    y: float
    z: float


@dataclass
class Quaternion:
    """A unit quaternion representing a 3D orientation."""

    x: float
    y: float
    z: float
    w: float

    def __post_init__(self) -> None:
        """Normalize the quaternion to ensure that it is a unit quaternion."""
        self.normalize()

    def normalize(self) -> None:
        """Normalize the quaternion to ensure that it is a unit quaternion."""
        norm = np.linalg.norm(self.to_array())
        assert norm != 0, "Cannot normalize a zero-valued quaternion."

        self.x /= norm
        self.y /= norm
        self.z /= norm
        self.w /= norm

    def to_array(self) -> np.ndarray:
        """Convert the quaternion to a NumPy array."""
        return np.array([self.x, self.y, self.z, self.w])

    @classmethod
    def from_array(cls, arr: np.ndarray) -> "Quaternion":
        """Construct a quaternion from a NumPy array."""
        assert arr.shape == (4,), "Quaternion must be a four-element vector."
        return cls(arr[0], arr[1], arr[2], arr[3])

    @classmethod
    def from_euler(
        cls,
        roll_rad: float,
        pitch_rad: float,
        yaw_rad: float,
    ) -> "Quaternion":
        """Construct a quaternion from three fixed-frame Euler angles.

        Note: By default, the quaternion_from_euler() function uses: axes="sxyz"
            meaning roll, then pitch, then yaw, all in a static (i.e., fixed) frame.

        :param roll_rad: Roll angle about the x-axis (radians)
        :param pitch_rad: Pitch angle about the y-axis (radians)
        :param yaw_rad: Yaw angle about the z-axis (radians)
        """
        return cls.from_array(quaternion_from_euler(roll_rad, pitch_rad, yaw_rad))


@dataclass
class Pose3D:
    """A position and orientation in 3D space."""

    position: Point3D
    orientation: Quaternion
