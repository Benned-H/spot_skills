;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PTZStateArray)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PTZStateArray (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::PTZSTATEARRAY")
  (make-package "SPOT_CAM::PTZSTATEARRAY"))

(in-package "ROS")
;;//! \htmlinclude PTZStateArray.msg.html


(defclass spot_cam::PTZStateArray
  :super ros::object
  :slots (_ptzs ))

(defmethod spot_cam::PTZStateArray
  (:init
   (&key
    ((:ptzs __ptzs) ())
    )
   (send-super :init)
   (setq _ptzs __ptzs)
   self)
  (:ptzs
   (&rest __ptzs)
   (if (keywordp (car __ptzs))
       (send* _ptzs __ptzs)
     (progn
       (if __ptzs (setq _ptzs (car __ptzs)))
       _ptzs)))
  (:serialization-length
   ()
   (+
    ;; spot_cam/PTZState[] _ptzs
    (apply #'+ (send-all _ptzs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_cam/PTZState[] _ptzs
     (write-long (length _ptzs) s)
     (dolist (elem _ptzs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_cam/PTZState[] _ptzs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ptzs (let (r) (dotimes (i n) (push (instance spot_cam::PTZState :init) r)) r))
     (dolist (elem- _ptzs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_cam::PTZStateArray :md5sum-) "c71a65fc59258e7303baf75176b74b2b")
(setf (get spot_cam::PTZStateArray :datatype-) "spot_cam/PTZStateArray")
(setf (get spot_cam::PTZStateArray :definition-)
      "spot_cam/PTZState[] ptzs
================================================================================
MSG: spot_cam/PTZState
# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,
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



(provide :spot_cam/PTZStateArray "c71a65fc59258e7303baf75176b74b2b")


