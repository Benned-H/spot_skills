; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude SetVelocity-request.msg.html

(cl:defclass <SetVelocity-request> (roslisp-msg-protocol:ros-message)
  ((velocity_limit
    :reader velocity_limit
    :initarg :velocity_limit
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist)))
)

(cl:defclass SetVelocity-request (<SetVelocity-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetVelocity-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetVelocity-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetVelocity-request> is deprecated: use spot_msgs-srv:SetVelocity-request instead.")))

(cl:ensure-generic-function 'velocity_limit-val :lambda-list '(m))
(cl:defmethod velocity_limit-val ((m <SetVelocity-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:velocity_limit-val is deprecated.  Use spot_msgs-srv:velocity_limit instead.")
  (velocity_limit m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetVelocity-request>) ostream)
  "Serializes a message object of type '<SetVelocity-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity_limit) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetVelocity-request>) istream)
  "Deserializes a message object of type '<SetVelocity-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity_limit) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetVelocity-request>)))
  "Returns string type for a service object of type '<SetVelocity-request>"
  "spot_msgs/SetVelocityRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetVelocity-request)))
  "Returns string type for a service object of type 'SetVelocity-request"
  "spot_msgs/SetVelocityRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetVelocity-request>)))
  "Returns md5sum for a message object of type '<SetVelocity-request>"
  "b42f41ffa01f8de6dcbf642f589646a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetVelocity-request)))
  "Returns md5sum for a message object of type 'SetVelocity-request"
  "b42f41ffa01f8de6dcbf642f589646a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetVelocity-request>)))
  "Returns full string definition for message of type '<SetVelocity-request>"
  (cl:format cl:nil "# The api only takes into account x and y for linear velocity, and z for angular.~%# Other values are ignored.~%geometry_msgs/Twist velocity_limit~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetVelocity-request)))
  "Returns full string definition for message of type 'SetVelocity-request"
  (cl:format cl:nil "# The api only takes into account x and y for linear velocity, and z for angular.~%# Other values are ignored.~%geometry_msgs/Twist velocity_limit~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetVelocity-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity_limit))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetVelocity-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetVelocity-request
    (cl:cons ':velocity_limit (velocity_limit msg))
))
;//! \htmlinclude SetVelocity-response.msg.html

(cl:defclass <SetVelocity-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetVelocity-response (<SetVelocity-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetVelocity-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetVelocity-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SetVelocity-response> is deprecated: use spot_msgs-srv:SetVelocity-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetVelocity-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetVelocity-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetVelocity-response>) ostream)
  "Serializes a message object of type '<SetVelocity-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetVelocity-response>) istream)
  "Deserializes a message object of type '<SetVelocity-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetVelocity-response>)))
  "Returns string type for a service object of type '<SetVelocity-response>"
  "spot_msgs/SetVelocityResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetVelocity-response)))
  "Returns string type for a service object of type 'SetVelocity-response"
  "spot_msgs/SetVelocityResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetVelocity-response>)))
  "Returns md5sum for a message object of type '<SetVelocity-response>"
  "b42f41ffa01f8de6dcbf642f589646a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetVelocity-response)))
  "Returns md5sum for a message object of type 'SetVelocity-response"
  "b42f41ffa01f8de6dcbf642f589646a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetVelocity-response>)))
  "Returns full string definition for message of type '<SetVelocity-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetVelocity-response)))
  "Returns full string definition for message of type 'SetVelocity-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetVelocity-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetVelocity-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetVelocity-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetVelocity)))
  'SetVelocity-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetVelocity)))
  'SetVelocity-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetVelocity)))
  "Returns string type for a service object of type '<SetVelocity>"
  "spot_msgs/SetVelocity")