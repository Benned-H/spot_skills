;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::PowerState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'PowerState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::POWERSTATE")
  (make-package "SPOT_MSGS::POWERSTATE"))

(in-package "ROS")
;;//! \htmlinclude PowerState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*STATE_UNKNOWN*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_UNKNOWN* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_UNKNOWN* 0)
(intern "*STATE_OFF*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_OFF* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_OFF* 1)
(intern "*STATE_ON*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_ON* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_ON* 2)
(intern "*STATE_POWERING_ON*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_POWERING_ON* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_POWERING_ON* 3)
(intern "*STATE_POWERING_OFF*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_POWERING_OFF* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_POWERING_OFF* 4)
(intern "*STATE_ERROR*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_ERROR* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_ERROR* 5)
(intern "*STATE_UNKNOWN_SHORE_POWER*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_UNKNOWN_SHORE_POWER* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_UNKNOWN_SHORE_POWER* 0)
(intern "*STATE_ON_SHORE_POWER*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_ON_SHORE_POWER* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_ON_SHORE_POWER* 1)
(intern "*STATE_OFF_SHORE_POWER*" (find-package "SPOT_MSGS::POWERSTATE"))
(shadow '*STATE_OFF_SHORE_POWER* (find-package "SPOT_MSGS::POWERSTATE"))
(defconstant spot_msgs::PowerState::*STATE_OFF_SHORE_POWER* 2)

(defun spot_msgs::PowerState-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::PowerState::*STATE_UNKNOWN*)
        ((= const 1) 'spot_msgs::PowerState::*STATE_OFF*)
        ((= const 2) 'spot_msgs::PowerState::*STATE_ON*)
        ((= const 3) 'spot_msgs::PowerState::*STATE_POWERING_ON*)
        ((= const 4) 'spot_msgs::PowerState::*STATE_POWERING_OFF*)
        ((= const 5) 'spot_msgs::PowerState::*STATE_ERROR*)
        ((= const 0) 'spot_msgs::PowerState::*STATE_UNKNOWN_SHORE_POWER*)
        ((= const 1) 'spot_msgs::PowerState::*STATE_ON_SHORE_POWER*)
        ((= const 2) 'spot_msgs::PowerState::*STATE_OFF_SHORE_POWER*)
        (t nil)))

(defclass spot_msgs::PowerState
  :super ros::object
  :slots (_header _motor_power_state _shore_power_state _locomotion_charge_percentage _locomotion_estimated_runtime ))

(defmethod spot_msgs::PowerState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:motor_power_state __motor_power_state) 0)
    ((:shore_power_state __shore_power_state) 0)
    ((:locomotion_charge_percentage __locomotion_charge_percentage) 0.0)
    ((:locomotion_estimated_runtime __locomotion_estimated_runtime) (instance ros::time :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _motor_power_state (round __motor_power_state))
   (setq _shore_power_state (round __shore_power_state))
   (setq _locomotion_charge_percentage (float __locomotion_charge_percentage))
   (setq _locomotion_estimated_runtime __locomotion_estimated_runtime)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:motor_power_state
   (&optional __motor_power_state)
   (if __motor_power_state (setq _motor_power_state __motor_power_state)) _motor_power_state)
  (:shore_power_state
   (&optional __shore_power_state)
   (if __shore_power_state (setq _shore_power_state __shore_power_state)) _shore_power_state)
  (:locomotion_charge_percentage
   (&optional __locomotion_charge_percentage)
   (if __locomotion_charge_percentage (setq _locomotion_charge_percentage __locomotion_charge_percentage)) _locomotion_charge_percentage)
  (:locomotion_estimated_runtime
   (&optional __locomotion_estimated_runtime)
   (if __locomotion_estimated_runtime (setq _locomotion_estimated_runtime __locomotion_estimated_runtime)) _locomotion_estimated_runtime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _motor_power_state
    1
    ;; uint8 _shore_power_state
    1
    ;; float64 _locomotion_charge_percentage
    8
    ;; duration _locomotion_estimated_runtime
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _motor_power_state
       (write-byte _motor_power_state s)
     ;; uint8 _shore_power_state
       (write-byte _shore_power_state s)
     ;; float64 _locomotion_charge_percentage
       (sys::poke _locomotion_charge_percentage (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; duration _locomotion_estimated_runtime
       (write-long (send _locomotion_estimated_runtime :sec) s) (write-long (send _locomotion_estimated_runtime :nsec) s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _motor_power_state
     (setq _motor_power_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _shore_power_state
     (setq _shore_power_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _locomotion_charge_percentage
     (setq _locomotion_charge_percentage (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; duration _locomotion_estimated_runtime
     (send _locomotion_estimated_runtime :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _locomotion_estimated_runtime :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::PowerState :md5sum-) "1248df72d2f23288441e3a23d09bd4f0")
(setf (get spot_msgs::PowerState :datatype-) "spot_msgs/PowerState")
(setf (get spot_msgs::PowerState :definition-)
      "# MotorPowerState
uint8 STATE_UNKNOWN = 0
uint8 STATE_OFF = 1
uint8 STATE_ON = 2
uint8 STATE_POWERING_ON = 3
uint8 STATE_POWERING_OFF = 4
uint8 STATE_ERROR = 5

# ShorePowerState
uint8 STATE_UNKNOWN_SHORE_POWER = 0
uint8 STATE_ON_SHORE_POWER = 1
uint8 STATE_OFF_SHORE_POWER = 2

Header header
uint8 motor_power_state
uint8 shore_power_state
float64 locomotion_charge_percentage
duration locomotion_estimated_runtime

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



(provide :spot_msgs/PowerState "1248df72d2f23288441e3a23d09bd4f0")


