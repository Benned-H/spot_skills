"""Define a class encapsulating the GraphNav service on the Spot robot."""

from __future__ import annotations

import contextlib
import time
from math import radians
from pathlib import Path
from typing import TYPE_CHECKING

from bosdyn.api.graph_nav import graph_nav_pb2, map_pb2, map_processing_pb2, nav_pb2
from bosdyn.client.exceptions import ResponseError
from bosdyn.client.frame_helpers import get_odom_tform_body, get_vision_tform_body
from bosdyn.client.graph_nav import GraphNavClient
from bosdyn.client.map_processing import MapProcessingServiceClient
from bosdyn.client.math_helpers import Quat, SE3Pose
from bosdyn.client.recording import GraphNavRecordingServiceClient, NotReadyYetError
from robotics_utils.kinematics import Point3D, Pose2D, Pose3D, Quaternion
from robotics_utils.ros import TransformManager
from robotics_utils.ros.call_loop_thread import CallLoopThread
from robotics_utils.ros.pose_broadcast_thread import PoseBroadcastThread

if TYPE_CHECKING:
    from robotics_utils.kinematics import Pose2D

    from spot_skills_py.spot.spot_manager import SpotManager


class SpotGraphNav:
    """An interface for the GraphNav service on Spot."""

    def __init__(
        self,
        manager: SpotManager,
        map_path: Path,
        *,
        mapping_mode: bool,
        load_map: bool,
    ) -> None:
        """Initialize the GraphNav interface by storing a SpotManager instance."""
        self._manager = manager
        self._robot = manager._robot

        self.map_path = map_path
        self.mapping_mode = mapping_mode
        self.should_load_map = load_map

        # Create metadata for the recording session
        self._recording_metadata = GraphNavRecordingServiceClient.make_client_metadata(
            client_username=self._manager.username,
            client_id="RecordingClient",
            client_type="Python SDK",
        )

        self.recording_client: GraphNavRecordingServiceClient = self._robot.ensure_client(
            GraphNavRecordingServiceClient.default_service_name,
        )

        # Create the recording environment
        self._recording_env = GraphNavRecordingServiceClient.make_recording_environment(
            waypoint_env=GraphNavRecordingServiceClient.make_waypoint_environment(
                client_metadata=self._recording_metadata,
            ),
        )

        self.graph_nav_client: GraphNavClient = self._robot.ensure_client(
            GraphNavClient.default_service_name,
        )

        self.map_proc_client: MapProcessingServiceClient = self._robot.ensure_client(
            MapProcessingServiceClient.default_service_name,
        )

        # Initialize threads to continually 1) broadcast and 2) update the latest odometry
        self._tf_broadcaster = PoseBroadcastThread()
        self._tf_updater = CallLoopThread(self.update_odometry)

        if self.should_load_map:
            if self.mapping_mode:
                ok, msg = self.load_map(self.map_path, reanchor=False)
            else:
                ok, msg = self.load_map_for_localization(self.map_path)

            self._manager.log_info(f"Loading a map {'succeeded' if ok else 'failed'}: {msg}")

            l_ok, l_msg = self.localize_nearest_fiducial()
            self._manager.log_info(f"Localization {'succeeded' if l_ok else 'failed'}: {l_msg}")

            self.log_graph_info()

        if self.mapping_mode:
            ok, msg = self.start_mapping()
            self._manager.log_info("Mapping started." if ok else f"Unable to start mapping: {msg}")

    @property
    def currently_recording(self) -> bool:
        """Return whether GraphNav is currently recording a map."""
        status = self.recording_client.get_record_status()
        return status.is_recording

    def check_localized(self) -> bool:
        """Check whether Spot is currently localized using GraphNav."""
        with contextlib.suppress(Exception):
            localization_state = self.graph_nav_client.get_localization_state()
            return bool(localization_state.localization.waypoint_id)

        return False

    def check_finished(self, command_id: int | None) -> bool:
        """Check whether the specified graph navigation command has finished."""
        if command_id is None:
            return False

        with contextlib.suppress(Exception):
            status = self.graph_nav_client.navigation_feedback(command_id).status
            self._manager.log_info(f"GraphNav command status: {status}.")

            return (
                status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_REACHED_GOAL
                or status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_STUCK
                or status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_NO_PATH
            )

        return False

    def localize_nearest_fiducial(self) -> tuple[bool, str]:
        """Initialize localization using the nearest fiducial visible to Spot."""
        try:
            rs = self._manager.get_robot_state()
            odom_t_body = get_odom_tform_body(rs.kinematic_state.transforms_snapshot).to_proto()
            self.graph_nav_client.set_localization(
                initial_guess_localization=nav_pb2.Localization(),
                ko_tform_body=odom_t_body,
            )

        except Exception as exc:
            return False, f"Failed to localize to fiducial: {exc}"

        else:
            return True, "Localized to nearest fiducial."

    def localize_to_waypoint(self, waypoint_id: str) -> tuple[bool, str]:
        """Initialize localization to a specific waypoint (must be exactly at that waypoint)."""
        try:
            rs = self._manager.get_robot_state()
            odom_t_body = get_odom_tform_body(rs.kinematic_state.transforms_snapshot).to_proto()
            localization = nav_pb2.Localization()
            localization.waypoint_id = waypoint_id
            localization.waypoint_tform_body.rotation.w = 1.0
            self.graph_nav_client.set_localization(
                initial_guess_localization=localization,
                max_distance=0.2,
                max_yaw=radians(20.0),
                fiducial_init=graph_nav_pb2.SetLocalizationRequest.FIDUCIAL_INIT_NO_FIDUCIAL,
                ko_tform_body=odom_t_body,
            )

        except Exception as exc:
            return False, f"Failed to localize to waypoint '{waypoint_id}': {exc}"

        else:
            return True, f"Localized to waypoint '{waypoint_id}'."

    def update_odometry(self) -> bool:
        """Update the current odometry estimate based on localization from GraphNav.

        :return: True if the odometry was successfully updated or verified, else False
        """
        try:  # Attempt to retrieve the current localization state
            loc_state = self.graph_nav_client.get_localization_state()
            loc = loc_state.localization
            if not loc.waypoint_id:
                self._manager.log_info("GraphNav not localized!")
                return False

            sTb = SE3Pose.from_proto(loc.seed_tform_body)  # Body w.r.t. seed frame

            robot_state = self._manager.get_robot_state()
            vTb = get_vision_tform_body(robot_state.kinematic_state.transforms_snapshot)
            bTv = SE3Pose(vTb.x, vTb.y, vTb.z, vTb.rot).inverse()

            mTv = sTb * bTv  # Treat GraphNav's seed frame as the map frame in TF

            pose_m_v = Pose3D(
                Point3D(mTv.x, mTv.y, mTv.z),
                Quaternion(x=mTv.rot.x, y=mTv.rot.y, z=mTv.rot.z, w=mTv.rot.w),
                ref_frame="map",
            )

        except Exception as exc:
            self._manager.log_info(f"update_odometry failed: {exc}")
            return False

        else:
            self._tf_broadcaster.poses["vision"] = pose_m_v  # Vision w.r.t. map
            return True

    def should_we_start_recording(self) -> bool:
        """Before starting to record a map, check the state of the GraphNav system."""
        graph = self.graph_nav_client.download_graph()

        # If the graph is non-empty, we must localize within the graph before recording
        if graph is not None and len(graph.waypoints) > 0:
            localization_state = self.graph_nav_client.get_localization_state()
            if not localization_state.localization.waypoint_id:
                # We aren't localized to anything in the map. We must clear the map
                #   or localize to the current map before we start recording
                return False
        return True

    def start_mapping(self) -> tuple[bool, str]:
        """Begin GraphNav recording (i.e., mapping) on the robot."""
        if self.currently_recording:
            return True, "GraphNav was already recording a map."

        should_start = self.should_we_start_recording()
        if not should_start:
            return False, "GraphNav isn't in the proper state to begin recording."

        try:
            self.recording_client.start_recording(
                recording_environment=self._recording_env,
            )
        except Exception as exc:
            return False, f"Failed to start recording: {exc}"
        else:
            return True, "Recording started."

    def stop_mapping(self) -> tuple[bool, str]:
        """Stop recording and attempt to process/anchor/connect the GraphNav map."""
        first_iter = True
        while self.currently_recording:
            try:
                self.recording_client.stop_recording()
                break
            except NotReadyYetError:
                # Recording may not be finished due to background processing; try waiting 1 sec
                if first_iter:
                    self._manager.log_info("Cleaning up recorded map...")
                first_iter = False
                time.sleep(1.0)
                continue
            except Exception as exc:
                return False, f"Failed to stop recording: {exc}"

        topo_ok = False
        anchor_ok = False

        try:
            topo_params = map_processing_pb2.ProcessTopologyRequest.Params()
            self.map_proc_client.process_topology(topo_params, modify_map_on_server=True)
            topo_ok = True
        except Exception as exc:
            self._manager.log_info(f"Topology processing failed: {exc}")

        try:
            anchor_params = map_processing_pb2.ProcessAnchoringRequest.Params()
            self.map_proc_client.process_anchoring(
                anchor_params,
                modify_anchoring_on_server=True,
                stream_intermediate_results=False,
            )
            anchor_ok = True
        except Exception as exc:
            self._manager.log_info(f"Anchor processing failed: {exc}")

        if topo_ok and anchor_ok:
            return True, "Recording stopped; topology processed and anchoring completed."

        if topo_ok or anchor_ok:
            return True, (
                "Recording stopped; partial processing "
                f"(topology={topo_ok}, anchoring={anchor_ok})."
            )

        return False, "Recording stopped but no processing completed."

    def log_graph_info(self) -> None:
        """Debugging function that logs information about the current graph.

        Reference: https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html#graph
        """
        try:
            graph = self.graph_nav_client.download_graph()

            waypoints = graph.waypoints
            edges = graph.edges
            anchoring = graph.anchoring
            anchors = anchoring.anchors

            self._manager.log_info(
                f"Downloaded graph with {len(waypoints)} waypoints, "
                f"{len(edges)} edges, and {len(anchors)} anchors.",
            )

        except Exception as exc:
            self._manager.log_info(f"Exception while logging graph info: {exc}")

    def save_map(self, output_dir: str | Path) -> tuple[bool, str]:
        """Save the on-robot GraphNav map to the given directory.

        Note: Mapping is paused, if active, during this method.

        :param output_dir: Output directory (created if missing)
        :return: Boolean success indicator and a message describing the outcome
        """
        if self.currently_recording:
            ok, msg = self.stop_mapping()
            if ok:
                self._manager.log_info(f"Successfully stopped mapping: {msg}")
            else:
                self._manager.log_info(f"Unable to stop mapping: {msg}")

        try:
            graph = self.graph_nav_client.download_graph()
            if not graph or len(graph.waypoints) == 0:
                return False, "No graph present on robot to save."

            base = Path(output_dir)
            (base / "waypoint_snapshots").mkdir(parents=True, exist_ok=True)
            (base / "edge_snapshots").mkdir(parents=True, exist_ok=True)

            (base / "graph").write_bytes(graph.SerializeToString())

            wp_total = sum(1 for wp in graph.waypoints if wp.snapshot_id)
            wp_saved = 0
            for wp in graph.waypoints:
                if not wp.snapshot_id:
                    continue

                with contextlib.suppress(Exception):
                    snap = self.graph_nav_client.download_waypoint_snapshot(wp.snapshot_id)
                    (base / "waypoint_snapshots" / snap.id).write_bytes(snap.SerializeToString())
                    wp_saved += 1

            e_ids = [e.snapshot_id for e in graph.edges if e.snapshot_id]
            e_total = len(e_ids)
            e_saved = 0
            for e_id in e_ids:
                with contextlib.suppress(Exception):
                    snap = self.graph_nav_client.download_edge_snapshot(e_id)
                    (base / "edge_snapshots" / snap.id).write_bytes(snap.SerializeToString())
                    e_saved += 1

        except Exception as exc:
            return False, f"Failed to save map: {exc}"

        else:
            summary = (
                f"GraphNav map saved to '{base}'. "
                f"Waypoints: {wp_saved}/{wp_total} saved. "
                f"Edges: {e_saved}/{e_total} saved."
            )

            any_saved = (wp_saved > 0 or wp_total == 0) and (e_saved > 0 or e_total == 0)
            return any_saved, summary

    def load_map(self, directory: str | Path, *, reanchor: bool = False) -> tuple[bool, str]:
        """Load a GraphNav map from a directory and upload it to Spot."""
        try:
            base = Path(directory)
            graph_path = base / "graph"
            if not graph_path.exists():
                return False, f"Missing map file: '{graph_path}'."

            graph = map_pb2.Graph()
            graph.ParseFromString(graph_path.read_bytes())

            # Preload snapshots from disk into memory for quick lookup
            wp_dir = base / "waypoint_snapshots"
            e_dir = base / "edge_snapshots"
            wp_files = {p.name: p for p in (wp_dir.iterdir() if wp_dir.exists() else [])}
            e_files = {p.name: p for p in (e_dir.iterdir() if e_dir.exists() else [])}

            # Upload the graph; server returns which snapshots it lacks
            response = self.graph_nav_client.upload_graph(
                graph=graph,
                generate_new_anchoring=bool(reanchor or not len(graph.anchoring.anchors)),
            )

            # Upload only missing waypoint snapshots
            for wid in response.unknown_waypoint_snapshot_ids:
                p = wp_files.get(wid)
                if not p:
                    return False, f"Missing waypoint snapshot file on disk: '{wid}'."
                snap = map_pb2.WaypointSnapshot()
                snap.ParseFromString(p.read_bytes())
                self.graph_nav_client.upload_waypoint_snapshot(snap)

            # Upload only missing edge snapshots
            for eid in response.unknown_edge_snapshot_ids:
                p = e_files.get(eid)
                if not p:
                    return False, f"Missing edge snapshot file on disk: '{eid}'."
                snap = map_pb2.EdgeSnapshot()
                snap.ParseFromString(p.read_bytes())
                self.graph_nav_client.upload_edge_snapshot(snap)

        except Exception as exc:
            return False, f"Failed to load GraphNav map: {exc}"

        else:
            return True, f"Map loaded from '{base!r}' (reanchor={reanchor})."

    def load_map_for_localization(self, directory: str | Path) -> tuple[bool, str]:
        """Load a previously recorded map strictly for localization (no reanchor)."""
        ok, msg = self.load_map(directory, reanchor=False)
        if ok:
            msg = f"{msg}\nNow localize (fiducial or waypoint) before navigating."
        return ok, msg

    def navigate_to_pose(self, target_pose: Pose2D, timeout_s: float = 30.0) -> tuple[bool, str]:
        """Navigate to the given base pose using GraphNav.

        :param target_pose: Target base pose for navigation
        :param timeout_s: Duration (seconds) after which navigation times out, defaults to 30 s
        :return: Tuple containing Boolean success and an outcome message
        """
        if not self._manager.ensure_control(take_by_force=True):
            return False, "SpotManager doesn't have control of the robot."

        if not self.check_localized():
            return False, "Spot is not currently localized."

        curr_pose_s_b = TransformManager.lookup_transform("body", "map")
        if curr_pose_s_b is None:
            return False, "Unable to find current transform from map frame to body frame."
        curr_z = curr_pose_s_b.position.z

        target_pose = TransformManager.convert_to_frame(target_pose, target_frame="map").to_2d()

        quat = Quat.from_yaw(target_pose.yaw_rad)
        target_proto = SE3Pose(x=target_pose.x, y=target_pose.y, z=curr_z, rot=quat).to_proto()

        nav_to_cmd_id: int | None = None
        end_time = time.time() + timeout_s

        self._manager.log_info(f"Starting GraphNav navigation to: {target_pose}")

        while time.time() < end_time:
            try:
                nav_to_cmd_id = self.graph_nav_client.navigate_to_anchor(
                    target_proto,
                    cmd_duration=1.0,
                    command_id=nav_to_cmd_id,
                )
            except ResponseError as re:
                return False, f"Error during navigation: {re}"

            time.sleep(0.5)  # Sleep for half a second to allow for command execution

            # Poll the robot for feedback to determine if the navigation command is complete
            finished = self.check_finished(nav_to_cmd_id)
            self._manager.log_info(f"Navigation has {'' if finished else 'not '}finished.")

            if finished:
                break

        if nav_to_cmd_id is None:
            return False, "Navigation failed to start."

        status = self.graph_nav_client.navigation_feedback(nav_to_cmd_id).status
        if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_REACHED_GOAL:
            return True, "Successfully completed graph navigation!"
        if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_LOST:
            return False, "Robot got lost during navigation."
        if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_STUCK:
            return False, "Robot got stuck during navigation."
        if status == graph_nav_pb2.NavigationFeedbackResponse.STATUS_ROBOT_IMPAIRED:
            return False, "Robot is impaired."

        return False, f"Navigation command timed out or did not succeed (status {status})."
