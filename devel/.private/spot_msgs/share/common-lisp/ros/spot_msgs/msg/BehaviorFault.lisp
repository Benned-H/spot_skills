; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude BehaviorFault.msg.html

(cl:defclass <BehaviorFault> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (behavior_fault_id
    :reader behavior_fault_id
    :initarg :behavior_fault_id
    :type cl:integer
    :initform 0)
   (cause
    :reader cause
    :initarg :cause
    :type cl:fixnum
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass BehaviorFault (<BehaviorFault>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BehaviorFault>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BehaviorFault)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<BehaviorFault> is deprecated: use spot_msgs-msg:BehaviorFault instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <BehaviorFault>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:header-val is deprecated.  Use spot_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'behavior_fault_id-val :lambda-list '(m))
(cl:defmethod behavior_fault_id-val ((m <BehaviorFault>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:behavior_fault_id-val is deprecated.  Use spot_msgs-msg:behavior_fault_id instead.")
  (behavior_fault_id m))

(cl:ensure-generic-function 'cause-val :lambda-list '(m))
(cl:defmethod cause-val ((m <BehaviorFault>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:cause-val is deprecated.  Use spot_msgs-msg:cause instead.")
  (cause m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <BehaviorFault>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:status-val is deprecated.  Use spot_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<BehaviorFault>)))
    "Constants for message type '<BehaviorFault>"
  '((:CAUSE_UNKNOWN . 0)
    (:CAUSE_FALL . 1)
    (:CAUSE_HARDWARE . 2)
    (:STATUS_UNKNOWN . 0)
    (:STATUS_CLEARABLE . 1)
    (:STATUS_UNCLEARABLE . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'BehaviorFault)))
    "Constants for message type 'BehaviorFault"
  '((:CAUSE_UNKNOWN . 0)
    (:CAUSE_FALL . 1)
    (:CAUSE_HARDWARE . 2)
    (:STATUS_UNKNOWN . 0)
    (:STATUS_CLEARABLE . 1)
    (:STATUS_UNCLEARABLE . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BehaviorFault>) ostream)
  "Serializes a message object of type '<BehaviorFault>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'behavior_fault_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'behavior_fault_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'behavior_fault_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'behavior_fault_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cause)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BehaviorFault>) istream)
  "Deserializes a message object of type '<BehaviorFault>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'behavior_fault_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'behavior_fault_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'behavior_fault_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'behavior_fault_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cause)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BehaviorFault>)))
  "Returns string type for a message object of type '<BehaviorFault>"
  "spot_msgs/BehaviorFault")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BehaviorFault)))
  "Returns string type for a message object of type 'BehaviorFault"
  "spot_msgs/BehaviorFault")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BehaviorFault>)))
  "Returns md5sum for a message object of type '<BehaviorFault>"
  "849048e719811a4f2cf68e276a235d76")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BehaviorFault)))
  "Returns md5sum for a message object of type 'BehaviorFault"
  "849048e719811a4f2cf68e276a235d76")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BehaviorFault>)))
  "Returns full string definition for message of type '<BehaviorFault>"
  (cl:format cl:nil "# Cause~%uint8 CAUSE_UNKNOWN = 0~%uint8 CAUSE_FALL = 1~%uint8 CAUSE_HARDWARE = 2~%~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_CLEARABLE = 1~%uint8 STATUS_UNCLEARABLE = 2~%~%Header header~%uint32 behavior_fault_id~%uint8 cause~%uint8 status~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BehaviorFault)))
  "Returns full string definition for message of type 'BehaviorFault"
  (cl:format cl:nil "# Cause~%uint8 CAUSE_UNKNOWN = 0~%uint8 CAUSE_FALL = 1~%uint8 CAUSE_HARDWARE = 2~%~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_CLEARABLE = 1~%uint8 STATUS_UNCLEARABLE = 2~%~%Header header~%uint32 behavior_fault_id~%uint8 cause~%uint8 status~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BehaviorFault>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BehaviorFault>))
  "Converts a ROS message object to a list"
  (cl:list 'BehaviorFault
    (cl:cons ':header (header msg))
    (cl:cons ':behavior_fault_id (behavior_fault_id msg))
    (cl:cons ':cause (cause msg))
    (cl:cons ':status (status msg))
))
