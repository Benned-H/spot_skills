; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude LoadSound-request.msg.html

(cl:defclass <LoadSound-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (wav_path
    :reader wav_path
    :initarg :wav_path
    :type cl:string
    :initform ""))
)

(cl:defclass LoadSound-request (<LoadSound-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadSound-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadSound-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<LoadSound-request> is deprecated: use spot_cam-srv:LoadSound-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <LoadSound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:name-val is deprecated.  Use spot_cam-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'wav_path-val :lambda-list '(m))
(cl:defmethod wav_path-val ((m <LoadSound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:wav_path-val is deprecated.  Use spot_cam-srv:wav_path instead.")
  (wav_path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadSound-request>) ostream)
  "Serializes a message object of type '<LoadSound-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'wav_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'wav_path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadSound-request>) istream)
  "Deserializes a message object of type '<LoadSound-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'wav_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'wav_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadSound-request>)))
  "Returns string type for a service object of type '<LoadSound-request>"
  "spot_cam/LoadSoundRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadSound-request)))
  "Returns string type for a service object of type 'LoadSound-request"
  "spot_cam/LoadSoundRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadSound-request>)))
  "Returns md5sum for a message object of type '<LoadSound-request>"
  "0a42f973c61b7597fb7a93f3219d3bc0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadSound-request)))
  "Returns md5sum for a message object of type 'LoadSound-request"
  "0a42f973c61b7597fb7a93f3219d3bc0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadSound-request>)))
  "Returns full string definition for message of type '<LoadSound-request>"
  (cl:format cl:nil "# Name to use for this sound~%string name~%# Path to the wav file to load onto the device~%string wav_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadSound-request)))
  "Returns full string definition for message of type 'LoadSound-request"
  (cl:format cl:nil "# Name to use for this sound~%string name~%# Path to the wav file to load onto the device~%string wav_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadSound-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'wav_path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadSound-request>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadSound-request
    (cl:cons ':name (name msg))
    (cl:cons ':wav_path (wav_path msg))
))
;//! \htmlinclude LoadSound-response.msg.html

(cl:defclass <LoadSound-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass LoadSound-response (<LoadSound-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadSound-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadSound-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<LoadSound-response> is deprecated: use spot_cam-srv:LoadSound-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <LoadSound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <LoadSound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadSound-response>) ostream)
  "Serializes a message object of type '<LoadSound-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadSound-response>) istream)
  "Deserializes a message object of type '<LoadSound-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadSound-response>)))
  "Returns string type for a service object of type '<LoadSound-response>"
  "spot_cam/LoadSoundResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadSound-response)))
  "Returns string type for a service object of type 'LoadSound-response"
  "spot_cam/LoadSoundResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadSound-response>)))
  "Returns md5sum for a message object of type '<LoadSound-response>"
  "0a42f973c61b7597fb7a93f3219d3bc0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadSound-response)))
  "Returns md5sum for a message object of type 'LoadSound-response"
  "0a42f973c61b7597fb7a93f3219d3bc0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadSound-response>)))
  "Returns full string definition for message of type '<LoadSound-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadSound-response)))
  "Returns full string definition for message of type 'LoadSound-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadSound-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadSound-response>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadSound-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'LoadSound)))
  'LoadSound-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'LoadSound)))
  'LoadSound-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadSound)))
  "Returns string type for a service object of type '<LoadSound>"
  "spot_cam/LoadSound")