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

Record demonstrations as ROS bag files on the robot, then place the `.bag` files in a data directory (e.g. `data/`). The training script reads `.bag` files directly — no manual extraction or syncing is needed.

Rosbag settings (image topic, TF topic, parent frame, sync threshold) are configured in [config/training_params.yaml](config/training_params.yaml) under the `rosbag` section.

### Manual extraction (optional)

If you prefer to pre-process data or need to inspect intermediate files, you can use `src/utils.py`:

```bash
# Extract images
python -m src.utils save traj_0.bag /camera/image_raw image ./output/images/

# Extract TF transforms
python -m src.utils save traj_0.bag /tf tf ./output/ --parent-frame body --child-frame hand

# Sync images with TF by timestamp
python -m src.utils sync ./output/images/ ./output/tf.npy ./output/synced.npy --threshold 0.05

# Visualize TF trajectories
python -m src.utils visualize ./output/tf.npy --child-frame hand --absolute
```

Pre-synced `.npy` files can also be placed in the data directory alongside `.bag` files — the dataset loads both formats.

## Project Structure

```
skill_learning/
├── src/
│   ├── model.py            # BC-RNN model (ResNet encoder + GRU)
│   ├── dataset.py           # Dataset loader (reads .bag and .npy files)
│   └── utils.py             # Rosbag parsing, TF extraction, sync, visualization
├── config/
│   ├── training_params.yaml  # Training hyperparameters + rosbag settings
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

To save intermediate `.npy` files extracted from rosbags (useful for debugging):

```bash
python train.py --debug
```

Debug files are saved to the directory specified by `debug_dir` in the config (default: `debug/`).

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
