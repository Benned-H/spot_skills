; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude SetLocomotion-request.msg.html

(cl:defclass <SetLocomotion-request> (roslisp-msg-protocol:ros-message)
  ((locomotion_mode
    :reader locomotion_mode
    :initarg :locomotion_mode
    :type cl:integer
    :initform 0))
)

(cl:defclass SetLocomotion-request (<SetLocomotion-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetLocomotion-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetLocomotion-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetLocomotion-request> is deprecated: use spot_msgs-srv:SetLocomotion-request instead.")))

(cl:ensure-generic-function 'locomotion_mode-val :lambda-list '(m))
(cl:defmethod locomotion_mode-val ((m <SetLocomotion-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:locomotion_mode-val is deprecated.  Use spot_msgs-srv:locomotion_mode instead.")
  (locomotion_mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SetLocomotion-request>)))
    "Constants for message type '<SetLocomotion-request>"
  '((:HINT_UNKNOWN . 0)
    (:HINT_AUTO . 1)
    (:HINT_TROT . 2)
    (:HINT_SPEED_SELECT_TROT . 3)
    (:HINT_CRAWL . 4)
    (:HINT_AMBLE . 5)
    (:HINT_SPEED_SELECT_AMBLE . 6)
    (:HINT_JOG . 7)
    (:HINT_HOP . 8)
    (:HINT_SPEED_SELECT_CRAWL . 10))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SetLocomotion-request)))
    "Constants for message type 'SetLocomotion-request"
  '((:HINT_UNKNOWN . 0)
    (:HINT_AUTO . 1)
    (:HINT_TROT . 2)
    (:HINT_SPEED_SELECT_TROT . 3)
    (:HINT_CRAWL . 4)
    (:HINT_AMBLE . 5)
    (:HINT_SPEED_SELECT_AMBLE . 6)
    (:HINT_JOG . 7)
    (:HINT_HOP . 8)
    (:HINT_SPEED_SELECT_CRAWL . 10))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetLocomotion-request>) ostream)
  "Serializes a message object of type '<SetLocomotion-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'locomotion_mode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'locomotion_mode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'locomotion_mode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'locomotion_mode)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetLocomotion-request>) istream)
  "Deserializes a message object of type '<SetLocomotion-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'locomotion_mode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'locomotion_mode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'locomotion_mode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'locomotion_mode)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetLocomotion-request>)))
  "Returns string type for a service object of type '<SetLocomotion-request>"
  "spot_msgs/SetLocomotionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetLocomotion-request)))
  "Returns string type for a service object of type 'SetLocomotion-request"
  "spot_msgs/SetLocomotionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetLocomotion-request>)))
  "Returns md5sum for a message object of type '<SetLocomotion-request>"
  "e8dfb4cee89cb4df2de99142d065f95d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetLocomotion-request)))
  "Returns md5sum for a message object of type 'SetLocomotion-request"
  "e8dfb4cee89cb4df2de99142d065f95d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetLocomotion-request>)))
  "Returns full string definition for message of type '<SetLocomotion-request>"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=mobilityparams#locomotionhint for details~%uint8 HINT_UNKNOWN=0~%uint8 HINT_AUTO=1~%uint8 HINT_TROT=2~%uint8 HINT_SPEED_SELECT_TROT=3~%uint8 HINT_CRAWL=4~%uint8 HINT_AMBLE=5~%uint8 HINT_SPEED_SELECT_AMBLE=6~%uint8 HINT_JOG=7~%uint8 HINT_HOP=8~%uint8 HINT_SPEED_SELECT_CRAWL=10~%~%uint32 locomotion_mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetLocomotion-request)))
  "Returns full string definition for message of type 'SetLocomotion-request"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=mobilityparams#locomotionhint for details~%uint8 HINT_UNKNOWN=0~%uint8 HINT_AUTO=1~%uint8 HINT_TROT=2~%uint8 HINT_SPEED_SELECT_TROT=3~%uint8 HINT_CRAWL=4~%uint8 HINT_AMBLE=5~%uint8 HINT_SPEED_SELECT_AMBLE=6~%uint8 HINT_JOG=7~%uint8 HINT_HOP=8~%uint8 HINT_SPEED_SELECT_CRAWL=10~%~%uint32 locomotion_mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetLocomotion-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetLocomotion-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetLocomotion-request
    (cl:cons ':locomotion_mode (locomotion_mode msg))
))
;//! \htmlinclude SetLocomotion-response.msg.html

(cl:defclass <SetLocomotion-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetLocomotion-response (<SetLocomotion-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetLocomotion-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetLocomotion-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetLocomotion-response> is deprecated: use spot_msgs-srv:SetLocomotion-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetLocomotion-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetLocomotion-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetLocomotion-response>) ostream)
  "Serializes a message object of type '<SetLocomotion-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetLocomotion-response>) istream)
  "Deserializes a message object of type '<SetLocomotion-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetLocomotion-response>)))
  "Returns string type for a service object of type '<SetLocomotion-response>"
  "spot_msgs/SetLocomotionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetLocomotion-response)))
  "Returns string type for a service object of type 'SetLocomotion-response"
  "spot_msgs/SetLocomotionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetLocomotion-response>)))
  "Returns md5sum for a message object of type '<SetLocomotion-response>"
  "e8dfb4cee89cb4df2de99142d065f95d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetLocomotion-response)))
  "Returns md5sum for a message object of type 'SetLocomotion-response"
  "e8dfb4cee89cb4df2de99142d065f95d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetLocomotion-response>)))
  "Returns full string definition for message of type '<SetLocomotion-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetLocomotion-response)))
  "Returns full string definition for message of type 'SetLocomotion-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetLocomotion-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetLocomotion-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetLocomotion-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetLocomotion)))
  'SetLocomotion-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetLocomotion)))
  'SetLocomotion-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetLocomotion)))
  "Returns string type for a service object of type '<SetLocomotion>"
  "spot_msgs/SetLocomotion")