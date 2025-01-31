"""Install the spot_skills Python package using Catkin."""

from distutils.core import setup

from catkin_pkg.python_setup import generate_distutils_setup

# Fetch values from package.xml
setup_args = generate_distutils_setup(
    packages=["spot_skills_py", "transform_utils"],
    package_dir={"": "src"},
)
setup(**setup_args)
