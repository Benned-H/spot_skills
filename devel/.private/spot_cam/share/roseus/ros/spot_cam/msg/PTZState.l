;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PTZState)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PTZState (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::PTZSTATE")
  (make-package "SPOT_CAM::PTZSTATE"))

(in-package "ROS")
;;//! \htmlinclude PTZState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass spot_cam::PTZState
  :super ros::object
  :slots (_header _ptz _pan _tilt _zoom ))

(defmethod spot_cam::PTZState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ptz __ptz) (instance spot_cam::PTZDescription :init))
    ((:pan __pan) 0.0)
    ((:tilt __tilt) 0.0)
    ((:zoom __zoom) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _ptz __ptz)
   (setq _pan (float __pan))
   (setq _tilt (float __tilt))
   (setq _zoom (float __zoom))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:ptz
   (&rest __ptz)
   (if (keywordp (car __ptz))
       (send* _ptz __ptz)
     (progn
       (if __ptz (setq _ptz (car __ptz)))
       _ptz)))
  (:pan
   (&optional __pan)
   (if __pan (setq _pan __pan)) _pan)
  (:tilt
   (&optional __tilt)
   (if __tilt (setq _tilt __tilt)) _tilt)
  (:zoom
   (&optional __zoom)
   (if __zoom (setq _zoom __zoom)) _zoom)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; spot_cam/PTZDescription _ptz
    (send _ptz :serialization-length)
    ;; float32 _pan
    4
    ;; float32 _tilt
    4
    ;; float32 _zoom
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; spot_cam/PTZDescription _ptz
       (send _ptz :serialize s)
     ;; float32 _pan
       (sys::poke _pan (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt
       (sys::poke _tilt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _zoom
       (sys::poke _zoom (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; spot_cam/PTZDescription _ptz
     (send _ptz :deserialize buf ptr-) (incf ptr- (send _ptz :serialization-length))
   ;; float32 _pan
     (setq _pan (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt
     (setq _tilt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _zoom
     (setq _zoom (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_cam::PTZState :md5sum-) "6780ed299706699768ff791d8291261f")
(setf (get spot_cam::PTZState :datatype-) "spot_cam/PTZState")
(setf (get spot_cam::PTZState :definition-)
      "# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,
# The meaning of the pan/tilt/zoom values changes.
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity
std_msgs/Header header
# Description of the ptz
spot_cam/PTZDescription ptz
# degrees or degrees per second
float32 pan
# degrees or degrees per second
float32 tilt
# zoom level or zoom level per second
float32 zoom
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: spot_cam/PTZDescription
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
# Name of this ptz (can be virtual)
string name
# Limits in degrees on the pan axis
spot_cam/PTZLimits pan_limit
# Limits in degrees on the pan axis
spot_cam/PTZLimits tilt_limit
# Limits in degrees on the pan axis
spot_cam/PTZLimits zoom_limit
================================================================================
MSG: spot_cam/PTZLimits
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits
# If both max and min are zero, this means the limit is unset. The documentation states that if a limit
# is unset, then all positions are valid.
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
# Minimum value for the axis
float32 min
# Maximum value for the axis
float32 max
")



(provide :spot_cam/PTZState "6780ed299706699768ff791d8291261f")


