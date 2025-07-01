"""Define a class to manage replaying recorded trajectories on Spot."""

from __future__ import annotations

import sys
import time
from dataclasses import dataclass
from pathlib import Path

import numpy as np
import rospy
from moveit_commander import MoveGroupCommander, RobotCommander, roscpp_initialize
from moveit_msgs.msg import DisplayTrajectory, RobotTrajectory
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse
from transform_utils.kinematics import Pose3D
from transform_utils.kinematics_ros import pose_to_msg
from transform_utils.transform_manager import TransformManager


@dataclass
class TrajReplayConfig:
    """A set of configuration parameters for the SpotTrajReplay class."""

    ee_frame: str = "arm_link_wr1"
    body_frame: str = "body"
    move_group_name: str = "arm"
    ee_step_resolution_m: float = 0.01  # Resolution (meters) between computed configurations
    pose_lookup_patience_s: float = 5.0  # Duration (seconds) to wait for pose lookup retries
    required_fraction: float = 0.9  # Proportion of the trajectory Cartesian planning must follow


class SpotTrajReplay:
    """A wrapper to manage replaying recorded trajectories on Spot."""

    def __init__(self, config: TrajReplayConfig | None = None) -> None:
        """Initialize the trajectory replayer with a collection of config parameters.

        When the given config is None, default values will be used.

        :param config: Struct of configuration settings for the SpotTrajReplay class
        """
        if config is None:
            config = TrajReplayConfig()

        self.config = config

        roscpp_initialize(sys.argv)  # Need for MoveIt!
        self.move_group = MoveGroupCommander(config.move_group_name, wait_for_servers=30)
        self.move_group.set_pose_reference_frame(config.body_frame)

        self.display_trajectory_publisher = rospy.Publisher(
            "/move_group/display_planned_path",
            DisplayTrajectory,
            queue_size=20,
        )

        self.robot = RobotCommander()

        self._open_cabinet_service = rospy.Service(
            "spot/open_cabinet",
            Trigger,
            self.handle_open_cabinet,
        )

        self.open_traj_filepath = Path(rospy.get_param("/spot/cabinet/open_trajectory"))
        self.close_traj_filepath = Path(rospy.get_param("/spot/cabinet/close_trajectory"))

    def get_end_effector_pose(self) -> Pose3D | None:
        """Retrieve the robot's current end-effector pose w.r.t. the body frame from /tf.

        :return: Pose of the end-effector, else None if transform lookup fails
        """
        ee_frame = self.config.ee_frame
        body_frame = self.config.body_frame

        pose_b_ee = None
        end_time_s = time.time() + self.config.pose_lookup_patience_s
        while pose_b_ee is None and time.time() < end_time_s:
            pose_b_ee = TransformManager.lookup_transform(body_frame, ee_frame)

        if pose_b_ee is None:
            rospy.loginfo(f"Couldn't lookup transform from '{body_frame}' to '{ee_frame}'.")

        return pose_b_ee

    def load_trajectory_from_file(self, initial_ee_pose: Pose3D, traj_path: Path) -> list[Pose3D]:
        """Load a trajectory saved as a NumPy array from the given file.

        :param initial_ee_pose: Initial end-effector pose (w.r.t. body)
        :param traj_path: Filepath to a trajectory to be imported
        :return: Imported trajectory as a list of 3D poses
        """
        assert traj_path.exists(), f"Trajectory file doesn't exist: {traj_path}"

        loaded_traj_arr = np.load(traj_path)  # Assume poses are end-effector w.r.t. body frame
        traj_ref_frame = self.config.body_frame

        # Compute the 'original' end-effector (oee) pose w.r.t. body (b) frame
        pose_b_oee = TransformManager.convert_to_frame(initial_ee_pose, traj_ref_frame)

        poses = [pose_b_oee]
        for pose_matrix in loaded_traj_arr:
            # Each loaded end-effector pose is w.r.t. the original end-effector pose
            next_pose_oee_ee = Pose3D.from_homogeneous_matrix(pose_matrix)
            next_pose_b_ee = pose_b_oee @ next_pose_oee_ee  # Current end-effector (ee) w.r.t. body
            poses.append(next_pose_b_ee)

        # But the poses are all in the end-effector frame, so change their frame directly
        for pose in poses:
            pose.ref_frame = self.config.ee_frame

        # Finally, convert the frame of every pose into Spot's current body frame
        return [TransformManager.convert_to_frame(pose, traj_ref_frame) for pose in poses]

    def compute_cartesian_plan(self, poses: list[Pose3D]) -> RobotTrajectory | None:
        """Compute a Cartesian plan between the given list of end-effector target poses.

        :param poses: List of target end-effector poses
        :return: Resulting trajectory, or None if the waypoints could not be followed
        """
        waypoints = [pose_to_msg(pose) for pose in poses]
        print(f"Type of poses: {type(poses[0])}, Type of waypoints: {type(waypoints[0])}")

        (plan, fraction) = self.move_group.compute_cartesian_path(
            waypoints,
            eef_step=self.config.ee_step_resolution_m,
            avoid_collisions=True,
        )

        # Display the generated trajectory in RViz
        display_trajectory = DisplayTrajectory()
        display_trajectory.trajectory_start = self.robot.get_current_state()
        display_trajectory.trajectory.append(plan)
        self.display_trajectory_publisher.publish(display_trajectory)

        if fraction < self.config.required_fraction:
            rospy.loginfo(f"MoveIt's plan followed {fraction * 100.0:.2f}% of the trajectory")
            return None

        return plan

    def handle_open_cabinet(self, _: TriggerRequest) -> TriggerResponse:
        """Handle a service request to open a cabinet.

        :param _: Message representing a request to open a cabinet
        :return: Response conveying whether the cabinet was opened
        """
        curr_ee_pose = self.get_end_effector_pose()
        trajectory = self.load_trajectory_from_file(curr_ee_pose, self.open_traj_filepath)

        cartesian_plan = self.compute_cartesian_plan(trajectory)

        if cartesian_plan is None:
            message = "Could not open cabinet because the MoveIt Cartesian plan returned None."
            return TriggerResponse(success=False, message=message)

        self.move_group.execute(cartesian_plan, wait=True)

        message = "Successfully executed the OpenCabinet trajectory on the robot."
        return TriggerResponse(success=True, message=message)
