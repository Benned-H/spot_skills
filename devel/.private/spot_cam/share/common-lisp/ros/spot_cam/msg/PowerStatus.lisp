; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude PowerStatus.msg.html

(cl:defclass <PowerStatus> (roslisp-msg-protocol:ros-message)
  ((ptz
    :reader ptz
    :initarg :ptz
    :type cl:fixnum
    :initform 0)
   (aux1
    :reader aux1
    :initarg :aux1
    :type cl:fixnum
    :initform 0)
   (aux2
    :reader aux2
    :initarg :aux2
    :type cl:fixnum
    :initform 0)
   (external_mic
    :reader external_mic
    :initarg :external_mic
    :type cl:fixnum
    :initform 0))
)

(cl:defclass PowerStatus (<PowerStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PowerStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PowerStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<PowerStatus> is deprecated: use spot_cam-msg:PowerStatus instead.")))

(cl:ensure-generic-function 'ptz-val :lambda-list '(m))
(cl:defmethod ptz-val ((m <PowerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:ptz-val is deprecated.  Use spot_cam-msg:ptz instead.")
  (ptz m))

(cl:ensure-generic-function 'aux1-val :lambda-list '(m))
(cl:defmethod aux1-val ((m <PowerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:aux1-val is deprecated.  Use spot_cam-msg:aux1 instead.")
  (aux1 m))

(cl:ensure-generic-function 'aux2-val :lambda-list '(m))
(cl:defmethod aux2-val ((m <PowerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:aux2-val is deprecated.  Use spot_cam-msg:aux2 instead.")
  (aux2 m))

(cl:ensure-generic-function 'external_mic-val :lambda-list '(m))
(cl:defmethod external_mic-val ((m <PowerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:external_mic-val is deprecated.  Use spot_cam-msg:external_mic instead.")
  (external_mic m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<PowerStatus>)))
    "Constants for message type '<PowerStatus>"
  '((:NO_ACTION . 0)
    (:POWER_ON . 1)
    (:POWER_OFF . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'PowerStatus)))
    "Constants for message type 'PowerStatus"
  '((:NO_ACTION . 0)
    (:POWER_ON . 1)
    (:POWER_OFF . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PowerStatus>) ostream)
  "Serializes a message object of type '<PowerStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ptz)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aux1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aux2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'external_mic)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PowerStatus>) istream)
  "Deserializes a message object of type '<PowerStatus>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ptz)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aux1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'aux2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'external_mic)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PowerStatus>)))
  "Returns string type for a message object of type '<PowerStatus>"
  "spot_cam/PowerStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PowerStatus)))
  "Returns string type for a message object of type 'PowerStatus"
  "spot_cam/PowerStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PowerStatus>)))
  "Returns md5sum for a message object of type '<PowerStatus>"
  "cff241b1526dd8ec49e990b4e13bfa92")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PowerStatus)))
  "Returns md5sum for a message object of type 'PowerStatus"
  "cff241b1526dd8ec49e990b4e13bfa92")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PowerStatus>)))
  "Returns full string definition for message of type '<PowerStatus>"
  (cl:format cl:nil "# Use when requesting a change to the power state. Indicates that no action should be taken on that device. This is~%# necessary because the BD API uses a bool to set the power state, where false is off. It would be impossible to know from~%# a bool in a request to change power state whether the user wanted to turn the device off or leave it as it was.~%uint8 NO_ACTION=0~%# Indicates that the power is on, or requests the power to be turned on~%uint8 POWER_ON=1~%# Indicates that the power is off, or requests the power to be turned off~%uint8 POWER_OFF=2~%~%uint8 ptz~%uint8 aux1~%uint8 aux2~%uint8 external_mic~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PowerStatus)))
  "Returns full string definition for message of type 'PowerStatus"
  (cl:format cl:nil "# Use when requesting a change to the power state. Indicates that no action should be taken on that device. This is~%# necessary because the BD API uses a bool to set the power state, where false is off. It would be impossible to know from~%# a bool in a request to change power state whether the user wanted to turn the device off or leave it as it was.~%uint8 NO_ACTION=0~%# Indicates that the power is on, or requests the power to be turned on~%uint8 POWER_ON=1~%# Indicates that the power is off, or requests the power to be turned off~%uint8 POWER_OFF=2~%~%uint8 ptz~%uint8 aux1~%uint8 aux2~%uint8 external_mic~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PowerStatus>))
  (cl:+ 0
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PowerStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'PowerStatus
    (cl:cons ':ptz (ptz msg))
    (cl:cons ':aux1 (aux1 msg))
    (cl:cons ':aux2 (aux2 msg))
    (cl:cons ':external_mic (external_mic msg))
))
