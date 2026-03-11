"""Define a class to control Spot's arm using the Spot SDK."""


# def log_debug_info(self, schedule: SegmentSchedule, traj: ArmJointTrajectory) -> None:
#     """Log debug information about the given schedule and trajectory command."""
#     self._manager.log_info(f"Trajectory segment length: {len(traj.points)}")

#     self._manager.log_info(
#         f"Schedule local reference time: {schedule.ref_local_time_s:.3f} seconds.",
#     )

#     first_rel_time_s = duration_to_seconds(traj.points[0].time_since_reference)
#     last_rel_time_s = duration_to_seconds(traj.points[-1].time_since_reference)

#     self._manager.log_info(f"First relative time in segment: {first_rel_time_s:.3f} seconds.")
#     self._manager.log_info(f"Last relative time in segment: {last_rel_time_s:.3f} seconds.")

#     segment_duration_s = last_rel_time_s - first_rel_time_s
#     self._manager.log_info(f"Total segment duration: {segment_duration_s:.3f} seconds.")

#     self._manager.log_info(f"Local clock time: {time.time():.3f} seconds.")

#     return ArmCommandOutcome.PREEMPTED if preempted else ArmCommandOutcome.SUCCESS

# def command_end_effector_body_velocity(
#     self,
#     linear_x_mps: float,
#     linear_y_mps: float,
#     linear_z_mps: float,
#     angular_x_radps: float,
#     angular_y_radps: float,
#     angular_z_radps: float,
#     duration_s: float = 0.2,
# ) -> bool:
#     """Command Spot's end-effector velocity in Spot's body frame via short-horizon updates."""
#     if self._locked:
#         self._manager.log_info(
#             "Rejected end-effector velocity command; Spot's arm remains locked.",
#         )
#         return False

#     if not self._manager.has_control:
#         self._manager.log_info(
#             "Rejected end-effector velocity command; SpotManager doesn't control Spot.",
#         )
#         return False

#     if duration_s <= 0:
#         self._manager.log_info(
#             "Rejected end-effector velocity command with non-positive duration.",
#         )
#         return False

#     try:
#         current_sdk_pose_b_ee = self._manager.get_hand_pose(ref_frame=BODY_FRAME_NAME)
#     except Exception as exc:
#         self._manager.log_info(
#             f"Rejected end-effector velocity command; failed to read hand pose: {exc}",
#         )
#         return False

#     current_pose_b_ee = pose_from_sdk(current_sdk_pose_b_ee, ref_frame=BODY_FRAME_NAME)
#     target_position = Point3D(
#         x=current_pose_b_ee.position.x + (linear_x_mps * duration_s),
#         y=current_pose_b_ee.position.y + (linear_y_mps * duration_s),
#         z=current_pose_b_ee.position.z + (linear_z_mps * duration_s),
#     )
#     target_orientation = self._integrate_body_angular_velocity(
#         current_pose_b_ee.orientation,
#         angular_x_radps=angular_x_radps,
#         angular_y_radps=angular_y_radps,
#         angular_z_radps=angular_z_radps,
#         duration_s=duration_s,
#     )
#     target_pose_b_ee = Pose3D(
#         position=target_position,
#         orientation=target_orientation,
#         ref_frame=BODY_FRAME_NAME,
#     )

#     return self.command_end_effector_pose(target_pose_b_ee, duration_s)

# @staticmethod
# def _integrate_body_angular_velocity(
#     start_orientation: Quaternion,
#     angular_x_radps: float,
#     angular_y_radps: float,
#     angular_z_radps: float,
#     duration_s: float,
# ) -> Quaternion:
#     """Integrate a constant body-frame angular velocity over a short duration."""
#     angular_norm = math.sqrt(
#         (angular_x_radps * angular_x_radps)
#         + (angular_y_radps * angular_y_radps)
#         + (angular_z_radps * angular_z_radps),
#     )
#     if angular_norm <= 1e-12:
#         return start_orientation

#     half_angle = 0.5 * angular_norm * duration_s
#     axis_scale = math.sin(half_angle) / angular_norm
#     delta_orientation = Quaternion(
#         x=angular_x_radps * axis_scale,
#         y=angular_y_radps * axis_scale,
#         z=angular_z_radps * axis_scale,
#         w=math.cos(half_angle),
#     )
#     return start_orientation * delta_orientation
