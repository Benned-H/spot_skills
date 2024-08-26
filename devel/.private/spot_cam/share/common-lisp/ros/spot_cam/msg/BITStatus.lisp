; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude BITStatus.msg.html

(cl:defclass <BITStatus> (roslisp-msg-protocol:ros-message)
  ((events
    :reader events
    :initarg :events
    :type (cl:vector spot_msgs-msg:SystemFault)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SystemFault :initial-element (cl:make-instance 'spot_msgs-msg:SystemFault)))
   (degradations
    :reader degradations
    :initarg :degradations
    :type (cl:vector spot_cam-msg:Degradation)
   :initform (cl:make-array 0 :element-type 'spot_cam-msg:Degradation :initial-element (cl:make-instance 'spot_cam-msg:Degradation))))
)

(cl:defclass BITStatus (<BITStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BITStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BITStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<BITStatus> is deprecated: use spot_cam-msg:BITStatus instead.")))

(cl:ensure-generic-function 'events-val :lambda-list '(m))
(cl:defmethod events-val ((m <BITStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:events-val is deprecated.  Use spot_cam-msg:events instead.")
  (events m))

(cl:ensure-generic-function 'degradations-val :lambda-list '(m))
(cl:defmethod degradations-val ((m <BITStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:degradations-val is deprecated.  Use spot_cam-msg:degradations instead.")
  (degradations m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BITStatus>) ostream)
  "Serializes a message object of type '<BITStatus>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'events))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'events))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'degradations))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'degradations))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BITStatus>) istream)
  "Deserializes a message object of type '<BITStatus>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'events) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'events)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SystemFault))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'degradations) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'degradations)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_cam-msg:Degradation))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BITStatus>)))
  "Returns string type for a message object of type '<BITStatus>"
  "spot_cam/BITStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BITStatus)))
  "Returns string type for a message object of type 'BITStatus"
  "spot_cam/BITStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BITStatus>)))
  "Returns md5sum for a message object of type '<BITStatus>"
  "bbef0264c8e68f60c3f5c0359d3c130d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BITStatus)))
  "Returns md5sum for a message object of type 'BITStatus"
  "bbef0264c8e68f60c3f5c0359d3c130d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BITStatus>)))
  "Returns full string definition for message of type '<BITStatus>"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse~%spot_msgs/SystemFault[] events~%spot_cam/Degradation[] degradations~%================================================================================~%MSG: spot_msgs/SystemFault~%# Severity~%uint8 SEVERITY_UNKNOWN = 0~%uint8 SEVERITY_INFO = 1~%uint8 SEVERITY_WARN = 2~%uint8 SEVERITY_CRITICAL = 3~%~%Header header~%string name~%duration duration~%int32 code~%uint64 uid~%string error_message~%string[] attributes~%uint8 severity~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/Degradation~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation~%# Different degradation types~%uint8 TYPE_STORAGE=0~%uint8 TYPE_PTZ=1~%uint8 TYPE_LED=2~%~%# The system affected by the degradation~%uint8 type~%# What degradation is being experienced~%string description~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BITStatus)))
  "Returns full string definition for message of type 'BITStatus"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse~%spot_msgs/SystemFault[] events~%spot_cam/Degradation[] degradations~%================================================================================~%MSG: spot_msgs/SystemFault~%# Severity~%uint8 SEVERITY_UNKNOWN = 0~%uint8 SEVERITY_INFO = 1~%uint8 SEVERITY_WARN = 2~%uint8 SEVERITY_CRITICAL = 3~%~%Header header~%string name~%duration duration~%int32 code~%uint64 uid~%string error_message~%string[] attributes~%uint8 severity~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: spot_cam/Degradation~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation~%# Different degradation types~%uint8 TYPE_STORAGE=0~%uint8 TYPE_PTZ=1~%uint8 TYPE_LED=2~%~%# The system affected by the degradation~%uint8 type~%# What degradation is being experienced~%string description~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BITStatus>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'events) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'degradations) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BITStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'BITStatus
    (cl:cons ':events (events msg))
    (cl:cons ':degradations (degradations msg))
))
