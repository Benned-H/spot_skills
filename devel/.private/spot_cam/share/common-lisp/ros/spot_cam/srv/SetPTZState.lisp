; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude SetPTZState-request.msg.html

(cl:defclass <SetPTZState-request> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type spot_cam-msg:PTZState
    :initform (cl:make-instance 'spot_cam-msg:PTZState)))
)

(cl:defclass SetPTZState-request (<SetPTZState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetPTZState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetPTZState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetPTZState-request> is deprecated: use spot_cam-srv:SetPTZState-request instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <SetPTZState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:command-val is deprecated.  Use spot_cam-srv:command instead.")
  (command m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetPTZState-request>) ostream)
  "Serializes a message object of type '<SetPTZState-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'command) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetPTZState-request>) istream)
  "Deserializes a message object of type '<SetPTZState-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'command) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetPTZState-request>)))
  "Returns string type for a service object of type '<SetPTZState-request>"
  "spot_cam/SetPTZStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetPTZState-request)))
  "Returns string type for a service object of type 'SetPTZState-request"
  "spot_cam/SetPTZStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetPTZState-request>)))
  "Returns md5sum for a message object of type '<SetPTZState-request>"
  "2dd984827d05222cd185e849e7da947f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetPTZState-request)))
  "Returns md5sum for a message object of type 'SetPTZState-request"
  "2dd984827d05222cd185e849e7da947f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetPTZState-request>)))
  "Returns full string definition for message of type '<SetPTZState-request>"
  (cl:format cl:nil "# This message can be used to send either position or velocity commands~%# The description of the ptz does not need to be complete - only the name is used~%spot_cam/PTZState command~%~%================================================================================~%MSG: spot_cam/PTZState~%# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,~%# The meaning of the pan/tilt/zoom values changes.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity~%std_msgs/Header header~%# Description of the ptz~%spot_cam/PTZDescription ptz~%# degrees or degrees per second~%float32 pan~%# degrees or degrees per second~%float32 tilt~%# zoom level or zoom level per second~%float32 zoom~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetPTZState-request)))
  "Returns full string definition for message of type 'SetPTZState-request"
  (cl:format cl:nil "# This message can be used to send either position or velocity commands~%# The description of the ptz does not need to be complete - only the name is used~%spot_cam/PTZState command~%~%================================================================================~%MSG: spot_cam/PTZState~%# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,~%# The meaning of the pan/tilt/zoom values changes.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity~%std_msgs/Header header~%# Description of the ptz~%spot_cam/PTZDescription ptz~%# degrees or degrees per second~%float32 pan~%# degrees or degrees per second~%float32 tilt~%# zoom level or zoom level per second~%float32 zoom~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetPTZState-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'command))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetPTZState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetPTZState-request
    (cl:cons ':command (command msg))
))
;//! \htmlinclude SetPTZState-response.msg.html

(cl:defclass <SetPTZState-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass SetPTZState-response (<SetPTZState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetPTZState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetPTZState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<SetPTZState-response> is deprecated: use spot_cam-srv:SetPTZState-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetPTZState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SetPTZState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetPTZState-response>) ostream)
  "Serializes a message object of type '<SetPTZState-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetPTZState-response>) istream)
  "Deserializes a message object of type '<SetPTZState-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetPTZState-response>)))
  "Returns string type for a service object of type '<SetPTZState-response>"
  "spot_cam/SetPTZStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetPTZState-response)))
  "Returns string type for a service object of type 'SetPTZState-response"
  "spot_cam/SetPTZStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetPTZState-response>)))
  "Returns md5sum for a message object of type '<SetPTZState-response>"
  "2dd984827d05222cd185e849e7da947f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetPTZState-response)))
  "Returns md5sum for a message object of type 'SetPTZState-response"
  "2dd984827d05222cd185e849e7da947f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetPTZState-response>)))
  "Returns full string definition for message of type '<SetPTZState-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetPTZState-response)))
  "Returns full string definition for message of type 'SetPTZState-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetPTZState-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetPTZState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetPTZState-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetPTZState)))
  'SetPTZState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetPTZState)))
  'SetPTZState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetPTZState)))
  "Returns string type for a service object of type '<SetPTZState>"
  "spot_cam/SetPTZState")