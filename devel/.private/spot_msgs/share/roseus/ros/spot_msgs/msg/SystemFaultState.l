;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SystemFaultState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SystemFaultState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SYSTEMFAULTSTATE")
  (make-package "SPOT_MSGS::SYSTEMFAULTSTATE"))

(in-package "ROS")
;;//! \htmlinclude SystemFaultState.msg.html


(defclass spot_msgs::SystemFaultState
  :super ros::object
  :slots (_faults _historical_faults ))

(defmethod spot_msgs::SystemFaultState
  (:init
   (&key
    ((:faults __faults) ())
    ((:historical_faults __historical_faults) ())
    )
   (send-super :init)
   (setq _faults __faults)
   (setq _historical_faults __historical_faults)
   self)
  (:faults
   (&rest __faults)
   (if (keywordp (car __faults))
       (send* _faults __faults)
     (progn
       (if __faults (setq _faults (car __faults)))
       _faults)))
  (:historical_faults
   (&rest __historical_faults)
   (if (keywordp (car __historical_faults))
       (send* _historical_faults __historical_faults)
     (progn
       (if __historical_faults (setq _historical_faults (car __historical_faults)))
       _historical_faults)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/SystemFault[] _faults
    (apply #'+ (send-all _faults :serialization-length)) 4
    ;; spot_msgs/SystemFault[] _historical_faults
    (apply #'+ (send-all _historical_faults :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/SystemFault[] _faults
     (write-long (length _faults) s)
     (dolist (elem _faults)
       (send elem :serialize s)
       )
     ;; spot_msgs/SystemFault[] _historical_faults
     (write-long (length _historical_faults) s)
     (dolist (elem _historical_faults)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/SystemFault[] _faults
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _faults (let (r) (dotimes (i n) (push (instance spot_msgs::SystemFault :init) r)) r))
     (dolist (elem- _faults)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; spot_msgs/SystemFault[] _historical_faults
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _historical_faults (let (r) (dotimes (i n) (push (instance spot_msgs::SystemFault :init) r)) r))
     (dolist (elem- _historical_faults)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::SystemFaultState :md5sum-) "3847105c5e3204fe63ad7caa31a33575")
(setf (get spot_msgs::SystemFaultState :datatype-) "spot_msgs/SystemFaultState")
(setf (get spot_msgs::SystemFaultState :definition-)
      "SystemFault[] faults
SystemFault[] historical_faults

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

")



(provide :spot_msgs/SystemFaultState "3847105c5e3204fe63ad7caa31a33575")


