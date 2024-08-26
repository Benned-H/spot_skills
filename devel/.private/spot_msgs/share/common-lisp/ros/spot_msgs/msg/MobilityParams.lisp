; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude MobilityParams.msg.html

(cl:defclass <MobilityParams> (roslisp-msg-protocol:ros-message)
  ((body_control
    :reader body_control
    :initarg :body_control
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (locomotion_hint
    :reader locomotion_hint
    :initarg :locomotion_hint
    :type cl:integer
    :initform 0)
   (swing_height
    :reader swing_height
    :initarg :swing_height
    :type cl:fixnum
    :initform 0)
   (stair_hint
    :reader stair_hint
    :initarg :stair_hint
    :type cl:boolean
    :initform cl:nil)
   (velocity_limit
    :reader velocity_limit
    :initarg :velocity_limit
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (obstacle_params
    :reader obstacle_params
    :initarg :obstacle_params
    :type spot_msgs-msg:ObstacleParams
    :initform (cl:make-instance 'spot_msgs-msg:ObstacleParams))
   (terrain_params
    :reader terrain_params
    :initarg :terrain_params
    :type spot_msgs-msg:TerrainParams
    :initform (cl:make-instance 'spot_msgs-msg:TerrainParams)))
)

(cl:defclass MobilityParams (<MobilityParams>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MobilityParams>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MobilityParams)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<MobilityParams> is deprecated: use spot_msgs-msg:MobilityParams instead.")))

(cl:ensure-generic-function 'body_control-val :lambda-list '(m))
(cl:defmethod body_control-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:body_control-val is deprecated.  Use spot_msgs-msg:body_control instead.")
  (body_control m))

(cl:ensure-generic-function 'locomotion_hint-val :lambda-list '(m))
(cl:defmethod locomotion_hint-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:locomotion_hint-val is deprecated.  Use spot_msgs-msg:locomotion_hint instead.")
  (locomotion_hint m))

(cl:ensure-generic-function 'swing_height-val :lambda-list '(m))
(cl:defmethod swing_height-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:swing_height-val is deprecated.  Use spot_msgs-msg:swing_height instead.")
  (swing_height m))

(cl:ensure-generic-function 'stair_hint-val :lambda-list '(m))
(cl:defmethod stair_hint-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:stair_hint-val is deprecated.  Use spot_msgs-msg:stair_hint instead.")
  (stair_hint m))

(cl:ensure-generic-function 'velocity_limit-val :lambda-list '(m))
(cl:defmethod velocity_limit-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:velocity_limit-val is deprecated.  Use spot_msgs-msg:velocity_limit instead.")
  (velocity_limit m))

(cl:ensure-generic-function 'obstacle_params-val :lambda-list '(m))
(cl:defmethod obstacle_params-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:obstacle_params-val is deprecated.  Use spot_msgs-msg:obstacle_params instead.")
  (obstacle_params m))

(cl:ensure-generic-function 'terrain_params-val :lambda-list '(m))
(cl:defmethod terrain_params-val ((m <MobilityParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:terrain_params-val is deprecated.  Use spot_msgs-msg:terrain_params instead.")
  (terrain_params m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MobilityParams>) ostream)
  "Serializes a message object of type '<MobilityParams>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'body_control) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'locomotion_hint)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'locomotion_hint)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'locomotion_hint)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'locomotion_hint)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swing_height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stair_hint) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity_limit) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'obstacle_params) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'terrain_params) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MobilityParams>) istream)
  "Deserializes a message object of type '<MobilityParams>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'body_control) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'locomotion_hint)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'locomotion_hint)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'locomotion_hint)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'locomotion_hint)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swing_height)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'stair_hint) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity_limit) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'obstacle_params) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'terrain_params) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MobilityParams>)))
  "Returns string type for a message object of type '<MobilityParams>"
  "spot_msgs/MobilityParams")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MobilityParams)))
  "Returns string type for a message object of type 'MobilityParams"
  "spot_msgs/MobilityParams")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MobilityParams>)))
  "Returns md5sum for a message object of type '<MobilityParams>"
  "cd45019f5c330befb9646917a064a94d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MobilityParams)))
  "Returns md5sum for a message object of type 'MobilityParams"
  "cd45019f5c330befb9646917a064a94d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MobilityParams>)))
  "Returns full string definition for message of type '<MobilityParams>"
  (cl:format cl:nil "geometry_msgs/Pose body_control~%uint32 locomotion_hint~%uint8 swing_height~%bool stair_hint~%geometry_msgs/Twist velocity_limit~%spot_msgs/ObstacleParams obstacle_params~%spot_msgs/TerrainParams terrain_params~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: spot_msgs/ObstacleParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams~%bool disable_vision_foot_obstacle_avoidance~%bool disable_vision_foot_constraint_avoidance~%bool disable_vision_body_obstacle_avoidance~%float32 obstacle_avoidance_padding~%bool disable_vision_foot_obstacle_body_assist~%bool disable_vision_negative_obstacles~%================================================================================~%MSG: spot_msgs/TerrainParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams~%uint8 GRATED_SURFACES_MODE_UNKNOWN=0~%uint8 GRATED_SURFACES_MODE_OFF=1~%uint8 GRATED_SURFACES_MODE_ON=2~%uint8 GRATED_SURFACES_MODE_AUTO=3~%~%float32 ground_mu_hint~%uint8 grated_surfaces_mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MobilityParams)))
  "Returns full string definition for message of type 'MobilityParams"
  (cl:format cl:nil "geometry_msgs/Pose body_control~%uint32 locomotion_hint~%uint8 swing_height~%bool stair_hint~%geometry_msgs/Twist velocity_limit~%spot_msgs/ObstacleParams obstacle_params~%spot_msgs/TerrainParams terrain_params~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: spot_msgs/ObstacleParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams~%bool disable_vision_foot_obstacle_avoidance~%bool disable_vision_foot_constraint_avoidance~%bool disable_vision_body_obstacle_avoidance~%float32 obstacle_avoidance_padding~%bool disable_vision_foot_obstacle_body_assist~%bool disable_vision_negative_obstacles~%================================================================================~%MSG: spot_msgs/TerrainParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams~%uint8 GRATED_SURFACES_MODE_UNKNOWN=0~%uint8 GRATED_SURFACES_MODE_OFF=1~%uint8 GRATED_SURFACES_MODE_ON=2~%uint8 GRATED_SURFACES_MODE_AUTO=3~%~%float32 ground_mu_hint~%uint8 grated_surfaces_mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MobilityParams>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'body_control))
     4
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity_limit))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'obstacle_params))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'terrain_params))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MobilityParams>))
  "Converts a ROS message object to a list"
  (cl:list 'MobilityParams
    (cl:cons ':body_control (body_control msg))
    (cl:cons ':locomotion_hint (locomotion_hint msg))
    (cl:cons ':swing_height (swing_height msg))
    (cl:cons ':stair_hint (stair_hint msg))
    (cl:cons ':velocity_limit (velocity_limit msg))
    (cl:cons ':obstacle_params (obstacle_params msg))
    (cl:cons ':terrain_params (terrain_params msg))
))
