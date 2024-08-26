; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude HandPose-request.msg.html

(cl:defclass <HandPose-request> (roslisp-msg-protocol:ros-message)
  ((duration
    :reader duration
    :initarg :duration
    :type cl:float
    :initform 0.0)
   (frame
    :reader frame
    :initarg :frame
    :type cl:string
    :initform "")
   (pose_point
    :reader pose_point
    :initarg :pose_point
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass HandPose-request (<HandPose-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HandPose-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HandPose-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<HandPose-request> is deprecated: use spot_msgs-srv:HandPose-request instead.")))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <HandPose-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:duration-val is deprecated.  Use spot_msgs-srv:duration instead.")
  (duration m))

(cl:ensure-generic-function 'frame-val :lambda-list '(m))
(cl:defmethod frame-val ((m <HandPose-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:frame-val is deprecated.  Use spot_msgs-srv:frame instead.")
  (frame m))

(cl:ensure-generic-function 'pose_point-val :lambda-list '(m))
(cl:defmethod pose_point-val ((m <HandPose-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:pose_point-val is deprecated.  Use spot_msgs-srv:pose_point instead.")
  (pose_point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HandPose-request>) ostream)
  "Serializes a message object of type '<HandPose-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'duration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose_point) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HandPose-request>) istream)
  "Deserializes a message object of type '<HandPose-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose_point) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HandPose-request>)))
  "Returns string type for a service object of type '<HandPose-request>"
  "spot_msgs/HandPoseRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HandPose-request)))
  "Returns string type for a service object of type 'HandPose-request"
  "spot_msgs/HandPoseRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HandPose-request>)))
  "Returns md5sum for a message object of type '<HandPose-request>"
  "6ebc466d74c88961d9a9d6e671fcb41c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HandPose-request)))
  "Returns md5sum for a message object of type 'HandPose-request"
  "6ebc466d74c88961d9a9d6e671fcb41c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HandPose-request>)))
  "Returns full string definition for message of type '<HandPose-request>"
  (cl:format cl:nil "float64 duration~%string frame~%geometry_msgs/Pose pose_point~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HandPose-request)))
  "Returns full string definition for message of type 'HandPose-request"
  (cl:format cl:nil "float64 duration~%string frame~%geometry_msgs/Pose pose_point~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HandPose-request>))
  (cl:+ 0
     8
     4 (cl:length (cl:slot-value msg 'frame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose_point))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HandPose-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HandPose-request
    (cl:cons ':duration (duration msg))
    (cl:cons ':frame (frame msg))
    (cl:cons ':pose_point (pose_point msg))
))
;//! \htmlinclude HandPose-response.msg.html

(cl:defclass <HandPose-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass HandPose-response (<HandPose-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HandPose-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HandPose-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<HandPose-response> is deprecated: use spot_msgs-srv:HandPose-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <HandPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <HandPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HandPose-response>) ostream)
  "Serializes a message object of type '<HandPose-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HandPose-response>) istream)
  "Deserializes a message object of type '<HandPose-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HandPose-response>)))
  "Returns string type for a service object of type '<HandPose-response>"
  "spot_msgs/HandPoseResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HandPose-response)))
  "Returns string type for a service object of type 'HandPose-response"
  "spot_msgs/HandPoseResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HandPose-response>)))
  "Returns md5sum for a message object of type '<HandPose-response>"
  "6ebc466d74c88961d9a9d6e671fcb41c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HandPose-response)))
  "Returns md5sum for a message object of type 'HandPose-response"
  "6ebc466d74c88961d9a9d6e671fcb41c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HandPose-response>)))
  "Returns full string definition for message of type '<HandPose-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HandPose-response)))
  "Returns full string definition for message of type 'HandPose-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HandPose-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HandPose-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HandPose-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HandPose)))
  'HandPose-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HandPose)))
  'HandPose-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HandPose)))
  "Returns string type for a service object of type '<HandPose>"
  "spot_msgs/HandPose")