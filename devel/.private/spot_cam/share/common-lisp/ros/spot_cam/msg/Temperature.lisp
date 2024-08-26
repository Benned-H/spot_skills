; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude Temperature.msg.html

(cl:defclass <Temperature> (roslisp-msg-protocol:ros-message)
  ((channel_name
    :reader channel_name
    :initarg :channel_name
    :type cl:string
    :initform "")
   (temperature
    :reader temperature
    :initarg :temperature
    :type cl:float
    :initform 0.0))
)

(cl:defclass Temperature (<Temperature>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Temperature>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Temperature)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<Temperature> is deprecated: use spot_cam-msg:Temperature instead.")))

(cl:ensure-generic-function 'channel_name-val :lambda-list '(m))
(cl:defmethod channel_name-val ((m <Temperature>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:channel_name-val is deprecated.  Use spot_cam-msg:channel_name instead.")
  (channel_name m))

(cl:ensure-generic-function 'temperature-val :lambda-list '(m))
(cl:defmethod temperature-val ((m <Temperature>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:temperature-val is deprecated.  Use spot_cam-msg:temperature instead.")
  (temperature m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Temperature>) ostream)
  "Serializes a message object of type '<Temperature>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'channel_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'channel_name))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Temperature>) istream)
  "Deserializes a message object of type '<Temperature>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'channel_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'channel_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'temperature) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Temperature>)))
  "Returns string type for a message object of type '<Temperature>"
  "spot_cam/Temperature")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Temperature)))
  "Returns string type for a message object of type 'Temperature"
  "spot_cam/Temperature")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Temperature>)))
  "Returns md5sum for a message object of type '<Temperature>"
  "086009cefe0e896fc6b042a5e575d367")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Temperature)))
  "Returns md5sum for a message object of type 'Temperature"
  "086009cefe0e896fc6b042a5e575d367")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Temperature>)))
  "Returns full string definition for message of type '<Temperature>"
  (cl:format cl:nil "string channel_name~%float32 temperature~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Temperature)))
  "Returns full string definition for message of type 'Temperature"
  (cl:format cl:nil "string channel_name~%float32 temperature~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Temperature>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'channel_name))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Temperature>))
  "Converts a ROS message object to a list"
  (cl:list 'Temperature
    (cl:cons ':channel_name (channel_name msg))
    (cl:cons ':temperature (temperature msg))
))
