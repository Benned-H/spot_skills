"""Define a dataclass representing a range of real numbers."""

from dataclasses import dataclass

from numpy.random import Generator


@dataclass
class RealRange:
    """A continuous range of real numbers between two bounds."""

    lower: float
    upper: float

    def __post_init__(self) -> None:
        """Verify that the range bounds are valid after initialization."""
        assert self.lower <= self.upper, "Lower bound cannot exceed upper bound."

    def random(self, rng: Generator) -> float:
        """Sample a uniformly random value within the range.

        :param rng: Random number generator
        """
        return rng.uniform(low=self.lower, high=self.upper)
