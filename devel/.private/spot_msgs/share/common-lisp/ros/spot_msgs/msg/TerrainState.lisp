; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude TerrainState.msg.html

(cl:defclass <TerrainState> (roslisp-msg-protocol:ros-message)
  ((ground_mu_est
    :reader ground_mu_est
    :initarg :ground_mu_est
    :type cl:float
    :initform 0.0)
   (frame_name
    :reader frame_name
    :initarg :frame_name
    :type cl:string
    :initform "")
   (foot_slip_distance_rt_frame
    :reader foot_slip_distance_rt_frame
    :initarg :foot_slip_distance_rt_frame
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (foot_slip_velocity_rt_frame
    :reader foot_slip_velocity_rt_frame
    :initarg :foot_slip_velocity_rt_frame
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (ground_contact_normal_rt_frame
    :reader ground_contact_normal_rt_frame
    :initarg :ground_contact_normal_rt_frame
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (visual_surface_ground_penetration_mean
    :reader visual_surface_ground_penetration_mean
    :initarg :visual_surface_ground_penetration_mean
    :type cl:float
    :initform 0.0)
   (visual_surface_ground_penetration_std
    :reader visual_surface_ground_penetration_std
    :initarg :visual_surface_ground_penetration_std
    :type cl:float
    :initform 0.0))
)

(cl:defclass TerrainState (<TerrainState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TerrainState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TerrainState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<TerrainState> is deprecated: use spot_msgs-msg:TerrainState instead.")))

(cl:ensure-generic-function 'ground_mu_est-val :lambda-list '(m))
(cl:defmethod ground_mu_est-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:ground_mu_est-val is deprecated.  Use spot_msgs-msg:ground_mu_est instead.")
  (ground_mu_est m))

(cl:ensure-generic-function 'frame_name-val :lambda-list '(m))
(cl:defmethod frame_name-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_name-val is deprecated.  Use spot_msgs-msg:frame_name instead.")
  (frame_name m))

(cl:ensure-generic-function 'foot_slip_distance_rt_frame-val :lambda-list '(m))
(cl:defmethod foot_slip_distance_rt_frame-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:foot_slip_distance_rt_frame-val is deprecated.  Use spot_msgs-msg:foot_slip_distance_rt_frame instead.")
  (foot_slip_distance_rt_frame m))

(cl:ensure-generic-function 'foot_slip_velocity_rt_frame-val :lambda-list '(m))
(cl:defmethod foot_slip_velocity_rt_frame-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:foot_slip_velocity_rt_frame-val is deprecated.  Use spot_msgs-msg:foot_slip_velocity_rt_frame instead.")
  (foot_slip_velocity_rt_frame m))

(cl:ensure-generic-function 'ground_contact_normal_rt_frame-val :lambda-list '(m))
(cl:defmethod ground_contact_normal_rt_frame-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:ground_contact_normal_rt_frame-val is deprecated.  Use spot_msgs-msg:ground_contact_normal_rt_frame instead.")
  (ground_contact_normal_rt_frame m))

(cl:ensure-generic-function 'visual_surface_ground_penetration_mean-val :lambda-list '(m))
(cl:defmethod visual_surface_ground_penetration_mean-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:visual_surface_ground_penetration_mean-val is deprecated.  Use spot_msgs-msg:visual_surface_ground_penetration_mean instead.")
  (visual_surface_ground_penetration_mean m))

(cl:ensure-generic-function 'visual_surface_ground_penetration_std-val :lambda-list '(m))
(cl:defmethod visual_surface_ground_penetration_std-val ((m <TerrainState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:visual_surface_ground_penetration_std-val is deprecated.  Use spot_msgs-msg:visual_surface_ground_penetration_std instead.")
  (visual_surface_ground_penetration_std m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TerrainState>) ostream)
  "Serializes a message object of type '<TerrainState>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ground_mu_est))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'foot_slip_distance_rt_frame) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'foot_slip_velocity_rt_frame) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ground_contact_normal_rt_frame) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'visual_surface_ground_penetration_mean))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'visual_surface_ground_penetration_std))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TerrainState>) istream)
  "Deserializes a message object of type '<TerrainState>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ground_mu_est) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'foot_slip_distance_rt_frame) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'foot_slip_velocity_rt_frame) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ground_contact_normal_rt_frame) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'visual_surface_ground_penetration_mean) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'visual_surface_ground_penetration_std) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TerrainState>)))
  "Returns string type for a message object of type '<TerrainState>"
  "spot_msgs/TerrainState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TerrainState)))
  "Returns string type for a message object of type 'TerrainState"
  "spot_msgs/TerrainState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TerrainState>)))
  "Returns md5sum for a message object of type '<TerrainState>"
  "8ace1ec594dcaee88134d9f49cb542d9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TerrainState)))
  "Returns md5sum for a message object of type 'TerrainState"
  "8ace1ec594dcaee88134d9f49cb542d9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TerrainState>)))
  "Returns full string definition for message of type '<TerrainState>"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=foot_state#footstate-terrainstate~%~%float32 ground_mu_est~%string frame_name~%geometry_msgs/Vector3 foot_slip_distance_rt_frame~%geometry_msgs/Vector3 foot_slip_velocity_rt_frame~%geometry_msgs/Vector3 ground_contact_normal_rt_frame~%float32 visual_surface_ground_penetration_mean~%float32 visual_surface_ground_penetration_std~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TerrainState)))
  "Returns full string definition for message of type 'TerrainState"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=foot_state#footstate-terrainstate~%~%float32 ground_mu_est~%string frame_name~%geometry_msgs/Vector3 foot_slip_distance_rt_frame~%geometry_msgs/Vector3 foot_slip_velocity_rt_frame~%geometry_msgs/Vector3 ground_contact_normal_rt_frame~%float32 visual_surface_ground_penetration_mean~%float32 visual_surface_ground_penetration_std~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TerrainState>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'frame_name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'foot_slip_distance_rt_frame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'foot_slip_velocity_rt_frame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ground_contact_normal_rt_frame))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TerrainState>))
  "Converts a ROS message object to a list"
  (cl:list 'TerrainState
    (cl:cons ':ground_mu_est (ground_mu_est msg))
    (cl:cons ':frame_name (frame_name msg))
    (cl:cons ':foot_slip_distance_rt_frame (foot_slip_distance_rt_frame msg))
    (cl:cons ':foot_slip_velocity_rt_frame (foot_slip_velocity_rt_frame msg))
    (cl:cons ':ground_contact_normal_rt_frame (ground_contact_normal_rt_frame msg))
    (cl:cons ':visual_surface_ground_penetration_mean (visual_surface_ground_penetration_mean msg))
    (cl:cons ':visual_surface_ground_penetration_std (visual_surface_ground_penetration_std msg))
))
