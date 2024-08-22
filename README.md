# spot_skills

Motion-planning-based skills for Boston Dynamics' Spot robot

## Docker Commands

This repository uses Docker to manage dependencies. To build and start the GPU-enabled container, run the command:
```bash
docker compose up --build --detach
```

Then, to enter the container, run the following commands:
```bash
xhost +local:docker
docker compose attach noetic-nvidia
```

## One-Off Commands

To re-generate Spot's URDF, run the following commands from the repo-level `spot_skills` directory:
```bash
export SPOT_ARM=1       # Include Spot's arm in the generated URDF
xacro src/spot_ros/spot_description/urdf/spot.urdf.xacro > src/spot_skills/urdf/spot_with_arm.urdf
```