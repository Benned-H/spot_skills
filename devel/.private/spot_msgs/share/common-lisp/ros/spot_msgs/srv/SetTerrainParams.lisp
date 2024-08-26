; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude SetTerrainParams-request.msg.html

(cl:defclass <SetTerrainParams-request> (roslisp-msg-protocol:ros-message)
  ((terrain_params
    :reader terrain_params
    :initarg :terrain_params
    :type spot_msgs-msg:TerrainParams
    :initform (cl:make-instance 'spot_msgs-msg:TerrainParams)))
)

(cl:defclass SetTerrainParams-request (<SetTerrainParams-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTerrainParams-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTerrainParams-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetTerrainParams-request> is deprecated: use spot_msgs-srv:SetTerrainParams-request instead.")))

(cl:ensure-generic-function 'terrain_params-val :lambda-list '(m))
(cl:defmethod terrain_params-val ((m <SetTerrainParams-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:terrain_params-val is deprecated.  Use spot_msgs-srv:terrain_params instead.")
  (terrain_params m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTerrainParams-request>) ostream)
  "Serializes a message object of type '<SetTerrainParams-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'terrain_params) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTerrainParams-request>) istream)
  "Deserializes a message object of type '<SetTerrainParams-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'terrain_params) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTerrainParams-request>)))
  "Returns string type for a service object of type '<SetTerrainParams-request>"
  "spot_msgs/SetTerrainParamsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTerrainParams-request)))
  "Returns string type for a service object of type 'SetTerrainParams-request"
  "spot_msgs/SetTerrainParamsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTerrainParams-request>)))
  "Returns md5sum for a message object of type '<SetTerrainParams-request>"
  "7ab3f769faaa7a5562cf1f71a78cd453")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTerrainParams-request)))
  "Returns md5sum for a message object of type 'SetTerrainParams-request"
  "7ab3f769faaa7a5562cf1f71a78cd453")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTerrainParams-request>)))
  "Returns full string definition for message of type '<SetTerrainParams-request>"
  (cl:format cl:nil "spot_msgs/TerrainParams terrain_params~%~%================================================================================~%MSG: spot_msgs/TerrainParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams~%uint8 GRATED_SURFACES_MODE_UNKNOWN=0~%uint8 GRATED_SURFACES_MODE_OFF=1~%uint8 GRATED_SURFACES_MODE_ON=2~%uint8 GRATED_SURFACES_MODE_AUTO=3~%~%float32 ground_mu_hint~%uint8 grated_surfaces_mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTerrainParams-request)))
  "Returns full string definition for message of type 'SetTerrainParams-request"
  (cl:format cl:nil "spot_msgs/TerrainParams terrain_params~%~%================================================================================~%MSG: spot_msgs/TerrainParams~%# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams~%uint8 GRATED_SURFACES_MODE_UNKNOWN=0~%uint8 GRATED_SURFACES_MODE_OFF=1~%uint8 GRATED_SURFACES_MODE_ON=2~%uint8 GRATED_SURFACES_MODE_AUTO=3~%~%float32 ground_mu_hint~%uint8 grated_surfaces_mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTerrainParams-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'terrain_params))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTerrainParams-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTerrainParams-request
    (cl:cons ':terrain_params (terrain_params msg))
))
;//! \htmlinclude SetTerrainParams-response.msg.html

(cl:defclass <SetTerrainParams-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetTerrainParams-response (<SetTerrainParams-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTerrainParams-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTerrainParams-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetTerrainParams-response> is deprecated: use spot_msgs-srv:SetTerrainParams-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetTerrainParams-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetTerrainParams-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTerrainParams-response>) ostream)
  "Serializes a message object of type '<SetTerrainParams-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTerrainParams-response>) istream)
  "Deserializes a message object of type '<SetTerrainParams-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTerrainParams-response>)))
  "Returns string type for a service object of type '<SetTerrainParams-response>"
  "spot_msgs/SetTerrainParamsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTerrainParams-response)))
  "Returns string type for a service object of type 'SetTerrainParams-response"
  "spot_msgs/SetTerrainParamsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTerrainParams-response>)))
  "Returns md5sum for a message object of type '<SetTerrainParams-response>"
  "7ab3f769faaa7a5562cf1f71a78cd453")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTerrainParams-response)))
  "Returns md5sum for a message object of type 'SetTerrainParams-response"
  "7ab3f769faaa7a5562cf1f71a78cd453")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTerrainParams-response>)))
  "Returns full string definition for message of type '<SetTerrainParams-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTerrainParams-response)))
  "Returns full string definition for message of type 'SetTerrainParams-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTerrainParams-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTerrainParams-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTerrainParams-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetTerrainParams)))
  'SetTerrainParams-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetTerrainParams)))
  'SetTerrainParams-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTerrainParams)))
  "Returns string type for a service object of type '<SetTerrainParams>"
  "spot_msgs/SetTerrainParams")