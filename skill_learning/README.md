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
│   ├── model.py            # BC-RNN model (ResNet encoder + GRU)
│   ├── dataset.py           # Dataset and dataloader utilities
│   └── utils.py             # Rosbag parsing, TF extraction, sync
├── config/
│   ├── training_params.yaml  # Training hyperparameters
│   └── ros_node_params.yaml  # Deployment config (topics, model params)
├── train.py                  # Training script
├── deploy_ros_node.py        # ROS1 deployment node
├── test.py                   # Smoke tests (model, dataset, training, deploy)
├── docker/
│   └── lerobot_docker.sh
└── README.md
```

## Training

Edit hyperparameters in [config/training_params.yaml](config/training_params.yaml), then run:

```bash
python train.py --config config/training_params.yaml
```

Checkpoints saved: `best.pt` (lowest validation loss), periodic (`epoch_NNN.pt`), and `final.pt`.

## Testing

```bash
python test.py
```

## ROS1 Deployment

Run the trained policy on the robot:

```bash
rosrun spot_skills deploy_ros_node.py --config config/ros_node_params.yaml
```

The node subscribes to a camera image topic and `/tf`, runs the BC-RNN model at a fixed rate, and publishes predicted poses as `geometry_msgs/PoseStamped`. All parameters (topics, model config, rate) are configured in [config/ros_node_params.yaml](config/ros_node_params.yaml).
