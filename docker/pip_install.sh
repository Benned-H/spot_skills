#!/usr/bin/env bash

# Install the project's Python packages (and their dependencies)
# Reference: https://stackoverflow.com/a/35064498/10278033
pip install -e /docker/spot_skills
pip install -e /docker/spot_skills/src/spot_skills/src/transform_utils
