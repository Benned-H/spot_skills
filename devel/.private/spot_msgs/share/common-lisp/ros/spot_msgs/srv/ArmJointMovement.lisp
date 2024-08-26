; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude ArmJointMovement-request.msg.html

(cl:defclass <ArmJointMovement-request> (roslisp-msg-protocol:ros-message)
  ((joint_target
    :reader joint_target
    :initarg :joint_target
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass ArmJointMovement-request (<ArmJointMovement-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ArmJointMovement-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ArmJointMovement-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ArmJointMovement-request> is deprecated: use spot_msgs-srv:ArmJointMovement-request instead.")))

(cl:ensure-generic-function 'joint_target-val :lambda-list '(m))
(cl:defmethod joint_target-val ((m <ArmJointMovement-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:joint_target-val is deprecated.  Use spot_msgs-srv:joint_target instead.")
  (joint_target m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ArmJointMovement-request>) ostream)
  "Serializes a message object of type '<ArmJointMovement-request>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'joint_target))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ArmJointMovement-request>) istream)
  "Deserializes a message object of type '<ArmJointMovement-request>"
  (cl:setf (cl:slot-value msg 'joint_target) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'joint_target)))
    (cl:dotimes (i 6)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ArmJointMovement-request>)))
  "Returns string type for a service object of type '<ArmJointMovement-request>"
  "spot_msgs/ArmJointMovementRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmJointMovement-request)))
  "Returns string type for a service object of type 'ArmJointMovement-request"
  "spot_msgs/ArmJointMovementRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ArmJointMovement-request>)))
  "Returns md5sum for a message object of type '<ArmJointMovement-request>"
  "d47819994e77542a6388625321902fe1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ArmJointMovement-request)))
  "Returns md5sum for a message object of type 'ArmJointMovement-request"
  "d47819994e77542a6388625321902fe1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ArmJointMovement-request>)))
  "Returns full string definition for message of type '<ArmJointMovement-request>"
  (cl:format cl:nil "float64[6] joint_target~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ArmJointMovement-request)))
  "Returns full string definition for message of type 'ArmJointMovement-request"
  (cl:format cl:nil "float64[6] joint_target~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ArmJointMovement-request>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'joint_target) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ArmJointMovement-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ArmJointMovement-request
    (cl:cons ':joint_target (joint_target msg))
))
;//! \htmlinclude ArmJointMovement-response.msg.html

(cl:defclass <ArmJointMovement-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass ArmJointMovement-response (<ArmJointMovement-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ArmJointMovement-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ArmJointMovement-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ArmJointMovement-response> is deprecated: use spot_msgs-srv:ArmJointMovement-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ArmJointMovement-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <ArmJointMovement-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ArmJointMovement-response>) ostream)
  "Serializes a message object of type '<ArmJointMovement-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ArmJointMovement-response>) istream)
  "Deserializes a message object of type '<ArmJointMovement-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ArmJointMovement-response>)))
  "Returns string type for a service object of type '<ArmJointMovement-response>"
  "spot_msgs/ArmJointMovementResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmJointMovement-response)))
  "Returns string type for a service object of type 'ArmJointMovement-response"
  "spot_msgs/ArmJointMovementResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ArmJointMovement-response>)))
  "Returns md5sum for a message object of type '<ArmJointMovement-response>"
  "d47819994e77542a6388625321902fe1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ArmJointMovement-response)))
  "Returns md5sum for a message object of type 'ArmJointMovement-response"
  "d47819994e77542a6388625321902fe1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ArmJointMovement-response>)))
  "Returns full string definition for message of type '<ArmJointMovement-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ArmJointMovement-response)))
  "Returns full string definition for message of type 'ArmJointMovement-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ArmJointMovement-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ArmJointMovement-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ArmJointMovement-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ArmJointMovement)))
  'ArmJointMovement-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ArmJointMovement)))
  'ArmJointMovement-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmJointMovement)))
  "Returns string type for a service object of type '<ArmJointMovement>"
  "spot_msgs/ArmJointMovement")