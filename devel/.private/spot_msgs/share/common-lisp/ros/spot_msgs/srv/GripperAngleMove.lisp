; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude GripperAngleMove-request.msg.html

(cl:defclass <GripperAngleMove-request> (roslisp-msg-protocol:ros-message)
  ((gripper_angle
    :reader gripper_angle
    :initarg :gripper_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass GripperAngleMove-request (<GripperAngleMove-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GripperAngleMove-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GripperAngleMove-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<GripperAngleMove-request> is deprecated: use spot_msgs-srv:GripperAngleMove-request instead.")))

(cl:ensure-generic-function 'gripper_angle-val :lambda-list '(m))
(cl:defmethod gripper_angle-val ((m <GripperAngleMove-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:gripper_angle-val is deprecated.  Use spot_msgs-srv:gripper_angle instead.")
  (gripper_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GripperAngleMove-request>) ostream)
  "Serializes a message object of type '<GripperAngleMove-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'gripper_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GripperAngleMove-request>) istream)
  "Deserializes a message object of type '<GripperAngleMove-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gripper_angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GripperAngleMove-request>)))
  "Returns string type for a service object of type '<GripperAngleMove-request>"
  "spot_msgs/GripperAngleMoveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GripperAngleMove-request)))
  "Returns string type for a service object of type 'GripperAngleMove-request"
  "spot_msgs/GripperAngleMoveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GripperAngleMove-request>)))
  "Returns md5sum for a message object of type '<GripperAngleMove-request>"
  "7900bbc2924d6597df7f80ea6945ab2b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GripperAngleMove-request)))
  "Returns md5sum for a message object of type 'GripperAngleMove-request"
  "7900bbc2924d6597df7f80ea6945ab2b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GripperAngleMove-request>)))
  "Returns full string definition for message of type '<GripperAngleMove-request>"
  (cl:format cl:nil "float64 gripper_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GripperAngleMove-request)))
  "Returns full string definition for message of type 'GripperAngleMove-request"
  (cl:format cl:nil "float64 gripper_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GripperAngleMove-request>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GripperAngleMove-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GripperAngleMove-request
    (cl:cons ':gripper_angle (gripper_angle msg))
))
;//! \htmlinclude GripperAngleMove-response.msg.html

(cl:defclass <GripperAngleMove-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass GripperAngleMove-response (<GripperAngleMove-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GripperAngleMove-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GripperAngleMove-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<GripperAngleMove-response> is deprecated: use spot_msgs-srv:GripperAngleMove-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <GripperAngleMove-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <GripperAngleMove-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GripperAngleMove-response>) ostream)
  "Serializes a message object of type '<GripperAngleMove-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GripperAngleMove-response>) istream)
  "Deserializes a message object of type '<GripperAngleMove-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GripperAngleMove-response>)))
  "Returns string type for a service object of type '<GripperAngleMove-response>"
  "spot_msgs/GripperAngleMoveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GripperAngleMove-response)))
  "Returns string type for a service object of type 'GripperAngleMove-response"
  "spot_msgs/GripperAngleMoveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GripperAngleMove-response>)))
  "Returns md5sum for a message object of type '<GripperAngleMove-response>"
  "7900bbc2924d6597df7f80ea6945ab2b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GripperAngleMove-response)))
  "Returns md5sum for a message object of type 'GripperAngleMove-response"
  "7900bbc2924d6597df7f80ea6945ab2b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GripperAngleMove-response>)))
  "Returns full string definition for message of type '<GripperAngleMove-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GripperAngleMove-response)))
  "Returns full string definition for message of type 'GripperAngleMove-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GripperAngleMove-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GripperAngleMove-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GripperAngleMove-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GripperAngleMove)))
  'GripperAngleMove-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GripperAngleMove)))
  'GripperAngleMove-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GripperAngleMove)))
  "Returns string type for a service object of type '<GripperAngleMove>"
  "spot_msgs/GripperAngleMove")