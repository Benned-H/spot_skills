; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude PTZDescription.msg.html

(cl:defclass <PTZDescription> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (pan_limit
    :reader pan_limit
    :initarg :pan_limit
    :type spot_cam-msg:PTZLimits
    :initform (cl:make-instance 'spot_cam-msg:PTZLimits))
   (tilt_limit
    :reader tilt_limit
    :initarg :tilt_limit
    :type spot_cam-msg:PTZLimits
    :initform (cl:make-instance 'spot_cam-msg:PTZLimits))
   (zoom_limit
    :reader zoom_limit
    :initarg :zoom_limit
    :type spot_cam-msg:PTZLimits
    :initform (cl:make-instance 'spot_cam-msg:PTZLimits)))
)

(cl:defclass PTZDescription (<PTZDescription>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PTZDescription>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PTZDescription)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<PTZDescription> is deprecated: use spot_cam-msg:PTZDescription instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <PTZDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:name-val is deprecated.  Use spot_cam-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'pan_limit-val :lambda-list '(m))
(cl:defmethod pan_limit-val ((m <PTZDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:pan_limit-val is deprecated.  Use spot_cam-msg:pan_limit instead.")
  (pan_limit m))

(cl:ensure-generic-function 'tilt_limit-val :lambda-list '(m))
(cl:defmethod tilt_limit-val ((m <PTZDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:tilt_limit-val is deprecated.  Use spot_cam-msg:tilt_limit instead.")
  (tilt_limit m))

(cl:ensure-generic-function 'zoom_limit-val :lambda-list '(m))
(cl:defmethod zoom_limit-val ((m <PTZDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:zoom_limit-val is deprecated.  Use spot_cam-msg:zoom_limit instead.")
  (zoom_limit m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PTZDescription>) ostream)
  "Serializes a message object of type '<PTZDescription>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pan_limit) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'tilt_limit) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'zoom_limit) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PTZDescription>) istream)
  "Deserializes a message object of type '<PTZDescription>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pan_limit) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'tilt_limit) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'zoom_limit) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PTZDescription>)))
  "Returns string type for a message object of type '<PTZDescription>"
  "spot_cam/PTZDescription")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PTZDescription)))
  "Returns string type for a message object of type 'PTZDescription"
  "spot_cam/PTZDescription")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PTZDescription>)))
  "Returns md5sum for a message object of type '<PTZDescription>"
  "e115be93750ee1ae6231f38b8b89491a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PTZDescription)))
  "Returns md5sum for a message object of type 'PTZDescription"
  "e115be93750ee1ae6231f38b8b89491a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PTZDescription>)))
  "Returns full string definition for message of type '<PTZDescription>"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PTZDescription)))
  "Returns full string definition for message of type 'PTZDescription"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PTZDescription>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pan_limit))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'tilt_limit))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'zoom_limit))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PTZDescription>))
  "Converts a ROS message object to a list"
  (cl:list 'PTZDescription
    (cl:cons ':name (name msg))
    (cl:cons ':pan_limit (pan_limit msg))
    (cl:cons ':tilt_limit (tilt_limit msg))
    (cl:cons ':zoom_limit (zoom_limit msg))
))
