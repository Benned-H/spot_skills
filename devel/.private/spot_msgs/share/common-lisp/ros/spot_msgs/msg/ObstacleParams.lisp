; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude ObstacleParams.msg.html

(cl:defclass <ObstacleParams> (roslisp-msg-protocol:ros-message)
  ((disable_vision_foot_obstacle_avoidance
    :reader disable_vision_foot_obstacle_avoidance
    :initarg :disable_vision_foot_obstacle_avoidance
    :type cl:boolean
    :initform cl:nil)
   (disable_vision_foot_constraint_avoidance
    :reader disable_vision_foot_constraint_avoidance
    :initarg :disable_vision_foot_constraint_avoidance
    :type cl:boolean
    :initform cl:nil)
   (disable_vision_body_obstacle_avoidance
    :reader disable_vision_body_obstacle_avoidance
    :initarg :disable_vision_body_obstacle_avoidance
    :type cl:boolean
    :initform cl:nil)
   (obstacle_avoidance_padding
    :reader obstacle_avoidance_padding
    :initarg :obstacle_avoidance_padding
    :type cl:float
    :initform 0.0)
   (disable_vision_foot_obstacle_body_assist
    :reader disable_vision_foot_obstacle_body_assist
    :initarg :disable_vision_foot_obstacle_body_assist
    :type cl:boolean
    :initform cl:nil)
   (disable_vision_negative_obstacles
    :reader disable_vision_negative_obstacles
    :initarg :disable_vision_negative_obstacles
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ObstacleParams (<ObstacleParams>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObstacleParams>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObstacleParams)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<ObstacleParams> is deprecated: use spot_msgs-msg:ObstacleParams instead.")))

(cl:ensure-generic-function 'disable_vision_foot_obstacle_avoidance-val :lambda-list '(m))
(cl:defmethod disable_vision_foot_obstacle_avoidance-val ((m <ObstacleParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:disable_vision_foot_obstacle_avoidance-val is deprecated.  Use spot_msgs-msg:disable_vision_foot_obstacle_avoidance instead.")
  (disable_vision_foot_obstacle_avoidance m))

(cl:ensure-generic-function 'disable_vision_foot_constraint_avoidance-val :lambda-list '(m))
(cl:defmethod disable_vision_foot_constraint_avoidance-val ((m <ObstacleParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:disable_vision_foot_constraint_avoidance-val is deprecated.  Use spot_msgs-msg:disable_vision_foot_constraint_avoidance instead.")
  (disable_vision_foot_constraint_avoidance m))

(cl:ensure-generic-function 'disable_vision_body_obstacle_avoidance-val :lambda-list '(m))
(cl:defmethod disable_vision_body_obstacle_avoidance-val ((m <ObstacleParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:disable_vision_body_obstacle_avoidance-val is deprecated.  Use spot_msgs-msg:disable_vision_body_obstacle_avoidance instead.")
  (disable_vision_body_obstacle_avoidance m))

(cl:ensure-generic-function 'obstacle_avoidance_padding-val :lambda-list '(m))
(cl:defmethod obstacle_avoidance_padding-val ((m <ObstacleParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:obstacle_avoidance_padding-val is deprecated.  Use spot_msgs-msg:obstacle_avoidance_padding instead.")
  (obstacle_avoidance_padding m))

(cl:ensure-generic-function 'disable_vision_foot_obstacle_body_assist-val :lambda-list '(m))
(cl:defmethod disable_vision_foot_obstacle_body_assist-val ((m <ObstacleParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:disable_vision_foot_obstacle_body_assist-val is deprecated.  Use spot_msgs-msg:disable_vision_foot_obstacle_body_assist instead.")
  (disable_vision_foot_obstacle_body_assist m))

(cl:ensure-generic-function 'disable_vision_negative_obstacles-val :lambda-list '(m))
(cl:defmethod disable_vision_negative_obstacles-val ((m <ObstacleParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:disable_vision_negative_obstacles-val is deprecated.  Use spot_msgs-msg:disable_vision_negative_obstacles instead.")
  (disable_vision_negative_obstacles m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObstacleParams>) ostream)
  "Serializes a message object of type '<ObstacleParams>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'disable_vision_foot_obstacle_avoidance) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'disable_vision_foot_constraint_avoidance) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'disable_vision_body_obstacle_avoidance) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'obstacle_avoidance_padding))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'disable_vision_foot_obstacle_body_assist) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'disable_vision_negative_obstacles) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObstacleParams>) istream)
  "Deserializes a message object of type '<ObstacleParams>"
    (cl:setf (cl:slot-value msg 'disable_vision_foot_obstacle_avoidance) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'disable_vision_foot_constraint_avoidance) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'disable_vision_body_obstacle_avoidance) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'obstacle_avoidance_padding) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'disable_vision_foot_obstacle_body_assist) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'disable_vision_negative_obstacles) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObstacleParams>)))
  "Returns string type for a message object of type '<ObstacleParams>"
  "spot_msgs/ObstacleParams")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObstacleParams)))
  "Returns string type for a message object of type 'ObstacleParams"
  "spot_msgs/ObstacleParams")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObstacleParams>)))
  "Returns md5sum for a message object of type '<ObstacleParams>"
  "9b3390759d58138d9a7a53bad6b0edad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObstacleParams)))
  "Returns md5sum for a message object of type 'ObstacleParams"
  "9b3390759d58138d9a7a53bad6b0edad")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObstacleParams>)))
  "Returns full string definition for message of type '<ObstacleParams>"
  (cl:format cl:nil "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams~%bool disable_vision_foot_obstacle_avoidance~%bool disable_vision_foot_constraint_avoidance~%bool disable_vision_body_obstacle_avoidance~%float32 obstacle_avoidance_padding~%bool disable_vision_foot_obstacle_body_assist~%bool disable_vision_negative_obstacles~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObstacleParams)))
  "Returns full string definition for message of type 'ObstacleParams"
  (cl:format cl:nil "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams~%bool disable_vision_foot_obstacle_avoidance~%bool disable_vision_foot_constraint_avoidance~%bool disable_vision_body_obstacle_avoidance~%float32 obstacle_avoidance_padding~%bool disable_vision_foot_obstacle_body_assist~%bool disable_vision_negative_obstacles~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObstacleParams>))
  (cl:+ 0
     1
     1
     1
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObstacleParams>))
  "Converts a ROS message object to a list"
  (cl:list 'ObstacleParams
    (cl:cons ':disable_vision_foot_obstacle_avoidance (disable_vision_foot_obstacle_avoidance msg))
    (cl:cons ':disable_vision_foot_constraint_avoidance (disable_vision_foot_constraint_avoidance msg))
    (cl:cons ':disable_vision_body_obstacle_avoidance (disable_vision_body_obstacle_avoidance msg))
    (cl:cons ':obstacle_avoidance_padding (obstacle_avoidance_padding msg))
    (cl:cons ':disable_vision_foot_obstacle_body_assist (disable_vision_foot_obstacle_body_assist msg))
    (cl:cons ':disable_vision_negative_obstacles (disable_vision_negative_obstacles msg))
))
