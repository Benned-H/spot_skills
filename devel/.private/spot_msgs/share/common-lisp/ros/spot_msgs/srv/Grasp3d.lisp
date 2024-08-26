; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude Grasp3d-request.msg.html

(cl:defclass <Grasp3d-request> (roslisp-msg-protocol:ros-message)
  ((frame_name
    :reader frame_name
    :initarg :frame_name
    :type cl:string
    :initform "")
   (object_rt_frame
    :reader object_rt_frame
    :initarg :object_rt_frame
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass Grasp3d-request (<Grasp3d-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Grasp3d-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Grasp3d-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<Grasp3d-request> is deprecated: use spot_msgs-srv:Grasp3d-request instead.")))

(cl:ensure-generic-function 'frame_name-val :lambda-list '(m))
(cl:defmethod frame_name-val ((m <Grasp3d-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:frame_name-val is deprecated.  Use spot_msgs-srv:frame_name instead.")
  (frame_name m))

(cl:ensure-generic-function 'object_rt_frame-val :lambda-list '(m))
(cl:defmethod object_rt_frame-val ((m <Grasp3d-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:object_rt_frame-val is deprecated.  Use spot_msgs-srv:object_rt_frame instead.")
  (object_rt_frame m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Grasp3d-request>) ostream)
  "Serializes a message object of type '<Grasp3d-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'object_rt_frame))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Grasp3d-request>) istream)
  "Deserializes a message object of type '<Grasp3d-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:setf (cl:slot-value msg 'object_rt_frame) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'object_rt_frame)))
    (cl:dotimes (i 3)
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Grasp3d-request>)))
  "Returns string type for a service object of type '<Grasp3d-request>"
  "spot_msgs/Grasp3dRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Grasp3d-request)))
  "Returns string type for a service object of type 'Grasp3d-request"
  "spot_msgs/Grasp3dRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Grasp3d-request>)))
  "Returns md5sum for a message object of type '<Grasp3d-request>"
  "7cdad498436e31571e25a54239d53a58")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Grasp3d-request)))
  "Returns md5sum for a message object of type 'Grasp3d-request"
  "7cdad498436e31571e25a54239d53a58")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Grasp3d-request>)))
  "Returns full string definition for message of type '<Grasp3d-request>"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#pickobject~%string frame_name # name of the tf frame~%float64[3] object_rt_frame # x,y,z of the object in the frame named above~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Grasp3d-request)))
  "Returns full string definition for message of type 'Grasp3d-request"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#pickobject~%string frame_name # name of the tf frame~%float64[3] object_rt_frame # x,y,z of the object in the frame named above~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Grasp3d-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'frame_name))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'object_rt_frame) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Grasp3d-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Grasp3d-request
    (cl:cons ':frame_name (frame_name msg))
    (cl:cons ':object_rt_frame (object_rt_frame msg))
))
;//! \htmlinclude Grasp3d-response.msg.html

(cl:defclass <Grasp3d-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Grasp3d-response (<Grasp3d-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Grasp3d-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Grasp3d-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<Grasp3d-response> is deprecated: use spot_msgs-srv:Grasp3d-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Grasp3d-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <Grasp3d-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Grasp3d-response>) ostream)
  "Serializes a message object of type '<Grasp3d-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Grasp3d-response>) istream)
  "Deserializes a message object of type '<Grasp3d-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Grasp3d-response>)))
  "Returns string type for a service object of type '<Grasp3d-response>"
  "spot_msgs/Grasp3dResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Grasp3d-response)))
  "Returns string type for a service object of type 'Grasp3d-response"
  "spot_msgs/Grasp3dResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Grasp3d-response>)))
  "Returns md5sum for a message object of type '<Grasp3d-response>"
  "7cdad498436e31571e25a54239d53a58")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Grasp3d-response)))
  "Returns md5sum for a message object of type 'Grasp3d-response"
  "7cdad498436e31571e25a54239d53a58")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Grasp3d-response>)))
  "Returns full string definition for message of type '<Grasp3d-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Grasp3d-response)))
  "Returns full string definition for message of type 'Grasp3d-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Grasp3d-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Grasp3d-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Grasp3d-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Grasp3d)))
  'Grasp3d-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Grasp3d)))
  'Grasp3d-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Grasp3d)))
  "Returns string type for a service object of type '<Grasp3d>"
  "spot_msgs/Grasp3d")