#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/spot_skills/src/spot_ros/spot_cam"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/spot_skills/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/spot_skills/install/lib/python3/dist-packages:/spot_skills/build/spot_cam/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/spot_skills/build/spot_cam" \
    "/usr/bin/python3" \
    "/spot_skills/src/spot_ros/spot_cam/setup.py" \
    egg_info --egg-base /spot_skills/build/spot_cam \
    build --build-base "/spot_skills/build/spot_cam" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/spot_skills/install" --install-scripts="/spot_skills/install/bin"
