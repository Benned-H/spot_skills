# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "spot_msgs: 71 messages, 20 services")

set(MSG_I_FLAGS "-Ispot_msgs:/spot_skills/src/spot_ros/spot_msgs/msg;-Ispot_msgs:/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(spot_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" "spot_msgs/BatteryState:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" "std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" "spot_msgs/EStopState:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" "spot_msgs/FootState:geometry_msgs/Vector3:spot_msgs/TerrainState:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" "spot_msgs/Lease:spot_msgs/LeaseResource:spot_msgs/LeaseOwner"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" "std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" "spot_msgs/TerrainParams:spot_msgs/ObstacleParams:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Vector3:geometry_msgs/Point:geometry_msgs/Twist"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" "std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" "std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" "spot_msgs/BehaviorFault:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" "std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" "geometry_msgs/Vector3:spot_msgs/TerrainState:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" "spot_msgs/Lease:spot_msgs/LeaseOwner"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" "std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" "spot_msgs/SystemFault:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" "geometry_msgs/Vector3"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" "geometry_msgs/PoseWithCovariance:geometry_msgs/Pose:geometry_msgs/Point:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" "geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point:spot_msgs/ParentEdge"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" "geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" "sensor_msgs/Image:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point:spot_msgs/FrameTreeSnapshot:spot_msgs/ParentEdge"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" "sensor_msgs/Image:std_msgs/Header:geometry_msgs/Polygon:spot_msgs/ImageCapture:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/Point32:spot_msgs/FrameTreeSnapshot:spot_msgs/ParentEdge:spot_msgs/ImageSource"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" "geometry_msgs/PoseWithCovariance:sensor_msgs/Image:std_msgs/Header:geometry_msgs/Polygon:spot_msgs/ImageCapture:spot_msgs/AprilTagProperties:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Vector3:geometry_msgs/Point:spot_msgs/ImageProperties:geometry_msgs/Point32:spot_msgs/FrameTreeSnapshot:spot_msgs/ParentEdge:spot_msgs/ImageSource"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" "geometry_msgs/PoseWithCovariance:sensor_msgs/Image:std_msgs/Header:geometry_msgs/Polygon:spot_msgs/ImageCapture:spot_msgs/AprilTagProperties:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Vector3:geometry_msgs/Point:spot_msgs/WorldObject:spot_msgs/ImageProperties:geometry_msgs/Point32:spot_msgs/FrameTreeSnapshot:spot_msgs/ParentEdge:spot_msgs/ImageSource"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" "spot_msgs/DockState:spot_msgs/DockGoal:spot_msgs/DockFeedback:std_msgs/Header:spot_msgs/DockActionFeedback:spot_msgs/DockActionGoal:actionlib_msgs/GoalStatus:spot_msgs/DockResult:spot_msgs/DockActionResult:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" "spot_msgs/DockGoal:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" "actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:spot_msgs/DockResult:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" "spot_msgs/DockState:spot_msgs/DockFeedback:std_msgs/Header:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" "spot_msgs/DockState"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" "spot_msgs/NavigateToGoal:spot_msgs/NavigateToFeedback:std_msgs/Header:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:spot_msgs/NavigateToActionGoal:spot_msgs/NavigateToActionResult:spot_msgs/NavigateToResult:spot_msgs/NavigateToActionFeedback"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" "spot_msgs/NavigateToGoal:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" "spot_msgs/NavigateToResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" "spot_msgs/NavigateToFeedback:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" "spot_msgs/NavigateRouteResult:std_msgs/Header:spot_msgs/NavigateRouteFeedback:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:spot_msgs/NavigateRouteGoal:spot_msgs/NavigateRouteActionResult:spot_msgs/NavigateRouteActionGoal:spot_msgs/NavigateRouteActionFeedback"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" "spot_msgs/NavigateRouteGoal:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" "spot_msgs/NavigateRouteResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" "spot_msgs/NavigateRouteFeedback:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" "spot_msgs/PoseBodyResult:std_msgs/Header:spot_msgs/PoseBodyActionGoal:actionlib_msgs/GoalStatus:spot_msgs/PoseBodyGoal:actionlib_msgs/GoalID:geometry_msgs/Pose:geometry_msgs/Quaternion:spot_msgs/PoseBodyActionResult:geometry_msgs/Point:spot_msgs/PoseBodyActionFeedback:spot_msgs/PoseBodyFeedback"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" "std_msgs/Header:spot_msgs/PoseBodyGoal:actionlib_msgs/GoalID:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" "spot_msgs/PoseBodyResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" "spot_msgs/PoseBodyFeedback:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" "geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" "spot_msgs/TrajectoryActionResult:std_msgs/Header:spot_msgs/TrajectoryActionGoal:geometry_msgs/PoseStamped:actionlib_msgs/GoalStatus:spot_msgs/TrajectoryResult:std_msgs/Duration:actionlib_msgs/GoalID:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point:spot_msgs/TrajectoryFeedback:spot_msgs/TrajectoryGoal:spot_msgs/TrajectoryActionFeedback"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" "std_msgs/Header:geometry_msgs/PoseStamped:std_msgs/Duration:actionlib_msgs/GoalID:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point:spot_msgs/TrajectoryGoal"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" "spot_msgs/TrajectoryResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" "spot_msgs/TrajectoryFeedback:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" "std_msgs/Header:geometry_msgs/PoseStamped:std_msgs/Duration:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" "geometry_msgs/Vector3:geometry_msgs/Twist"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" "geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" "spot_msgs/ObstacleParams"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" "spot_msgs/TerrainParams"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" "spot_msgs/DockState"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" "spot_msgs/SpotCheckLoadCell:spot_msgs/SpotCheckKinematic:spot_msgs/SpotCheckDepth:spot_msgs/SpotCheckHipROM:spot_msgs/SpotCheckPayload"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" NAME_WE)
add_custom_target(_spot_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_msgs" "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_msg_cpp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)

### Generating Services
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)
_generate_srv_cpp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
)

### Generating Module File
_generate_module_cpp(spot_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(spot_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(spot_msgs_generate_messages spot_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_cpp _spot_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_msgs_gencpp)
add_dependencies(spot_msgs_gencpp spot_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_msg_eus(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)

### Generating Services
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)
_generate_srv_eus(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
)

### Generating Module File
_generate_module_eus(spot_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(spot_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(spot_msgs_generate_messages spot_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_eus _spot_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_msgs_geneus)
add_dependencies(spot_msgs_geneus spot_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_msg_lisp(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)

### Generating Services
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)
_generate_srv_lisp(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
)

### Generating Module File
_generate_module_lisp(spot_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(spot_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(spot_msgs_generate_messages spot_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_lisp _spot_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_msgs_genlisp)
add_dependencies(spot_msgs_genlisp spot_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_msg_nodejs(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)

### Generating Services
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)
_generate_srv_nodejs(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
)

### Generating Module File
_generate_module_nodejs(spot_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(spot_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(spot_msgs_generate_messages spot_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_nodejs _spot_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_msgs_gennodejs)
add_dependencies(spot_msgs_gennodejs spot_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg;/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Polygon.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg;/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point32.msg;/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg;/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Duration.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_msg_py(spot_msgs
  "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)

### Generating Services
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg;/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)
_generate_srv_py(spot_msgs
  "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
)

### Generating Module File
_generate_module_py(spot_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(spot_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(spot_msgs_generate_messages spot_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv" NAME_WE)
add_dependencies(spot_msgs_generate_messages_py _spot_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_msgs_genpy)
add_dependencies(spot_msgs_genpy spot_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(spot_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(spot_msgs_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(spot_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(spot_msgs_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(spot_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(spot_msgs_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(spot_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(spot_msgs_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(spot_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(spot_msgs_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(spot_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(spot_msgs_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(spot_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(spot_msgs_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(spot_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(spot_msgs_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(spot_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(spot_msgs_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(spot_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(spot_msgs_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
