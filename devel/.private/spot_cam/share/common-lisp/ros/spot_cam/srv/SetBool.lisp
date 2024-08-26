; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude SetBool-request.msg.html

(cl:defclass <SetBool-request> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetBool-request (<SetBool-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetBool-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetBool-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetBool-request> is deprecated: use spot_cam-srv:SetBool-request instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <SetBool-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:value-val is deprecated.  Use spot_cam-srv:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetBool-request>) ostream)
  "Serializes a message object of type '<SetBool-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'value) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetBool-request>) istream)
  "Deserializes a message object of type '<SetBool-request>"
    (cl:setf (cl:slot-value msg 'value) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetBool-request>)))
  "Returns string type for a service object of type '<SetBool-request>"
  "spot_cam/SetBoolRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetBool-request)))
  "Returns string type for a service object of type 'SetBool-request"
  "spot_cam/SetBoolRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetBool-request>)))
  "Returns md5sum for a message object of type '<SetBool-request>"
  "5818564455354be7201484c2bf028604")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetBool-request)))
  "Returns md5sum for a message object of type 'SetBool-request"
  "5818564455354be7201484c2bf028604")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetBool-request>)))
  "Returns full string definition for message of type '<SetBool-request>"
  (cl:format cl:nil "bool value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetBool-request)))
  "Returns full string definition for message of type 'SetBool-request"
  (cl:format cl:nil "bool value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetBool-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetBool-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetBool-request
    (cl:cons ':value (value msg))
))
;//! \htmlinclude SetBool-response.msg.html

(cl:defclass <SetBool-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetBool-response (<SetBool-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetBool-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetBool-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetBool-response> is deprecated: use spot_cam-srv:SetBool-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetBool-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetBool-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetBool-response>) ostream)
  "Serializes a message object of type '<SetBool-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetBool-response>) istream)
  "Deserializes a message object of type '<SetBool-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetBool-response>)))
  "Returns string type for a service object of type '<SetBool-response>"
  "spot_cam/SetBoolResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetBool-response)))
  "Returns string type for a service object of type 'SetBool-response"
  "spot_cam/SetBoolResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetBool-response>)))
  "Returns md5sum for a message object of type '<SetBool-response>"
  "5818564455354be7201484c2bf028604")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetBool-response)))
  "Returns md5sum for a message object of type 'SetBool-response"
  "5818564455354be7201484c2bf028604")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetBool-response>)))
  "Returns full string definition for message of type '<SetBool-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetBool-response)))
  "Returns full string definition for message of type 'SetBool-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetBool-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetBool-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetBool-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetBool)))
  'SetBool-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetBool)))
  'SetBool-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetBool)))
  "Returns string type for a service object of type '<SetBool>"
  "spot_cam/SetBool")