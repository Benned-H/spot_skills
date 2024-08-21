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
