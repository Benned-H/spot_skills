; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude SetIRColormap-request.msg.html

(cl:defclass <SetIRColormap-request> (roslisp-msg-protocol:ros-message)
  ((colormap
    :reader colormap
    :initarg :colormap
    :type cl:fixnum
    :initform 0)
   (min
    :reader min
    :initarg :min
    :type cl:float
    :initform 0.0)
   (max
    :reader max
    :initarg :max
    :type cl:float
    :initform 0.0)
   (auto_scale
    :reader auto_scale
    :initarg :auto_scale
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetIRColormap-request (<SetIRColormap-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetIRColormap-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetIRColormap-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetIRColormap-request> is deprecated: use spot_cam-srv:SetIRColormap-request instead.")))

(cl:ensure-generic-function 'colormap-val :lambda-list '(m))
(cl:defmethod colormap-val ((m <SetIRColormap-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:colormap-val is deprecated.  Use spot_cam-srv:colormap instead.")
  (colormap m))

(cl:ensure-generic-function 'min-val :lambda-list '(m))
(cl:defmethod min-val ((m <SetIRColormap-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:min-val is deprecated.  Use spot_cam-srv:min instead.")
  (min m))

(cl:ensure-generic-function 'max-val :lambda-list '(m))
(cl:defmethod max-val ((m <SetIRColormap-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:max-val is deprecated.  Use spot_cam-srv:max instead.")
  (max m))

(cl:ensure-generic-function 'auto_scale-val :lambda-list '(m))
(cl:defmethod auto_scale-val ((m <SetIRColormap-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:auto_scale-val is deprecated.  Use spot_cam-srv:auto_scale instead.")
  (auto_scale m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SetIRColormap-request>)))
    "Constants for message type '<SetIRColormap-request>"
  '((:COLORMAP_UNKNOWN . 0)
    (:COLORMAP_GREYSCALE . 1)
    (:COLORMAP_JET . 2)
    (:COLORMAP_INFERNO . 3)
    (:COLORMAP_TURBO . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SetIRColormap-request)))
    "Constants for message type 'SetIRColormap-request"
  '((:COLORMAP_UNKNOWN . 0)
    (:COLORMAP_GREYSCALE . 1)
    (:COLORMAP_JET . 2)
    (:COLORMAP_INFERNO . 3)
    (:COLORMAP_TURBO . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetIRColormap-request>) ostream)
  "Serializes a message object of type '<SetIRColormap-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'colormap)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'auto_scale) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetIRColormap-request>) istream)
  "Deserializes a message object of type '<SetIRColormap-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'colormap)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'auto_scale) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetIRColormap-request>)))
  "Returns string type for a service object of type '<SetIRColormap-request>"
  "spot_cam/SetIRColormapRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetIRColormap-request)))
  "Returns string type for a service object of type 'SetIRColormap-request"
  "spot_cam/SetIRColormapRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetIRColormap-request>)))
  "Returns md5sum for a message object of type '<SetIRColormap-request>"
  "e8a4267610857cdc61a42ef5adcd242f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetIRColormap-request)))
  "Returns md5sum for a message object of type 'SetIRColormap-request"
  "e8a4267610857cdc61a42ef5adcd242f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetIRColormap-request>)))
  "Returns full string definition for message of type '<SetIRColormap-request>"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ircolormap for definition~%uint8 COLORMAP_UNKNOWN=0~%# The greyscale colormap maps the minimum value (defined below) to black and the maximum value (defined below) to white~%uint8 COLORMAP_GREYSCALE=1~%# The jet colormap uses blues for values closer to the minimum, and red values for values closer to the maximum.~%uint8 COLORMAP_JET=2~%# The inferno colormap maps the minimum value to black and the maximum value to light yellow RGB(252, 252, 164).~%# It is also easier to view by those with color blindness~%uint8 COLORMAP_INFERNO=3~%# The turbo colormap uses blues for values closer to the minumum, red values for values closer to the maximum,~%# and addresses some short comings of the jet color map such as false detail, banding and color blindness~%uint8 COLORMAP_TURBO=4~%~%# The colormap to use for the IR display~%uint8 colormap~%# Minimum value for the color mapping in degrees celsius~%float32 min~%# Maximum value for the color mapping in degrees celsius~%float32 max~%# If true, automatically derive min and max from the image data. Min and max values are ignored~%bool auto_scale~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetIRColormap-request)))
  "Returns full string definition for message of type 'SetIRColormap-request"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ircolormap for definition~%uint8 COLORMAP_UNKNOWN=0~%# The greyscale colormap maps the minimum value (defined below) to black and the maximum value (defined below) to white~%uint8 COLORMAP_GREYSCALE=1~%# The jet colormap uses blues for values closer to the minimum, and red values for values closer to the maximum.~%uint8 COLORMAP_JET=2~%# The inferno colormap maps the minimum value to black and the maximum value to light yellow RGB(252, 252, 164).~%# It is also easier to view by those with color blindness~%uint8 COLORMAP_INFERNO=3~%# The turbo colormap uses blues for values closer to the minumum, red values for values closer to the maximum,~%# and addresses some short comings of the jet color map such as false detail, banding and color blindness~%uint8 COLORMAP_TURBO=4~%~%# The colormap to use for the IR display~%uint8 colormap~%# Minimum value for the color mapping in degrees celsius~%float32 min~%# Maximum value for the color mapping in degrees celsius~%float32 max~%# If true, automatically derive min and max from the image data. Min and max values are ignored~%bool auto_scale~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetIRColormap-request>))
  (cl:+ 0
     1
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetIRColormap-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetIRColormap-request
    (cl:cons ':colormap (colormap msg))
    (cl:cons ':min (min msg))
    (cl:cons ':max (max msg))
    (cl:cons ':auto_scale (auto_scale msg))
))
;//! \htmlinclude SetIRColormap-response.msg.html

(cl:defclass <SetIRColormap-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetIRColormap-response (<SetIRColormap-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetIRColormap-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetIRColormap-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetIRColormap-response> is deprecated: use spot_cam-srv:SetIRColormap-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetIRColormap-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetIRColormap-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetIRColormap-response>) ostream)
  "Serializes a message object of type '<SetIRColormap-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetIRColormap-response>) istream)
  "Deserializes a message object of type '<SetIRColormap-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetIRColormap-response>)))
  "Returns string type for a service object of type '<SetIRColormap-response>"
  "spot_cam/SetIRColormapResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetIRColormap-response)))
  "Returns string type for a service object of type 'SetIRColormap-response"
  "spot_cam/SetIRColormapResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetIRColormap-response>)))
  "Returns md5sum for a message object of type '<SetIRColormap-response>"
  "e8a4267610857cdc61a42ef5adcd242f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetIRColormap-response)))
  "Returns md5sum for a message object of type 'SetIRColormap-response"
  "e8a4267610857cdc61a42ef5adcd242f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetIRColormap-response>)))
  "Returns full string definition for message of type '<SetIRColormap-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetIRColormap-response)))
  "Returns full string definition for message of type 'SetIRColormap-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetIRColormap-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetIRColormap-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetIRColormap-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetIRColormap)))
  'SetIRColormap-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetIRColormap)))
  'SetIRColormap-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetIRColormap)))
  "Returns string type for a service object of type '<SetIRColormap>"
  "spot_cam/SetIRColormap")