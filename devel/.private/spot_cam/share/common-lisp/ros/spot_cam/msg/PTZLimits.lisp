; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude PTZLimits.msg.html

(cl:defclass <PTZLimits> (roslisp-msg-protocol:ros-message)
  ((min
    :reader min
    :initarg :min
    :type cl:float
    :initform 0.0)
   (max
    :reader max
    :initarg :max
    :type cl:float
    :initform 0.0))
)

(cl:defclass PTZLimits (<PTZLimits>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PTZLimits>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PTZLimits)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<PTZLimits> is deprecated: use spot_cam-msg:PTZLimits instead.")))

(cl:ensure-generic-function 'min-val :lambda-list '(m))
(cl:defmethod min-val ((m <PTZLimits>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:min-val is deprecated.  Use spot_cam-msg:min instead.")
  (min m))

(cl:ensure-generic-function 'max-val :lambda-list '(m))
(cl:defmethod max-val ((m <PTZLimits>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:max-val is deprecated.  Use spot_cam-msg:max instead.")
  (max m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PTZLimits>) ostream)
  "Serializes a message object of type '<PTZLimits>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PTZLimits>) istream)
  "Deserializes a message object of type '<PTZLimits>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PTZLimits>)))
  "Returns string type for a message object of type '<PTZLimits>"
  "spot_cam/PTZLimits")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PTZLimits)))
  "Returns string type for a message object of type 'PTZLimits"
  "spot_cam/PTZLimits")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PTZLimits>)))
  "Returns md5sum for a message object of type '<PTZLimits>"
  "b3ee9ed25575b46bb47c7673ad202faa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PTZLimits)))
  "Returns md5sum for a message object of type 'PTZLimits"
  "b3ee9ed25575b46bb47c7673ad202faa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PTZLimits>)))
  "Returns full string definition for message of type '<PTZLimits>"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PTZLimits)))
  "Returns full string definition for message of type 'PTZLimits"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PTZLimits>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PTZLimits>))
  "Converts a ROS message object to a list"
  (cl:list 'PTZLimits
    (cl:cons ':min (min msg))
    (cl:cons ':max (max msg))
))
