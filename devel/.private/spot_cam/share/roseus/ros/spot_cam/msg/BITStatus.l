;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::BITStatus)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'BITStatus (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::BITSTATUS")
  (make-package "SPOT_CAM::BITSTATUS"))

(in-package "ROS")
;;//! \htmlinclude BITStatus.msg.html
(if (not (find-package "SPOT_MSGS"))
  (ros::roseus-add-msgs "spot_msgs"))


(defclass spot_cam::BITStatus
  :super ros::object
  :slots (_events _degradations ))

(defmethod spot_cam::BITStatus
  (:init
   (&key
    ((:events __events) ())
    ((:degradations __degradations) ())
    )
   (send-super :init)
   (setq _events __events)
   (setq _degradations __degradations)
   self)
  (:events
   (&rest __events)
   (if (keywordp (car __events))
       (send* _events __events)
     (progn
       (if __events (setq _events (car __events)))
       _events)))
  (:degradations
   (&rest __degradations)
   (if (keywordp (car __degradations))
       (send* _degradations __degradations)
     (progn
       (if __degradations (setq _degradations (car __degradations)))
       _degradations)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/SystemFault[] _events
    (apply #'+ (send-all _events :serialization-length)) 4
    ;; spot_cam/Degradation[] _degradations
    (apply #'+ (send-all _degradations :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/SystemFault[] _events
     (write-long (length _events) s)
     (dolist (elem _events)
       (send elem :serialize s)
       )
     ;; spot_cam/Degradation[] _degradations
     (write-long (length _degradations) s)
     (dolist (elem _degradations)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/SystemFault[] _events
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _events (let (r) (dotimes (i n) (push (instance spot_msgs::SystemFault :init) r)) r))
     (dolist (elem- _events)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; spot_cam/Degradation[] _degradations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _degradations (let (r) (dotimes (i n) (push (instance spot_cam::Degradation :init) r)) r))
     (dolist (elem- _degradations)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_cam::BITStatus :md5sum-) "bbef0264c8e68f60c3f5c0359d3c130d")
(setf (get spot_cam::BITStatus :datatype-) "spot_cam/BITStatus")
(setf (get spot_cam::BITStatus :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse
spot_msgs/SystemFault[] events
spot_cam/Degradation[] degradations
================================================================================
MSG: spot_msgs/SystemFault
# Severity
uint8 SEVERITY_UNKNOWN = 0
uint8 SEVERITY_INFO = 1
uint8 SEVERITY_WARN = 2
uint8 SEVERITY_CRITICAL = 3

Header header
string name
duration duration
int32 code
uint64 uid
string error_message
string[] attributes
uint8 severity

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
MSG: spot_cam/Degradation
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation
# Different degradation types
uint8 TYPE_STORAGE=0
uint8 TYPE_PTZ=1
uint8 TYPE_LED=2

# The system affected by the degradation
uint8 type
# What degradation is being experienced
string description
")



(provide :spot_cam/BITStatus "bbef0264c8e68f60c3f5c0359d3c130d")


