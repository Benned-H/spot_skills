"""Define functions to enable Spot to erase a whiteboard.

Note: Adapted from the Spot SDK example "erase.py"
"""

import time

from bosdyn.api import (
    arm_command_pb2,
    geometry_pb2,
    robot_command_pb2,
    synchronized_command_pb2,
    trajectory_pb2,
)
from bosdyn.api.spot import robot_command_pb2 as spot_command_pb2
from bosdyn.client import math_helpers
from bosdyn.client.frame_helpers import (
    BODY_FRAME_NAME,
    GRAV_ALIGNED_BODY_FRAME_NAME,
    ODOM_FRAME_NAME,
    get_a_tform_b,
)
from bosdyn.client.robot_command import RobotCommandBuilder
from bosdyn.util import seconds_to_duration
from transform_utils.kinematics import Point3D

from spot_skills_py.spot.spot_manager import SpotManager


def erase_board(manager: SpotManager) -> None:
    """Use the given Spot manager to erase a whiteboard in front of Spot."""
    assert manager.has_arm(), "Robot requires an arm to erase a whiteboard!"

    manager.log_info("Now starting erase_board()...")

    # Make Spot stand and enable Spot to adjust its body height to assist manipulation
    body_control = spot_command_pb2.BodyControlParams(
        body_assist_for_manipulation=spot_command_pb2.BodyControlParams.BodyAssistForManipulation(
            enable_hip_height_assist=True,
            enable_body_yaw_assist=True,
        ),
    )

    manager.stand_up(10, control_params=body_control)
    manager.deploy_arm()  # Unstow Spot's arm

    # Start in gravity-compensation mode (but zero force)
    f_x = 0  # Newtons
    f_y = 0
    f_z = 0

    # We won't have any rotational torques
    torque_x = 0
    torque_y = 0
    torque_z = 0

    # Duration in seconds.
    seconds = 1000

    # Use the helper function to build a single wrench
    command = RobotCommandBuilder.arm_wrench_command(
        f_x,
        f_y,
        f_z,
        torque_x,
        torque_y,
        torque_z,
        BODY_FRAME_NAME,
        seconds,
    )

    command_id = manager.send_robot_command(command)
    manager.log_info("Zero force commanded...")

    time.sleep(2.0)  # TODO: Should we instead wait for the command to finish?

    # --------------- #

    # Hybrid position-force mode and trajectories.

    f_x = 10
    hand_point_coords: list[Point3D] = [
        Point3D(1.2, 0.2, 0.3),
        Point3D(1.2, 0.2, 0.7),
        Point3D(1.2, 0.12, 0.7),
        Point3D(1.2, 0.12, 0.3),
        Point3D(1.2, 0.04, 0.3),
        Point3D(1.2, 0.04, 0.7),
        Point3D(1.2, -0.04, 0.7),
        Point3D(1.2, -0.04, 0.3),
        Point3D(1.2, -0.12, 0.3),
        Point3D(1.2, -0.12, 0.7),
        Point3D(1.2, -0.2, 0.7),
        Point3D(1.2, -0.2, 0.3),
    ]

    hand_points = [geometry_pb2.Vec3(x=p.x, y=p.y, z=p.z) for p in hand_point_coords]

    quat = geometry_pb2.Quaternion(w=1, x=0, y=0, z=0)

    # Build a position trajectory
    hand_poses_in_flat_body = [
        geometry_pb2.SE3Pose(position=hand_point, rotation=quat) for hand_point in hand_points
    ]

    robot_state = manager.get_robot_state()

    odom_t_flat_body = get_a_tform_b(
        robot_state.kinematic_state.transforms_snapshot,
        ODOM_FRAME_NAME,
        GRAV_ALIGNED_BODY_FRAME_NAME,
    )

    hand_poses = [
        odom_t_flat_body * math_helpers.SE3Pose.from_proto(hand_pose_in_flat_body)
        for hand_pose_in_flat_body in hand_poses_in_flat_body
    ]

    traj_time = 5.0
    time_since_reference = seconds_to_duration(traj_time)
    traj_points = [
        trajectory_pb2.SE3TrajectoryPoint(
            pose=hand_pose.to_proto(),
            time_since_reference=time_since_reference,
        )
        for hand_pose in hand_poses
    ]

    hand_trajs = [
        trajectory_pb2.SE3Trajectory(points=[traj_points[i], traj_points[i + 1]])
        for i in range(len(traj_points) - 1)
    ]

    # We'll use a constant wrench here.
    force_tuple = odom_t_flat_body.rotation.transform_point(x=f_x, y=f_y, z=f_z)
    force = geometry_pb2.Vec3(x=force_tuple[0], y=force_tuple[1], z=force_tuple[2])
    torque = geometry_pb2.Vec3(x=0, y=0, z=0)
    wrench = geometry_pb2.Wrench(force=force, torque=torque)

    duration = seconds_to_duration(5)
    traj_point = trajectory_pb2.WrenchTrajectoryPoint(
        wrench=wrench,
        time_since_reference=duration,
    )
    trajectory = trajectory_pb2.WrenchTrajectory(points=[traj_point])
    for hand_traj in hand_trajs:
        arm_cartesian_command = arm_command_pb2.ArmCartesianCommand.Request(
            pose_trajectory_in_task=hand_traj,
            root_frame_name=ODOM_FRAME_NAME,
            wrench_trajectory_in_task=trajectory,
            x_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_FORCE,
            y_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            z_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            rx_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            ry_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
            rz_axis=arm_command_pb2.ArmCartesianCommand.Request.AXIS_MODE_POSITION,
        )
        arm_command = arm_command_pb2.ArmCommand.Request(
            arm_cartesian_command=arm_cartesian_command,
        )
        synchronized_command = synchronized_command_pb2.SynchronizedCommand.Request(
            arm_command=arm_command,
        )
        robot_command = robot_command_pb2.RobotCommand(
            synchronized_command=synchronized_command,
        )

        # Send the request
        command_id = manager.send_robot_command(robot_command)
        manager.block_until_arm_arrives(command_id)

    time.sleep(2)  # Chill after erasing for a bit

    # Stow Spot's arm to indicate that erasing has finished
    manager.stow_arm()
