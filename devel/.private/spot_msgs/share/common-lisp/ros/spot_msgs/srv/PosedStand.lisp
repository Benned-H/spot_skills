; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude PosedStand-request.msg.html

(cl:defclass <PosedStand-request> (roslisp-msg-protocol:ros-message)
  ((body_height
    :reader body_height
    :initarg :body_height
    :type cl:float
    :initform 0.0)
   (body_yaw
    :reader body_yaw
    :initarg :body_yaw
    :type cl:float
    :initform 0.0)
   (body_pitch
    :reader body_pitch
    :initarg :body_pitch
    :type cl:float
    :initform 0.0)
   (body_roll
    :reader body_roll
    :initarg :body_roll
    :type cl:float
    :initform 0.0))
)

(cl:defclass PosedStand-request (<PosedStand-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PosedStand-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PosedStand-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<PosedStand-request> is deprecated: use spot_msgs-srv:PosedStand-request instead.")))

(cl:ensure-generic-function 'body_height-val :lambda-list '(m))
(cl:defmethod body_height-val ((m <PosedStand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:body_height-val is deprecated.  Use spot_msgs-srv:body_height instead.")
  (body_height m))

(cl:ensure-generic-function 'body_yaw-val :lambda-list '(m))
(cl:defmethod body_yaw-val ((m <PosedStand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:body_yaw-val is deprecated.  Use spot_msgs-srv:body_yaw instead.")
  (body_yaw m))

(cl:ensure-generic-function 'body_pitch-val :lambda-list '(m))
(cl:defmethod body_pitch-val ((m <PosedStand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:body_pitch-val is deprecated.  Use spot_msgs-srv:body_pitch instead.")
  (body_pitch m))

(cl:ensure-generic-function 'body_roll-val :lambda-list '(m))
(cl:defmethod body_roll-val ((m <PosedStand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:body_roll-val is deprecated.  Use spot_msgs-srv:body_roll instead.")
  (body_roll m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PosedStand-request>) ostream)
  "Serializes a message object of type '<PosedStand-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'body_height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'body_yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'body_pitch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'body_roll))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PosedStand-request>) istream)
  "Deserializes a message object of type '<PosedStand-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'body_height) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'body_yaw) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'body_pitch) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'body_roll) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PosedStand-request>)))
  "Returns string type for a service object of type '<PosedStand-request>"
  "spot_msgs/PosedStandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PosedStand-request)))
  "Returns string type for a service object of type 'PosedStand-request"
  "spot_msgs/PosedStandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PosedStand-request>)))
  "Returns md5sum for a message object of type '<PosedStand-request>"
  "832f607027428cf7110c7d6907d1c083")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PosedStand-request)))
  "Returns md5sum for a message object of type 'PosedStand-request"
  "832f607027428cf7110c7d6907d1c083")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PosedStand-request>)))
  "Returns full string definition for message of type '<PosedStand-request>"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command.html?highlight=feedback#bosdyn.client.robot_command.RobotCommandBuilder.stand_command~%~%# Offset of the body from the default stand height, in metres~%float32 body_height~%~%# RPY of the body relative to the robot's default stand pose~%float32 body_yaw~%float32 body_pitch~%float32 body_roll~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PosedStand-request)))
  "Returns full string definition for message of type 'PosedStand-request"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command.html?highlight=feedback#bosdyn.client.robot_command.RobotCommandBuilder.stand_command~%~%# Offset of the body from the default stand height, in metres~%float32 body_height~%~%# RPY of the body relative to the robot's default stand pose~%float32 body_yaw~%float32 body_pitch~%float32 body_roll~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PosedStand-request>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PosedStand-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PosedStand-request
    (cl:cons ':body_height (body_height msg))
    (cl:cons ':body_yaw (body_yaw msg))
    (cl:cons ':body_pitch (body_pitch msg))
    (cl:cons ':body_roll (body_roll msg))
))
;//! \htmlinclude PosedStand-response.msg.html

(cl:defclass <PosedStand-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass PosedStand-response (<PosedStand-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PosedStand-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PosedStand-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<PosedStand-response> is deprecated: use spot_msgs-srv:PosedStand-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <PosedStand-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <PosedStand-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PosedStand-response>) ostream)
  "Serializes a message object of type '<PosedStand-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PosedStand-response>) istream)
  "Deserializes a message object of type '<PosedStand-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PosedStand-response>)))
  "Returns string type for a service object of type '<PosedStand-response>"
  "spot_msgs/PosedStandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PosedStand-response)))
  "Returns string type for a service object of type 'PosedStand-response"
  "spot_msgs/PosedStandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PosedStand-response>)))
  "Returns md5sum for a message object of type '<PosedStand-response>"
  "832f607027428cf7110c7d6907d1c083")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PosedStand-response)))
  "Returns md5sum for a message object of type 'PosedStand-response"
  "832f607027428cf7110c7d6907d1c083")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PosedStand-response>)))
  "Returns full string definition for message of type '<PosedStand-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PosedStand-response)))
  "Returns full string definition for message of type 'PosedStand-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PosedStand-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PosedStand-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PosedStand-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PosedStand)))
  'PosedStand-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PosedStand)))
  'PosedStand-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PosedStand)))
  "Returns string type for a service object of type '<PosedStand>"
  "spot_msgs/PosedStand")