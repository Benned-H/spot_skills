; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude LeaseResource.msg.html

(cl:defclass <LeaseResource> (roslisp-msg-protocol:ros-message)
  ((resource
    :reader resource
    :initarg :resource
    :type cl:string
    :initform "")
   (lease
    :reader lease
    :initarg :lease
    :type spot_msgs-msg:Lease
    :initform (cl:make-instance 'spot_msgs-msg:Lease))
   (lease_owner
    :reader lease_owner
    :initarg :lease_owner
    :type spot_msgs-msg:LeaseOwner
    :initform (cl:make-instance 'spot_msgs-msg:LeaseOwner)))
)

(cl:defclass LeaseResource (<LeaseResource>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LeaseResource>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LeaseResource)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<LeaseResource> is deprecated: use spot_msgs-msg:LeaseResource instead.")))

(cl:ensure-generic-function 'resource-val :lambda-list '(m))
(cl:defmethod resource-val ((m <LeaseResource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:resource-val is deprecated.  Use spot_msgs-msg:resource instead.")
  (resource m))

(cl:ensure-generic-function 'lease-val :lambda-list '(m))
(cl:defmethod lease-val ((m <LeaseResource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:lease-val is deprecated.  Use spot_msgs-msg:lease instead.")
  (lease m))

(cl:ensure-generic-function 'lease_owner-val :lambda-list '(m))
(cl:defmethod lease_owner-val ((m <LeaseResource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:lease_owner-val is deprecated.  Use spot_msgs-msg:lease_owner instead.")
  (lease_owner m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LeaseResource>) ostream)
  "Serializes a message object of type '<LeaseResource>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'resource))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'resource))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lease) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lease_owner) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LeaseResource>) istream)
  "Deserializes a message object of type '<LeaseResource>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'resource) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'resource) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lease) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lease_owner) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LeaseResource>)))
  "Returns string type for a message object of type '<LeaseResource>"
  "spot_msgs/LeaseResource")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LeaseResource)))
  "Returns string type for a message object of type 'LeaseResource"
  "spot_msgs/LeaseResource")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LeaseResource>)))
  "Returns md5sum for a message object of type '<LeaseResource>"
  "e2b2b151bf21111e26403b0a4feba023")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LeaseResource)))
  "Returns md5sum for a message object of type 'LeaseResource"
  "e2b2b151bf21111e26403b0a4feba023")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LeaseResource>)))
  "Returns full string definition for message of type '<LeaseResource>"
  (cl:format cl:nil "string resource~%Lease lease~%LeaseOwner lease_owner~%~%================================================================================~%MSG: spot_msgs/Lease~%string resource~%string epoch~%uint32[] sequence~%~%================================================================================~%MSG: spot_msgs/LeaseOwner~%string client_name~%string user_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LeaseResource)))
  "Returns full string definition for message of type 'LeaseResource"
  (cl:format cl:nil "string resource~%Lease lease~%LeaseOwner lease_owner~%~%================================================================================~%MSG: spot_msgs/Lease~%string resource~%string epoch~%uint32[] sequence~%~%================================================================================~%MSG: spot_msgs/LeaseOwner~%string client_name~%string user_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LeaseResource>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'resource))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lease))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lease_owner))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LeaseResource>))
  "Converts a ROS message object to a list"
  (cl:list 'LeaseResource
    (cl:cons ':resource (resource msg))
    (cl:cons ':lease (lease msg))
    (cl:cons ':lease_owner (lease_owner msg))
))
