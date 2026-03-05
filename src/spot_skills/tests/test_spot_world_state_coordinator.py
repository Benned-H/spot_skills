"""Tests for SpotWorldStateCoordinator runtime state orchestration."""

from __future__ import annotations

from pathlib import Path

import pytest

from robotics_utils.io.yaml_utils import export_yaml_data
from robotics_utils.spatial import Pose3D
from robotics_utils.states import GraspAttachment, WorldStateStore
from spot_skills_py.spot.spot_world_state_coordinator import SpotWorldStateCoordinator


class FakePlanningScene:
    """Minimal planning-scene stub for coordinator tests."""

    def __init__(self) -> None:
        self.attached_calls: list[tuple[str, str, str, tuple[str, ...]]] = []

    def attach_object(
        self,
        obj_name: str,
        robot_name: str,
        ee_link_name: str,
        touch_links: list[str],
    ) -> bool:
        """Record attach requests and report success."""
        self.attached_calls.append((obj_name, robot_name, ee_link_name, tuple(sorted(touch_links))))
        return True


class FakeManipulator:
    """Minimal manipulator stub exposing fields used by the coordinator."""

    def __init__(self) -> None:
        self.robot_name = "Spot"
        self.ee_link_name = "gripper_link"
        self.planning_scene = FakePlanningScene()
        self._env_state = None


@pytest.fixture
def container_env_yaml() -> Path:
    """Return path to an environment with containers and graspable objects."""
    yaml_path = Path(__file__).resolve().parents[1] / "src/robotics_utils/tests/test_data/yaml/filing_cabinets_env.yaml"
    assert yaml_path.exists(), f"Expected test YAML to exist: {yaml_path}"
    return yaml_path


def _make_coordinator(
    *,
    manipulator: FakeManipulator,
    env_yaml_path: Path,
    overlay_dir: Path,
    autoload: bool,
    autosave: bool,
) -> SpotWorldStateCoordinator:
    """Construct a coordinator with standard defaults for tests."""
    return SpotWorldStateCoordinator(
        manipulator=manipulator,
        env_yaml_path=env_yaml_path,
        robot_key="spot-host",
        overlay_enabled=True,
        overlay_dir=overlay_dir,
        stale_after_s=300.0,
        autoload=autoload,
        autosave=autosave,
        clear_on_reset=True,
    )


def test_startup_restore_reattaches_active_grasps(tmp_path: Path, container_env_yaml: Path) -> None:
    """Verify active grasps from checkpoint are restored as MoveIt attachments on startup."""
    baseline_state_store = WorldStateStore(overlay_dir=tmp_path, stale_after_s=300.0)

    coordinator_for_seed = _make_coordinator(
        manipulator=FakeManipulator(),
        env_yaml_path=container_env_yaml,
        overlay_dir=tmp_path,
        autoload=False,
        autosave=True,
    )
    seeded_state = coordinator_for_seed.load_initial_state()

    seeded_state.add_end_effector(robot_name="Spot", ee_link_name="gripper_link")
    seeded_state.attach_grasp(
        GraspAttachment(
            obj_name="eraser1",
            robot_name="Spot",
            ee_link_name="gripper_link",
            pose_ee_o=Pose3D.from_xyz_rpy(x=0.03, y=0.0, z=0.22, ref_frame="gripper_link"),
            touching_link_names={"gripper_link"},
        ),
    )
    baseline_state_store.save_checkpoint(
        state=seeded_state,
        robot_key="spot-host",
        baseline_env_yaml=container_env_yaml,
    )

    manipulator = FakeManipulator()
    coordinator = _make_coordinator(
        manipulator=manipulator,
        env_yaml_path=container_env_yaml,
        overlay_dir=tmp_path,
        autoload=True,
        autosave=True,
    )
    coordinator.load_initial_state()

    assert coordinator.get_grasp_for_object("eraser1") is not None
    assert coordinator.restore_attached_objects_in_planning_scene()
    assert manipulator.planning_scene.attached_calls
    attached_obj_names = {call[0] for call in manipulator.planning_scene.attached_calls}
    assert "eraser1" in attached_obj_names


def test_detach_grasp_updates_persisted_overlay(tmp_path: Path, container_env_yaml: Path) -> None:
    """Verify detaching a grasp updates the persisted overlay state."""
    coordinator = _make_coordinator(
        manipulator=FakeManipulator(),
        env_yaml_path=container_env_yaml,
        overlay_dir=tmp_path,
        autoload=False,
        autosave=True,
    )
    coordinator.load_initial_state()

    coordinator.attach_grasp(
        GraspAttachment(
            obj_name="eraser1",
            robot_name="Spot",
            ee_link_name="gripper_link",
            pose_ee_o=Pose3D.from_xyz_rpy(x=0.02, z=0.21, ref_frame="gripper_link"),
            touching_link_names={"gripper_link"},
        ),
        persist=True,
    )

    store = WorldStateStore(overlay_dir=tmp_path, stale_after_s=300.0)
    load_before_detach = store.load_checkpoint(
        robot_key="spot-host",
        baseline_env_yaml=container_env_yaml,
    )
    assert load_before_detach.checkpoint is not None
    assert len(load_before_detach.checkpoint.active_grasps) == 1

    coordinator.detach_grasp_for_object("eraser1", persist=True)

    load_after_detach = store.load_checkpoint(
        robot_key="spot-host",
        baseline_env_yaml=container_env_yaml,
    )
    assert load_after_detach.checkpoint is not None
    assert len(load_after_detach.checkpoint.active_grasps) == 0


def test_reset_clears_checkpoint_by_default(tmp_path: Path, container_env_yaml: Path) -> None:
    """Verify reset semantics clear persisted checkpoint state by default."""
    coordinator = _make_coordinator(
        manipulator=FakeManipulator(),
        env_yaml_path=container_env_yaml,
        overlay_dir=tmp_path,
        autoload=False,
        autosave=True,
    )
    coordinator.load_initial_state()

    coordinator.attach_grasp(
        GraspAttachment(
            obj_name="eraser1",
            robot_name="Spot",
            ee_link_name="gripper_link",
            pose_ee_o=Pose3D.from_xyz_rpy(x=0.01, z=0.2, ref_frame="gripper_link"),
            touching_link_names={"gripper_link"},
        ),
    )
    assert coordinator.checkpoint_path.exists()

    coordinator.reset_state(yaml_path=container_env_yaml)

    assert not coordinator.checkpoint_path.exists()


def test_unknown_checkpoint_entries_are_ignored(tmp_path: Path, container_env_yaml: Path) -> None:
    """Verify applying checkpoint with unknown entries does not fail state load."""
    manipulator = FakeManipulator()
    coordinator = _make_coordinator(
        manipulator=manipulator,
        env_yaml_path=container_env_yaml,
        overlay_dir=tmp_path,
        autoload=False,
        autosave=False,
    )
    state = coordinator.load_initial_state()

    state.add_end_effector(robot_name="Spot", ee_link_name="gripper_link")
    state.attach_grasp(
        GraspAttachment(
            obj_name="eraser1",
            robot_name="Spot",
            ee_link_name="gripper_link",
            pose_ee_o=Pose3D.from_xyz_rpy(x=0.03, z=0.22, ref_frame="gripper_link"),
            touching_link_names={"gripper_link"},
        ),
    )

    store = WorldStateStore(overlay_dir=tmp_path, stale_after_s=300.0)
    checkpoint = store.build_checkpoint(
        state=state,
        robot_key="spot-host",
        baseline_env_yaml=container_env_yaml,
    )

    checkpoint_data = checkpoint.model_dump(mode="json")
    checkpoint_data["hidden_objects"].append("unknown_object")
    checkpoint_data["container_statuses"]["unknown_container"] = "open"
    checkpoint_data["active_grasps"].append(
        {
            "obj_name": "missing_object",
            "robot_name": "Spot",
            "ee_link_name": "gripper_link",
            "pose_ee_o": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
            "touching_link_names": ["gripper_link"],
        },
    )

    export_yaml_data(
        data=checkpoint_data,
        filepath=store.checkpoint_path(robot_key="spot-host", baseline_env_yaml=container_env_yaml),
    )

    reloaded = _make_coordinator(
        manipulator=FakeManipulator(),
        env_yaml_path=container_env_yaml,
        overlay_dir=tmp_path,
        autoload=True,
        autosave=False,
    )
    loaded_state = reloaded.load_initial_state()

    assert "unknown_object" not in loaded_state.object_names
    assert reloaded.get_grasp_for_object("eraser1") is not None
