; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude PTZState.msg.html

(cl:defclass <PTZState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (ptz
    :reader ptz
    :initarg :ptz
    :type spot_cam-msg:PTZDescription
    :initform (cl:make-instance 'spot_cam-msg:PTZDescription))
   (pan
    :reader pan
    :initarg :pan
    :type cl:float
    :initform 0.0)
   (tilt
    :reader tilt
    :initarg :tilt
    :type cl:float
    :initform 0.0)
   (zoom
    :reader zoom
    :initarg :zoom
    :type cl:float
    :initform 0.0))
)

(cl:defclass PTZState (<PTZState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PTZState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PTZState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<PTZState> is deprecated: use spot_cam-msg:PTZState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PTZState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:header-val is deprecated.  Use spot_cam-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'ptz-val :lambda-list '(m))
(cl:defmethod ptz-val ((m <PTZState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:ptz-val is deprecated.  Use spot_cam-msg:ptz instead.")
  (ptz m))

(cl:ensure-generic-function 'pan-val :lambda-list '(m))
(cl:defmethod pan-val ((m <PTZState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:pan-val is deprecated.  Use spot_cam-msg:pan instead.")
  (pan m))

(cl:ensure-generic-function 'tilt-val :lambda-list '(m))
(cl:defmethod tilt-val ((m <PTZState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:tilt-val is deprecated.  Use spot_cam-msg:tilt instead.")
  (tilt m))

(cl:ensure-generic-function 'zoom-val :lambda-list '(m))
(cl:defmethod zoom-val ((m <PTZState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:zoom-val is deprecated.  Use spot_cam-msg:zoom instead.")
  (zoom m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PTZState>) ostream)
  "Serializes a message object of type '<PTZState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ptz) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'zoom))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PTZState>) istream)
  "Deserializes a message object of type '<PTZState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ptz) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'zoom) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PTZState>)))
  "Returns string type for a message object of type '<PTZState>"
  "spot_cam/PTZState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PTZState)))
  "Returns string type for a message object of type 'PTZState"
  "spot_cam/PTZState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PTZState>)))
  "Returns md5sum for a message object of type '<PTZState>"
  "6780ed299706699768ff791d8291261f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PTZState)))
  "Returns md5sum for a message object of type 'PTZState"
  "6780ed299706699768ff791d8291261f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PTZState>)))
  "Returns full string definition for message of type '<PTZState>"
  (cl:format cl:nil "# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,~%# The meaning of the pan/tilt/zoom values changes.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity~%std_msgs/Header header~%# Description of the ptz~%spot_cam/PTZDescription ptz~%# degrees or degrees per second~%float32 pan~%# degrees or degrees per second~%float32 tilt~%# zoom level or zoom level per second~%float32 zoom~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PTZState)))
  "Returns full string definition for message of type 'PTZState"
  (cl:format cl:nil "# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,~%# The meaning of the pan/tilt/zoom values changes.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity~%std_msgs/Header header~%# Description of the ptz~%spot_cam/PTZDescription ptz~%# degrees or degrees per second~%float32 pan~%# degrees or degrees per second~%float32 tilt~%# zoom level or zoom level per second~%float32 zoom~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PTZState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ptz))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PTZState>))
  "Converts a ROS message object to a list"
  (cl:list 'PTZState
    (cl:cons ':header (header msg))
    (cl:cons ':ptz (ptz msg))
    (cl:cons ':pan (pan msg))
    (cl:cons ':tilt (tilt msg))
    (cl:cons ':zoom (zoom msg))
))
