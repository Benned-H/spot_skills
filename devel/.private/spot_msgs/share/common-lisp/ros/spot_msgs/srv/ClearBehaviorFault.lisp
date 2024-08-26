; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude ClearBehaviorFault-request.msg.html

(cl:defclass <ClearBehaviorFault-request> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0))
)

(cl:defclass ClearBehaviorFault-request (<ClearBehaviorFault-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearBehaviorFault-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearBehaviorFault-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ClearBehaviorFault-request> is deprecated: use spot_msgs-srv:ClearBehaviorFault-request instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ClearBehaviorFault-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:id-val is deprecated.  Use spot_msgs-srv:id instead.")
  (id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearBehaviorFault-request>) ostream)
  "Serializes a message object of type '<ClearBehaviorFault-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearBehaviorFault-request>) istream)
  "Deserializes a message object of type '<ClearBehaviorFault-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearBehaviorFault-request>)))
  "Returns string type for a service object of type '<ClearBehaviorFault-request>"
  "spot_msgs/ClearBehaviorFaultRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearBehaviorFault-request)))
  "Returns string type for a service object of type 'ClearBehaviorFault-request"
  "spot_msgs/ClearBehaviorFaultRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearBehaviorFault-request>)))
  "Returns md5sum for a message object of type '<ClearBehaviorFault-request>"
  "7cc61c4cb728bc0f5321bac4af610a6e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearBehaviorFault-request)))
  "Returns md5sum for a message object of type 'ClearBehaviorFault-request"
  "7cc61c4cb728bc0f5321bac4af610a6e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearBehaviorFault-request>)))
  "Returns full string definition for message of type '<ClearBehaviorFault-request>"
  (cl:format cl:nil "uint32 id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearBehaviorFault-request)))
  "Returns full string definition for message of type 'ClearBehaviorFault-request"
  (cl:format cl:nil "uint32 id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearBehaviorFault-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearBehaviorFault-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearBehaviorFault-request
    (cl:cons ':id (id msg))
))
;//! \htmlinclude ClearBehaviorFault-response.msg.html

(cl:defclass <ClearBehaviorFault-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass ClearBehaviorFault-response (<ClearBehaviorFault-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearBehaviorFault-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearBehaviorFault-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ClearBehaviorFault-response> is deprecated: use spot_msgs-srv:ClearBehaviorFault-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ClearBehaviorFault-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <ClearBehaviorFault-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearBehaviorFault-response>) ostream)
  "Serializes a message object of type '<ClearBehaviorFault-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearBehaviorFault-response>) istream)
  "Deserializes a message object of type '<ClearBehaviorFault-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearBehaviorFault-response>)))
  "Returns string type for a service object of type '<ClearBehaviorFault-response>"
  "spot_msgs/ClearBehaviorFaultResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearBehaviorFault-response)))
  "Returns string type for a service object of type 'ClearBehaviorFault-response"
  "spot_msgs/ClearBehaviorFaultResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearBehaviorFault-response>)))
  "Returns md5sum for a message object of type '<ClearBehaviorFault-response>"
  "7cc61c4cb728bc0f5321bac4af610a6e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearBehaviorFault-response)))
  "Returns md5sum for a message object of type 'ClearBehaviorFault-response"
  "7cc61c4cb728bc0f5321bac4af610a6e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearBehaviorFault-response>)))
  "Returns full string definition for message of type '<ClearBehaviorFault-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearBehaviorFault-response)))
  "Returns full string definition for message of type 'ClearBehaviorFault-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearBehaviorFault-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearBehaviorFault-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearBehaviorFault-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ClearBehaviorFault)))
  'ClearBehaviorFault-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ClearBehaviorFault)))
  'ClearBehaviorFault-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearBehaviorFault)))
  "Returns string type for a service object of type '<ClearBehaviorFault>"
  "spot_msgs/ClearBehaviorFault")