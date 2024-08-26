# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "spot_cam: 19 messages, 10 services")

set(MSG_I_FLAGS "-Ispot_cam:/spot_skills/src/spot_ros/spot_cam/msg;-Ispot_cam:/spot_skills/devel/.private/spot_cam/share/spot_cam/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Ispot_msgs:/spot_skills/src/spot_ros/spot_msgs/msg;-Ispot_msgs:/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(spot_cam_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" "spot_msgs/SystemFault:spot_cam/Degradation:std_msgs/Header"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" "spot_cam/PTZLimits"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" "spot_cam/PTZDescription:spot_cam/PTZLimits"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" "spot_cam/PTZDescription:std_msgs/Header:spot_cam/PTZLimits"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" "spot_cam/PTZDescription:std_msgs/Header:spot_cam/PTZState:spot_cam/PTZLimits"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" "spot_cam/Temperature"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" "spot_cam/LookAtPointActionResult:geometry_msgs/PointStamped:spot_cam/LookAtPointActionGoal:std_msgs/Header:actionlib_msgs/GoalID:spot_cam/LookAtPointActionFeedback:actionlib_msgs/GoalStatus:spot_cam/LookAtPointGoal:spot_cam/LookAtPointFeedback:geometry_msgs/Point:spot_cam/LookAtPointResult"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" "geometry_msgs/PointStamped:std_msgs/Header:actionlib_msgs/GoalID:spot_cam/LookAtPointGoal:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" "actionlib_msgs/GoalStatus:spot_cam/LookAtPointResult:std_msgs/Header:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" "actionlib_msgs/GoalStatus:spot_cam/LookAtPointFeedback:std_msgs/Header:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" "geometry_msgs/PointStamped:std_msgs/Header:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" ""
)

get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" "geometry_msgs/PointStamped:std_msgs/Header:geometry_msgs/Point"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" ""
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" "spot_cam/PTZDescription:std_msgs/Header:spot_cam/PTZState:spot_cam/PTZLimits"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" "spot_cam/StreamParams"
)

get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" NAME_WE)
add_custom_target(_spot_cam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "spot_cam" "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_msg_cpp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)

### Generating Services
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)
_generate_srv_cpp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
)

### Generating Module File
_generate_module_cpp(spot_cam
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(spot_cam_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(spot_cam_generate_messages spot_cam_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_cpp _spot_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_cam_gencpp)
add_dependencies(spot_cam_gencpp spot_cam_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_cam_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_msg_eus(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)

### Generating Services
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)
_generate_srv_eus(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
)

### Generating Module File
_generate_module_eus(spot_cam
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(spot_cam_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(spot_cam_generate_messages spot_cam_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_eus _spot_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_cam_geneus)
add_dependencies(spot_cam_geneus spot_cam_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_cam_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_msg_lisp(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)

### Generating Services
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)
_generate_srv_lisp(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
)

### Generating Module File
_generate_module_lisp(spot_cam
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(spot_cam_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(spot_cam_generate_messages spot_cam_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_lisp _spot_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_cam_genlisp)
add_dependencies(spot_cam_genlisp spot_cam_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_cam_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_msg_nodejs(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)

### Generating Services
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)
_generate_srv_nodejs(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
)

### Generating Module File
_generate_module_nodejs(spot_cam
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(spot_cam_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(spot_cam_generate_messages spot_cam_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_nodejs _spot_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_cam_gennodejs)
add_dependencies(spot_cam_gennodejs spot_cam_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_cam_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg;/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg"
  "${MSG_I_FLAGS}"
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_msg_py(spot_cam
  "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)

### Generating Services
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PointStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg;/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv"
  "${MSG_I_FLAGS}"
  "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)
_generate_srv_py(spot_cam
  "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
)

### Generating Module File
_generate_module_py(spot_cam
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(spot_cam_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(spot_cam_generate_messages spot_cam_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/BITStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Degradation.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PowerStatus.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescription.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZDescriptionArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZLimits.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZState.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/PTZStateArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StreamParams.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/StringMultiArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/Temperature.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/msg/TemperatureArray.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointAction.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointActionFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointGoal.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointResult.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/devel/.private/spot_cam/share/spot_cam/msg/LookAtPointFeedback.msg" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LoadSound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/LookAtPoint.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/PlaySound.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetBool.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetFloat.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRColormap.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetIRMeterOverlay.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetPTZState.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetStreamParams.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/spot_skills/src/spot_ros/spot_cam/srv/SetString.srv" NAME_WE)
add_dependencies(spot_cam_generate_messages_py _spot_cam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(spot_cam_genpy)
add_dependencies(spot_cam_genpy spot_cam_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS spot_cam_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/spot_cam
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(spot_cam_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET spot_msgs_generate_messages_cpp)
  add_dependencies(spot_cam_generate_messages_cpp spot_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(spot_cam_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/spot_cam
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(spot_cam_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET spot_msgs_generate_messages_eus)
  add_dependencies(spot_cam_generate_messages_eus spot_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(spot_cam_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/spot_cam
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(spot_cam_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET spot_msgs_generate_messages_lisp)
  add_dependencies(spot_cam_generate_messages_lisp spot_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(spot_cam_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/spot_cam
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(spot_cam_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET spot_msgs_generate_messages_nodejs)
  add_dependencies(spot_cam_generate_messages_nodejs spot_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(spot_cam_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/spot_cam
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(spot_cam_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET spot_msgs_generate_messages_py)
  add_dependencies(spot_cam_generate_messages_py spot_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(spot_cam_generate_messages_py geometry_msgs_generate_messages_py)
endif()
