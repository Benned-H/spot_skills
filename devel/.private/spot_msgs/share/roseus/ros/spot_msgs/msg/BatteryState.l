;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::BatteryState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'BatteryState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::BATTERYSTATE")
  (make-package "SPOT_MSGS::BATTERYSTATE"))

(in-package "ROS")
;;//! \htmlinclude BatteryState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*STATUS_UNKNOWN*" (find-package "SPOT_MSGS::BATTERYSTATE"))
(shadow '*STATUS_UNKNOWN* (find-package "SPOT_MSGS::BATTERYSTATE"))
(defconstant spot_msgs::BatteryState::*STATUS_UNKNOWN* 0)
(intern "*STATUS_MISSING*" (find-package "SPOT_MSGS::BATTERYSTATE"))
(shadow '*STATUS_MISSING* (find-package "SPOT_MSGS::BATTERYSTATE"))
(defconstant spot_msgs::BatteryState::*STATUS_MISSING* 1)
(intern "*STATUS_CHARGING*" (find-package "SPOT_MSGS::BATTERYSTATE"))
(shadow '*STATUS_CHARGING* (find-package "SPOT_MSGS::BATTERYSTATE"))
(defconstant spot_msgs::BatteryState::*STATUS_CHARGING* 2)
(intern "*STATUS_DISCHARGING*" (find-package "SPOT_MSGS::BATTERYSTATE"))
(shadow '*STATUS_DISCHARGING* (find-package "SPOT_MSGS::BATTERYSTATE"))
(defconstant spot_msgs::BatteryState::*STATUS_DISCHARGING* 3)
(intern "*STATUS_BOOTING*" (find-package "SPOT_MSGS::BATTERYSTATE"))
(shadow '*STATUS_BOOTING* (find-package "SPOT_MSGS::BATTERYSTATE"))
(defconstant spot_msgs::BatteryState::*STATUS_BOOTING* 4)

(defun spot_msgs::BatteryState-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::BatteryState::*STATUS_UNKNOWN*)
        ((= const 1) 'spot_msgs::BatteryState::*STATUS_MISSING*)
        ((= const 2) 'spot_msgs::BatteryState::*STATUS_CHARGING*)
        ((= const 3) 'spot_msgs::BatteryState::*STATUS_DISCHARGING*)
        ((= const 4) 'spot_msgs::BatteryState::*STATUS_BOOTING*)
        (t nil)))

(defclass spot_msgs::BatteryState
  :super ros::object
  :slots (_header _identifier _charge_percentage _estimated_runtime _current _voltage _temperatures _status ))

(defmethod spot_msgs::BatteryState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:identifier __identifier) "")
    ((:charge_percentage __charge_percentage) 0.0)
    ((:estimated_runtime __estimated_runtime) (instance ros::time :init))
    ((:current __current) 0.0)
    ((:voltage __voltage) 0.0)
    ((:temperatures __temperatures) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _identifier (string __identifier))
   (setq _charge_percentage (float __charge_percentage))
   (setq _estimated_runtime __estimated_runtime)
   (setq _current (float __current))
   (setq _voltage (float __voltage))
   (setq _temperatures __temperatures)
   (setq _status (round __status))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:identifier
   (&optional __identifier)
   (if __identifier (setq _identifier __identifier)) _identifier)
  (:charge_percentage
   (&optional __charge_percentage)
   (if __charge_percentage (setq _charge_percentage __charge_percentage)) _charge_percentage)
  (:estimated_runtime
   (&optional __estimated_runtime)
   (if __estimated_runtime (setq _estimated_runtime __estimated_runtime)) _estimated_runtime)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:temperatures
   (&optional __temperatures)
   (if __temperatures (setq _temperatures __temperatures)) _temperatures)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _identifier
    4 (length _identifier)
    ;; float64 _charge_percentage
    8
    ;; duration _estimated_runtime
    8
    ;; float64 _current
    8
    ;; float64 _voltage
    8
    ;; float64[] _temperatures
    (* 8    (length _temperatures)) 4
    ;; uint8 _status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _identifier
       (write-long (length _identifier) s) (princ _identifier s)
     ;; float64 _charge_percentage
       (sys::poke _charge_percentage (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; duration _estimated_runtime
       (write-long (send _estimated_runtime :sec) s) (write-long (send _estimated_runtime :nsec) s)
     ;; float64 _current
       (sys::poke _current (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _voltage
       (sys::poke _voltage (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[] _temperatures
     (write-long (length _temperatures) s)
     (dotimes (i (length _temperatures))
       (sys::poke (elt _temperatures i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; uint8 _status
       (write-byte _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _identifier
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _identifier (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _charge_percentage
     (setq _charge_percentage (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; duration _estimated_runtime
     (send _estimated_runtime :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _estimated_runtime :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _current
     (setq _current (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _voltage
     (setq _voltage (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[] _temperatures
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _temperatures (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _temperatures i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_msgs::BatteryState :md5sum-) "d4f77065e2805bf6a288541cb5a848ce")
(setf (get spot_msgs::BatteryState :datatype-) "spot_msgs/BatteryState")
(setf (get spot_msgs::BatteryState :definition-)
      "# Status
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



(provide :spot_msgs/BatteryState "d4f77065e2805bf6a288541cb5a848ce")


