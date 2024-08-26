; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude TerrainParams.msg.html

(cl:defclass <TerrainParams> (roslisp-msg-protocol:ros-message)
  ((ground_mu_hint
    :reader ground_mu_hint
    :initarg :ground_mu_hint
    :type cl:float
    :initform 0.0)
   (grated_surfaces_mode
    :reader grated_surfaces_mode
    :initarg :grated_surfaces_mode
    :type cl:fixnum
    :initform 0))
)

(cl:defclass TerrainParams (<TerrainParams>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TerrainParams>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TerrainParams)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<TerrainParams> is deprecated: use spot_msgs-msg:TerrainParams instead.")))

(cl:ensure-generic-function 'ground_mu_hint-val :lambda-list '(m))
(cl:defmethod ground_mu_hint-val ((m <TerrainParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:ground_mu_hint-val is deprecated.  Use spot_msgs-msg:ground_mu_hint instead.")
  (ground_mu_hint m))

(cl:ensure-generic-function 'grated_surfaces_mode-val :lambda-list '(m))
(cl:defmethod grated_surfaces_mode-val ((m <TerrainParams>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:grated_surfaces_mode-val is deprecated.  Use spot_msgs-msg:grated_surfaces_mode instead.")
  (grated_surfaces_mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<TerrainParams>)))
    "Constants for message type '<TerrainParams>"
  '((:GRATED_SURFACES_MODE_UNKNOWN . 0)
    (:GRATED_SURFACES_MODE_OFF . 1)
    (:GRATED_SURFACES_MODE_ON . 2)
    (:GRATED_SURFACES_MODE_AUTO . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'TerrainParams)))
    "Constants for message type 'TerrainParams"
  '((:GRATED_SURFACES_MODE_UNKNOWN . 0)
    (:GRATED_SURFACES_MODE_OFF . 1)
    (:GRATED_SURFACES_MODE_ON . 2)
    (:GRATED_SURFACES_MODE_AUTO . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TerrainParams>) ostream)
  "Serializes a message object of type '<TerrainParams>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ground_mu_hint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'grated_surfaces_mode)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TerrainParams>) istream)
  "Deserializes a message object of type '<TerrainParams>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ground_mu_hint) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'grated_surfaces_mode)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TerrainParams>)))
  "Returns string type for a message object of type '<TerrainParams>"
  "spot_msgs/TerrainParams")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TerrainParams)))
  "Returns string type for a message object of type 'TerrainParams"
  "spot_msgs/TerrainParams")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TerrainParams>)))
  "Returns md5sum for a message object of type '<TerrainParams>"
  "58fe7415b44378cf75e03c9f80729c0f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TerrainParams)))
  "Returns md5sum for a message object of type 'TerrainParams"
  "58fe7415b44378cf75e03c9f80729c0f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TerrainParams>)))
  "Returns full string definition for message of type '<TerrainParams>"
  (cl:format cl:nil "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams~%uint8 GRATED_SURFACES_MODE_UNKNOWN=0~%uint8 GRATED_SURFACES_MODE_OFF=1~%uint8 GRATED_SURFACES_MODE_ON=2~%uint8 GRATED_SURFACES_MODE_AUTO=3~%~%float32 ground_mu_hint~%uint8 grated_surfaces_mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TerrainParams)))
  "Returns full string definition for message of type 'TerrainParams"
  (cl:format cl:nil "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams~%uint8 GRATED_SURFACES_MODE_UNKNOWN=0~%uint8 GRATED_SURFACES_MODE_OFF=1~%uint8 GRATED_SURFACES_MODE_ON=2~%uint8 GRATED_SURFACES_MODE_AUTO=3~%~%float32 ground_mu_hint~%uint8 grated_surfaces_mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TerrainParams>))
  (cl:+ 0
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TerrainParams>))
  "Converts a ROS message object to a list"
  (cl:list 'TerrainParams
    (cl:cons ':ground_mu_hint (ground_mu_hint msg))
    (cl:cons ':grated_surfaces_mode (grated_surfaces_mode msg))
))
