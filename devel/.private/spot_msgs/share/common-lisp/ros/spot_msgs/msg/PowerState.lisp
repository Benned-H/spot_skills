; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude PowerState.msg.html

(cl:defclass <PowerState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (motor_power_state
    :reader motor_power_state
    :initarg :motor_power_state
    :type cl:fixnum
    :initform 0)
   (shore_power_state
    :reader shore_power_state
    :initarg :shore_power_state
    :type cl:fixnum
    :initform 0)
   (locomotion_charge_percentage
    :reader locomotion_charge_percentage
    :initarg :locomotion_charge_percentage
    :type cl:float
    :initform 0.0)
   (locomotion_estimated_runtime
    :reader locomotion_estimated_runtime
    :initarg :locomotion_estimated_runtime
    :type cl:real
    :initform 0))
)

(cl:defclass PowerState (<PowerState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PowerState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PowerState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<PowerState> is deprecated: use spot_msgs-msg:PowerState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PowerState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:header-val is deprecated.  Use spot_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'motor_power_state-val :lambda-list '(m))
(cl:defmethod motor_power_state-val ((m <PowerState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:motor_power_state-val is deprecated.  Use spot_msgs-msg:motor_power_state instead.")
  (motor_power_state m))

(cl:ensure-generic-function 'shore_power_state-val :lambda-list '(m))
(cl:defmethod shore_power_state-val ((m <PowerState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:shore_power_state-val is deprecated.  Use spot_msgs-msg:shore_power_state instead.")
  (shore_power_state m))

(cl:ensure-generic-function 'locomotion_charge_percentage-val :lambda-list '(m))
(cl:defmethod locomotion_charge_percentage-val ((m <PowerState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:locomotion_charge_percentage-val is deprecated.  Use spot_msgs-msg:locomotion_charge_percentage instead.")
  (locomotion_charge_percentage m))

(cl:ensure-generic-function 'locomotion_estimated_runtime-val :lambda-list '(m))
(cl:defmethod locomotion_estimated_runtime-val ((m <PowerState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:locomotion_estimated_runtime-val is deprecated.  Use spot_msgs-msg:locomotion_estimated_runtime instead.")
  (locomotion_estimated_runtime m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<PowerState>)))
    "Constants for message type '<PowerState>"
  '((:STATE_UNKNOWN . 0)
    (:STATE_OFF . 1)
    (:STATE_ON . 2)
    (:STATE_POWERING_ON . 3)
    (:STATE_POWERING_OFF . 4)
    (:STATE_ERROR . 5)
    (:STATE_UNKNOWN_SHORE_POWER . 0)
    (:STATE_ON_SHORE_POWER . 1)
    (:STATE_OFF_SHORE_POWER . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'PowerState)))
    "Constants for message type 'PowerState"
  '((:STATE_UNKNOWN . 0)
    (:STATE_OFF . 1)
    (:STATE_ON . 2)
    (:STATE_POWERING_ON . 3)
    (:STATE_POWERING_OFF . 4)
    (:STATE_ERROR . 5)
    (:STATE_UNKNOWN_SHORE_POWER . 0)
    (:STATE_ON_SHORE_POWER . 1)
    (:STATE_OFF_SHORE_POWER . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PowerState>) ostream)
  "Serializes a message object of type '<PowerState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'motor_power_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'shore_power_state)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'locomotion_charge_percentage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'locomotion_estimated_runtime)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'locomotion_estimated_runtime) (cl:floor (cl:slot-value msg 'locomotion_estimated_runtime)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PowerState>) istream)
  "Deserializes a message object of type '<PowerState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'motor_power_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'shore_power_state)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'locomotion_charge_percentage) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'locomotion_estimated_runtime) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PowerState>)))
  "Returns string type for a message object of type '<PowerState>"
  "spot_msgs/PowerState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PowerState)))
  "Returns string type for a message object of type 'PowerState"
  "spot_msgs/PowerState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PowerState>)))
  "Returns md5sum for a message object of type '<PowerState>"
  "1248df72d2f23288441e3a23d09bd4f0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PowerState)))
  "Returns md5sum for a message object of type 'PowerState"
  "1248df72d2f23288441e3a23d09bd4f0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PowerState>)))
  "Returns full string definition for message of type '<PowerState>"
  (cl:format cl:nil "# MotorPowerState~%uint8 STATE_UNKNOWN = 0~%uint8 STATE_OFF = 1~%uint8 STATE_ON = 2~%uint8 STATE_POWERING_ON = 3~%uint8 STATE_POWERING_OFF = 4~%uint8 STATE_ERROR = 5~%~%# ShorePowerState~%uint8 STATE_UNKNOWN_SHORE_POWER = 0~%uint8 STATE_ON_SHORE_POWER = 1~%uint8 STATE_OFF_SHORE_POWER = 2~%~%Header header~%uint8 motor_power_state~%uint8 shore_power_state~%float64 locomotion_charge_percentage~%duration locomotion_estimated_runtime~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PowerState)))
  "Returns full string definition for message of type 'PowerState"
  (cl:format cl:nil "# MotorPowerState~%uint8 STATE_UNKNOWN = 0~%uint8 STATE_OFF = 1~%uint8 STATE_ON = 2~%uint8 STATE_POWERING_ON = 3~%uint8 STATE_POWERING_OFF = 4~%uint8 STATE_ERROR = 5~%~%# ShorePowerState~%uint8 STATE_UNKNOWN_SHORE_POWER = 0~%uint8 STATE_ON_SHORE_POWER = 1~%uint8 STATE_OFF_SHORE_POWER = 2~%~%Header header~%uint8 motor_power_state~%uint8 shore_power_state~%float64 locomotion_charge_percentage~%duration locomotion_estimated_runtime~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PowerState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PowerState>))
  "Converts a ROS message object to a list"
  (cl:list 'PowerState
    (cl:cons ':header (header msg))
    (cl:cons ':motor_power_state (motor_power_state msg))
    (cl:cons ':shore_power_state (shore_power_state msg))
    (cl:cons ':locomotion_charge_percentage (locomotion_charge_percentage msg))
    (cl:cons ':locomotion_estimated_runtime (locomotion_estimated_runtime msg))
))
