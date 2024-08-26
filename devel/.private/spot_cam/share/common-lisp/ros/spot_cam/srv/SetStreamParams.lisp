; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude SetStreamParams-request.msg.html

(cl:defclass <SetStreamParams-request> (roslisp-msg-protocol:ros-message)
  ((params
    :reader params
    :initarg :params
    :type spot_cam-msg:StreamParams
    :initform (cl:make-instance 'spot_cam-msg:StreamParams)))
)

(cl:defclass SetStreamParams-request (<SetStreamParams-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetStreamParams-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetStreamParams-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetStreamParams-request> is deprecated: use spot_cam-srv:SetStreamParams-request instead.")))

(cl:ensure-generic-function 'params-val :lambda-list '(m))
(cl:defmethod params-val ((m <SetStreamParams-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:params-val is deprecated.  Use spot_cam-srv:params instead.")
  (params m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetStreamParams-request>) ostream)
  "Serializes a message object of type '<SetStreamParams-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'params) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetStreamParams-request>) istream)
  "Deserializes a message object of type '<SetStreamParams-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'params) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetStreamParams-request>)))
  "Returns string type for a service object of type '<SetStreamParams-request>"
  "spot_cam/SetStreamParamsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetStreamParams-request)))
  "Returns string type for a service object of type 'SetStreamParams-request"
  "spot_cam/SetStreamParamsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetStreamParams-request>)))
  "Returns md5sum for a message object of type '<SetStreamParams-request>"
  "bde49dd2a9f9234c2f23c257153388e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetStreamParams-request)))
  "Returns md5sum for a message object of type 'SetStreamParams-request"
  "bde49dd2a9f9234c2f23c257153388e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetStreamParams-request>)))
  "Returns full string definition for message of type '<SetStreamParams-request>"
  (cl:format cl:nil "spot_cam/StreamParams params~%~%================================================================================~%MSG: spot_cam/StreamParams~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams~%# White balance modes~%int8 OFF=-1~%# This is not provided, but we add it to be able to distinguish when setting the white balance~%int8 UNSET=0~%int8 AUTO=1~%int8 INCANDESCENT=2~%int8 FLUORESCENT=3~%int8 WARM_FLUORESCENT=4~%int8 DAYLIGHT=5~%int8 CLOUDY=6~%int8 TWILIGHT=7~%int8 SHADE=8~%int8 DARK=9~%~%# Compression level target in bits per second~%int64 target_bitrate~%# How often should the entire feed be refreshed (in frames)~%int64 refresh_interval~%# How often should an IDR message be sent (in frames)~%int64 idr_interval~%# Automatic white balance~%int8 awb~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetStreamParams-request)))
  "Returns full string definition for message of type 'SetStreamParams-request"
  (cl:format cl:nil "spot_cam/StreamParams params~%~%================================================================================~%MSG: spot_cam/StreamParams~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams~%# White balance modes~%int8 OFF=-1~%# This is not provided, but we add it to be able to distinguish when setting the white balance~%int8 UNSET=0~%int8 AUTO=1~%int8 INCANDESCENT=2~%int8 FLUORESCENT=3~%int8 WARM_FLUORESCENT=4~%int8 DAYLIGHT=5~%int8 CLOUDY=6~%int8 TWILIGHT=7~%int8 SHADE=8~%int8 DARK=9~%~%# Compression level target in bits per second~%int64 target_bitrate~%# How often should the entire feed be refreshed (in frames)~%int64 refresh_interval~%# How often should an IDR message be sent (in frames)~%int64 idr_interval~%# Automatic white balance~%int8 awb~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetStreamParams-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'params))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetStreamParams-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetStreamParams-request
    (cl:cons ':params (params msg))
))
;//! \htmlinclude SetStreamParams-response.msg.html

(cl:defclass <SetStreamParams-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetStreamParams-response (<SetStreamParams-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetStreamParams-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetStreamParams-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetStreamParams-response> is deprecated: use spot_cam-srv:SetStreamParams-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetStreamParams-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetStreamParams-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetStreamParams-response>) ostream)
  "Serializes a message object of type '<SetStreamParams-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetStreamParams-response>) istream)
  "Deserializes a message object of type '<SetStreamParams-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetStreamParams-response>)))
  "Returns string type for a service object of type '<SetStreamParams-response>"
  "spot_cam/SetStreamParamsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetStreamParams-response)))
  "Returns string type for a service object of type 'SetStreamParams-response"
  "spot_cam/SetStreamParamsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetStreamParams-response>)))
  "Returns md5sum for a message object of type '<SetStreamParams-response>"
  "bde49dd2a9f9234c2f23c257153388e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetStreamParams-response)))
  "Returns md5sum for a message object of type 'SetStreamParams-response"
  "bde49dd2a9f9234c2f23c257153388e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetStreamParams-response>)))
  "Returns full string definition for message of type '<SetStreamParams-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetStreamParams-response)))
  "Returns full string definition for message of type 'SetStreamParams-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetStreamParams-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetStreamParams-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetStreamParams-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetStreamParams)))
  'SetStreamParams-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetStreamParams)))
  'SetStreamParams-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetStreamParams)))
  "Returns string type for a service object of type '<SetStreamParams>"
  "spot_cam/SetStreamParams")