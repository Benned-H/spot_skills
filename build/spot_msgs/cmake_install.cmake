# Install script for directory: /spot_skills/src/spot_ros/spot_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/spot_skills/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/spot_skills/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/spot_skills/install" TYPE PROGRAM FILES "/spot_skills/build/spot_msgs/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/spot_skills/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/spot_skills/install" TYPE PROGRAM FILES "/spot_skills/build/spot_msgs/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/spot_skills/install/setup.bash;/spot_skills/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/spot_skills/install" TYPE FILE FILES
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/setup.bash"
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/spot_skills/install/setup.sh;/spot_skills/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/spot_skills/install" TYPE FILE FILES
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/setup.sh"
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/spot_skills/install/setup.zsh;/spot_skills/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/spot_skills/install" TYPE FILE FILES
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/setup.zsh"
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/spot_skills/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/spot_skills/install" TYPE FILE FILES "/spot_skills/build/spot_msgs/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/msg" TYPE FILE FILES
    "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryStateArray.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFault.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/EStopStateArray.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/FootStateArray.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseArray.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseOwner.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/Metrics.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/MobilityParams.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFault.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/WiFiState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/BatteryState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/BehaviorFaultState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/EStopState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/Feedback.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/FootState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/Lease.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/LeaseResource.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/PowerState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SystemFaultState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/DockState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/ObstacleParams.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainParams.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/TerrainState.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckDepth.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckHipROM.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckKinematic.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckLoadCell.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/SpotCheckPayload.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/AprilTagProperties.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/FrameTreeSnapshot.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/ParentEdge.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/ImageCapture.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/ImageProperties.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/ImageSource.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObject.msg"
    "/spot_skills/src/spot_ros/spot_msgs/msg/WorldObjectArray.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/srv" TYPE FILE FILES
    "/spot_skills/src/spot_ros/spot_msgs/srv/DownloadGraph.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/ListGraph.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/GraphCloseLoops.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/SetLocomotion.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/SetSwingHeight.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/SetVelocity.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/ClearBehaviorFault.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/ArmJointMovement.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/ConstrainedArmJointMovement.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/GripperAngleMove.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/ArmForceTrajectory.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/HandPose.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/SetObstacleParams.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/SetTerrainParams.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/PosedStand.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/Dock.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/GetDockState.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/SpotCheck.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/Grasp3d.srv"
    "/spot_skills/src/spot_ros/spot_msgs/srv/NavigateInit.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/action" TYPE FILE FILES
    "/spot_skills/src/spot_ros/spot_msgs/action/Dock.action"
    "/spot_skills/src/spot_ros/spot_msgs/action/NavigateTo.action"
    "/spot_skills/src/spot_ros/spot_msgs/action/NavigateRoute.action"
    "/spot_skills/src/spot_ros/spot_msgs/action/PoseBody.action"
    "/spot_skills/src/spot_ros/spot_msgs/action/Trajectory.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/msg" TYPE FILE FILES
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockAction.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockActionFeedback.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/DockFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/msg" TYPE FILE FILES
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToAction.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToActionFeedback.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateToFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/msg" TYPE FILE FILES
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteAction.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteActionFeedback.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/NavigateRouteFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/msg" TYPE FILE FILES
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyAction.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyActionFeedback.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/PoseBodyFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/msg" TYPE FILE FILES
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryAction.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryActionFeedback.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryGoal.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryResult.msg"
    "/spot_skills/devel/.private/spot_msgs/share/spot_msgs/msg/TrajectoryFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/cmake" TYPE FILE FILES "/spot_skills/build/spot_msgs/catkin_generated/installspace/spot_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/spot_skills/devel/.private/spot_msgs/include/spot_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/spot_skills/devel/.private/spot_msgs/share/roseus/ros/spot_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/spot_skills/devel/.private/spot_msgs/share/common-lisp/ros/spot_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/spot_skills/devel/.private/spot_msgs/share/gennodejs/ros/spot_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/spot_skills/devel/.private/spot_msgs/lib/python3/dist-packages/spot_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/spot_skills/devel/.private/spot_msgs/lib/python3/dist-packages/spot_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/spot_skills/build/spot_msgs/catkin_generated/installspace/spot_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/cmake" TYPE FILE FILES "/spot_skills/build/spot_msgs/catkin_generated/installspace/spot_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs/cmake" TYPE FILE FILES
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/spot_msgsConfig.cmake"
    "/spot_skills/build/spot_msgs/catkin_generated/installspace/spot_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/spot_msgs" TYPE FILE FILES "/spot_skills/src/spot_ros/spot_msgs/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/spot_skills/build/spot_msgs/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/spot_skills/build/spot_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
