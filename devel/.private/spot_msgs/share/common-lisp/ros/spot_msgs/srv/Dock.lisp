; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude Dock-request.msg.html

(cl:defclass <Dock-request> (roslisp-msg-protocol:ros-message)
  ((dock_id
    :reader dock_id
    :initarg :dock_id
    :type cl:integer
    :initform 0))
)

(cl:defclass Dock-request (<Dock-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Dock-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Dock-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<Dock-request> is deprecated: use spot_msgs-srv:Dock-request instead.")))

(cl:ensure-generic-function 'dock_id-val :lambda-list '(m))
(cl:defmethod dock_id-val ((m <Dock-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:dock_id-val is deprecated.  Use spot_msgs-srv:dock_id instead.")
  (dock_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Dock-request>) ostream)
  "Serializes a message object of type '<Dock-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'dock_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'dock_id)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Dock-request>) istream)
  "Deserializes a message object of type '<Dock-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'dock_id)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Dock-request>)))
  "Returns string type for a service object of type '<Dock-request>"
  "spot_msgs/DockRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Dock-request)))
  "Returns string type for a service object of type 'Dock-request"
  "spot_msgs/DockRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Dock-request>)))
  "Returns md5sum for a message object of type '<Dock-request>"
  "c1102efdad60fe70c4c44187beb3e1e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Dock-request)))
  "Returns md5sum for a message object of type 'Dock-request"
  "c1102efdad60fe70c4c44187beb3e1e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Dock-request>)))
  "Returns full string definition for message of type '<Dock-request>"
  (cl:format cl:nil "uint32 dock_id # dock fiducials id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Dock-request)))
  "Returns full string definition for message of type 'Dock-request"
  (cl:format cl:nil "uint32 dock_id # dock fiducials id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Dock-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Dock-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Dock-request
    (cl:cons ':dock_id (dock_id msg))
))
;//! \htmlinclude Dock-response.msg.html

(cl:defclass <Dock-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Dock-response (<Dock-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Dock-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Dock-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<Dock-response> is deprecated: use spot_msgs-srv:Dock-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Dock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <Dock-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Dock-response>) ostream)
  "Serializes a message object of type '<Dock-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Dock-response>) istream)
  "Deserializes a message object of type '<Dock-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Dock-response>)))
  "Returns string type for a service object of type '<Dock-response>"
  "spot_msgs/DockResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Dock-response)))
  "Returns string type for a service object of type 'Dock-response"
  "spot_msgs/DockResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Dock-response>)))
  "Returns md5sum for a message object of type '<Dock-response>"
  "c1102efdad60fe70c4c44187beb3e1e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Dock-response)))
  "Returns md5sum for a message object of type 'Dock-response"
  "c1102efdad60fe70c4c44187beb3e1e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Dock-response>)))
  "Returns full string definition for message of type '<Dock-response>"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Dock-response)))
  "Returns full string definition for message of type 'Dock-response"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Dock-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Dock-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Dock-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Dock)))
  'Dock-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Dock)))
  'Dock-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Dock)))
  "Returns string type for a service object of type '<Dock>"
  "spot_msgs/Dock")