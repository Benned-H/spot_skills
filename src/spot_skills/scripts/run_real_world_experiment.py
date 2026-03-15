#!/usr/bin/env python3
"""Run the documented real-world Spot experiment via ROS services."""

from __future__ import annotations

import argparse
import sys
import time
from dataclasses import dataclass
from typing import Any, Callable, Dict, List, Optional, Tuple

import rospy
from std_srvs.srv import Trigger, TriggerRequest

from spot_skills.srv import NameService, NameServiceRequest, OpenDoor, OpenDoorRequest


@dataclass(frozen=True)
class ExperimentConfig:
    """CLI-configurable parameters for the experiment."""

    object_name: str
    close_door_policy: str
    open_door_body_pitch_rad: float
    open_door_is_pull: bool
    open_door_hinge_on_left: bool
    open_door_offset_m: float
    open_door_ray_search_dist_m: float
    service_timeout_s: float
    continue_on_failure: bool
    dry_run: bool
    start_at_step: Optional[str]
    stop_after_step: Optional[str]


@dataclass(frozen=True)
class ExperimentStep:
    """One service call in the experiment sequence."""

    key: str
    description: str
    service_name: str
    service_type: type
    request_factory: Callable[[ExperimentConfig], Any]
    critical: bool = True


@dataclass(frozen=True)
class StepResult:
    """Outcome of executing a single experiment step."""

    step: ExperimentStep
    success: bool
    message: str
    elapsed_s: float
    counts_as_failure: bool = True


class ExperimentRunner:
    """Execute the documented service sequence for the real-world experiment."""

    def __init__(self, config: ExperimentConfig) -> None:
        """Initialize the runner and lazily-created ROS service proxies."""
        self._config = config
        self._service_proxies: Dict[Tuple[str, type], rospy.ServiceProxy] = {}
        self._steps = self._build_steps()

    def run(self) -> bool:
        """Run the selected portion of the experiment sequence."""
        steps = self._select_steps()
        self._log_selected_steps(steps)

        if self._config.dry_run:
            rospy.loginfo("Dry run requested; no services were called.")
            return True

        results: List[StepResult] = []
        aborted = False
        index = 0

        while index < len(steps):
            step = steps[index]
            if self._is_navigation_step(step):
                nav_results = self._execute_navigation_block(
                    steps=steps,
                    start_index=index,
                    total_steps=len(steps),
                )
                results.extend(nav_results)

                final_result = nav_results[-1]
                if (
                    self._is_failure_that_counts(final_result)
                    and not self._config.continue_on_failure
                ):
                    rospy.logerr(
                        "Aborting after navigation block ending at critical step '%s' failed.",
                        final_result.step.key,
                    )
                    aborted = True
                    break

                index += len(nav_results)
                continue

            result = self._execute_logged_step(
                step=step,
                display_index=index + 1,
                total_steps=len(steps),
            )
            results.append(result)

            if self._is_failure_that_counts(result) and not self._config.continue_on_failure:
                rospy.logerr("Aborting after critical step '%s' failed.", step.key)
                aborted = True
                break

            index += 1

        self._log_summary(results, aborted, len(steps))
        return (not aborted) and not any(self._is_failure_that_counts(result) for result in results)

    def _select_steps(self) -> List[ExperimentStep]:
        """Return the requested contiguous subset of the experiment plan."""
        step_keys = [step.key for step in self._steps]
        start_index = 0
        stop_index = len(self._steps) - 1

        if self._config.start_at_step is not None:
            start_index = self._find_step_index(self._config.start_at_step)

        if self._config.stop_after_step is not None:
            stop_index = self._find_step_index(self._config.stop_after_step)

        if stop_index < start_index:
            raise ValueError(
                "The requested stop step occurs before the requested start step. "
                f"Available steps: {step_keys}",
            )

        return self._steps[start_index : stop_index + 1]

    def _find_step_index(self, step_key: str) -> int:
        """Look up the index for a named step."""
        for index, step in enumerate(self._steps):
            if step.key == step_key:
                return index

        available_steps = ", ".join(step.key for step in self._steps)
        raise ValueError(f"Unknown step '{step_key}'. Available steps: {available_steps}")

    def _execute_step(self, step: ExperimentStep) -> StepResult:
        """Call the ROS service associated with a single experiment step."""
        start_time = time.monotonic()

        try:
            response = self._call_service(
                service_name=step.service_name,
                service_type=step.service_type,
                request=step.request_factory(self._config),
            )
        except (rospy.ROSException, rospy.ServiceException) as exc:
            elapsed_s = time.monotonic() - start_time
            return StepResult(step=step, success=False, message=str(exc), elapsed_s=elapsed_s)

        elapsed_s = time.monotonic() - start_time
        if response is None:
            return StepResult(
                step=step,
                success=False,
                message="Service returned no response.",
                elapsed_s=elapsed_s,
            )

        return StepResult(
            step=step,
            success=bool(getattr(response, "success", False)),
            message=str(getattr(response, "message", "")),
            elapsed_s=elapsed_s,
        )

    def _execute_logged_step(
        self,
        step: ExperimentStep,
        display_index: int,
        total_steps: int,
        counts_as_failure: bool = True,
        failure_message_suffix: str = "",
    ) -> StepResult:
        """Execute a step, then log its outcome."""
        rospy.loginfo("")
        rospy.loginfo("[%d/%d] %s", display_index, total_steps, step.description)

        result = self._execute_step(step)
        message = result.message
        if (not result.success) and failure_message_suffix:
            message += failure_message_suffix

        if result.counts_as_failure != counts_as_failure or message != result.message:
            result = StepResult(
                step=result.step,
                success=result.success,
                message=message,
                elapsed_s=result.elapsed_s,
                counts_as_failure=counts_as_failure,
            )

        self._log_step_result(result)
        return result

    def _execute_navigation_block(
        self,
        steps: List[ExperimentStep],
        start_index: int,
        total_steps: int,
    ) -> List[StepResult]:
        """Execute a consecutive run of navigation steps as one failure block."""
        block_steps: List[ExperimentStep] = []

        while start_index + len(block_steps) < len(steps):
            step = steps[start_index + len(block_steps)]
            if not self._is_navigation_step(step):
                break
            block_steps.append(step)

        results: List[StepResult] = []
        for offset, step in enumerate(block_steps):
            is_final_step = offset == len(block_steps) - 1
            failure_message_suffix = ""
            if not is_final_step:
                failure_message_suffix = (
                    " Continuing because only the final navigation step in this "
                    "consecutive waypoint sequence determines failure."
                )

            result = self._execute_logged_step(
                step=step,
                display_index=start_index + offset + 1,
                total_steps=total_steps,
                counts_as_failure=is_final_step,
                failure_message_suffix=failure_message_suffix,
            )
            results.append(result)

        return results

    def _call_service(self, service_name: str, service_type: type, request: Any) -> Any:
        """Wait for a service if needed, then invoke it."""
        proxy_key = (service_name, service_type)
        if proxy_key not in self._service_proxies:
            rospy.loginfo("Waiting for service '%s'...", service_name)
            rospy.wait_for_service(service_name, timeout=self._config.service_timeout_s)
            self._service_proxies[proxy_key] = rospy.ServiceProxy(service_name, service_type)

        proxy = self._service_proxies[proxy_key]
        return proxy(request)

    def _log_selected_steps(self, steps: List[ExperimentStep]) -> None:
        """Emit the selected step list before execution begins."""
        rospy.loginfo("Selected %d experiment steps:", len(steps))
        for index, step in enumerate(steps, start=1):
            rospy.loginfo("  %02d. %s [%s]", index, step.description, step.key)

    def _log_step_result(self, result: StepResult) -> None:
        """Log a single step result with the appropriate severity."""
        if result.success:
            rospy.loginfo(
                "[%s] SUCCESS (%.1fs): %s",
                result.step.key,
                result.elapsed_s,
                result.message,
            )
            return

        if self._is_failure_that_counts(result):
            rospy.logerr(
                "[%s] FAILED (%.1fs): %s",
                result.step.key,
                result.elapsed_s,
                result.message,
            )
            return

        rospy.logwarn(
            "[%s] FAILED (non-blocking, %.1fs): %s",
            result.step.key,
            result.elapsed_s,
            result.message,
        )

    def _log_summary(self, results: List[StepResult], aborted: bool, total_steps: int) -> None:
        """Emit a compact summary at the end of the run."""
        rospy.loginfo("")
        rospy.loginfo("Experiment summary:")
        for result in results:
            if result.success:
                log_fn = rospy.loginfo
                status = "OK"
            elif self._is_failure_that_counts(result):
                log_fn = rospy.logerr
                status = "FAIL"
            else:
                log_fn = rospy.logwarn
                status = "WARN"

            log_fn("  [%s] %s: %s", status, result.step.key, result.message)

        if aborted:
            rospy.logerr(
                "Experiment aborted after %d/%d executed steps.",
                len(results),
                total_steps,
            )
            return

        if len(results) < total_steps:
            rospy.logwarn(
                "Experiment stopped early after %d/%d steps.",
                len(results),
                total_steps,
            )
            return

        if not any(self._is_failure_that_counts(result) for result in results):
            rospy.loginfo("Experiment completed successfully.")
            return

        rospy.logerr("Experiment finished with one or more failed critical steps.")

    @staticmethod
    def _is_navigation_step(step: ExperimentStep) -> bool:
        """Return whether the step is a waypoint-navigation step."""
        return step.service_name == "/spot/navigation/to_waypoint"

    @staticmethod
    def _is_failure_that_counts(result: StepResult) -> bool:
        """Return whether the result should count as a run failure."""
        return (not result.success) and result.step.critical and result.counts_as_failure

    def _build_steps(self) -> List[ExperimentStep]:
        """Build the full experiment plan described in the interface document."""
        return [
            self._trigger_step("take_control", "Take control of Spot", "/spot/take_control"),
            self._trigger_step("unlock_arm", "Unlock the arm", "/spot/unlock_arm"),
            self._trigger_step("undock", "Undock Spot", "/spot/undock"),
            self._trigger_step(
                "localize_after_undock",
                "Re-localize after undocking",
                "/spot/relocalize",
            ),
            self._waypoint_step(
                "goto_drawer_setup",
                "Navigate to the drawer opening waypoint",
                "open_drawer",
            ),
            self._trigger_step("open_drawer", "Open the drawer", "/spot/open_drawer"),
            self._waypoint_step("goto_door", "Navigate to the door waypoint", "open_door"),
            ExperimentStep(
                key="open_door",
                description="Open the door",
                service_name="/spot/open_door",
                service_type=OpenDoor,
                request_factory=lambda config: OpenDoorRequest(
                    body_pitch_rad=config.open_door_body_pitch_rad,
                    is_pull=config.open_door_is_pull,
                    hinge_on_left=config.open_door_hinge_on_left,
                    door_offset_m=config.open_door_offset_m,
                    ray_search_dist_m=config.open_door_ray_search_dist_m,
                ),
            ),
            self._waypoint_step(
                "return_to_drawer",
                "Navigate back to the drawer staging waypoint",
                "open_drawer",
            ),
            self._waypoint_step(
                "goto_drawer_pick",
                "Navigate to the drawer pick waypoint",
                "pick_from_drawer",
            ),
            self._name_step(
                "pick_from_drawer",
                "Pick the eraser from the drawer",
                "/spot/pick_from_drawer",
                lambda config: config.object_name,
            ),
            self._waypoint_step(
                "leave_drawer",
                "Navigate back out from the drawer",
                "open_drawer",
            ),
            self._waypoint_step("into_office", "Navigate into the office", "into_office"),
            self._waypoint_step(
                "approach_cabinet",
                "Navigate to the filing cabinet approach waypoint",
                "approach_filing_cabinet",
            ),
            self._trigger_step(
                "localize_for_cabinet",
                "Re-localize before approaching the filing cabinet",
                "/spot/relocalize",
            ),
            self._waypoint_step(
                "face_cabinet",
                "Navigate to the filing cabinet placement waypoint",
                "facing_filing_cabinet",
            ),
            self._name_step(
                "place_on_cabinet",
                "Place the eraser on the cabinet",
                "/spot/place_on_cabinet",
                lambda config: config.object_name,
            ),
            self._waypoint_step(
                "back_from_cabinet",
                "Navigate back away from the filing cabinet",
                "approach_filing_cabinet",
            ),
            self._waypoint_step(
                "goto_close_door",
                "Navigate to the close-door waypoint",
                "close_door",
            ),
            self._name_step(
                "close_door_policy",
                "Run the close-door policy replay",
                "/spot/policy_replay",
                lambda config: config.close_door_policy,
            ),
            self._waypoint_step(
                "return_to_cabinet",
                "Navigate back to the filing cabinet approach waypoint",
                "approach_filing_cabinet",
            ),
            self._waypoint_step(
                "face_cabinet_for_pick",
                "Navigate to the filing cabinet pickup waypoint",
                "facing_filing_cabinet",
            ),
            self._name_step(
                "pick_from_filing_cabinet",
                "Pick the eraser back up from the filing cabinet",
                "/spot/pick_from_filing_cabinet",
                lambda config: config.object_name,
            ),
            self._waypoint_step(
                "leave_cabinet",
                "Navigate away from the filing cabinet",
                "approach_filing_cabinet",
            ),
            self._waypoint_step("goto_erase", "Navigate to the erase waypoint", "erase"),
            self._trigger_step("erase_board", "Erase the board", "/spot/erase_board"),
        ]

    @staticmethod
    def _trigger_step(key: str, description: str, service_name: str) -> ExperimentStep:
        """Create a Trigger-based experiment step."""
        return ExperimentStep(
            key=key,
            description=description,
            service_name=service_name,
            service_type=Trigger,
            request_factory=lambda _config: TriggerRequest(),
        )

    @staticmethod
    def _waypoint_step(key: str, description: str, waypoint_name: str) -> ExperimentStep:
        """Create a waypoint-navigation experiment step."""
        return ExperimentStep(
            key=key,
            description=description,
            service_name="/spot/navigation/to_waypoint",
            service_type=NameService,
            request_factory=lambda _config: NameServiceRequest(name=waypoint_name),
        )

    @staticmethod
    def _name_step(
        key: str,
        description: str,
        service_name: str,
        value_factory: Callable[[ExperimentConfig], str],
    ) -> ExperimentStep:
        """Create a NameService-based experiment step."""
        return ExperimentStep(
            key=key,
            description=description,
            service_name=service_name,
            service_type=NameService,
            request_factory=lambda config: NameServiceRequest(name=value_factory(config)),
        )


def _build_arg_parser() -> argparse.ArgumentParser:
    """Create the CLI parser for the experiment runner."""
    parser = argparse.ArgumentParser(
        description=(
            "Run the documented real-world Spot experiment using the available ROS services."
        ),
    )
    parser.add_argument(
        "--object-name",
        default="eraser1",
        help="Object to move through the experiment sequence.",
    )
    parser.add_argument(
        "--close-door-policy",
        default="spot-close-door2-combined",
        help="Policy replay model name used for the close-door step.",
    )
    parser.add_argument(
        "--open-door-body-pitch-rad",
        type=float,
        default=-0.1,
        help="Body pitch used for the open-door request.",
    )
    parser.add_argument(
        "--open-door-is-pull",
        action="store_true",
        help="Set the open-door request to pull instead of push.",
    )
    parser.add_argument(
        "--open-door-hinge-on-left",
        action="store_true",
        default=True,
        help="Set the open-door request hinge direction to left.",
    )
    parser.add_argument(
        "--open-door-hinge-on-right",
        action="store_false",
        dest="open_door_hinge_on_left",
        help="Set the open-door request hinge direction to right.",
    )
    parser.add_argument(
        "--open-door-offset-m",
        type=float,
        default=1.25,
        help="Door offset used by the open-door service.",
    )
    parser.add_argument(
        "--open-door-ray-search-dist-m",
        type=float,
        default=0.25,
        help="Ray search distance used by the open-door service.",
    )
    parser.add_argument(
        "--service-timeout-s",
        type=float,
        default=30.0,
        help="How long to wait for each ROS service to become available.",
    )
    parser.add_argument(
        "--continue-on-failure",
        action="store_true",
        help="Log step failures and keep going instead of aborting on the first critical failure.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print the selected step sequence without calling any services.",
    )
    parser.add_argument(
        "--start-at-step",
        help="Start execution at the named step key instead of from the beginning.",
    )
    parser.add_argument(
        "--stop-after-step",
        help="Stop execution after the named step key.",
    )
    parser.add_argument(
        "--list-steps",
        action="store_true",
        help="Print all step keys and exit.",
    )
    return parser


def _config_from_args(args: argparse.Namespace) -> ExperimentConfig:
    """Convert parsed CLI arguments into a strongly-typed config."""
    return ExperimentConfig(
        object_name=args.object_name,
        close_door_policy=args.close_door_policy,
        open_door_body_pitch_rad=args.open_door_body_pitch_rad,
        open_door_is_pull=args.open_door_is_pull,
        open_door_hinge_on_left=args.open_door_hinge_on_left,
        open_door_offset_m=args.open_door_offset_m,
        open_door_ray_search_dist_m=args.open_door_ray_search_dist_m,
        service_timeout_s=args.service_timeout_s,
        continue_on_failure=args.continue_on_failure,
        dry_run=args.dry_run,
        start_at_step=args.start_at_step,
        stop_after_step=args.stop_after_step,
    )


def main() -> int:
    """Parse args, initialize ROS, and run the experiment."""
    parser = _build_arg_parser()
    args = parser.parse_args()
    config = _config_from_args(args)
    runner = ExperimentRunner(config)

    if args.list_steps:
        for step in runner._steps:
            print(f"{step.key}: {step.description}")
        return 0

    rospy.init_node("run_real_world_experiment", anonymous=True)

    try:
        success = runner.run()
    except ValueError as exc:
        parser.error(str(exc))
    except KeyboardInterrupt:
        rospy.logwarn("Experiment interrupted by user.")
        return 130

    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
