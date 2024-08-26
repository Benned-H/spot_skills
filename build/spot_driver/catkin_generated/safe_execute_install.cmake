execute_process(COMMAND "/spot_skills/build/spot_driver/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/spot_skills/build/spot_driver/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
