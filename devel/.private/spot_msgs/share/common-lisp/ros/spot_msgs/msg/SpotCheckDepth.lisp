; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude SpotCheckDepth.msg.html

(cl:defclass <SpotCheckDepth> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0)
   (severity_score
    :reader severity_score
    :initarg :severity_score
    :type cl:float
    :initform 0.0))
)

(cl:defclass SpotCheckDepth (<SpotCheckDepth>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheckDepth>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheckDepth)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<SpotCheckDepth> is deprecated: use spot_msgs-msg:SpotCheckDepth instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <SpotCheckDepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:status-val is deprecated.  Use spot_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'severity_score-val :lambda-list '(m))
(cl:defmethod severity_score-val ((m <SpotCheckDepth>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:severity_score-val is deprecated.  Use spot_msgs-msg:severity_score instead.")
  (severity_score m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SpotCheckDepth>)))
    "Constants for message type '<SpotCheckDepth>"
  '((:STATUS_UNKNOWN . 0)
    (:STATUS_OK . 1)
    (:STATUS_WARNING . 2)
    (:STATUS_ERROR . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SpotCheckDepth)))
    "Constants for message type 'SpotCheckDepth"
  '((:STATUS_UNKNOWN . 0)
    (:STATUS_OK . 1)
    (:STATUS_WARNING . 2)
    (:STATUS_ERROR . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheckDepth>) ostream)
  "Serializes a message object of type '<SpotCheckDepth>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'severity_score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheckDepth>) istream)
  "Deserializes a message object of type '<SpotCheckDepth>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'severity_score) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheckDepth>)))
  "Returns string type for a message object of type '<SpotCheckDepth>"
  "spot_msgs/SpotCheckDepth")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheckDepth)))
  "Returns string type for a message object of type 'SpotCheckDepth"
  "spot_msgs/SpotCheckDepth")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheckDepth>)))
  "Returns md5sum for a message object of type '<SpotCheckDepth>"
  "1df6ba22c62edcdd0f95e8c8502952ed")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheckDepth)))
  "Returns md5sum for a message object of type 'SpotCheckDepth"
  "1df6ba22c62edcdd0f95e8c8502952ed")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheckDepth>)))
  "Returns full string definition for message of type '<SpotCheckDepth>"
  (cl:format cl:nil "uint8 STATUS_UNKNOWN = 0     # Unused enum.~%uint8 STATUS_OK = 1          # No detected calibration error.~%uint8 STATUS_WARNING = 2     # Possible calibration error detected.~%uint8 STATUS_ERROR = 3       # Error with robot calibration.~%~%uint8 status~%float32 severity_score~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheckDepth)))
  "Returns full string definition for message of type 'SpotCheckDepth"
  (cl:format cl:nil "uint8 STATUS_UNKNOWN = 0     # Unused enum.~%uint8 STATUS_OK = 1          # No detected calibration error.~%uint8 STATUS_WARNING = 2     # Possible calibration error detected.~%uint8 STATUS_ERROR = 3       # Error with robot calibration.~%~%uint8 status~%float32 severity_score~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheckDepth>))
  (cl:+ 0
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheckDepth>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheckDepth
    (cl:cons ':status (status msg))
    (cl:cons ':severity_score (severity_score msg))
))
