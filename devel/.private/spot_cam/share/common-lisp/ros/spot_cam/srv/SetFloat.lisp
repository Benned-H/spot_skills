; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude SetFloat-request.msg.html

(cl:defclass <SetFloat-request> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetFloat-request (<SetFloat-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetFloat-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetFloat-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetFloat-request> is deprecated: use spot_cam-srv:SetFloat-request instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <SetFloat-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:value-val is deprecated.  Use spot_cam-srv:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetFloat-request>) ostream)
  "Serializes a message object of type '<SetFloat-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetFloat-request>) istream)
  "Deserializes a message object of type '<SetFloat-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'value) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetFloat-request>)))
  "Returns string type for a service object of type '<SetFloat-request>"
  "spot_cam/SetFloatRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetFloat-request)))
  "Returns string type for a service object of type 'SetFloat-request"
  "spot_cam/SetFloatRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetFloat-request>)))
  "Returns md5sum for a message object of type '<SetFloat-request>"
  "345a3274594e7cc629d8cd38d3b1fe73")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetFloat-request)))
  "Returns md5sum for a message object of type 'SetFloat-request"
  "345a3274594e7cc629d8cd38d3b1fe73")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetFloat-request>)))
  "Returns full string definition for message of type '<SetFloat-request>"
  (cl:format cl:nil "float32 value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetFloat-request)))
  "Returns full string definition for message of type 'SetFloat-request"
  (cl:format cl:nil "float32 value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetFloat-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetFloat-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetFloat-request
    (cl:cons ':value (value msg))
))
;//! \htmlinclude SetFloat-response.msg.html

(cl:defclass <SetFloat-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetFloat-response (<SetFloat-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetFloat-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetFloat-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetFloat-response> is deprecated: use spot_cam-srv:SetFloat-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetFloat-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetFloat-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetFloat-response>) ostream)
  "Serializes a message object of type '<SetFloat-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetFloat-response>) istream)
  "Deserializes a message object of type '<SetFloat-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetFloat-response>)))
  "Returns string type for a service object of type '<SetFloat-response>"
  "spot_cam/SetFloatResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetFloat-response)))
  "Returns string type for a service object of type 'SetFloat-response"
  "spot_cam/SetFloatResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetFloat-response>)))
  "Returns md5sum for a message object of type '<SetFloat-response>"
  "345a3274594e7cc629d8cd38d3b1fe73")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetFloat-response)))
  "Returns md5sum for a message object of type 'SetFloat-response"
  "345a3274594e7cc629d8cd38d3b1fe73")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetFloat-response>)))
  "Returns full string definition for message of type '<SetFloat-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetFloat-response)))
  "Returns full string definition for message of type 'SetFloat-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetFloat-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetFloat-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetFloat-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetFloat)))
  'SetFloat-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetFloat)))
  'SetFloat-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetFloat)))
  "Returns string type for a service object of type '<SetFloat>"
  "spot_cam/SetFloat")