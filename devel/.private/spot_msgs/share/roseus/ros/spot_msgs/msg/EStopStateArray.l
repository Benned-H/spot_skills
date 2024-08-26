;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::EStopStateArray)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'EStopStateArray (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::ESTOPSTATEARRAY")
  (make-package "SPOT_MSGS::ESTOPSTATEARRAY"))

(in-package "ROS")
;;//! \htmlinclude EStopStateArray.msg.html


(defclass spot_msgs::EStopStateArray
  :super ros::object
  :slots (_estop_states ))

(defmethod spot_msgs::EStopStateArray
  (:init
   (&key
    ((:estop_states __estop_states) ())
    )
   (send-super :init)
   (setq _estop_states __estop_states)
   self)
  (:estop_states
   (&rest __estop_states)
   (if (keywordp (car __estop_states))
       (send* _estop_states __estop_states)
     (progn
       (if __estop_states (setq _estop_states (car __estop_states)))
       _estop_states)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/EStopState[] _estop_states
    (apply #'+ (send-all _estop_states :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/EStopState[] _estop_states
     (write-long (length _estop_states) s)
     (dolist (elem _estop_states)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/EStopState[] _estop_states
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _estop_states (let (r) (dotimes (i n) (push (instance spot_msgs::EStopState :init) r)) r))
     (dolist (elem- _estop_states)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::EStopStateArray :md5sum-) "9a14a6b761f26c00c5613f0dc614f084")
(setf (get spot_msgs::EStopStateArray :datatype-) "spot_msgs/EStopStateArray")
(setf (get spot_msgs::EStopStateArray :definition-)
      "EStopState[] estop_states

================================================================================
MSG: spot_msgs/EStopState
# Type
uint8 TYPE_UNKNOWN = 0
uint8 TYPE_HARDWARE = 1
uint8 TYPE_SOFTWARE = 2

# State
uint8 STATE_UNKNOWN = 0
uint8 STATE_ESTOPPED = 1
uint8 STATE_NOT_ESTOPPED = 2

Header header
string name
uint8 type
uint8 state
string state_description

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



(provide :spot_msgs/EStopStateArray "9a14a6b761f26c00c5613f0dc614f084")


