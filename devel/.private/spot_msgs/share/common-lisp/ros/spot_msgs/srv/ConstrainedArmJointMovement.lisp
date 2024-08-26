; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude ConstrainedArmJointMovement-request.msg.html

(cl:defclass <ConstrainedArmJointMovement-request> (roslisp-msg-protocol:ros-message)
  ((joint_target
    :reader joint_target
    :initarg :joint_target
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (max_execution_time
    :reader max_execution_time
    :initarg :max_execution_time
    :type cl:float
    :initform 0.0)
   (max_velocity
    :reader max_velocity
    :initarg :max_velocity
    :type cl:float
    :initform 0.0)
   (max_acceleration
    :reader max_acceleration
    :initarg :max_acceleration
    :type cl:float
    :initform 0.0))
)

(cl:defclass ConstrainedArmJointMovement-request (<ConstrainedArmJointMovement-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ConstrainedArmJointMovement-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ConstrainedArmJointMovement-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ConstrainedArmJointMovement-request> is deprecated: use spot_msgs-srv:ConstrainedArmJointMovement-request instead.")))

(cl:ensure-generic-function 'joint_target-val :lambda-list '(m))
(cl:defmethod joint_target-val ((m <ConstrainedArmJointMovement-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:joint_target-val is deprecated.  Use spot_msgs-srv:joint_target instead.")
  (joint_target m))

(cl:ensure-generic-function 'max_execution_time-val :lambda-list '(m))
(cl:defmethod max_execution_time-val ((m <ConstrainedArmJointMovement-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:max_execution_time-val is deprecated.  Use spot_msgs-srv:max_execution_time instead.")
  (max_execution_time m))

(cl:ensure-generic-function 'max_velocity-val :lambda-list '(m))
(cl:defmethod max_velocity-val ((m <ConstrainedArmJointMovement-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:max_velocity-val is deprecated.  Use spot_msgs-srv:max_velocity instead.")
  (max_velocity m))

(cl:ensure-generic-function 'max_acceleration-val :lambda-list '(m))
(cl:defmethod max_acceleration-val ((m <ConstrainedArmJointMovement-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:max_acceleration-val is deprecated.  Use spot_msgs-srv:max_acceleration instead.")
  (max_acceleration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ConstrainedArmJointMovement-request>) ostream)
  "Serializes a message object of type '<ConstrainedArmJointMovement-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'joint_target))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
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
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'max_execution_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'max_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'max_acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ConstrainedArmJointMovement-request>) istream)
  "Deserializes a message object of type '<ConstrainedArmJointMovement-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'joint_target) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'joint_target)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max_execution_time) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max_velocity) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max_acceleration) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ConstrainedArmJointMovement-request>)))
  "Returns string type for a service object of type '<ConstrainedArmJointMovement-request>"
  "spot_msgs/ConstrainedArmJointMovementRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ConstrainedArmJointMovement-request)))
  "Returns string type for a service object of type 'ConstrainedArmJointMovement-request"
  "spot_msgs/ConstrainedArmJointMovementRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ConstrainedArmJointMovement-request>)))
  "Returns md5sum for a message object of type '<ConstrainedArmJointMovement-request>"
  "9e4ce278a819d084143e339b61079523")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ConstrainedArmJointMovement-request)))
  "Returns md5sum for a message object of type 'ConstrainedArmJointMovement-request"
  "9e4ce278a819d084143e339b61079523")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ConstrainedArmJointMovement-request>)))
  "Returns full string definition for message of type '<ConstrainedArmJointMovement-request>"
  (cl:format cl:nil "float64[] joint_target~%float64 max_execution_time~%float64 max_velocity~%float64 max_acceleration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ConstrainedArmJointMovement-request)))
  "Returns full string definition for message of type 'ConstrainedArmJointMovement-request"
  (cl:format cl:nil "float64[] joint_target~%float64 max_execution_time~%float64 max_velocity~%float64 max_acceleration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ConstrainedArmJointMovement-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'joint_target) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ConstrainedArmJointMovement-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ConstrainedArmJointMovement-request
    (cl:cons ':joint_target (joint_target msg))
    (cl:cons ':max_execution_time (max_execution_time msg))
    (cl:cons ':max_velocity (max_velocity msg))
    (cl:cons ':max_acceleration (max_acceleration msg))
))
;//! \htmlinclude ConstrainedArmJointMovement-response.msg.html

(cl:defclass <ConstrainedArmJointMovement-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass ConstrainedArmJointMovement-response (<ConstrainedArmJointMovement-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ConstrainedArmJointMovement-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ConstrainedArmJointMovement-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ConstrainedArmJointMovement-response> is deprecated: use spot_msgs-srv:ConstrainedArmJointMovement-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ConstrainedArmJointMovement-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <ConstrainedArmJointMovement-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ConstrainedArmJointMovement-response>) ostream)
  "Serializes a message object of type '<ConstrainedArmJointMovement-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ConstrainedArmJointMovement-response>) istream)
  "Deserializes a message object of type '<ConstrainedArmJointMovement-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ConstrainedArmJointMovement-response>)))
  "Returns string type for a service object of type '<ConstrainedArmJointMovement-response>"
  "spot_msgs/ConstrainedArmJointMovementResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ConstrainedArmJointMovement-response)))
  "Returns string type for a service object of type 'ConstrainedArmJointMovement-response"
  "spot_msgs/ConstrainedArmJointMovementResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ConstrainedArmJointMovement-response>)))
  "Returns md5sum for a message object of type '<ConstrainedArmJointMovement-response>"
  "9e4ce278a819d084143e339b61079523")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ConstrainedArmJointMovement-response)))
  "Returns md5sum for a message object of type 'ConstrainedArmJointMovement-response"
  "9e4ce278a819d084143e339b61079523")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ConstrainedArmJointMovement-response>)))
  "Returns full string definition for message of type '<ConstrainedArmJointMovement-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ConstrainedArmJointMovement-response)))
  "Returns full string definition for message of type 'ConstrainedArmJointMovement-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ConstrainedArmJointMovement-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ConstrainedArmJointMovement-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ConstrainedArmJointMovement-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ConstrainedArmJointMovement)))
  'ConstrainedArmJointMovement-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ConstrainedArmJointMovement)))
  'ConstrainedArmJointMovement-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ConstrainedArmJointMovement)))
  "Returns string type for a service object of type '<ConstrainedArmJointMovement>"
  "spot_msgs/ConstrainedArmJointMovement")