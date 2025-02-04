"""Define an interface for a sampler of continuous predicate parameters."""

from abc import ABC, abstractmethod
from typing import Generic, Iterator, TypeVar

from numpy.random import default_rng

SampledT = TypeVar("SampledT")


class Sampler(Generic[SampledT], ABC):
    """A generator of continuous parameters for hybrid predicates.

    Type Parameters:
        SampledT: Type of the sampled objects
    """

    def __init__(self, rng_seed: int, sample_limit: int):
        """Initialize the Sampler's random number generator.

        :param rng_seed: Seed used to initialize the sampler's RNG
        :param sample_limit: Number of samples before the sampler is exhausted
        """
        self.seed = rng_seed
        self.rng = default_rng(self.seed)
        self._generator = self.get_generator()

        self.sample_limit = sample_limit  # Number of samples before exhausted
        self.samples_left = self.sample_limit  # Counts down as samples are used
        self.last_sampled_value = None  # Most recent value sampled from the generator

    def reset(self, rng_seed: int) -> None:
        """Reset the state of the sampler using the given random seed.

        :param rng_seed: Seed used to re-initialize the sampler's RNG
        """
        self.seed = rng_seed
        self.rng = default_rng(self.seed)
        self._generator = self.get_generator()
        self.samples_left = self.sample_limit

    def next(self) -> SampledT:
        """Sample the next value from the sampler.

        :returns: Next sampled object from the sampler's generator function
        """
        sample = next(self._generator)
        self.last_sampled_value = sample
        self.samples_left -= 1

        return sample

    @abstractmethod
    def get_generator(self) -> Iterator[SampledT]:
        """Create a lazy iterator over the sampler's outputs.

        :returns: Generator object providing an iterator over sampled outputs
        """
