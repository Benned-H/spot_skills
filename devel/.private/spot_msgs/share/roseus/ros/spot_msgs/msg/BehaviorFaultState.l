;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::BehaviorFaultState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'BehaviorFaultState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::BEHAVIORFAULTSTATE")
  (make-package "SPOT_MSGS::BEHAVIORFAULTSTATE"))

(in-package "ROS")
;;//! \htmlinclude BehaviorFaultState.msg.html


(defclass spot_msgs::BehaviorFaultState
  :super ros::object
  :slots (_faults ))

(defmethod spot_msgs::BehaviorFaultState
  (:init
   (&key
    ((:faults __faults) ())
    )
   (send-super :init)
   (setq _faults __faults)
   self)
  (:faults
   (&rest __faults)
   (if (keywordp (car __faults))
       (send* _faults __faults)
     (progn
       (if __faults (setq _faults (car __faults)))
       _faults)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/BehaviorFault[] _faults
    (apply #'+ (send-all _faults :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/BehaviorFault[] _faults
     (write-long (length _faults) s)
     (dolist (elem _faults)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/BehaviorFault[] _faults
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _faults (let (r) (dotimes (i n) (push (instance spot_msgs::BehaviorFault :init) r)) r))
     (dolist (elem- _faults)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::BehaviorFaultState :md5sum-) "59543c1c1ad10a39140a97dcfc78f876")
(setf (get spot_msgs::BehaviorFaultState :datatype-) "spot_msgs/BehaviorFaultState")
(setf (get spot_msgs::BehaviorFaultState :definition-)
      "BehaviorFault[] faults

================================================================================
MSG: spot_msgs/BehaviorFault
# Cause
uint8 CAUSE_UNKNOWN = 0
uint8 CAUSE_FALL = 1
uint8 CAUSE_HARDWARE = 2

# Status
uint8 STATUS_UNKNOWN = 0
uint8 STATUS_CLEARABLE = 1
uint8 STATUS_UNCLEARABLE = 2

Header header
uint32 behavior_fault_id
uint8 cause
uint8 status

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



(provide :spot_msgs/BehaviorFaultState "59543c1c1ad10a39140a97dcfc78f876")


