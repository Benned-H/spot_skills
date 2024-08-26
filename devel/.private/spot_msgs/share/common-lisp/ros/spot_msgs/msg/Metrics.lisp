; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude Metrics.msg.html

(cl:defclass <Metrics> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0)
   (gait_cycles
    :reader gait_cycles
    :initarg :gait_cycles
    :type cl:integer
    :initform 0)
   (time_moving
    :reader time_moving
    :initarg :time_moving
    :type cl:real
    :initform 0)
   (electric_power
    :reader electric_power
    :initarg :electric_power
    :type cl:real
    :initform 0))
)

(cl:defclass Metrics (<Metrics>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Metrics>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Metrics)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<Metrics> is deprecated: use spot_msgs-msg:Metrics instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Metrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:header-val is deprecated.  Use spot_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <Metrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:distance-val is deprecated.  Use spot_msgs-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'gait_cycles-val :lambda-list '(m))
(cl:defmethod gait_cycles-val ((m <Metrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:gait_cycles-val is deprecated.  Use spot_msgs-msg:gait_cycles instead.")
  (gait_cycles m))

(cl:ensure-generic-function 'time_moving-val :lambda-list '(m))
(cl:defmethod time_moving-val ((m <Metrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:time_moving-val is deprecated.  Use spot_msgs-msg:time_moving instead.")
  (time_moving m))

(cl:ensure-generic-function 'electric_power-val :lambda-list '(m))
(cl:defmethod electric_power-val ((m <Metrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:electric_power-val is deprecated.  Use spot_msgs-msg:electric_power instead.")
  (electric_power m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Metrics>) ostream)
  "Serializes a message object of type '<Metrics>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'gait_cycles)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'time_moving)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'time_moving) (cl:floor (cl:slot-value msg 'time_moving)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'electric_power)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'electric_power) (cl:floor (cl:slot-value msg 'electric_power)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Metrics>) istream)
  "Deserializes a message object of type '<Metrics>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gait_cycles) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'time_moving) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'electric_power) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Metrics>)))
  "Returns string type for a message object of type '<Metrics>"
  "spot_msgs/Metrics")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Metrics)))
  "Returns string type for a message object of type 'Metrics"
  "spot_msgs/Metrics")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Metrics>)))
  "Returns md5sum for a message object of type '<Metrics>"
  "493e599307ab2a6dbe49405e7b5a9b6d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Metrics)))
  "Returns md5sum for a message object of type 'Metrics"
  "493e599307ab2a6dbe49405e7b5a9b6d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Metrics>)))
  "Returns full string definition for message of type '<Metrics>"
  (cl:format cl:nil "Header header~%float32 distance~%int32 gait_cycles~%duration time_moving~%duration electric_power~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Metrics)))
  "Returns full string definition for message of type 'Metrics"
  (cl:format cl:nil "Header header~%float32 distance~%int32 gait_cycles~%duration time_moving~%duration electric_power~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Metrics>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Metrics>))
  "Converts a ROS message object to a list"
  (cl:list 'Metrics
    (cl:cons ':header (header msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':gait_cycles (gait_cycles msg))
    (cl:cons ':time_moving (time_moving msg))
    (cl:cons ':electric_power (electric_power msg))
))
