#!/bin/bash

# Move to the directory of this script
cd $(dirname "$0") || exit 1
source ros_docker/scripts/filesystem.sh

spot_skills_path="$HOME/Documents/spot_skills"
spot_skills_remote="git@github.com:Benned-H/spot_skills.git"
pose_path="$HOME/Documents/pose"
pose_remote="git@github.com:SpotIncarnated/pose.git"

check_repo "$HOME/Documents/spot_skills" "git@github.com:Benned-H/spot_skills.git"
check_repo "$HOME/Documents/pose" "git@github.com:SpotIncarnated/pose.git"

# Verify that tmux is installed (script can't install it without sudo)
source ros_docker/scripts/commandline.sh
check_command "tmux" "sudo apt install tmux"

# If the user doesn't have a tmux config, install a baseline ~/.tmux.conf
tmux_conf="$HOME/.tmux.conf"
tmux_raw_gist_url="https://gist.githubusercontent.com/Benned-H/6b6836e02d4b9bd2974ac0b8572800fe/raw/1053e3c72f1312db07f11a38a7546793c4f6033e/.tmux.conf"
tpm_path="$HOME/.tmux/plugins/tpm"

if [ ! -f "$tmux_conf" ]; then
	wget -O "$tmux_conf" "$tmux_raw_gist_url"
else
	echo "${tmux_conf} already exists; leaving as-is..."
fi
check_file "$tmux_conf"

# Check for tmux plugin manager (tpm), install if missing
if [ ! -d "$tpm_path" ]; then
	git clone https://github.com/tmux-plugins/tpm "$tpm_path"
fi

# Create the tmux session
session="pose-estimate"
if [ "$(tmux ls 2>/dev/null | grep ${session})" ]; then
	tmux kill-session -t "$session"
fi
tmux new-session -d -s "$session"

tmux source-file "$tmux_conf"
"${tpm_path}/bin/install_plugins"

# Ask for user input once all environment verification is complete
echo "Environment verification is complete. Press any key to continue..."
read -n1

# Window 1: Docker containers
w1="docker"
tmux rename-window -t "${session}:{start}" "$w1"
tmux send-keys -t "${session}:${w1}" "xhost +local:docker" C-m
tmux split-window -h

# Window 1.1 (left): Spot Skills
tmux send-keys -t {left} "cd $spot_skills_path" C-m "bash docker/launch.sh" C-m "bash /entrypoint.sh" \
	C-m "source docker/source.sh" C-m "echo -e '\nLaunch the Spot bringup nodes using the command:\n    roslaunch spot_skills pose_estimation_demo.launch'" C-m

# Window 1.2 (right): Pose
tmux send-keys -t {right} "cd $pose_path" C-m "sh docker/run_container_ros1.sh" C-m \
	"cd /docker/pose/pose_ws" C-m "catkin_make" C-m "cd /docker/pose" C-m \
	"echo -e '\nLaunch the pose estimation server using the command:\n    sh /docker/pose/run_service.sh'" C-m

# Window 2: Git (again, spot_skills and pose)
w2="git"
tmux new-window -t "${session}:{start}" -a -n "$w2"
tmux split-window -h

tmux send-keys -t {left} "cd $spot_skills_path" C-m "clear" C-m "git status" C-m
tmux send-keys -t {right} "cd $pose_path" C-m "clear" C-m "git status" C-m

# Attach to the spot_skills Docker
tmux attach-session -t "${session}:${w1}.{left}"
