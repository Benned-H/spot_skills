; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude SetSwingHeight-request.msg.html

(cl:defclass <SetSwingHeight-request> (roslisp-msg-protocol:ros-message)
  ((swing_height
    :reader swing_height
    :initarg :swing_height
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SetSwingHeight-request (<SetSwingHeight-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetSwingHeight-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetSwingHeight-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetSwingHeight-request> is deprecated: use spot_msgs-srv:SetSwingHeight-request instead.")))

(cl:ensure-generic-function 'swing_height-val :lambda-list '(m))
(cl:defmethod swing_height-val ((m <SetSwingHeight-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:swing_height-val is deprecated.  Use spot_msgs-srv:swing_height instead.")
  (swing_height m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SetSwingHeight-request>)))
    "Constants for message type '<SetSwingHeight-request>"
  '((:SWING_HEIGHT_UNKNOWN . 0)
    (:SWING_HEIGHT_LOW . 1)
    (:SWING_HEIGHT_MEDIUM . 2)
    (:SWING_HEIGHT_HIGH . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SetSwingHeight-request)))
    "Constants for message type 'SetSwingHeight-request"
  '((:SWING_HEIGHT_UNKNOWN . 0)
    (:SWING_HEIGHT_LOW . 1)
    (:SWING_HEIGHT_MEDIUM . 2)
    (:SWING_HEIGHT_HIGH . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetSwingHeight-request>) ostream)
  "Serializes a message object of type '<SetSwingHeight-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swing_height)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetSwingHeight-request>) istream)
  "Deserializes a message object of type '<SetSwingHeight-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swing_height)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetSwingHeight-request>)))
  "Returns string type for a service object of type '<SetSwingHeight-request>"
  "spot_msgs/SetSwingHeightRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetSwingHeight-request)))
  "Returns string type for a service object of type 'SetSwingHeight-request"
  "spot_msgs/SetSwingHeightRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetSwingHeight-request>)))
  "Returns md5sum for a message object of type '<SetSwingHeight-request>"
  "27a6a29042cae7012a31b7fb7aa42680")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetSwingHeight-request)))
  "Returns md5sum for a message object of type 'SetSwingHeight-request"
  "27a6a29042cae7012a31b7fb7aa42680")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetSwingHeight-request>)))
  "Returns full string definition for message of type '<SetSwingHeight-request>"
  (cl:format cl:nil "#see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#swingheight~%uint8 SWING_HEIGHT_UNKNOWN=0~%uint8 SWING_HEIGHT_LOW=1~%uint8 SWING_HEIGHT_MEDIUM=2~%uint8 SWING_HEIGHT_HIGH=3~%~%uint8 swing_height~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetSwingHeight-request)))
  "Returns full string definition for message of type 'SetSwingHeight-request"
  (cl:format cl:nil "#see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#swingheight~%uint8 SWING_HEIGHT_UNKNOWN=0~%uint8 SWING_HEIGHT_LOW=1~%uint8 SWING_HEIGHT_MEDIUM=2~%uint8 SWING_HEIGHT_HIGH=3~%~%uint8 swing_height~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetSwingHeight-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetSwingHeight-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetSwingHeight-request
    (cl:cons ':swing_height (swing_height msg))
))
;//! \htmlinclude SetSwingHeight-response.msg.html

(cl:defclass <SetSwingHeight-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetSwingHeight-response (<SetSwingHeight-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetSwingHeight-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetSwingHeight-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetSwingHeight-response> is deprecated: use spot_msgs-srv:SetSwingHeight-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetSwingHeight-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetSwingHeight-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetSwingHeight-response>) ostream)
  "Serializes a message object of type '<SetSwingHeight-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetSwingHeight-response>) istream)
  "Deserializes a message object of type '<SetSwingHeight-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetSwingHeight-response>)))
  "Returns string type for a service object of type '<SetSwingHeight-response>"
  "spot_msgs/SetSwingHeightResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetSwingHeight-response)))
  "Returns string type for a service object of type 'SetSwingHeight-response"
  "spot_msgs/SetSwingHeightResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetSwingHeight-response>)))
  "Returns md5sum for a message object of type '<SetSwingHeight-response>"
  "27a6a29042cae7012a31b7fb7aa42680")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetSwingHeight-response)))
  "Returns md5sum for a message object of type 'SetSwingHeight-response"
  "27a6a29042cae7012a31b7fb7aa42680")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetSwingHeight-response>)))
  "Returns full string definition for message of type '<SetSwingHeight-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetSwingHeight-response)))
  "Returns full string definition for message of type 'SetSwingHeight-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetSwingHeight-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetSwingHeight-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetSwingHeight-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetSwingHeight)))
  'SetSwingHeight-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetSwingHeight)))
  'SetSwingHeight-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetSwingHeight)))
  "Returns string type for a service object of type '<SetSwingHeight>"
  "spot_msgs/SetSwingHeight")