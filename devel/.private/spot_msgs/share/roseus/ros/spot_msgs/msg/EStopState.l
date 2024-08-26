;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::EStopState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'EStopState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::ESTOPSTATE")
  (make-package "SPOT_MSGS::ESTOPSTATE"))

(in-package "ROS")
;;//! \htmlinclude EStopState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*TYPE_UNKNOWN*" (find-package "SPOT_MSGS::ESTOPSTATE"))
(shadow '*TYPE_UNKNOWN* (find-package "SPOT_MSGS::ESTOPSTATE"))
(defconstant spot_msgs::EStopState::*TYPE_UNKNOWN* 0)
(intern "*TYPE_HARDWARE*" (find-package "SPOT_MSGS::ESTOPSTATE"))
(shadow '*TYPE_HARDWARE* (find-package "SPOT_MSGS::ESTOPSTATE"))
(defconstant spot_msgs::EStopState::*TYPE_HARDWARE* 1)
(intern "*TYPE_SOFTWARE*" (find-package "SPOT_MSGS::ESTOPSTATE"))
(shadow '*TYPE_SOFTWARE* (find-package "SPOT_MSGS::ESTOPSTATE"))
(defconstant spot_msgs::EStopState::*TYPE_SOFTWARE* 2)
(intern "*STATE_UNKNOWN*" (find-package "SPOT_MSGS::ESTOPSTATE"))
(shadow '*STATE_UNKNOWN* (find-package "SPOT_MSGS::ESTOPSTATE"))
(defconstant spot_msgs::EStopState::*STATE_UNKNOWN* 0)
(intern "*STATE_ESTOPPED*" (find-package "SPOT_MSGS::ESTOPSTATE"))
(shadow '*STATE_ESTOPPED* (find-package "SPOT_MSGS::ESTOPSTATE"))
(defconstant spot_msgs::EStopState::*STATE_ESTOPPED* 1)
(intern "*STATE_NOT_ESTOPPED*" (find-package "SPOT_MSGS::ESTOPSTATE"))
(shadow '*STATE_NOT_ESTOPPED* (find-package "SPOT_MSGS::ESTOPSTATE"))
(defconstant spot_msgs::EStopState::*STATE_NOT_ESTOPPED* 2)

(defun spot_msgs::EStopState-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::EStopState::*TYPE_UNKNOWN*)
        ((= const 1) 'spot_msgs::EStopState::*TYPE_HARDWARE*)
        ((= const 2) 'spot_msgs::EStopState::*TYPE_SOFTWARE*)
        ((= const 0) 'spot_msgs::EStopState::*STATE_UNKNOWN*)
        ((= const 1) 'spot_msgs::EStopState::*STATE_ESTOPPED*)
        ((= const 2) 'spot_msgs::EStopState::*STATE_NOT_ESTOPPED*)
        (t nil)))

(defclass spot_msgs::EStopState
  :super ros::object
  :slots (_header _name _type _state _state_description ))

(defmethod spot_msgs::EStopState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:name __name) "")
    ((:type __type) 0)
    ((:state __state) 0)
    ((:state_description __state_description) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _name (string __name))
   (setq _type (round __type))
   (setq _state (round __state))
   (setq _state_description (string __state_description))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:state_description
   (&optional __state_description)
   (if __state_description (setq _state_description __state_description)) _state_description)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _name
    4 (length _name)
    ;; uint8 _type
    1
    ;; uint8 _state
    1
    ;; string _state_description
    4 (length _state_description)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; uint8 _type
       (write-byte _type s)
     ;; uint8 _state
       (write-byte _state s)
     ;; string _state_description
       (write-long (length _state_description) s) (princ _state_description s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _state
     (setq _state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _state_description
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _state_description (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::EStopState :md5sum-) "4e1a419eb9800cdac35ecfe372fcc725")
(setf (get spot_msgs::EStopState :datatype-) "spot_msgs/EStopState")
(setf (get spot_msgs::EStopState :definition-)
      "# Type
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



(provide :spot_msgs/EStopState "4e1a419eb9800cdac35ecfe372fcc725")


