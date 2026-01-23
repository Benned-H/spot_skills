"""Define utility classes to visualize navigation graphs from GraphNav."""

from __future__ import annotations

from dataclasses import dataclass, replace
from typing import TYPE_CHECKING

import rospy
from bosdyn.client.math_helpers import SE3Pose
from robotics_utils.geometry import Point3D
from robotics_utils.parallelism import ResourceManager
from robotics_utils.ros.call_loop_thread import CallLoopThread
from robotics_utils.ros.msg_conversion import point_to_msg, pose_to_msg
from robotics_utils.spatial import DEFAULT_FRAME, Pose3D, Quaternion
from std_msgs.msg import ColorRGBA, Header
from visualization_msgs.msg import Marker, MarkerArray

if TYPE_CHECKING:
    from bosdyn.api.graph_nav.map_pb2 import Graph as GraphProto
    from bosdyn.client.graph_nav import GraphNavClient


def se3_to_pose(se3: SE3Pose, ref_frame: str = DEFAULT_FRAME) -> Pose3D:
    """Convert an SE3Pose into a Pose3D."""
    position = Point3D(se3.x, se3.y, se3.z)
    rotation = Quaternion(x=se3.rot.x, y=se3.rot.y, z=se3.rot.z, w=se3.rot.w)
    return Pose3D(position, rotation, ref_frame=ref_frame)


@dataclass
class NavigationGraph:
    """Dataclass representing a graph from GraphNav."""

    waypoints: dict[str, Pose3D]
    edges: list[tuple[str, str]]  # (from_waypoint, to_waypoint)

    @classmethod
    def from_proto(cls, graph: GraphProto) -> NavigationGraph:
        """Construct a navigation graph from a GraphNav Protobuf message.

        Reference: https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html#graph
        """
        num_waypoints = len(graph.waypoints)
        anchors = graph.anchoring.anchors

        if num_waypoints != len(anchors):
            raise RuntimeError(f"Found {num_waypoints} waypoints and {len(anchors)} anchors.")

        waypoints = {a.id: se3_to_pose(SE3Pose.from_proto(a.seed_tform_waypoint)) for a in anchors}
        edges = [(edge.id.from_waypoint, edge.id.to_waypoint) for edge in graph.edges]

        return NavigationGraph(waypoints, edges)


class GraphNavRViz:
    """Visualize a Spot GraphNav graph using RViz markers."""

    def __init__(
        self,
        client: GraphNavClient,
        topic: str = "/graphnav_markers",
        frame_id: str = "map",
        ns: str = "graphnav",
        waypoint_size_m: float = 0.1,
        edge_width_m: float = 0.03,
        *,
        show_labels: bool = True,
        resource_manager: ResourceManager | None = None,
    ) -> None:
        """Initialize the class with everything needed to update the visualization."""
        self.client = client
        self.frame_id = frame_id
        self.ns = ns
        self.waypoint_size_m = waypoint_size_m
        self.edge_width_m = edge_width_m
        self.show_labels = show_labels

        self.graph: NavigationGraph | None = None

        self._waypoint_color = ColorRGBA(0.1, 0.7, 1.0, 1.0)
        self._label_color = ColorRGBA(1.0, 1.0, 1.0, 0.8)
        self._edge_color = ColorRGBA(1.0, 0.5, 0.1, 1.0)

        self.resource_manager = resource_manager
        self.pub = rospy.Publisher(topic, MarkerArray, queue_size=1, latch=True)
        self.loop_thread = CallLoopThread(
            self.update,
            loop_hz=1.0,
            name="GraphNavRViz",
            resource_manager=self.resource_manager,
        )

    def get_updated_graph(self) -> NavigationGraph:
        """Retrieve an updated graph from the GraphNav client."""
        graph_proto = self.client.download_graph()
        return NavigationGraph.from_proto(graph_proto)

    def _header(self) -> Header:
        """Construct a std_msgs/Header message."""
        h = Header()
        h.frame_id = self.frame_id
        h.stamp = rospy.Time.now()
        return h

    def _waypoint_marker(self, marker_id: int, pose: Pose3D) -> Marker:
        """Construct a visualization_msgs/Marker message to represent a waypoint."""
        m = Marker()
        m.header = self._header()
        m.ns = f"{self.ns}/waypoints"
        m.id = marker_id
        m.type = Marker.SPHERE
        m.action = Marker.ADD
        m.pose = pose_to_msg(pose)
        m.scale.x = m.scale.y = m.scale.z = self.waypoint_size_m
        m.color = self._waypoint_color
        return m

    def _label_marker(self, marker_id: int, pose: Pose3D, text: str) -> Marker:
        """Construct a visualization_msgs/Marker message to display text at a given pose."""
        m = Marker()
        m.header = self._header()
        m.ns = f"{self.ns}/labels"
        m.id = marker_id
        m.type = Marker.TEXT_VIEW_FACING
        m.action = Marker.ADD

        text_position = replace(pose.position, z=pose.position.z + 0.25)
        text_pose = replace(pose, position=text_position)

        m.pose = pose_to_msg(text_pose)
        m.scale.z = 0.03
        m.color = self._label_color
        m.text = text
        return m

    def _edges_marker(self, marker_id: int, flattened_poses: list[Pose3D]) -> Marker:
        """Construct a visualization_msgs/Marker message to represent all graph edges."""
        m = Marker()
        m.header = self._header()
        m.ns = f"{self.ns}/edges"
        m.id = marker_id
        m.type = Marker.LINE_LIST
        m.action = Marker.ADD
        m.pose.orientation.w = 1.0
        m.scale.x = self.edge_width_m
        m.color = self._edge_color
        m.points = [point_to_msg(p.position) for p in flattened_poses]
        return m

    def update(self) -> None:
        """Publish updated markers to visualize the current GraphNav graph."""
        if self.resource_manager.should_pause:  # Exit early if RPC pause is requested
            return

        if self.graph is not None:
            markers = MarkerArray()
            markers.markers = []
            marker_id = 0
            for wp_name, wp_pose in self.graph.waypoints.items():
                markers.markers.append(self._waypoint_marker(marker_id, wp_pose))
                marker_id += 1
                if self.show_labels:
                    markers.markers.append(self._label_marker(marker_id, wp_pose, wp_name))
                    marker_id += 1

            # Find the poses of the waypoints for each edge
            edge_poses = [
                (self.graph.waypoints[src], self.graph.waypoints[dst])
                for (src, dst) in self.graph.edges
            ]
            flattened = [p for edge in edge_poses for p in edge]

            markers.markers.append(self._edges_marker(marker_id, flattened))

            self.pub.publish(markers)
            self.graph = None  # Clear the stored graph once it's been published to RViz

        if self.resource_manager.should_pause:  # Exit early if RPC pause is requested
            return

        self.graph = self.get_updated_graph()
