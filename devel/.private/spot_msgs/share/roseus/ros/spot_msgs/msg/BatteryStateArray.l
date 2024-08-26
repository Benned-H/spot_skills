;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::BatteryStateArray)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'BatteryStateArray (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::BATTERYSTATEARRAY")
  (make-package "SPOT_MSGS::BATTERYSTATEARRAY"))

(in-package "ROS")
;;//! \htmlinclude BatteryStateArray.msg.html


(defclass spot_msgs::BatteryStateArray
  :super ros::object
  :slots (_battery_states ))

(defmethod spot_msgs::BatteryStateArray
  (:init
   (&key
    ((:battery_states __battery_states) ())
    )
   (send-super :init)
   (setq _battery_states __battery_states)
   self)
  (:battery_states
   (&rest __battery_states)
   (if (keywordp (car __battery_states))
       (send* _battery_states __battery_states)
     (progn
       (if __battery_states (setq _battery_states (car __battery_states)))
       _battery_states)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/BatteryState[] _battery_states
    (apply #'+ (send-all _battery_states :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/BatteryState[] _battery_states
     (write-long (length _battery_states) s)
     (dolist (elem _battery_states)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/BatteryState[] _battery_states
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _battery_states (let (r) (dotimes (i n) (push (instance spot_msgs::BatteryState :init) r)) r))
     (dolist (elem- _battery_states)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::BatteryStateArray :md5sum-) "5be00bcb9a392f14ba6707e020a94106")
(setf (get spot_msgs::BatteryStateArray :datatype-) "spot_msgs/BatteryStateArray")
(setf (get spot_msgs::BatteryStateArray :definition-)
      "BatteryState[] battery_states

================================================================================
MSG: spot_msgs/BatteryState
# Status
uint8 STATUS_UNKNOWN = 0
uint8 STATUS_MISSING = 1
uint8 STATUS_CHARGING = 2
uint8 STATUS_DISCHARGING = 3
uint8 STATUS_BOOTING = 4

Header header
string identifier
float64 charge_percentage
duration estimated_runtime
float64 current
float64 voltage
float64[] temperatures
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



(provide :spot_msgs/BatteryStateArray "5be00bcb9a392f14ba6707e020a94106")


