; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude PlaySound-request.msg.html

(cl:defclass <PlaySound-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (gain
    :reader gain
    :initarg :gain
    :type cl:float
    :initform 0.0))
)

(cl:defclass PlaySound-request (<PlaySound-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlaySound-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlaySound-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<PlaySound-request> is deprecated: use spot_cam-srv:PlaySound-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <PlaySound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:name-val is deprecated.  Use spot_cam-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'gain-val :lambda-list '(m))
(cl:defmethod gain-val ((m <PlaySound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:gain-val is deprecated.  Use spot_cam-srv:gain instead.")
  (gain m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlaySound-request>) ostream)
  "Serializes a message object of type '<PlaySound-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gain))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlaySound-request>) istream)
  "Deserializes a message object of type '<PlaySound-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gain) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlaySound-request>)))
  "Returns string type for a service object of type '<PlaySound-request>"
  "spot_cam/PlaySoundRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlaySound-request)))
  "Returns string type for a service object of type 'PlaySound-request"
  "spot_cam/PlaySoundRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlaySound-request>)))
  "Returns md5sum for a message object of type '<PlaySound-request>"
  "2fa7527a0fde73dd5206e9498d885ad7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlaySound-request)))
  "Returns md5sum for a message object of type 'PlaySound-request"
  "2fa7527a0fde73dd5206e9498d885ad7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlaySound-request>)))
  "Returns full string definition for message of type '<PlaySound-request>"
  (cl:format cl:nil "# Name of the sound to play~%string name~%# Multiplier on the sound volume~%float32 gain~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlaySound-request)))
  "Returns full string definition for message of type 'PlaySound-request"
  (cl:format cl:nil "# Name of the sound to play~%string name~%# Multiplier on the sound volume~%float32 gain~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlaySound-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlaySound-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PlaySound-request
    (cl:cons ':name (name msg))
    (cl:cons ':gain (gain msg))
))
;//! \htmlinclude PlaySound-response.msg.html

(cl:defclass <PlaySound-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass PlaySound-response (<PlaySound-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlaySound-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlaySound-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<PlaySound-response> is deprecated: use spot_cam-srv:PlaySound-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <PlaySound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <PlaySound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlaySound-response>) ostream)
  "Serializes a message object of type '<PlaySound-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlaySound-response>) istream)
  "Deserializes a message object of type '<PlaySound-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlaySound-response>)))
  "Returns string type for a service object of type '<PlaySound-response>"
  "spot_cam/PlaySoundResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlaySound-response)))
  "Returns string type for a service object of type 'PlaySound-response"
  "spot_cam/PlaySoundResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlaySound-response>)))
  "Returns md5sum for a message object of type '<PlaySound-response>"
  "2fa7527a0fde73dd5206e9498d885ad7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlaySound-response)))
  "Returns md5sum for a message object of type 'PlaySound-response"
  "2fa7527a0fde73dd5206e9498d885ad7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlaySound-response>)))
  "Returns full string definition for message of type '<PlaySound-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlaySound-response)))
  "Returns full string definition for message of type 'PlaySound-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlaySound-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlaySound-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PlaySound-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PlaySound)))
  'PlaySound-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PlaySound)))
  'PlaySound-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlaySound)))
  "Returns string type for a service object of type '<PlaySound>"
  "spot_cam/PlaySound")