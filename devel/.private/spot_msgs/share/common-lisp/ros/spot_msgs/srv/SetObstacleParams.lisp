; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude SetObstacleParams-request.msg.html

(cl:defclass <SetObstacleParams-request> (roslisp-msg-protocol:ros-message)
  ((obstacle_params
    :reader obstacle_params
    :initarg :obstacle_params
    :type spot_msgs-msg:ObstacleParams
    :initform (cl:make-instance 'spot_msgs-msg:ObstacleParams)))
)

(cl:defclass SetObstacleParams-request (<SetObstacleParams-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetObstacleParams-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetObstacleParams-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetObstacleParams-request> is deprecated: use spot_msgs-srv:SetObstacleParams-request instead.")))

(cl:ensure-generic-function 'obstacle_params-val :lambda-list '(m))
(cl:defmethod obstacle_params-val ((m <SetObstacleParams-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:obstacle_params-val is deprecated.  Use spot_msgs-srv:obstacle_params instead.")
  (obstacle_params m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetObstacleParams-request>) ostream)
  "Serializes a message object of type '<SetObstacleParams-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'obstacle_params) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetObstacleParams-request>) istream)
  "Deserializes a message object of type '<SetObstacleParams-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'obstacle_params) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetObstacleParams-request>)))
  "Returns string type for a service object of type '<SetObstacleParams-request>"
  "spot_msgs/SetObstacleParamsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetObstacleParams-request)))
  "Returns string type for a service object of type 'SetObstacleParams-request"
  "spot_msgs/SetObstacleParamsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetObstacleParams-request>)))
  "Returns md5sum for a message object of type '<SetObstacleParams-request>"
  "8ca30ec022a12ccabed5c0af340a4796")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetObstacleParams-request)))
  "Returns md5sum for a message object of type 'SetObstacleParams-request"
  "8ca30ec022a12ccabed5c0af340a4796")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetObstacleParams-request>)))
  "Returns full string definition for message of type '<SetObstacleParams-request>"
  (cl:format cl:nil "spot_msgs/ObstacleParams obstacle_params~%~%================================================================================~%MSG: spot_msgs/ObstacleParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams~%bool disable_vision_foot_obstacle_avoidance~%bool disable_vision_foot_constraint_avoidance~%bool disable_vision_body_obstacle_avoidance~%float32 obstacle_avoidance_padding~%bool disable_vision_foot_obstacle_body_assist~%bool disable_vision_negative_obstacles~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetObstacleParams-request)))
  "Returns full string definition for message of type 'SetObstacleParams-request"
  (cl:format cl:nil "spot_msgs/ObstacleParams obstacle_params~%~%================================================================================~%MSG: spot_msgs/ObstacleParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams~%bool disable_vision_foot_obstacle_avoidance~%bool disable_vision_foot_constraint_avoidance~%bool disable_vision_body_obstacle_avoidance~%float32 obstacle_avoidance_padding~%bool disable_vision_foot_obstacle_body_assist~%bool disable_vision_negative_obstacles~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetObstacleParams-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'obstacle_params))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetObstacleParams-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetObstacleParams-request
    (cl:cons ':obstacle_params (obstacle_params msg))
))
;//! \htmlinclude SetObstacleParams-response.msg.html

(cl:defclass <SetObstacleParams-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetObstacleParams-response (<SetObstacleParams-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetObstacleParams-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetObstacleParams-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetObstacleParams-response> is deprecated: use spot_msgs-srv:SetObstacleParams-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetObstacleParams-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetObstacleParams-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetObstacleParams-response>) ostream)
  "Serializes a message object of type '<SetObstacleParams-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetObstacleParams-response>) istream)
  "Deserializes a message object of type '<SetObstacleParams-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetObstacleParams-response>)))
  "Returns string type for a service object of type '<SetObstacleParams-response>"
  "spot_msgs/SetObstacleParamsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetObstacleParams-response)))
  "Returns string type for a service object of type 'SetObstacleParams-response"
  "spot_msgs/SetObstacleParamsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetObstacleParams-response>)))
  "Returns md5sum for a message object of type '<SetObstacleParams-response>"
  "8ca30ec022a12ccabed5c0af340a4796")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetObstacleParams-response)))
  "Returns md5sum for a message object of type 'SetObstacleParams-response"
  "8ca30ec022a12ccabed5c0af340a4796")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetObstacleParams-response>)))
  "Returns full string definition for message of type '<SetObstacleParams-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetObstacleParams-response)))
  "Returns full string definition for message of type 'SetObstacleParams-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetObstacleParams-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetObstacleParams-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetObstacleParams-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetObstacleParams)))
  'SetObstacleParams-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetObstacleParams)))
  'SetObstacleParams-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetObstacleParams)))
  "Returns string type for a service object of type '<SetObstacleParams>"
  "spot_msgs/SetObstacleParams")