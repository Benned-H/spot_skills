;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetPTZState)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetPTZState (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETPTZSTATE")
  (make-package "SPOT_CAM::SETPTZSTATE"))
(unless (find-package "SPOT_CAM::SETPTZSTATEREQUEST")
  (make-package "SPOT_CAM::SETPTZSTATEREQUEST"))
(unless (find-package "SPOT_CAM::SETPTZSTATERESPONSE")
  (make-package "SPOT_CAM::SETPTZSTATERESPONSE"))

(in-package "ROS")





(defclass spot_cam::SetPTZStateRequest
  :super ros::object
  :slots (_command ))

(defmethod spot_cam::SetPTZStateRequest
  (:init
   (&key
    ((:command __command) (instance spot_cam::PTZState :init))
    )
   (send-super :init)
   (setq _command __command)
   self)
  (:command
   (&rest __command)
   (if (keywordp (car __command))
       (send* _command __command)
     (progn
       (if __command (setq _command (car __command)))
       _command)))
  (:serialization-length
   ()
   (+
    ;; spot_cam/PTZState _command
    (send _command :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_cam/PTZState _command
       (send _command :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_cam/PTZState _command
     (send _command :deserialize buf ptr-) (incf ptr- (send _command :serialization-length))
   ;;
   self)
  )

(defclass spot_cam::SetPTZStateResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetPTZStateResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_cam::SetPTZState
  :super ros::object
  :slots ())

(setf (get spot_cam::SetPTZState :md5sum-) "2dd984827d05222cd185e849e7da947f")
(setf (get spot_cam::SetPTZState :datatype-) "spot_cam/SetPTZState")
(setf (get spot_cam::SetPTZState :request) spot_cam::SetPTZStateRequest)
(setf (get spot_cam::SetPTZState :response) spot_cam::SetPTZStateResponse)

(defmethod spot_cam::SetPTZStateRequest
  (:response () (instance spot_cam::SetPTZStateResponse :init)))

(setf (get spot_cam::SetPTZStateRequest :md5sum-) "2dd984827d05222cd185e849e7da947f")
(setf (get spot_cam::SetPTZStateRequest :datatype-) "spot_cam/SetPTZStateRequest")
(setf (get spot_cam::SetPTZStateRequest :definition-)
      "# This message can be used to send either position or velocity commands
# The description of the ptz does not need to be complete - only the name is used
spot_cam/PTZState command

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
---
bool success
string message
")

(setf (get spot_cam::SetPTZStateResponse :md5sum-) "2dd984827d05222cd185e849e7da947f")
(setf (get spot_cam::SetPTZStateResponse :datatype-) "spot_cam/SetPTZStateResponse")
(setf (get spot_cam::SetPTZStateResponse :definition-)
      "# This message can be used to send either position or velocity commands
# The description of the ptz does not need to be complete - only the name is used
spot_cam/PTZState command

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
---
bool success
string message
")



(provide :spot_cam/SetPTZState "2dd984827d05222cd185e849e7da947f")


