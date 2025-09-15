#!/usr/bin/env python

"""Unified Spot Skills CLI (ROS 1 Noetic).

- Trigger service skills (stand, sit, etc.)
- Parameterized service skills (playback_trajectory, pose_lookup)
- Motion skills (move_to_pose, move_to_configuration) via MoveIt
- TF broadcasting for pose visualization

Run inside your container/shell with ROS env sourced:
    $ python -m spot_skills_cli   # or chmod +x and execute directly

Design notes:
- Initializes as a ROS node (no spin required).
- Waits for services (with timeouts) and caches proxies.
- Handles Ctrl+C cleanly.
- Trigger-based skills are fully wired.
- PlaybackTrajectory / PoseLookup are stubs pending UX decisions.
"""

from __future__ import annotations

import time
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, Dict, Optional, Tuple

import click
import numpy as np
import rospy
from geometry_msgs.msg import PoseStamped
from rich.console import Console
from rich.markup import escape
from rich.panel import Panel
from rich.prompt import Confirm, FloatPrompt, IntPrompt, Prompt
from rich.table import Table
from rich.text import Text
from robotics_utils.kinematics import DEFAULT_FRAME, Pose3D
from robotics_utils.motion_planning import MotionPlanningQuery
from robotics_utils.robots import GripperAngleLimits
from robotics_utils.ros.moveit_motion_planner import MoveItMotionPlanner
from robotics_utils.ros.msg_conversion import pose_to_stamped_msg
from robotics_utils.ros.planning_scene_manager import PlanningSceneManager
from robotics_utils.ros.pose_broadcast_thread import PoseBroadcastThread
from robotics_utils.ros.robots import MoveItManipulator, ROSAngularGripper
from robotics_utils.ros.services import ServiceCaller, trigger_service
from robotics_utils.ros.transform_manager import TransformManager

# ROS service types
from std_srvs.srv import Trigger, TriggerRequest, TriggerResponse

from spot_skills.srv import (
    NameService,
    NameServiceRequest,
    NameServiceResponse,
    NavigateToPose,
    NavigateToPoseRequest,
    NavigateToPoseResponse,
    PlaybackTrajectory,
    PlaybackTrajectoryRequest,
    PlaybackTrajectoryResponse,
    PoseLookup,
    PoseLookupRequest,
    PoseLookupResponse,
)

console = Console()

# ---------------------------
# Motion skill configuration
# ---------------------------
JOINT_ORDER = ["arm_el0", "arm_el1", "arm_sh0", "arm_sh1", "arm_wr0", "arm_wr1"]
JOINT_DEFAULTS = {
    "arm_el0": 1.8336877822875977,
    "arm_el1": 0.03147602081298828,
    "arm_sh0": 0.006414175033569336,
    "arm_sh1": -0.7490799427032471,
    "arm_wr0": -1.1007270812988281,
    "arm_wr1": -0.024648189544677734,
}


@dataclass(frozen=True)
class Options:
    broadcast_for_s: float
    ref_frame: str
    noise_deg: float


@dataclass(frozen=True)
class ServiceSpec:
    """Descriptor for a ROS service exposed by the CLI."""

    name: str
    """Fully qualified ROS service name."""

    srv_type: type
    """Service class (e.g., std_srvs.srv.Trigger)."""

    description: str
    """Human-facing description shown in the menu."""

    kind: str = "trigger"  # 'trigger' | 'path' | 'pose'
    """Semantic kind; 'trigger' calls need no additional user input."""


class RosServices:
    """Service proxy manager with lazy wait & safe spinners (no input blocking)."""

    def __init__(self, specs: Dict[str, ServiceSpec], wait_timeout_s: float = 5.0) -> None:
        self._specs = specs
        self._proxies: Dict[str, Callable] = {}
        self._wait_timeout_s = wait_timeout_s

    def _ensure(self, key: str) -> Callable:
        spec = self._specs[key]
        if key not in self._proxies:
            deadline = time.time() + self._wait_timeout_s
            while time.time() < deadline and not rospy.is_shutdown():
                try:
                    rospy.wait_for_service(spec.name, timeout=0.25)
                    break
                except rospy.ROSException:
                    pass
            self._proxies[key] = rospy.ServiceProxy(spec.name, spec.srv_type)
        return self._proxies[key]

    def call_trigger(self, key: str) -> Tuple[bool, str]:
        spec = self._specs[key]
        proxy = self._ensure(key)
        try:
            with console.status(
                Text.assemble("Calling ", (spec.name, "bold"), "…"),
                spinner="dots",
            ):
                resp: TriggerResponse = proxy(TriggerRequest())
            return (bool(resp.success), str(resp.message))
        except (rospy.ServiceException, rospy.ROSException) as e:
            return (False, f"{type(e).__name__}: {e}")

    def call_playback(self, key: str, yaml_path: Path) -> Tuple[bool, str]:
        spec = self._specs[key]
        proxy = self._ensure(key)
        try:
            req = PlaybackTrajectoryRequest(yaml_path=str(yaml_path))
            with console.status(
                Text.assemble("Calling ", (spec.name, "bold"), "…"),
                spinner="dots",
            ):
                resp: PlaybackTrajectoryResponse = proxy(req)
            return (bool(resp.success), str(resp.message))
        except (rospy.ServiceException, rospy.ROSException) as e:
            return (False, f"{type(e).__name__}: {e}")

    def call_pose_lookup(
        self,
        key: str,
        source_frame: str,
        target_frame: str,
    ) -> Tuple[bool, str, Optional[PoseStamped]]:
        spec = self._specs[key]
        proxy = self._ensure(key)
        try:
            req = PoseLookupRequest(source_frame=source_frame, target_frame=target_frame)
            with console.status(
                Text.assemble("Calling ", (spec.name, "bold"), "…"),
                spinner="dots",
            ):
                resp: PoseLookupResponse = proxy(req)
            return (
                bool(resp.success),
                str(resp.message),
                resp.relative_pose if resp.success else None,
            )
        except (rospy.ServiceException, rospy.ROSException) as e:
            return (False, f"{type(e).__name__}: {e}", None)

    def call_nav_to_pose(self, key: str, target: PoseStamped) -> tuple[bool, str]:
        spec = self._specs[key]
        proxy = self._ensure(key)
        try:
            req = NavigateToPoseRequest(target_base_pose=target)
            with console.status(
                Text.assemble("Calling ", (spec.name, "bold"), "…"),
                spinner="dots",
            ):
                resp: NavigateToPoseResponse = proxy(req)
            return (bool(resp.success), str(resp.message))
        except (rospy.ServiceException, rospy.ROSException) as e:
            return (False, f"{type(e).__name__}: {e}")

    def call_name_service(self, key: str, name: str) -> tuple[bool, str]:
        spec = self._specs[key]
        proxy = self._ensure(key)
        try:
            req = NameServiceRequest(name=name)
            with console.status(
                Text.assemble("Calling ", (spec.name, "bold"), "…"),
                spinner="dots",
            ):
                resp: NameServiceResponse = proxy(req)
            return (bool(resp.success), str(resp.message))
        except (rospy.ServiceException, rospy.ROSException) as e:
            return (False, f"{type(e).__name__}: {e}")


# ---------------------------
# Service catalog (menu items)
# ---------------------------

SERVICES: Dict[str, ServiceSpec] = {
    # Trigger-based skills
    "stand": ServiceSpec("spot/stand", Trigger, "Stand the robot."),
    "sit": ServiceSpec("spot/sit", Trigger, "Sit the robot."),
    "shutdown": ServiceSpec("spot/shutdown", Trigger, "Power down the robot."),
    "unlock_arm": ServiceSpec("spot/unlock_arm", Trigger, "Unlock the arm."),
    "stow_arm": ServiceSpec("spot/stow_arm", Trigger, "Stow the arm."),
    "deploy_arm": ServiceSpec("spot/deploy_arm", Trigger, "Deploy the arm."),
    "open_door": ServiceSpec("spot/open_door", Trigger, "Open a door."),
    "erase_board": ServiceSpec("spot/erase_board", Trigger, "Erase whiteboard."),
    "take_control": ServiceSpec("spot/take_control", Trigger, "Acquire robot control."),
    "playback_trajectory": ServiceSpec(
        "spot/playback_trajectory",
        PlaybackTrajectory,
        "Load and playback a saved trajectory from YAML.",
        kind="path",
    ),
    "pose_lookup": ServiceSpec(
        "pose_lookup",
        PoseLookup,
        "Lookup the transform between two frames.",
        kind="pose",
    ),
}

SERVICES.update(
    {
        "nav_to_pose": ServiceSpec(
            "/spot/navigation/to_pose",
            NavigateToPose,
            "Navigate base to a PoseStamped target.",
            "nav_pose",  # new kind
        ),
        "nav_to_waypoint": ServiceSpec(
            "/spot/navigation/to_waypoint",
            NameService,
            "Navigate base to a named waypoint.",
            "name",  # new kind
        ),
        "create_waypoint": ServiceSpec(
            "/spot/navigation/create_waypoint",
            NameService,
            "Create a named waypoint at the current base pose.",
            "name",
        ),
    },
)


# ---------------------------
# Motion helpers (MoveIt)
# ---------------------------
def _broadcast_pose(label: str, pose: Pose3D, seconds: float) -> None:
    if seconds <= 0:
        return
    end_time = time.time() + seconds
    console.print(f"[dim]Broadcasting target ({escape(label)}) for {seconds:.2f}s…[/]")
    while time.time() < end_time and not rospy.is_shutdown():
        TransformManager.broadcast_transform("ee_target", pose)
        time.sleep(TransformManager.LOOP_HZ)


def _prompt_configuration() -> Tuple[Dict[str, float], str]:
    console.print(Panel("Configuration mode: enter joint angles (radians)", border_style="cyan"))
    cfg: Dict[str, float] = {}
    for j in JOINT_ORDER:
        cfg[j] = float(FloatPrompt.ask(j, default=JOINT_DEFAULTS.get(j, 0.0)))
    table = Table(title="Joint targets", show_header=True, header_style="bold", expand=False)
    table.add_column("Joint")
    table.add_column("Value (rad)", justify="right")
    for j in JOINT_ORDER:
        table.add_row(j, f"{cfg[j]:.6f}")
    console.print(table)
    return cfg, "Configuration (rad) shown above"


class SpotArmStack:
    """Singleton-style wrapper for Spot's MoveIt arm, gripper, planning scene, and planner."""

    _instance: Optional[SpotArmStack] = None

    def __init__(self) -> None:
        # Only called internally; use SpotArmStack.get() instead
        self.gripper = ROSAngularGripper(
            limits=GripperAngleLimits(open_rad=-1.5707, closed_rad=0.0),
            grasping_group="gripper",
            action_name="gripper_controller/gripper_action",
        )
        self.arm = MoveItManipulator(name="arm", base_frame="body", gripper=self.gripper)
        self.scene = PlanningSceneManager(body_frame="body")
        self.planner = MoveItMotionPlanner(self.arm, self.scene)

    # --- singleton accessor ---
    @classmethod
    def get(cls) -> SpotArmStack:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    # --- gripper helpers ---
    def open_gripper(self) -> None:
        console.print("[cyan]Opening gripper…[/]")
        self.gripper.open()

    def close_gripper(self) -> None:
        console.print("[cyan]Closing gripper…[/]")
        self.gripper.close()


# --- updated motion helpers using SpotArmStack ---
def _plan_exec_pose(pose: Pose3D, opts: Options) -> bool:
    _broadcast_pose("pre", pose, opts.broadcast_for_s)
    stack = SpotArmStack.get()

    if opts.noise_deg > 0:
        _ = np.random.random(size=(6,)) * np.deg2rad(opts.noise_deg)

    query = MotionPlanningQuery(pose)
    with console.status(
        Text.assemble("Planning to pose in ", (pose.ref_frame or opts.ref_frame, "bold"), "…"),
        spinner="dots",
    ):
        traj = stack.planner.compute_motion_plan(query)

    if traj is None:
        console.print(Panel("❌ No plan found.", border_style="red"))
        return False

    with console.status("Executing trajectory…", spinner="dots"):
        stack.arm.execute_motion_plan(traj)

    _broadcast_pose("post", pose, opts.broadcast_for_s)
    console.print(Panel("✅ Reached target pose.", border_style="green"))
    return True


def _plan_exec_config(cfg: Dict[str, float]) -> bool:
    stack = SpotArmStack.get()

    try:
        query = MotionPlanningQuery(cfg)
    except TypeError:
        try:
            query = MotionPlanningQuery.from_configuration(cfg)  # type: ignore[attr-defined]
        except Exception as e:
            console.print(Panel(Text.assemble("❌ ", escape(str(e))), border_style="red"))
            return False

    with console.status("Planning to joint configuration…", spinner="dots"):
        traj = stack.planner.compute_motion_plan(query)

    if traj is None:
        console.print(Panel("❌ No plan found for configuration.", border_style="red"))
        return False

    with console.status("Executing trajectory…", spinner="dots"):
        stack.arm.execute_motion_plan(traj)

    console.print(Panel("✅ Reached target configuration.", border_style="green"))
    return True


def open_drawer() -> None:
    """Execute the steps necessary to open the black dresser's drawer."""
    nav_to_waypoint = ServiceCaller("/spot/navigation/to_waypoint", NameService)
    nav_to_waypoint(NameServiceRequest(name="open_black_dresser"))

    trigger_service("spot/take_control")
    trigger_service("spot/unlock_arm")

    SpotArmStack.get().open_gripper()  # Open gripper before touching the dresser
    grasp_pose = Pose3D.from_xyz_rpy(x=0.471, z=0.476, yaw_rad=3.14159, ref_frame="black_dresser")
    pose_exec_options = Options(0, DEFAULT_FRAME, 0)
    _plan_exec_pose(grasp_pose, pose_exec_options)

    SpotArmStack.get().close_gripper()
    time.sleep(3)

    pull_pose = Pose3D.from_xyz_rpy(x=0.65, z=0.51, yaw_rad=3.14159, ref_frame="black_dresser")
    _plan_exec_pose(pull_pose, pose_exec_options)

    SpotArmStack.get().open_gripper()

    # TODO: Record a final trajectory from here to finish opening the drawer


# ---------------------------
# Menu & dispatch
# ---------------------------
MENU_ORDER = [
    "move_to_pose",
    "move_to_configuration",
    "open_gripper",
    "close_gripper",
    "open_drawer",
    "load_planning_scene",
    "---",
    "nav_to_pose",
    "nav_to_waypoint",
    "create_waypoint",
    "---",
    "stand",
    "sit",
    "stow_arm",
    "deploy_arm",
    "unlock_arm",
    "open_door",
    "erase_board",
    "take_control",
    "shutdown",
    "---",
    "playback_trajectory",
    "pose_lookup",
]


def _render_menu() -> None:
    table = Table(title="Spot Skills", show_lines=False, expand=True)
    table.add_column("#", justify="right", style="bold", no_wrap=True)
    table.add_column("Skill", style="bold")
    table.add_column("Type")
    table.add_column("ROS Service / Details")
    table.add_column("Description")

    idx = 1
    for key in MENU_ORDER:
        if key == "---":
            table.add_row("", "[dim]—[/]", "", "", "")
            continue
        if key in SERVICES:
            spec = SERVICES[key]
            table.add_row(str(idx), Text(key), "service", Text(spec.name), Text(spec.description))
        elif key == "move_to_pose":
            table.add_row(
                str(idx),
                Text(key),
                "motion",
                Text("MoveIt to Pose3D"),
                Text("Plan/execute to [x,y,z,r,p,y] in ref_frame"),
            )
        elif key == "move_to_configuration":
            table.add_row(
                str(idx),
                Text(key),
                "motion",
                Text("MoveIt to joints"),
                Text("Plan/execute to 6-joint config"),
            )
        elif key == "open_gripper":
            table.add_row(
                str(idx),
                Text(key),
                "motion",
                Text("MoveIt to gripper"),
                Text("Open the gripper"),
            )
        elif key == "close_gripper":
            table.add_row(
                str(idx),
                Text(key),
                "motion",
                Text("MoveIt to gripper"),
                Text("Close the gripper"),
            )
        elif key == "open_drawer":
            table.add_row(
                str(idx),
                Text(key),
                "motion",
                Text("MoveIt motion plan"),
                Text("Open the drawer on the black dresser"),
            )
        elif key == "load_planning_scene":
            table.add_row(
                str(idx),
                Text(key),
                "planning scene",
                Text("MoveIt Planning Scene"),
                Text("Load the planning scene from a YAML file"),
            )
        elif key == "nav_to_pose":
            table.add_row(
                str(idx),
                Text(key),
                "service",
                Text(SERVICES[key].name),
                Text("Navigate base to PoseStamped"),
            )
        elif key == "nav_to_waypoint":
            table.add_row(
                str(idx),
                Text(key),
                "service",
                Text(SERVICES[key].name),
                Text("Navigate base to named waypoint"),
            )
        elif key == "create_waypoint":
            table.add_row(
                str(idx),
                Text(key),
                "service",
                Text(SERVICES[key].name),
                Text("Create waypoint at current base pose"),
            )
        idx += 1

    console.print(Panel(table, title="Select a skill to run", border_style="cyan"))


def _index_to_key(choice: int) -> Optional[str]:
    numeric = [k for k in MENU_ORDER if k != "---"]
    return numeric[choice - 1] if 1 <= choice <= len(numeric) else None


def _pretty_pose(panel_title: str, pose: PoseStamped) -> Panel:
    p, o = pose.pose.position, pose.pose.orientation
    t = Text()
    # Avoid .to_sec() on zero stamp if sim—guard just in case
    stamp = getattr(pose.header.stamp, "to_sec", lambda: 0.0)()
    t.append(f"Stamp: {stamp:.6f}\n")
    t.append(f"Frame: {pose.header.frame_id}\n")
    t.append(f"Position (m): x={p.x:.3f}, y={p.y:.3f}, z={p.z:.3f}\n")
    t.append(f"Orientation (quat): x={o.x:.3f}, y={o.y:.3f}, z={o.z:.3f}, w={o.w:.3f}")
    return Panel(t, title=panel_title, border_style="magenta")


def _handle_service(services: RosServices, key: str, opts: Options) -> Tuple[bool, str]:
    if key in SERVICES:
        spec = SERVICES[key]

        # existing kinds: 'trigger' | 'path' | 'pose'
        if spec.kind == "nav_pose":
            # Prompt for a base target pose; convert via Pose3D -> PoseStamped
            console.print(
                Panel(
                    "Navigation: enter base target [x,y,z,r,p,y] and ref_frame",
                    border_style="cyan",
                ),
            )

            def askf(label: str, default: float) -> float:
                return FloatPrompt.ask(label, default=default)

            x = askf("x (m)", 0.0)
            y = askf("y (m)", 0.0)
            z = askf("z (m)", 0.0)
            r = askf("roll r (rad)", 0.0)
            p = askf("pitch p (rad)", 0.0)
            yaw = askf("yaw y (rad)", 0.0)
            ref = Prompt.ask("ref_frame", default="map")

            target_pose3d = Pose3D.from_list([x, y, z, r, p, yaw], ref_frame=ref)
            target_ps: PoseStamped = pose_to_stamped_msg(target_pose3d)

            return services.call_nav_to_pose(key, target_ps)

        if spec.kind == "name":
            name = Prompt.ask("Name", default="").strip()
            if not name:
                return (False, "Empty name.")
            return services.call_name_service(key, name)

        if spec.kind == "trigger":
            return services.call_trigger(key)

    else:
        # Motion skills
        if key == "move_to_pose":
            pose, summary = _prompt_pose(opts.ref_frame)
            console.print(Panel(Text(summary), border_style="blue"))
            if not Confirm.ask("Proceed to plan & execute to this pose?", default=True):
                return (False, "Canceled")
            ok = _plan_exec_pose(pose, opts)
            return (ok, "Done" if ok else "Failed")
        if key == "move_to_configuration":
            cfg, _ = _prompt_configuration()
            if not Confirm.ask("Proceed to plan & execute to this configuration?", default=True):
                return (False, "Canceled")
            ok = _plan_exec_config(cfg)
            return (ok, "Done" if ok else "Failed")

        if key == "open_drawer":
            open_drawer()
            return (True, "Done")
        if key == "load_planning_scene":
            path = prompt_for_path("YAML file specifying an environment state")
            if path is None:
                return (False, "Canceled")
            success, message = PlanningSceneManager.populate_from_yaml(path)
            return (success, message)

    return (False, f"Unknown key: {key}")


def _handle_custom(services: RosServices, key: str) -> Tuple[bool, str]:
    """Dispatch parameterized UX by kind."""
    spec = SERVICES[key]

    if spec.kind == "path":
        # PlaybackTrajectory: request YAML path
        while True:
            raw = Prompt.ask("YAML path for trajectory (absolute or relative to CWD)")
            path = Path(raw).expanduser().resolve()
            if path.is_file():
                break
            console.print(f"[red]File not found:[/] {path}")
            if not Confirm.ask("Try again?", default=True):
                return (False, "User canceled.")
        console.print(f"[cyan]Using file:[/] {path}")
        return services.call_playback(key, path)

    if spec.kind == "pose":
        # PoseLookup: request source/target frames
        source = Prompt.ask("Source frame", default="map")
        target = Prompt.ask("Target frame", default="base_link")

        success, message, rel_pose = services.call_pose_lookup(key, source, target)
        if success and rel_pose is not None:
            console.print(_pretty_pose(f"{source} → {target}", rel_pose))
        return (success, message)

    return (False, f"Unhandled kind '{spec.kind}' for service '{key}'.")


# ---------------------------
# CLI entrypoint
# ---------------------------
@click.command(context_settings={"help_option_names": ["-h", "--help"]})
@click.option(
    "--wait-timeout",
    type=float,
    default=5.0,
    show_default=True,
    help="Seconds to wait for services before first call.",
)
@click.option(
    "--broadcast-for",
    type=float,
    default=0.0,
    show_default=True,
    help="Seconds to broadcast 'ee_target' before/after pose motion.",
)
@click.option(
    "--ref-frame",
    type=str,
    default="map",
    show_default=True,
    help="Default ref_frame for pose mode.",
)
@click.option(
    "--noise-deg",
    type=float,
    default=0.0,
    show_default=True,
    help="Optional initial joint noise (deg) (pose mode only).",
)
@click.option("--once", is_flag=True, help="Run a single selection instead of a REPL.")
def main(
    wait_timeout: float,
    broadcast_for: float,
    ref_frame: str,
    noise_deg: float,
    once: bool,
) -> None:  # type: ignore[no-redef]
    # Initialize ROS via TransformManager (works for both TF and services)

    try:
        TransformManager.init_node("spot_skills_cli")
    except Exception as e:
        console.print(
            Panel(
                Text.assemble("❌ Failed to initialize ROS node: ", escape(str(e))),
                border_style="red",
            ),
        )
        raise SystemExit(2)

    services = RosServices(SERVICES, wait_timeout_s=wait_timeout)
    opts = Options(broadcast_for_s=broadcast_for, ref_frame=ref_frame, noise_deg=noise_deg)

    console.print(Panel(Text("Spot Skills CLI", justify="center"), border_style="green"))
    while not rospy.is_shutdown():
        _render_menu()
        try:
            choice = IntPrompt.ask("Enter selection (number), or 0 to quit", default=0)
        except KeyboardInterrupt:
            console.print("\n[red]Interrupted.[/]")
            break
        if choice == 0:
            break

        key = _index_to_key(choice)
        if key is None:
            console.print(Panel("❌ Invalid selection.", border_style="red"))
            continue

        ok, msg = _handle_service(services, key, opts)
        panel = Panel(
            Text.assemble(("✅ " if ok else "❌ "), escape(str(msg))),
            border_style=("green" if ok else "red"),
        )
        console.print(panel)

        if once:
            break

    console.print("[dim]Bye.[/]")
    # Optional: graceful node shutdown if a motion completed
    # rospy.signal_shutdown("CLI exit")


if __name__ == "__main__":
    main()
