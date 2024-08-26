; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude DockState.msg.html

(cl:defclass <DockState> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0)
   (dock_type
    :reader dock_type
    :initarg :dock_type
    :type cl:fixnum
    :initform 0)
   (dock_id
    :reader dock_id
    :initarg :dock_id
    :type cl:integer
    :initform 0)
   (power_status
    :reader power_status
    :initarg :power_status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass DockState (<DockState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DockState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DockState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<DockState> is deprecated: use spot_msgs-msg:DockState instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <DockState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:status-val is deprecated.  Use spot_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'dock_type-val :lambda-list '(m))
(cl:defmethod dock_type-val ((m <DockState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:dock_type-val is deprecated.  Use spot_msgs-msg:dock_type instead.")
  (dock_type m))

(cl:ensure-generic-function 'dock_id-val :lambda-list '(m))
(cl:defmethod dock_id-val ((m <DockState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:dock_id-val is deprecated.  Use spot_msgs-msg:dock_id instead.")
  (dock_id m))

(cl:ensure-generic-function 'power_status-val :lambda-list '(m))
(cl:defmethod power_status-val ((m <DockState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:power_status-val is deprecated.  Use spot_msgs-msg:power_status instead.")
  (power_status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<DockState>)))
    "Constants for message type '<DockState>"
  '((:DOCK_STATUS_UNKNOWN . 0)
    (:DOCK_STATUS_DOCKED . 1)
    (:DOCK_STATUS_DOCKING . 2)
    (:DOCK_STATUS_UNDOCKED . 3)
    (:DOCK_STATUS_UNDOCKING . 4)
    (:DOCK_TYPE_UNKNOWN . 0)
    (:DOCK_TYPE_CONTACT_PROTOTYPE . 2)
    (:DOCK_TYPE_SPOT_DOCK . 3)
    (:LINK_STATUS_UNKNOWN . 0)
    (:LINK_STATUS_CONNECTED . 1)
    (:LINK_STATUS_ERROR . 2)
    (:LINK_STATUS_DETECTING . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'DockState)))
    "Constants for message type 'DockState"
  '((:DOCK_STATUS_UNKNOWN . 0)
    (:DOCK_STATUS_DOCKED . 1)
    (:DOCK_STATUS_DOCKING . 2)
    (:DOCK_STATUS_UNDOCKED . 3)
    (:DOCK_STATUS_UNDOCKING . 4)
    (:DOCK_TYPE_UNKNOWN . 0)
    (:DOCK_TYPE_CONTACT_PROTOTYPE . 2)
    (:DOCK_TYPE_SPOT_DOCK . 3)
    (:LINK_STATUS_UNKNOWN . 0)
    (:LINK_STATUS_CONNECTED . 1)
    (:LINK_STATUS_ERROR . 2)
    (:LINK_STATUS_DETECTING . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DockState>) ostream)
  "Serializes a message object of type '<DockState>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'power_status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DockState>) istream)
  "Deserializes a message object of type '<DockState>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'power_status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DockState>)))
  "Returns string type for a message object of type '<DockState>"
  "spot_msgs/DockState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DockState)))
  "Returns string type for a message object of type 'DockState"
  "spot_msgs/DockState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DockState>)))
  "Returns md5sum for a message object of type '<DockState>"
  "a5cf6a3afaa5e6b3ccda4170a976059d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DockState)))
  "Returns md5sum for a message object of type 'DockState"
  "a5cf6a3afaa5e6b3ccda4170a976059d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DockState>)))
  "Returns full string definition for message of type '<DockState>"
  (cl:format cl:nil "# Status~%uint8 DOCK_STATUS_UNKNOWN = 0~%uint8 DOCK_STATUS_DOCKED = 1~%uint8 DOCK_STATUS_DOCKING = 2~%uint8 DOCK_STATUS_UNDOCKED = 3~%uint8 DOCK_STATUS_UNDOCKING = 4~%~%# DockType~%uint8 DOCK_TYPE_UNKNOWN = 0~%uint8 DOCK_TYPE_CONTACT_PROTOTYPE = 2~%uint8 DOCK_TYPE_SPOT_DOCK = 3~%~%# LinkStatus~%uint8 LINK_STATUS_UNKNOWN = 0~%uint8 LINK_STATUS_CONNECTED = 1~%uint8 LINK_STATUS_ERROR = 2~%uint8 LINK_STATUS_DETECTING = 3~%~%uint8 status~%uint8 dock_type~%uint32 dock_id~%uint8 power_status~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DockState)))
  "Returns full string definition for message of type 'DockState"
  (cl:format cl:nil "# Status~%uint8 DOCK_STATUS_UNKNOWN = 0~%uint8 DOCK_STATUS_DOCKED = 1~%uint8 DOCK_STATUS_DOCKING = 2~%uint8 DOCK_STATUS_UNDOCKED = 3~%uint8 DOCK_STATUS_UNDOCKING = 4~%~%# DockType~%uint8 DOCK_TYPE_UNKNOWN = 0~%uint8 DOCK_TYPE_CONTACT_PROTOTYPE = 2~%uint8 DOCK_TYPE_SPOT_DOCK = 3~%~%# LinkStatus~%uint8 LINK_STATUS_UNKNOWN = 0~%uint8 LINK_STATUS_CONNECTED = 1~%uint8 LINK_STATUS_ERROR = 2~%uint8 LINK_STATUS_DETECTING = 3~%~%uint8 status~%uint8 dock_type~%uint32 dock_id~%uint8 power_status~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DockState>))
  (cl:+ 0
     1
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DockState>))
  "Converts a ROS message object to a list"
  (cl:list 'DockState
    (cl:cons ':status (status msg))
    (cl:cons ':dock_type (dock_type msg))
    (cl:cons ':dock_id (dock_id msg))
    (cl:cons ':power_status (power_status msg))
))
