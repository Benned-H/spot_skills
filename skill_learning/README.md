# Skill Learning

BC-RNN (Behavior Cloning with Recurrent Neural Networks) for Spot manipulation tasks.

## Setup

All dependencies are pre-installed in the Docker container. To start the environment:

```bash
cd skill_learning/docker
./lerobot_docker.sh
```

This launches the `huggingface/lerobot-gpu` container with GPU support and mounts the workspace at `/spot_skills`.

## Data Collection

Demonstrations must be collected before training. The pipeline is:

1. **Record** demonstrations as ROS bag files on the robot.
2. **Extract** TF transforms and images from the bags:
   ```bash
   python -m src.utils save --bag <path_to_bag> --topic /tf --out tf.npy
   python -m src.utils save --bag <path_to_bag> --topic /camera/image --out images/
   ```
3. **Sync** images and transforms by timestamp:
   ```bash
   python -m src.utils sync --images images/ --tf tf.npy --out synced.npy
   ```

## Project Structure

```
skill_learning/
├── src/
│   ├── model.py      # BC-RNN model (ResNet encoder + GRU)
│   ├── dataset.py     # Dataset and dataloader utilities
│   └── utils.py       # Rosbag parsing, TF extraction, sync
├── test.py            # Smoke tests for model and dataset
├── docker/
│   └── lerobot_docker.sh
└── README.md
```

## Usage

Run tests:

```bash
python test.py
```

## ROS1 Deployment

WIP -- a deployment node for running trained policies on Spot via ROS1 is planned.
