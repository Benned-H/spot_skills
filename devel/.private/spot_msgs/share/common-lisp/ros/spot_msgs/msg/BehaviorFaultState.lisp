; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude BehaviorFaultState.msg.html

(cl:defclass <BehaviorFaultState> (roslisp-msg-protocol:ros-message)
  ((faults
    :reader faults
    :initarg :faults
    :type (cl:vector spot_msgs-msg:BehaviorFault)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:BehaviorFault :initial-element (cl:make-instance 'spot_msgs-msg:BehaviorFault))))
)

(cl:defclass BehaviorFaultState (<BehaviorFaultState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BehaviorFaultState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BehaviorFaultState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<BehaviorFaultState> is deprecated: use spot_msgs-msg:BehaviorFaultState instead.")))

(cl:ensure-generic-function 'faults-val :lambda-list '(m))
(cl:defmethod faults-val ((m <BehaviorFaultState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:faults-val is deprecated.  Use spot_msgs-msg:faults instead.")
  (faults m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BehaviorFaultState>) ostream)
  "Serializes a message object of type '<BehaviorFaultState>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'faults))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'faults))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BehaviorFaultState>) istream)
  "Deserializes a message object of type '<BehaviorFaultState>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'faults) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'faults)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:BehaviorFault))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BehaviorFaultState>)))
  "Returns string type for a message object of type '<BehaviorFaultState>"
  "spot_msgs/BehaviorFaultState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BehaviorFaultState)))
  "Returns string type for a message object of type 'BehaviorFaultState"
  "spot_msgs/BehaviorFaultState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BehaviorFaultState>)))
  "Returns md5sum for a message object of type '<BehaviorFaultState>"
  "59543c1c1ad10a39140a97dcfc78f876")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BehaviorFaultState)))
  "Returns md5sum for a message object of type 'BehaviorFaultState"
  "59543c1c1ad10a39140a97dcfc78f876")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BehaviorFaultState>)))
  "Returns full string definition for message of type '<BehaviorFaultState>"
  (cl:format cl:nil "BehaviorFault[] faults~%~%================================================================================~%MSG: spot_msgs/BehaviorFault~%# Cause~%uint8 CAUSE_UNKNOWN = 0~%uint8 CAUSE_FALL = 1~%uint8 CAUSE_HARDWARE = 2~%~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_CLEARABLE = 1~%uint8 STATUS_UNCLEARABLE = 2~%~%Header header~%uint32 behavior_fault_id~%uint8 cause~%uint8 status~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BehaviorFaultState)))
  "Returns full string definition for message of type 'BehaviorFaultState"
  (cl:format cl:nil "BehaviorFault[] faults~%~%================================================================================~%MSG: spot_msgs/BehaviorFault~%# Cause~%uint8 CAUSE_UNKNOWN = 0~%uint8 CAUSE_FALL = 1~%uint8 CAUSE_HARDWARE = 2~%~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_CLEARABLE = 1~%uint8 STATUS_UNCLEARABLE = 2~%~%Header header~%uint32 behavior_fault_id~%uint8 cause~%uint8 status~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BehaviorFaultState>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'faults) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BehaviorFaultState>))
  "Converts a ROS message object to a list"
  (cl:list 'BehaviorFaultState
    (cl:cons ':faults (faults msg))
))
