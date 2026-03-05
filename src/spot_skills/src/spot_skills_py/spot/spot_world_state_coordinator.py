"""Coordinate Spot-specific world-state lifecycle and runtime checkpoint persistence."""

from __future__ import annotations

from pathlib import Path

import rospy
from robotics_utils.io.world_state_checkpoint_schema import WorldStateCheckpointSchema
from robotics_utils.spatial import Pose3D
from robotics_utils.states import GraspAttachment, ObjectCentricState, WorldStateStore
from robotics_utils.states.world_state_store import LoadCheckpointOutcome


class SpotWorldStateCoordinator:
    """Coordinate runtime state load/save/reset for Spot and MoveIt integration."""

    def __init__(
        self,
        *,
        manipulator,
        env_yaml_path: Path,
        robot_key: str,
        overlay_enabled: bool = True,
        overlay_dir: Path = Path("/tmp/spot_skills/state_overlays"),
        stale_after_s: float = 300.0,
        autoload: bool = True,
        autosave: bool = True,
        clear_on_reset: bool = True,
    ) -> None:
        """Initialize the coordinator with persistence and load-policy settings."""
        self.manipulator = manipulator
        self.robot_key = robot_key

        self.overlay_enabled = overlay_enabled
        self.autoload = autoload
        self.autosave = autosave
        self.clear_on_reset = clear_on_reset

        self._baseline_env_yaml = env_yaml_path.resolve()
        self._state: ObjectCentricState | None = None

        self._state_store = WorldStateStore(overlay_dir=overlay_dir, stale_after_s=stale_after_s)

    @property
    def state(self) -> ObjectCentricState:
        """Access the active world state managed by this coordinator."""
        if self._state is None:
            raise RuntimeError("World state has not been loaded yet.")
        return self._state

    @property
    def baseline_env_yaml(self) -> Path:
        """Access the current baseline environment YAML path."""
        return self._baseline_env_yaml

    @property
    def checkpoint_path(self) -> Path:
        """Retrieve the expected checkpoint filepath for the active baseline."""
        return self._state_store.checkpoint_path(
            robot_key=self.robot_key,
            baseline_env_yaml=self._baseline_env_yaml,
        )

    def load_initial_state(self) -> ObjectCentricState:
        """Load the baseline state and optionally apply a fresh runtime checkpoint."""
        state = ObjectCentricState.from_yaml(self._baseline_env_yaml)
        self._register_manipulator_frames(state)

        if self.overlay_enabled and self.autoload:
            load_outcome = self._state_store.load_checkpoint(
                robot_key=self.robot_key,
                baseline_env_yaml=self._baseline_env_yaml,
            )
            self._log_checkpoint_load_outcome(load_outcome)
            if load_outcome.checkpoint is not None:
                self._apply_checkpoint(state, load_outcome.checkpoint)

        self._set_state(state)
        return state

    def restore_attached_objects_in_planning_scene(self) -> bool:
        """Rebuild MoveIt's attached-object state based on active grasps in the world state."""
        all_attached = True
        for grasp in self.state.grasp_attachments:
            attached = self.manipulator.planning_scene.attach_object(
                obj_name=grasp.obj_name,
                robot_name=grasp.robot_name,
                ee_link_name=grasp.ee_link_name,
                touch_links=list(grasp.touching_link_names),
            )
            if not attached:
                rospy.logwarn(
                    "Failed to restore attached object '%s' to end-effector '%s'.",
                    grasp.obj_name,
                    grasp.ee_link_name,
                )
            all_attached = all_attached and attached

        return all_attached

    def save_checkpoint(self) -> Path | None:
        """Persist a checkpoint for the current state, if overlays are enabled."""
        if not self.overlay_enabled:
            return None

        checkpoint_path = self._state_store.save_checkpoint(
            state=self.state,
            robot_key=self.robot_key,
            baseline_env_yaml=self._baseline_env_yaml,
        )
        rospy.loginfo("Saved state overlay checkpoint to '%s'.", checkpoint_path)
        return checkpoint_path

    def clear_checkpoint(self) -> bool:
        """Clear the current checkpoint for the active baseline environment."""
        if not self.overlay_enabled:
            return False

        cleared = self._state_store.clear_checkpoint(
            robot_key=self.robot_key,
            baseline_env_yaml=self._baseline_env_yaml,
        )
        if cleared:
            rospy.loginfo("Cleared state overlay checkpoint at '%s'.", self.checkpoint_path)
        return cleared

    def reset_state(
        self,
        *,
        yaml_path: Path | None = None,
        clear_checkpoint: bool | None = None,
    ) -> ObjectCentricState:
        """Reset the active state from a baseline YAML, optionally clearing overlay state."""
        clear_checkpoint = self.clear_on_reset if clear_checkpoint is None else clear_checkpoint
        prior_baseline = self._baseline_env_yaml
        next_baseline = prior_baseline if yaml_path is None else yaml_path.resolve()

        if clear_checkpoint:
            self.clear_checkpoint()
            if next_baseline != prior_baseline and self.overlay_enabled:
                self._state_store.clear_checkpoint(
                    robot_key=self.robot_key,
                    baseline_env_yaml=next_baseline,
                )

        self._baseline_env_yaml = next_baseline

        state = ObjectCentricState.from_yaml(self._baseline_env_yaml)
        self._register_manipulator_frames(state)
        self._set_state(state)

        if not clear_checkpoint:
            self._autosave_if_requested()

        return state

    def set_known_object_pose(self, obj_name: str, pose: Pose3D, *, persist: bool = True) -> None:
        """Set a known object pose and optionally persist the resulting state."""
        self.state.set_known_object_pose(obj_name=obj_name, pose=pose)
        self._autosave_if_requested(persist=persist)

    def clear_object_pose(self, obj_name: str, *, persist: bool = True) -> None:
        """Clear an object's pose and optionally persist the resulting state."""
        self.state.clear_object_pose(obj_name=obj_name)
        self._autosave_if_requested(persist=persist)

    def attach_grasp(self, grasp: GraspAttachment, *, persist: bool = True) -> None:
        """Attach a grasp in state and optionally persist the resulting overlay."""
        if grasp.robot_name not in self.state.robot_names:
            self.state.add_robot(grasp.robot_name)

        if not self.state.has_end_effector(
            robot_name=grasp.robot_name,
            ee_link_name=grasp.ee_link_name,
        ):
            self.state.add_end_effector(
                robot_name=grasp.robot_name,
                ee_link_name=grasp.ee_link_name,
            )

        self.state.attach_grasp(grasp)
        self._autosave_if_requested(persist=persist)

    def get_grasp_for_object(self, obj_name: str) -> GraspAttachment | None:
        """Retrieve the active grasp for the named object, if any."""
        return self.state.get_grasp_for_object(obj_name)

    def detach_grasp_for_object(
        self,
        obj_name: str,
        *,
        persist: bool = True,
    ) -> GraspAttachment | None:
        """Detach the named object from state and optionally persist."""
        detached = self.state.detach_grasp_for_object(obj_name)
        self._autosave_if_requested(persist=persist)
        return detached

    def hide_object(self, obj_name: str, *, persist: bool = True) -> None:
        """Hide an object in state and optionally persist."""
        self.state.hide_object(obj_name=obj_name)
        self._autosave_if_requested(persist=persist)

    def unhide_object(self, obj_name: str, *, persist: bool = True) -> None:
        """Unhide an object in state and optionally persist."""
        self.state.unhide_object(obj_name=obj_name)
        self._autosave_if_requested(persist=persist)

    def open_container(self, container_name: str, *, persist: bool = True) -> None:
        """Open a container in state and optionally persist."""
        self.state.open_container(container_name=container_name)
        self._autosave_if_requested(persist=persist)

    def close_container(self, container_name: str, *, persist: bool = True) -> None:
        """Close a container in state and optionally persist."""
        self.state.close_container(container_name=container_name)
        self._autosave_if_requested(persist=persist)

    def _set_state(self, state: ObjectCentricState) -> None:
        """Set the active state and bind it to the manipulator for grasp bookkeeping."""
        self._state = state
        self.manipulator._env_state = state  # noqa: SLF001

    def _register_manipulator_frames(self, state: ObjectCentricState) -> None:
        """Ensure the manipulator's robot and end-effector names are registered in state."""
        if self.manipulator.robot_name not in state.robot_names:
            state.add_robot(self.manipulator.robot_name)

        if not state.has_end_effector(
            robot_name=self.manipulator.robot_name,
            ee_link_name=self.manipulator.ee_link_name,
        ):
            state.add_end_effector(
                robot_name=self.manipulator.robot_name,
                ee_link_name=self.manipulator.ee_link_name,
            )

    def _autosave_if_requested(self, *, persist: bool = True) -> None:
        """Persist state if persistence is enabled and the mutation requested it."""
        if persist and self.autosave:
            self.save_checkpoint()

    def _apply_checkpoint(
        self,
        state: ObjectCentricState,
        checkpoint: WorldStateCheckpointSchema,
    ) -> None:
        """Apply a parsed checkpoint onto the given baseline-loaded world state."""
        default_frame = state.kinematic_tree.root_frame

        for container_name, status in checkpoint.container_statuses.items():
            if container_name not in state.containers:
                rospy.logwarn("Skipping unknown checkpoint container '%s'.", container_name)
                continue

            if status == "open":
                state.open_container(container_name)
            else:
                state.close_container(container_name)

        for obj_name, pose_schema in checkpoint.known_object_poses.items():
            if obj_name not in state.object_names:
                rospy.logwarn("Skipping unknown checkpoint object pose '%s'.", obj_name)
                continue

            pose = Pose3D.from_schema(pose_schema, default_frame=default_frame)
            state.set_known_object_pose(obj_name, pose)

        for grasp_schema in checkpoint.active_grasps:
            if grasp_schema.obj_name not in state.object_names:
                rospy.logwarn("Skipping grasp for unknown object '%s'.", grasp_schema.obj_name)
                continue

            if grasp_schema.robot_name not in state.robot_names:
                state.add_robot(grasp_schema.robot_name)

            if not state.has_end_effector(
                robot_name=grasp_schema.robot_name,
                ee_link_name=grasp_schema.ee_link_name,
            ):
                state.add_end_effector(
                    robot_name=grasp_schema.robot_name,
                    ee_link_name=grasp_schema.ee_link_name,
                )

            pose_ee_o = Pose3D.from_schema(grasp_schema.pose_ee_o, default_frame=default_frame)
            grasp = GraspAttachment(
                obj_name=grasp_schema.obj_name,
                robot_name=grasp_schema.robot_name,
                ee_link_name=grasp_schema.ee_link_name,
                pose_ee_o=pose_ee_o,
                touching_link_names=set(grasp_schema.touching_link_names),
            )

            try:
                state.attach_grasp(grasp)
            except ValueError as err:
                rospy.logwarn("Skipping invalid checkpoint grasp for '%s': %s", grasp.obj_name, err)

        for hidden_obj_name in checkpoint.hidden_objects:
            if hidden_obj_name not in state.object_names:
                rospy.logwarn("Skipping hidden checkpoint object '%s'.", hidden_obj_name)
                continue

            if hidden_obj_name in state.hidden_object_names:
                continue

            try:
                state.hide_object(hidden_obj_name)
            except ValueError as err:
                rospy.logwarn("Unable to hide checkpoint object '%s': %s", hidden_obj_name, err)

    def _log_checkpoint_load_outcome(self, outcome: LoadCheckpointOutcome) -> None:
        """Log the result of a checkpoint load attempt."""
        if outcome.checkpoint is not None:
            rospy.loginfo(outcome.message)
            return

        if outcome.message.startswith("No checkpoint found"):
            rospy.loginfo(outcome.message)
            return

        rospy.logwarn("Skipped world-state checkpoint: %s", outcome.message)
