; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude SetIRMeterOverlay-request.msg.html

(cl:defclass <SetIRMeterOverlay-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (enable
    :reader enable
    :initarg :enable
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetIRMeterOverlay-request (<SetIRMeterOverlay-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetIRMeterOverlay-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetIRMeterOverlay-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetIRMeterOverlay-request> is deprecated: use spot_cam-srv:SetIRMeterOverlay-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <SetIRMeterOverlay-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:x-val is deprecated.  Use spot_cam-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <SetIRMeterOverlay-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:y-val is deprecated.  Use spot_cam-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <SetIRMeterOverlay-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:enable-val is deprecated.  Use spot_cam-srv:enable instead.")
  (enable m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetIRMeterOverlay-request>) ostream)
  "Serializes a message object of type '<SetIRMeterOverlay-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enable) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetIRMeterOverlay-request>) istream)
  "Deserializes a message object of type '<SetIRMeterOverlay-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enable) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetIRMeterOverlay-request>)))
  "Returns string type for a service object of type '<SetIRMeterOverlay-request>"
  "spot_cam/SetIRMeterOverlayRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetIRMeterOverlay-request)))
  "Returns string type for a service object of type 'SetIRMeterOverlay-request"
  "spot_cam/SetIRMeterOverlayRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetIRMeterOverlay-request>)))
  "Returns md5sum for a message object of type '<SetIRMeterOverlay-request>"
  "d78148bbe8e3d55b83a79817052ec369")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetIRMeterOverlay-request)))
  "Returns md5sum for a message object of type 'SetIRMeterOverlay-request"
  "d78148bbe8e3d55b83a79817052ec369")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetIRMeterOverlay-request>)))
  "Returns full string definition for message of type '<SetIRMeterOverlay-request>"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#irmeteroverlay for definition~%# Horizontal coordinate between 0 and 1~%float32 x~%# Vertical coordinate between 0 and 1~%float32 y~%# If false, disable the display of the overlay~%bool enable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetIRMeterOverlay-request)))
  "Returns full string definition for message of type 'SetIRMeterOverlay-request"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#irmeteroverlay for definition~%# Horizontal coordinate between 0 and 1~%float32 x~%# Vertical coordinate between 0 and 1~%float32 y~%# If false, disable the display of the overlay~%bool enable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetIRMeterOverlay-request>))
  (cl:+ 0
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetIRMeterOverlay-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetIRMeterOverlay-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':enable (enable msg))
))
;//! \htmlinclude SetIRMeterOverlay-response.msg.html

(cl:defclass <SetIRMeterOverlay-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetIRMeterOverlay-response (<SetIRMeterOverlay-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetIRMeterOverlay-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetIRMeterOverlay-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetIRMeterOverlay-response> is deprecated: use spot_cam-srv:SetIRMeterOverlay-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetIRMeterOverlay-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetIRMeterOverlay-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetIRMeterOverlay-response>) ostream)
  "Serializes a message object of type '<SetIRMeterOverlay-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetIRMeterOverlay-response>) istream)
  "Deserializes a message object of type '<SetIRMeterOverlay-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetIRMeterOverlay-response>)))
  "Returns string type for a service object of type '<SetIRMeterOverlay-response>"
  "spot_cam/SetIRMeterOverlayResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetIRMeterOverlay-response)))
  "Returns string type for a service object of type 'SetIRMeterOverlay-response"
  "spot_cam/SetIRMeterOverlayResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetIRMeterOverlay-response>)))
  "Returns md5sum for a message object of type '<SetIRMeterOverlay-response>"
  "d78148bbe8e3d55b83a79817052ec369")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetIRMeterOverlay-response)))
  "Returns md5sum for a message object of type 'SetIRMeterOverlay-response"
  "d78148bbe8e3d55b83a79817052ec369")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetIRMeterOverlay-response>)))
  "Returns full string definition for message of type '<SetIRMeterOverlay-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetIRMeterOverlay-response)))
  "Returns full string definition for message of type 'SetIRMeterOverlay-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetIRMeterOverlay-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetIRMeterOverlay-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetIRMeterOverlay-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetIRMeterOverlay)))
  'SetIRMeterOverlay-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetIRMeterOverlay)))
  'SetIRMeterOverlay-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetIRMeterOverlay)))
  "Returns string type for a service object of type '<SetIRMeterOverlay>"
  "spot_cam/SetIRMeterOverlay")