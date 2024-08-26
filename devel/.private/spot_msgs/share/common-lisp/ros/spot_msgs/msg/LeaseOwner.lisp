; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude LeaseOwner.msg.html

(cl:defclass <LeaseOwner> (roslisp-msg-protocol:ros-message)
  ((client_name
    :reader client_name
    :initarg :client_name
    :type cl:string
    :initform "")
   (user_name
    :reader user_name
    :initarg :user_name
    :type cl:string
    :initform ""))
)

(cl:defclass LeaseOwner (<LeaseOwner>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LeaseOwner>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LeaseOwner)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<LeaseOwner> is deprecated: use spot_msgs-msg:LeaseOwner instead.")))

(cl:ensure-generic-function 'client_name-val :lambda-list '(m))
(cl:defmethod client_name-val ((m <LeaseOwner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:client_name-val is deprecated.  Use spot_msgs-msg:client_name instead.")
  (client_name m))

(cl:ensure-generic-function 'user_name-val :lambda-list '(m))
(cl:defmethod user_name-val ((m <LeaseOwner>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:user_name-val is deprecated.  Use spot_msgs-msg:user_name instead.")
  (user_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LeaseOwner>) ostream)
  "Serializes a message object of type '<LeaseOwner>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'client_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'client_name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'user_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'user_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LeaseOwner>) istream)
  "Deserializes a message object of type '<LeaseOwner>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'client_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'client_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'user_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'user_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LeaseOwner>)))
  "Returns string type for a message object of type '<LeaseOwner>"
  "spot_msgs/LeaseOwner")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LeaseOwner)))
  "Returns string type for a message object of type 'LeaseOwner"
  "spot_msgs/LeaseOwner")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LeaseOwner>)))
  "Returns md5sum for a message object of type '<LeaseOwner>"
  "5cea27b2d1a89312b1101c1d985fe078")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LeaseOwner)))
  "Returns md5sum for a message object of type 'LeaseOwner"
  "5cea27b2d1a89312b1101c1d985fe078")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LeaseOwner>)))
  "Returns full string definition for message of type '<LeaseOwner>"
  (cl:format cl:nil "string client_name~%string user_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LeaseOwner)))
  "Returns full string definition for message of type 'LeaseOwner"
  (cl:format cl:nil "string client_name~%string user_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LeaseOwner>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'client_name))
     4 (cl:length (cl:slot-value msg 'user_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LeaseOwner>))
  "Converts a ROS message object to a list"
  (cl:list 'LeaseOwner
    (cl:cons ':client_name (client_name msg))
    (cl:cons ':user_name (user_name msg))
))
