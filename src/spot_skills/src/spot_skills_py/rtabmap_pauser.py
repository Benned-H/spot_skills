"""Define classes to manage pausing and resuming RTAB-Map."""

from enum import Enum

import rospy
from robotics_utils.ros.services import ServiceCaller
from std_srvs.srv import Empty, EmptyRequest


class RTABMapState(Enum):
    """State of RTAB-Map: Either not running, paused, or live."""

    NOT_RUNNING = 0
    PAUSED = 1
    LIVE = 2


RTABMAP_PAUSE_WAIT_S = 3  # Duration (seconds) to wait after pausing RTAB-Map
RTABMAP_RESUME_WAIT_S = 1  # Duration (seconds) to wait after resuming RTAB-Map


class RTABMapPauser:
    """Manages pausing and resuming RTAB-Map through ROS service calls."""

    def __init__(self) -> None:
        """Initialize the state of the RTAB-Map pauser by checking if RTAB-Map is live."""
        self.state = RTABMapState.NOT_RUNNING

        try:
            self._pause_srv = ServiceCaller("rtabmap/pause", Empty, timeout_s=10)
            self._resume_srv = ServiceCaller("rtabmap/resume", Empty, timeout_s=10)
            rospy.loginfo("Service callers have been created to pause and resume RTAB-Map.")

            self._resume_srv(EmptyRequest())  # Ensure that RTAB-Map is unpaused by default
            self.state = RTABMapState.LIVE

        except rospy.ROSException as exc:
            rospy.logwarn(f"Exception when checking for RTAB-Map services: {exc}")
            self.state = RTABMapState.NOT_RUNNING

    def pause(self) -> None:
        """If RTAB-Map is running and live, pause it."""
        rospy.loginfo(f"Entering RTABMapPauser.pause with state: {self.state}...")
        if self.state == RTABMapState.LIVE:
            rospy.loginfo("Pausing RTAB-Map, which is currently live...")
            self._pause_srv(EmptyRequest())
            self.state = RTABMapState.PAUSED
            rospy.sleep(RTABMAP_PAUSE_WAIT_S)

    def resume(self) -> None:
        """If RTAB-Map is running and paused, resume it."""
        rospy.loginfo(f"Entering RTABMapPauser.resume with state: {self.state}...")
        if self.state == RTABMapState.PAUSED:
            rospy.loginfo("Resuming RTAB-Map, which is currently paused...")
            self._resume_srv(EmptyRequest())
            self.state = RTABMapState.LIVE
            rospy.sleep(RTABMAP_RESUME_WAIT_S)
