; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude GetDockState-request.msg.html

(cl:defclass <GetDockState-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetDockState-request (<GetDockState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDockState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDockState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<GetDockState-request> is deprecated: use spot_msgs-srv:GetDockState-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDockState-request>) ostream)
  "Serializes a message object of type '<GetDockState-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDockState-request>) istream)
  "Deserializes a message object of type '<GetDockState-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDockState-request>)))
  "Returns string type for a service object of type '<GetDockState-request>"
  "spot_msgs/GetDockStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDockState-request)))
  "Returns string type for a service object of type 'GetDockState-request"
  "spot_msgs/GetDockStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDockState-request>)))
  "Returns md5sum for a message object of type '<GetDockState-request>"
  "01a4a21c7545e2e6d9b2173fc84d1af7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDockState-request)))
  "Returns md5sum for a message object of type 'GetDockState-request"
  "01a4a21c7545e2e6d9b2173fc84d1af7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDockState-request>)))
  "Returns full string definition for message of type '<GetDockState-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDockState-request)))
  "Returns full string definition for message of type 'GetDockState-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDockState-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDockState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDockState-request
))
;//! \htmlinclude GetDockState-response.msg.html

(cl:defclass <GetDockState-response> (roslisp-msg-protocol:ros-message)
  ((dock_state
    :reader dock_state
    :initarg :dock_state
    :type spot_msgs-msg:DockState
    :initform (cl:make-instance 'spot_msgs-msg:DockState)))
)

(cl:defclass GetDockState-response (<GetDockState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDockState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDockState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<GetDockState-response> is deprecated: use spot_msgs-srv:GetDockState-response instead.")))

(cl:ensure-generic-function 'dock_state-val :lambda-list '(m))
(cl:defmethod dock_state-val ((m <GetDockState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:dock_state-val is deprecated.  Use spot_msgs-srv:dock_state instead.")
  (dock_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDockState-response>) ostream)
  "Serializes a message object of type '<GetDockState-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'dock_state) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDockState-response>) istream)
  "Deserializes a message object of type '<GetDockState-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'dock_state) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDockState-response>)))
  "Returns string type for a service object of type '<GetDockState-response>"
  "spot_msgs/GetDockStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDockState-response)))
  "Returns string type for a service object of type 'GetDockState-response"
  "spot_msgs/GetDockStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDockState-response>)))
  "Returns md5sum for a message object of type '<GetDockState-response>"
  "01a4a21c7545e2e6d9b2173fc84d1af7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDockState-response)))
  "Returns md5sum for a message object of type 'GetDockState-response"
  "01a4a21c7545e2e6d9b2173fc84d1af7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDockState-response>)))
  "Returns full string definition for message of type '<GetDockState-response>"
  (cl:format cl:nil "DockState dock_state~%~%================================================================================~%MSG: spot_msgs/DockState~%# Status~%uint8 DOCK_STATUS_UNKNOWN = 0~%uint8 DOCK_STATUS_DOCKED = 1~%uint8 DOCK_STATUS_DOCKING = 2~%uint8 DOCK_STATUS_UNDOCKED = 3~%uint8 DOCK_STATUS_UNDOCKING = 4~%~%# DockType~%uint8 DOCK_TYPE_UNKNOWN = 0~%uint8 DOCK_TYPE_CONTACT_PROTOTYPE = 2~%uint8 DOCK_TYPE_SPOT_DOCK = 3~%~%# LinkStatus~%uint8 LINK_STATUS_UNKNOWN = 0~%uint8 LINK_STATUS_CONNECTED = 1~%uint8 LINK_STATUS_ERROR = 2~%uint8 LINK_STATUS_DETECTING = 3~%~%uint8 status~%uint8 dock_type~%uint32 dock_id~%uint8 power_status~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDockState-response)))
  "Returns full string definition for message of type 'GetDockState-response"
  (cl:format cl:nil "DockState dock_state~%~%================================================================================~%MSG: spot_msgs/DockState~%# Status~%uint8 DOCK_STATUS_UNKNOWN = 0~%uint8 DOCK_STATUS_DOCKED = 1~%uint8 DOCK_STATUS_DOCKING = 2~%uint8 DOCK_STATUS_UNDOCKED = 3~%uint8 DOCK_STATUS_UNDOCKING = 4~%~%# DockType~%uint8 DOCK_TYPE_UNKNOWN = 0~%uint8 DOCK_TYPE_CONTACT_PROTOTYPE = 2~%uint8 DOCK_TYPE_SPOT_DOCK = 3~%~%# LinkStatus~%uint8 LINK_STATUS_UNKNOWN = 0~%uint8 LINK_STATUS_CONNECTED = 1~%uint8 LINK_STATUS_ERROR = 2~%uint8 LINK_STATUS_DETECTING = 3~%~%uint8 status~%uint8 dock_type~%uint32 dock_id~%uint8 power_status~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDockState-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'dock_state))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDockState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDockState-response
    (cl:cons ':dock_state (dock_state msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDockState)))
  'GetDockState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDockState)))
  'GetDockState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDockState)))
  "Returns string type for a service object of type '<GetDockState>"
  "spot_msgs/GetDockState")