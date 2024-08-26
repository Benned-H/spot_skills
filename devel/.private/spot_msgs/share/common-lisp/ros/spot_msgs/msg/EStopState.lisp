; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude EStopState.msg.html

(cl:defclass <EStopState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (state
    :reader state
    :initarg :state
    :type cl:fixnum
    :initform 0)
   (state_description
    :reader state_description
    :initarg :state_description
    :type cl:string
    :initform ""))
)

(cl:defclass EStopState (<EStopState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EStopState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EStopState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<EStopState> is deprecated: use spot_msgs-msg:EStopState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EStopState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:header-val is deprecated.  Use spot_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <EStopState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:name-val is deprecated.  Use spot_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <EStopState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:type-val is deprecated.  Use spot_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <EStopState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:state-val is deprecated.  Use spot_msgs-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'state_description-val :lambda-list '(m))
(cl:defmethod state_description-val ((m <EStopState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:state_description-val is deprecated.  Use spot_msgs-msg:state_description instead.")
  (state_description m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<EStopState>)))
    "Constants for message type '<EStopState>"
  '((:TYPE_UNKNOWN . 0)
    (:TYPE_HARDWARE . 1)
    (:TYPE_SOFTWARE . 2)
    (:STATE_UNKNOWN . 0)
    (:STATE_ESTOPPED . 1)
    (:STATE_NOT_ESTOPPED . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'EStopState)))
    "Constants for message type 'EStopState"
  '((:TYPE_UNKNOWN . 0)
    (:TYPE_HARDWARE . 1)
    (:TYPE_SOFTWARE . 2)
    (:STATE_UNKNOWN . 0)
    (:STATE_ESTOPPED . 1)
    (:STATE_NOT_ESTOPPED . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EStopState>) ostream)
  "Serializes a message object of type '<EStopState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'state_description))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'state_description))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EStopState>) istream)
  "Deserializes a message object of type '<EStopState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'state_description) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'state_description) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EStopState>)))
  "Returns string type for a message object of type '<EStopState>"
  "spot_msgs/EStopState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EStopState)))
  "Returns string type for a message object of type 'EStopState"
  "spot_msgs/EStopState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EStopState>)))
  "Returns md5sum for a message object of type '<EStopState>"
  "4e1a419eb9800cdac35ecfe372fcc725")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EStopState)))
  "Returns md5sum for a message object of type 'EStopState"
  "4e1a419eb9800cdac35ecfe372fcc725")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EStopState>)))
  "Returns full string definition for message of type '<EStopState>"
  (cl:format cl:nil "# Type~%uint8 TYPE_UNKNOWN = 0~%uint8 TYPE_HARDWARE = 1~%uint8 TYPE_SOFTWARE = 2~%~%# State~%uint8 STATE_UNKNOWN = 0~%uint8 STATE_ESTOPPED = 1~%uint8 STATE_NOT_ESTOPPED = 2~%~%Header header~%string name~%uint8 type~%uint8 state~%string state_description~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EStopState)))
  "Returns full string definition for message of type 'EStopState"
  (cl:format cl:nil "# Type~%uint8 TYPE_UNKNOWN = 0~%uint8 TYPE_HARDWARE = 1~%uint8 TYPE_SOFTWARE = 2~%~%# State~%uint8 STATE_UNKNOWN = 0~%uint8 STATE_ESTOPPED = 1~%uint8 STATE_NOT_ESTOPPED = 2~%~%Header header~%string name~%uint8 type~%uint8 state~%string state_description~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EStopState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'name))
     1
     1
     4 (cl:length (cl:slot-value msg 'state_description))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EStopState>))
  "Converts a ROS message object to a list"
  (cl:list 'EStopState
    (cl:cons ':header (header msg))
    (cl:cons ':name (name msg))
    (cl:cons ':type (type msg))
    (cl:cons ':state (state msg))
    (cl:cons ':state_description (state_description msg))
))
