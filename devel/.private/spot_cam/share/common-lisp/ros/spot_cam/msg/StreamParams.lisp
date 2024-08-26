; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude StreamParams.msg.html

(cl:defclass <StreamParams> (roslisp-msg-protocol:ros-message)
  ((target_bitrate
    :reader target_bitrate
    :initarg :target_bitrate
    :type cl:integer
    :initform 0)
   (refresh_interval
    :reader refresh_interval
    :initarg :refresh_interval
    :type cl:integer
    :initform 0)
   (idr_interval
    :reader idr_interval
    :initarg :idr_interval
    :type cl:integer
    :initform 0)
   (awb
    :reader awb
    :initarg :awb
    :type cl:fixnum
    :initform 0))
)

(cl:defclass StreamParams (<StreamParams>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StreamParams>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StreamParams)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<StreamParams> is deprecated: use spot_cam-msg:StreamParams instead.")))

(cl:ensure-generic-function 'target_bitrate-val :lambda-list '(m))
(cl:defmethod target_bitrate-val ((m <StreamParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:target_bitrate-val is deprecated.  Use spot_cam-msg:target_bitrate instead.")
  (target_bitrate m))

(cl:ensure-generic-function 'refresh_interval-val :lambda-list '(m))
(cl:defmethod refresh_interval-val ((m <StreamParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:refresh_interval-val is deprecated.  Use spot_cam-msg:refresh_interval instead.")
  (refresh_interval m))

(cl:ensure-generic-function 'idr_interval-val :lambda-list '(m))
(cl:defmethod idr_interval-val ((m <StreamParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:idr_interval-val is deprecated.  Use spot_cam-msg:idr_interval instead.")
  (idr_interval m))

(cl:ensure-generic-function 'awb-val :lambda-list '(m))
(cl:defmethod awb-val ((m <StreamParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:awb-val is deprecated.  Use spot_cam-msg:awb instead.")
  (awb m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<StreamParams>)))
    "Constants for message type '<StreamParams>"
  '((:OFF . -1)
    (:UNSET . 0)
    (:AUTO . 1)
    (:INCANDESCENT . 2)
    (:FLUORESCENT . 3)
    (:WARM_FLUORESCENT . 4)
    (:DAYLIGHT . 5)
    (:CLOUDY . 6)
    (:TWILIGHT . 7)
    (:SHADE . 8)
    (:DARK . 9))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'StreamParams)))
    "Constants for message type 'StreamParams"
  '((:OFF . -1)
    (:UNSET . 0)
    (:AUTO . 1)
    (:INCANDESCENT . 2)
    (:FLUORESCENT . 3)
    (:WARM_FLUORESCENT . 4)
    (:DAYLIGHT . 5)
    (:CLOUDY . 6)
    (:TWILIGHT . 7)
    (:SHADE . 8)
    (:DARK . 9))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StreamParams>) ostream)
  "Serializes a message object of type '<StreamParams>"
  (cl:let* ((signed (cl:slot-value msg 'target_bitrate)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'refresh_interval)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'idr_interval)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'awb)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StreamParams>) istream)
  "Deserializes a message object of type '<StreamParams>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target_bitrate) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'refresh_interval) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'idr_interval) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'awb) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StreamParams>)))
  "Returns string type for a message object of type '<StreamParams>"
  "spot_cam/StreamParams")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StreamParams)))
  "Returns string type for a message object of type 'StreamParams"
  "spot_cam/StreamParams")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StreamParams>)))
  "Returns md5sum for a message object of type '<StreamParams>"
  "7fa7ed9c6dbde8368621018918a2a544")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StreamParams)))
  "Returns md5sum for a message object of type 'StreamParams"
  "7fa7ed9c6dbde8368621018918a2a544")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StreamParams>)))
  "Returns full string definition for message of type '<StreamParams>"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams~%# White balance modes~%int8 OFF=-1~%# This is not provided, but we add it to be able to distinguish when setting the white balance~%int8 UNSET=0~%int8 AUTO=1~%int8 INCANDESCENT=2~%int8 FLUORESCENT=3~%int8 WARM_FLUORESCENT=4~%int8 DAYLIGHT=5~%int8 CLOUDY=6~%int8 TWILIGHT=7~%int8 SHADE=8~%int8 DARK=9~%~%# Compression level target in bits per second~%int64 target_bitrate~%# How often should the entire feed be refreshed (in frames)~%int64 refresh_interval~%# How often should an IDR message be sent (in frames)~%int64 idr_interval~%# Automatic white balance~%int8 awb~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StreamParams)))
  "Returns full string definition for message of type 'StreamParams"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams~%# White balance modes~%int8 OFF=-1~%# This is not provided, but we add it to be able to distinguish when setting the white balance~%int8 UNSET=0~%int8 AUTO=1~%int8 INCANDESCENT=2~%int8 FLUORESCENT=3~%int8 WARM_FLUORESCENT=4~%int8 DAYLIGHT=5~%int8 CLOUDY=6~%int8 TWILIGHT=7~%int8 SHADE=8~%int8 DARK=9~%~%# Compression level target in bits per second~%int64 target_bitrate~%# How often should the entire feed be refreshed (in frames)~%int64 refresh_interval~%# How often should an IDR message be sent (in frames)~%int64 idr_interval~%# Automatic white balance~%int8 awb~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StreamParams>))
  (cl:+ 0
     8
     8
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StreamParams>))
  "Converts a ROS message object to a list"
  (cl:list 'StreamParams
    (cl:cons ':target_bitrate (target_bitrate msg))
    (cl:cons ':refresh_interval (refresh_interval msg))
    (cl:cons ':idr_interval (idr_interval msg))
    (cl:cons ':awb (awb msg))
))
