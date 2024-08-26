; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude SystemFaultState.msg.html

(cl:defclass <SystemFaultState> (roslisp-msg-protocol:ros-message)
  ((faults
    :reader faults
    :initarg :faults
    :type (cl:vector spot_msgs-msg:SystemFault)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SystemFault :initial-element (cl:make-instance 'spot_msgs-msg:SystemFault)))
   (historical_faults
    :reader historical_faults
    :initarg :historical_faults
    :type (cl:vector spot_msgs-msg:SystemFault)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SystemFault :initial-element (cl:make-instance 'spot_msgs-msg:SystemFault))))
)

(cl:defclass SystemFaultState (<SystemFaultState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SystemFaultState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SystemFaultState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<SystemFaultState> is deprecated: use spot_msgs-msg:SystemFaultState instead.")))

(cl:ensure-generic-function 'faults-val :lambda-list '(m))
(cl:defmethod faults-val ((m <SystemFaultState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:faults-val is deprecated.  Use spot_msgs-msg:faults instead.")
  (faults m))

(cl:ensure-generic-function 'historical_faults-val :lambda-list '(m))
(cl:defmethod historical_faults-val ((m <SystemFaultState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:historical_faults-val is deprecated.  Use spot_msgs-msg:historical_faults instead.")
  (historical_faults m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SystemFaultState>) ostream)
  "Serializes a message object of type '<SystemFaultState>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'faults))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'faults))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'historical_faults))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'historical_faults))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SystemFaultState>) istream)
  "Deserializes a message object of type '<SystemFaultState>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'faults) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'faults)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SystemFault))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'historical_faults) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'historical_faults)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SystemFault))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SystemFaultState>)))
  "Returns string type for a message object of type '<SystemFaultState>"
  "spot_msgs/SystemFaultState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SystemFaultState)))
  "Returns string type for a message object of type 'SystemFaultState"
  "spot_msgs/SystemFaultState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SystemFaultState>)))
  "Returns md5sum for a message object of type '<SystemFaultState>"
  "3847105c5e3204fe63ad7caa31a33575")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SystemFaultState)))
  "Returns md5sum for a message object of type 'SystemFaultState"
  "3847105c5e3204fe63ad7caa31a33575")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SystemFaultState>)))
  "Returns full string definition for message of type '<SystemFaultState>"
  (cl:format cl:nil "SystemFault[] faults~%SystemFault[] historical_faults~%~%================================================================================~%MSG: spot_msgs/SystemFault~%# Severity~%uint8 SEVERITY_UNKNOWN = 0~%uint8 SEVERITY_INFO = 1~%uint8 SEVERITY_WARN = 2~%uint8 SEVERITY_CRITICAL = 3~%~%Header header~%string name~%duration duration~%int32 code~%uint64 uid~%string error_message~%string[] attributes~%uint8 severity~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SystemFaultState)))
  "Returns full string definition for message of type 'SystemFaultState"
  (cl:format cl:nil "SystemFault[] faults~%SystemFault[] historical_faults~%~%================================================================================~%MSG: spot_msgs/SystemFault~%# Severity~%uint8 SEVERITY_UNKNOWN = 0~%uint8 SEVERITY_INFO = 1~%uint8 SEVERITY_WARN = 2~%uint8 SEVERITY_CRITICAL = 3~%~%Header header~%string name~%duration duration~%int32 code~%uint64 uid~%string error_message~%string[] attributes~%uint8 severity~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SystemFaultState>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'faults) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'historical_faults) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SystemFaultState>))
  "Converts a ROS message object to a list"
  (cl:list 'SystemFaultState
    (cl:cons ':faults (faults msg))
    (cl:cons ':historical_faults (historical_faults msg))
))
