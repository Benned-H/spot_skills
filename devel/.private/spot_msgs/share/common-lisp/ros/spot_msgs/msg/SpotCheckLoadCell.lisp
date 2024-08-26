; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude SpotCheckLoadCell.msg.html

(cl:defclass <SpotCheckLoadCell> (roslisp-msg-protocol:ros-message)
  ((error
    :reader error
    :initarg :error
    :type cl:fixnum
    :initform 0)
   (zero
    :reader zero
    :initarg :zero
    :type cl:float
    :initform 0.0)
   (old_zero
    :reader old_zero
    :initarg :old_zero
    :type cl:float
    :initform 0.0))
)

(cl:defclass SpotCheckLoadCell (<SpotCheckLoadCell>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheckLoadCell>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheckLoadCell)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<SpotCheckLoadCell> is deprecated: use spot_msgs-msg:SpotCheckLoadCell instead.")))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <SpotCheckLoadCell>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:error-val is deprecated.  Use spot_msgs-msg:error instead.")
  (error m))

(cl:ensure-generic-function 'zero-val :lambda-list '(m))
(cl:defmethod zero-val ((m <SpotCheckLoadCell>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:zero-val is deprecated.  Use spot_msgs-msg:zero instead.")
  (zero m))

(cl:ensure-generic-function 'old_zero-val :lambda-list '(m))
(cl:defmethod old_zero-val ((m <SpotCheckLoadCell>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:old_zero-val is deprecated.  Use spot_msgs-msg:old_zero instead.")
  (old_zero m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SpotCheckLoadCell>)))
    "Constants for message type '<SpotCheckLoadCell>"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_ZERO_OUT_OF_RANGE . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SpotCheckLoadCell)))
    "Constants for message type 'SpotCheckLoadCell"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_ZERO_OUT_OF_RANGE . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheckLoadCell>) ostream)
  "Serializes a message object of type '<SpotCheckLoadCell>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'zero))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'old_zero))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheckLoadCell>) istream)
  "Deserializes a message object of type '<SpotCheckLoadCell>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'zero) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'old_zero) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheckLoadCell>)))
  "Returns string type for a message object of type '<SpotCheckLoadCell>"
  "spot_msgs/SpotCheckLoadCell")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheckLoadCell)))
  "Returns string type for a message object of type 'SpotCheckLoadCell"
  "spot_msgs/SpotCheckLoadCell")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheckLoadCell>)))
  "Returns md5sum for a message object of type '<SpotCheckLoadCell>"
  "bfb62ba66777d3800f98e3fc7140667a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheckLoadCell)))
  "Returns md5sum for a message object of type 'SpotCheckLoadCell"
  "bfb62ba66777d3800f98e3fc7140667a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheckLoadCell>)))
  "Returns full string definition for message of type '<SpotCheckLoadCell>"
  (cl:format cl:nil "uint8 ERROR_UNKNOWN = 0              # Unused enum.~%uint8 ERROR_NONE = 1                 # No hardware error detected.~%uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.~%~%# The loadcell error code~%uint8 error~%# The current loadcell zero as fraction of full range [0-1]~%float32 zero~%# The previous loadcell zero as fraction of full range [0-1]~%float32 old_zero~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheckLoadCell)))
  "Returns full string definition for message of type 'SpotCheckLoadCell"
  (cl:format cl:nil "uint8 ERROR_UNKNOWN = 0              # Unused enum.~%uint8 ERROR_NONE = 1                 # No hardware error detected.~%uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.~%~%# The loadcell error code~%uint8 error~%# The current loadcell zero as fraction of full range [0-1]~%float32 zero~%# The previous loadcell zero as fraction of full range [0-1]~%float32 old_zero~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheckLoadCell>))
  (cl:+ 0
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheckLoadCell>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheckLoadCell
    (cl:cons ':error (error msg))
    (cl:cons ':zero (zero msg))
    (cl:cons ':old_zero (old_zero msg))
))
