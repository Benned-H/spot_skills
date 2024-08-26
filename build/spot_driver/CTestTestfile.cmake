# CMake generated Testfile for 
# Source directory: /spot_skills/src/spot_ros/spot_driver
# Build directory: /spot_skills/build/spot_driver
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_spot_driver_nosetests_test.run_tests.py "/spot_skills/build/spot_driver/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/spot_skills/build/spot_driver/test_results/spot_driver/nosetests-test.run_tests.py.xml" "--return-code" "\"/usr/bin/cmake\" -E make_directory /spot_skills/build/spot_driver/test_results/spot_driver" "/usr/bin/nosetests3 -P --process-timeout=60 /spot_skills/src/spot_ros/spot_driver/test/run_tests.py --with-xunit --xunit-file=/spot_skills/build/spot_driver/test_results/spot_driver/nosetests-test.run_tests.py.xml")
set_tests_properties(_ctest_spot_driver_nosetests_test.run_tests.py PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/catkin/cmake/test/nosetests.cmake;83;catkin_run_tests_target;/spot_skills/src/spot_ros/spot_driver/CMakeLists.txt;26;catkin_add_nosetests;/spot_skills/src/spot_ros/spot_driver/CMakeLists.txt;0;")
subdirs("gtest")
