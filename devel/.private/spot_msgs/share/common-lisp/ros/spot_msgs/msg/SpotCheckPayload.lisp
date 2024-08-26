; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude SpotCheckPayload.msg.html

(cl:defclass <SpotCheckPayload> (roslisp-msg-protocol:ros-message)
  ((error
    :reader error
    :initarg :error
    :type cl:fixnum
    :initform 0)
   (extra_payload
    :reader extra_payload
    :initarg :extra_payload
    :type cl:float
    :initform 0.0))
)

(cl:defclass SpotCheckPayload (<SpotCheckPayload>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheckPayload>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheckPayload)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<SpotCheckPayload> is deprecated: use spot_msgs-msg:SpotCheckPayload instead.")))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <SpotCheckPayload>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:error-val is deprecated.  Use spot_msgs-msg:error instead.")
  (error m))

(cl:ensure-generic-function 'extra_payload-val :lambda-list '(m))
(cl:defmethod extra_payload-val ((m <SpotCheckPayload>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:extra_payload-val is deprecated.  Use spot_msgs-msg:extra_payload instead.")
  (extra_payload m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SpotCheckPayload>)))
    "Constants for message type '<SpotCheckPayload>"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_MASS_DISCREPANCY . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SpotCheckPayload)))
    "Constants for message type 'SpotCheckPayload"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_MASS_DISCREPANCY . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheckPayload>) ostream)
  "Serializes a message object of type '<SpotCheckPayload>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'extra_payload))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheckPayload>) istream)
  "Deserializes a message object of type '<SpotCheckPayload>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'extra_payload) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheckPayload>)))
  "Returns string type for a message object of type '<SpotCheckPayload>"
  "spot_msgs/SpotCheckPayload")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheckPayload)))
  "Returns string type for a message object of type 'SpotCheckPayload"
  "spot_msgs/SpotCheckPayload")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheckPayload>)))
  "Returns md5sum for a message object of type '<SpotCheckPayload>"
  "8a5462c1672d0b3443d0f93dc832b167")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheckPayload)))
  "Returns md5sum for a message object of type 'SpotCheckPayload"
  "8a5462c1672d0b3443d0f93dc832b167")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheckPayload>)))
  "Returns full string definition for message of type '<SpotCheckPayload>"
  (cl:format cl:nil "# Errors reflect an issue with payload configuration.~%~%# Unused enum.~%uint8 ERROR_UNKNOWN = 0~%# No error found in the payloads.~%uint8 ERROR_NONE = 1~%# There is a mass discrepancy between the registered payload and what is estimated.~%uint8 ERROR_MASS_DISCREPANCY = 2~%~%# A flag to indicate if configuration has an error.~%uint8 error~%~%# Indicates how much extra payload (in kg) we think the robot has~%# Positive indicates robot has more payload than it is configured.~%# Negative indicates robot has less payload than it is configured.~%float32 extra_payload~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheckPayload)))
  "Returns full string definition for message of type 'SpotCheckPayload"
  (cl:format cl:nil "# Errors reflect an issue with payload configuration.~%~%# Unused enum.~%uint8 ERROR_UNKNOWN = 0~%# No error found in the payloads.~%uint8 ERROR_NONE = 1~%# There is a mass discrepancy between the registered payload and what is estimated.~%uint8 ERROR_MASS_DISCREPANCY = 2~%~%# A flag to indicate if configuration has an error.~%uint8 error~%~%# Indicates how much extra payload (in kg) we think the robot has~%# Positive indicates robot has more payload than it is configured.~%# Negative indicates robot has less payload than it is configured.~%float32 extra_payload~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheckPayload>))
  (cl:+ 0
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheckPayload>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheckPayload
    (cl:cons ':error (error msg))
    (cl:cons ':extra_payload (extra_payload msg))
))
