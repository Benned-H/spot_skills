"""Define a class to sample put-down poses for placing objects on surfaces."""

import numpy as np

from spot_skills.planning_scene.put_down_surface import PutDownSurface
from spot_skills.tamp.geometry.transforms_3d import Point3D, Pose3D, Quaternion

from .sampler import Iterator, Sampler


class PutDownPoseSampler(Sampler[Pose3D]):
    """A sampler for put-down poses when placing objects."""

    def __init__(self, surface: PutDownSurface, rng_seed: int, sample_limit: int):
        """Initialize the put-down pose sampler with a placement surface.

        Notation: p_SO denotes the pose of the (placed) object O w.r.t. the frame of
            the placement surface S. This sampler samples such poses.

        :param surface: Surface over which put-down poses are sampled
        :param rng_seed: Seed used to initialize the sampler's RNG
        :param sample_limit: Number of samples before the sampler is exhausted
        """
        super().__init__(rng_seed=rng_seed, sample_limit=sample_limit)

        self.surface = surface  # Placement surface to sample poses over

    def get_generator(self) -> Iterator[Pose3D]:
        """Create a lazy iterator over the grasp pose sampler's outputs.

        :returns: Generator object providing an iterator over sampled outputs
        """
        while self.samples_left:
            # TODO: Avoid surface edges by *at least* the radius of the placed object
            x_m = self.surface.x_extent.random(self.rng)
            y_m = self.surface.y_extent.random(self.rng)

            yaw_rad = self.rng.uniform(0, 2.0 * np.pi)  # No constraints on valid yaw

            yield Pose3D(
                Point3D(x_m, y_m, self.surface.height_m),
                Quaternion.from_euler(0, 0, yaw_rad),
            )
