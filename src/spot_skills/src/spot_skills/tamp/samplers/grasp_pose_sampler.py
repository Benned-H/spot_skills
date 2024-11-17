"""Define a class to sample grasping poses for object manipulation."""

import numpy as np

from spot_skills.tamp.geometry.real_range import RealRange
from spot_skills.tamp.geometry.transforms_3d import Point3D, Pose3D, Quaternion

from .sampler import Iterator, Sampler


class GraspPoseSampler(Sampler[Pose3D]):
    """A sampler for gripper poses used to grasp an object."""

    def __init__(
        self,
        radius_m: float,
        z_range_m: RealRange,
        yaw_range_rad: RealRange,
        rng_seed: int,
        sample_limit: int,
    ):
        """Initialize the grasp pose sampler's range of valid poses.

        Notation: p_OG denotes the pose of the gripper G from the frame of object O.

        The sampled gripper pose will be specified in the frame of the object, with a
            random height, facing the z-axis of the object's frame, and located at a
            randomly sampled angle around the frame's z-axis (yaw) at a given radius.

        :param radius_m: Radius (meters) of p_OG from the z-axis of frame O
        :param z_range_m: Range of allowed values for the height (meters) of p_OG
        :param yaw_range_rad: Range of angles (radians) of p_OG in frame O
        :param rng_seed: Seed used to initialize the sampler's RNG
        :param sample_limit: Number of samples before the sampler is exhausted
        """
        super().__init__(rng_seed=rng_seed, sample_limit=sample_limit)

        self.radius_m = radius_m  # Radius (m) of gripper pose from object frame
        self.z_range_m = z_range_m  # Range of sampled heights (m) in object frame
        self.yaw_range_rad = yaw_range_rad  # Range of sampled yaw angles (rad)

    def get_generator(self) -> Iterator[Pose3D]:
        """Create a lazy iterator over the grasp pose sampler's outputs.

        :returns: Generator object providing an iterator over sampled outputs
        """
        while self.samples_left:
            height_m = self.z_range_m.random(self.rng)

            yaw_rad = self.yaw_range_rad.random(self.rng)
            x_m = self.radius_m * np.cos(yaw_rad)
            y_m = self.radius_m * np.sin(yaw_rad)

            yield Pose3D(
                Point3D(x_m, y_m, height_m),
                Quaternion.from_euler(0, 0, yaw_rad + np.pi),
            )
