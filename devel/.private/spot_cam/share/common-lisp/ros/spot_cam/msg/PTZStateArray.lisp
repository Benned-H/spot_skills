; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude PTZStateArray.msg.html

(cl:defclass <PTZStateArray> (roslisp-msg-protocol:ros-message)
  ((ptzs
    :reader ptzs
    :initarg :ptzs
    :type (cl:vector spot_cam-msg:PTZState)
   :initform (cl:make-array 0 :element-type 'spot_cam-msg:PTZState :initial-element (cl:make-instance 'spot_cam-msg:PTZState))))
)

(cl:defclass PTZStateArray (<PTZStateArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PTZStateArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PTZStateArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<PTZStateArray> is deprecated: use spot_cam-msg:PTZStateArray instead.")))

(cl:ensure-generic-function 'ptzs-val :lambda-list '(m))
(cl:defmethod ptzs-val ((m <PTZStateArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:ptzs-val is deprecated.  Use spot_cam-msg:ptzs instead.")
  (ptzs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PTZStateArray>) ostream)
  "Serializes a message object of type '<PTZStateArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ptzs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ptzs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PTZStateArray>) istream)
  "Deserializes a message object of type '<PTZStateArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ptzs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ptzs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_cam-msg:PTZState))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PTZStateArray>)))
  "Returns string type for a message object of type '<PTZStateArray>"
  "spot_cam/PTZStateArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PTZStateArray)))
  "Returns string type for a message object of type 'PTZStateArray"
  "spot_cam/PTZStateArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PTZStateArray>)))
  "Returns md5sum for a message object of type '<PTZStateArray>"
  "c71a65fc59258e7303baf75176b74b2b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PTZStateArray)))
  "Returns md5sum for a message object of type 'PTZStateArray"
  "c71a65fc59258e7303baf75176b74b2b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PTZStateArray>)))
  "Returns full string definition for message of type '<PTZStateArray>"
  (cl:format cl:nil "spot_cam/PTZState[] ptzs~%================================================================================~%MSG: spot_cam/PTZState~%# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,~%# The meaning of the pan/tilt/zoom values changes.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity~%std_msgs/Header header~%# Description of the ptz~%spot_cam/PTZDescription ptz~%# degrees or degrees per second~%float32 pan~%# degrees or degrees per second~%float32 tilt~%# zoom level or zoom level per second~%float32 zoom~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PTZStateArray)))
  "Returns full string definition for message of type 'PTZStateArray"
  (cl:format cl:nil "spot_cam/PTZState[] ptzs~%================================================================================~%MSG: spot_cam/PTZState~%# This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,~%# The meaning of the pan/tilt/zoom values changes.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity~%std_msgs/Header header~%# Description of the ptz~%spot_cam/PTZDescription ptz~%# degrees or degrees per second~%float32 pan~%# degrees or degrees per second~%float32 tilt~%# zoom level or zoom level per second~%float32 zoom~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PTZStateArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ptzs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PTZStateArray>))
  "Converts a ROS message object to a list"
  (cl:list 'PTZStateArray
    (cl:cons ':ptzs (ptzs msg))
))
