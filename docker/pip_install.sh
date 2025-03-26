#!/usr/bin/env bash

# Install dependencies of the project's Python packages
pip install -r /docker/spot_skills/src/spot_skills/requirements.txt

# Install the project's Python packages on the local machine
# Reference: https://stackoverflow.com/a/35064498/10278033
pip install -e /docker/spot_skills/src/spot_skills
