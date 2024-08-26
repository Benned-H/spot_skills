;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::BehaviorFault)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'BehaviorFault (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::BEHAVIORFAULT")
  (make-package "SPOT_MSGS::BEHAVIORFAULT"))

(in-package "ROS")
;;//! \htmlinclude BehaviorFault.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*CAUSE_UNKNOWN*" (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(shadow '*CAUSE_UNKNOWN* (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(defconstant spot_msgs::BehaviorFault::*CAUSE_UNKNOWN* 0)
(intern "*CAUSE_FALL*" (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(shadow '*CAUSE_FALL* (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(defconstant spot_msgs::BehaviorFault::*CAUSE_FALL* 1)
(intern "*CAUSE_HARDWARE*" (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(shadow '*CAUSE_HARDWARE* (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(defconstant spot_msgs::BehaviorFault::*CAUSE_HARDWARE* 2)
(intern "*STATUS_UNKNOWN*" (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(shadow '*STATUS_UNKNOWN* (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(defconstant spot_msgs::BehaviorFault::*STATUS_UNKNOWN* 0)
(intern "*STATUS_CLEARABLE*" (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(shadow '*STATUS_CLEARABLE* (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(defconstant spot_msgs::BehaviorFault::*STATUS_CLEARABLE* 1)
(intern "*STATUS_UNCLEARABLE*" (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(shadow '*STATUS_UNCLEARABLE* (find-package "SPOT_MSGS::BEHAVIORFAULT"))
(defconstant spot_msgs::BehaviorFault::*STATUS_UNCLEARABLE* 2)

(defun spot_msgs::BehaviorFault-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::BehaviorFault::*CAUSE_UNKNOWN*)
        ((= const 1) 'spot_msgs::BehaviorFault::*CAUSE_FALL*)
        ((= const 2) 'spot_msgs::BehaviorFault::*CAUSE_HARDWARE*)
        ((= const 0) 'spot_msgs::BehaviorFault::*STATUS_UNKNOWN*)
        ((= const 1) 'spot_msgs::BehaviorFault::*STATUS_CLEARABLE*)
        ((= const 2) 'spot_msgs::BehaviorFault::*STATUS_UNCLEARABLE*)
        (t nil)))

(defclass spot_msgs::BehaviorFault
  :super ros::object
  :slots (_header _behavior_fault_id _cause _status ))

(defmethod spot_msgs::BehaviorFault
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:behavior_fault_id __behavior_fault_id) 0)
    ((:cause __cause) 0)
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _behavior_fault_id (round __behavior_fault_id))
   (setq _cause (round __cause))
   (setq _status (round __status))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:behavior_fault_id
   (&optional __behavior_fault_id)
   (if __behavior_fault_id (setq _behavior_fault_id __behavior_fault_id)) _behavior_fault_id)
  (:cause
   (&optional __cause)
   (if __cause (setq _cause __cause)) _cause)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _behavior_fault_id
    4
    ;; uint8 _cause
    1
    ;; uint8 _status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _behavior_fault_id
       (write-long _behavior_fault_id s)
     ;; uint8 _cause
       (write-byte _cause s)
     ;; uint8 _status
       (write-byte _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _behavior_fault_id
     (setq _behavior_fault_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _cause
     (setq _cause (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_msgs::BehaviorFault :md5sum-) "849048e719811a4f2cf68e276a235d76")
(setf (get spot_msgs::BehaviorFault :datatype-) "spot_msgs/BehaviorFault")
(setf (get spot_msgs::BehaviorFault :definition-)
      "# Cause
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



(provide :spot_msgs/BehaviorFault "849048e719811a4f2cf68e276a235d76")


