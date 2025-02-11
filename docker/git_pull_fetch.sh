#!/usr/bin/env bash

# Pull, fetch, and update all submodules according to the remote version

# Move to the directory of this script, then to the top of the repository
cd `dirname "$0"`
cd ..

# Only proceed if there are no untracked local changes
if [ -n "$(git status --porcelain)" ]; then
    echo "Local changes detected, cannot safely pull from remote..."
    exit 1
fi

git pull --prune
git submodule update --init --recursive
