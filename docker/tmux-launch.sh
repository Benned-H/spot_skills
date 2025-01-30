#!/bin/bash

# Begin by verifying proper environment setup
check_directory () {
	local dir_path="$1"
	
	if [ ! -d "$dir_path" ]; then
		echo "Error: Expected to find directory $dir_path"
		exit 1
	fi
}

check_repo() {
	local dir_path="$1"
	local expected_repo_url="$2"

	check_directory "$dir_path"
	
	local working_dir=$(pwd)
	cd "$dir_path" || exit 1
	
	local found_repo_url=$(git config --get remote.origin.url)
	if [ "$expected_repo_url" != "$found_repo_url" ]; then
		echo "Error: Expected directory ${dir_path} to have remote URL '${expected_repo_url}' but instead found '${found_repo_url}'"
		exit 1
	else
		echo "Confirmed that directory ${dir_path} has remote URL '${found_repo_url}'"
	fi

	cd "$working_dir"
}

spot_skills_path="$HOME/Documents/spot_skills"
spot_skills_remote="git@github.com:Benned-H/spot_skills.git"
pose_path="$HOME/Documents/pose"
pose_remote="git@github.com:SpotIncarnated/pose.git"

check_repo "$spot_skills_path" "$spot_skills_remote"
check_repo "$pose_path" "$pose_remote"

# Create the tmux session

session="pose-estimate"
tmux new-session -d -s $session

# Window 1: Docker containers
w1="docker"
tmux rename-window -t "${session}:{start}" "$w1"
tmux send-keys -t "${session}:${w1}" "xhost +local:docker" C-m
tmux split-window -h

# Window 1.1 (left): Spot Skills
tmux send-keys -t {left} "cd $spot_skills_path" C-m "bash docker/launch.sh" C-m \
	"source devel/setup.bash" C-m "clear" C-m "roslaunch spot_skills pose_estimation_demo.launch"

# Window 1.2 (right): Pose
tmux send-keys -t {right} "cd $pose_path" C-m "sh docker/run_container_ros1.sh" C-m \
	"cd /docker/pose/pose_ws" C-m "catkin_make" C-m "cd /docker/pose" C-m "clear" C-m \
	"sh /docker/pose/run_service.sh"

# Window 2: Git (again, spot_skills and pose)
w2="git"
tmux new-window -t "${session}:{start}" -a -n "$w2"
tmux split-window -h

tmux send-keys -t {left} "cd $spot_skills_path" C-m "clear" C-m "git status" C-m
tmux send-keys -t {right} "cd $pose_path" C-m "clear" C-m "git status" C-m

# Attach to the spot_skills Docker
tmux attach-session -t "${session}:${w1}.{left}"
