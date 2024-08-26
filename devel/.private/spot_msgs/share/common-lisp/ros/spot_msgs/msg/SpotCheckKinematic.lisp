; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude SpotCheckKinematic.msg.html

(cl:defclass <SpotCheckKinematic> (roslisp-msg-protocol:ros-message)
  ((error
    :reader error
    :initarg :error
    :type cl:fixnum
    :initform 0)
   (offset
    :reader offset
    :initarg :offset
    :type cl:float
    :initform 0.0)
   (old_offset
    :reader old_offset
    :initarg :old_offset
    :type cl:float
    :initform 0.0)
   (health_score
    :reader health_score
    :initarg :health_score
    :type cl:float
    :initform 0.0))
)

(cl:defclass SpotCheckKinematic (<SpotCheckKinematic>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheckKinematic>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheckKinematic)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<SpotCheckKinematic> is deprecated: use spot_msgs-msg:SpotCheckKinematic instead.")))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <SpotCheckKinematic>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:error-val is deprecated.  Use spot_msgs-msg:error instead.")
  (error m))

(cl:ensure-generic-function 'offset-val :lambda-list '(m))
(cl:defmethod offset-val ((m <SpotCheckKinematic>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:offset-val is deprecated.  Use spot_msgs-msg:offset instead.")
  (offset m))

(cl:ensure-generic-function 'old_offset-val :lambda-list '(m))
(cl:defmethod old_offset-val ((m <SpotCheckKinematic>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:old_offset-val is deprecated.  Use spot_msgs-msg:old_offset instead.")
  (old_offset m))

(cl:ensure-generic-function 'health_score-val :lambda-list '(m))
(cl:defmethod health_score-val ((m <SpotCheckKinematic>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:health_score-val is deprecated.  Use spot_msgs-msg:health_score instead.")
  (health_score m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SpotCheckKinematic>)))
    "Constants for message type '<SpotCheckKinematic>"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_CLUTCH_SLIP . 2)
    (:ERROR_INVALID_RANGE_OF_MOTION . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SpotCheckKinematic)))
    "Constants for message type 'SpotCheckKinematic"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_CLUTCH_SLIP . 2)
    (:ERROR_INVALID_RANGE_OF_MOTION . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheckKinematic>) ostream)
  "Serializes a message object of type '<SpotCheckKinematic>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'offset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'old_offset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'health_score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheckKinematic>) istream)
  "Deserializes a message object of type '<SpotCheckKinematic>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'offset) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'old_offset) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'health_score) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheckKinematic>)))
  "Returns string type for a message object of type '<SpotCheckKinematic>"
  "spot_msgs/SpotCheckKinematic")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheckKinematic)))
  "Returns string type for a message object of type 'SpotCheckKinematic"
  "spot_msgs/SpotCheckKinematic")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheckKinematic>)))
  "Returns md5sum for a message object of type '<SpotCheckKinematic>"
  "fe33606761c255ffb331f260e7ee4d23")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheckKinematic)))
  "Returns md5sum for a message object of type 'SpotCheckKinematic"
  "fe33606761c255ffb331f260e7ee4d23")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheckKinematic>)))
  "Returns full string definition for message of type '<SpotCheckKinematic>"
  (cl:format cl:nil "# Errors reflect an issue with robot hardware.~%uint8 ERROR_UNKNOWN = 0       # Unused enum.~%uint8 ERROR_NONE = 1          # No hardware error detected.~%uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.~%uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.~%~%# A flag to indicate if results has an error.~%uint8 error~%~%# The current offset [rad]~%float32 offset~%# The previous offset [rad]~%float32 old_offset~%~%# Joint calibration health score. range [0-1]~%# 0 indicates an unhealthy kinematic joint calibration~%# 1 indicates a perfect kinematic joint calibration~%# Typically, values greater than 0.8 should be expected.~%float32 health_score~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheckKinematic)))
  "Returns full string definition for message of type 'SpotCheckKinematic"
  (cl:format cl:nil "# Errors reflect an issue with robot hardware.~%uint8 ERROR_UNKNOWN = 0       # Unused enum.~%uint8 ERROR_NONE = 1          # No hardware error detected.~%uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.~%uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.~%~%# A flag to indicate if results has an error.~%uint8 error~%~%# The current offset [rad]~%float32 offset~%# The previous offset [rad]~%float32 old_offset~%~%# Joint calibration health score. range [0-1]~%# 0 indicates an unhealthy kinematic joint calibration~%# 1 indicates a perfect kinematic joint calibration~%# Typically, values greater than 0.8 should be expected.~%float32 health_score~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheckKinematic>))
  (cl:+ 0
     1
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheckKinematic>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheckKinematic
    (cl:cons ':error (error msg))
    (cl:cons ':offset (offset msg))
    (cl:cons ':old_offset (old_offset msg))
    (cl:cons ':health_score (health_score msg))
))
