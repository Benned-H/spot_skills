; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude EStopStateArray.msg.html

(cl:defclass <EStopStateArray> (roslisp-msg-protocol:ros-message)
  ((estop_states
    :reader estop_states
    :initarg :estop_states
    :type (cl:vector spot_msgs-msg:EStopState)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:EStopState :initial-element (cl:make-instance 'spot_msgs-msg:EStopState))))
)

(cl:defclass EStopStateArray (<EStopStateArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EStopStateArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EStopStateArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<EStopStateArray> is deprecated: use spot_msgs-msg:EStopStateArray instead.")))

(cl:ensure-generic-function 'estop_states-val :lambda-list '(m))
(cl:defmethod estop_states-val ((m <EStopStateArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:estop_states-val is deprecated.  Use spot_msgs-msg:estop_states instead.")
  (estop_states m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EStopStateArray>) ostream)
  "Serializes a message object of type '<EStopStateArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'estop_states))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'estop_states))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EStopStateArray>) istream)
  "Deserializes a message object of type '<EStopStateArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'estop_states) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'estop_states)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:EStopState))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EStopStateArray>)))
  "Returns string type for a message object of type '<EStopStateArray>"
  "spot_msgs/EStopStateArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EStopStateArray)))
  "Returns string type for a message object of type 'EStopStateArray"
  "spot_msgs/EStopStateArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EStopStateArray>)))
  "Returns md5sum for a message object of type '<EStopStateArray>"
  "9a14a6b761f26c00c5613f0dc614f084")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EStopStateArray)))
  "Returns md5sum for a message object of type 'EStopStateArray"
  "9a14a6b761f26c00c5613f0dc614f084")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EStopStateArray>)))
  "Returns full string definition for message of type '<EStopStateArray>"
  (cl:format cl:nil "EStopState[] estop_states~%~%================================================================================~%MSG: spot_msgs/EStopState~%# Type~%uint8 TYPE_UNKNOWN = 0~%uint8 TYPE_HARDWARE = 1~%uint8 TYPE_SOFTWARE = 2~%~%# State~%uint8 STATE_UNKNOWN = 0~%uint8 STATE_ESTOPPED = 1~%uint8 STATE_NOT_ESTOPPED = 2~%~%Header header~%string name~%uint8 type~%uint8 state~%string state_description~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EStopStateArray)))
  "Returns full string definition for message of type 'EStopStateArray"
  (cl:format cl:nil "EStopState[] estop_states~%~%================================================================================~%MSG: spot_msgs/EStopState~%# Type~%uint8 TYPE_UNKNOWN = 0~%uint8 TYPE_HARDWARE = 1~%uint8 TYPE_SOFTWARE = 2~%~%# State~%uint8 STATE_UNKNOWN = 0~%uint8 STATE_ESTOPPED = 1~%uint8 STATE_NOT_ESTOPPED = 2~%~%Header header~%string name~%uint8 type~%uint8 state~%string state_description~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EStopStateArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'estop_states) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EStopStateArray>))
  "Converts a ROS message object to a list"
  (cl:list 'EStopStateArray
    (cl:cons ':estop_states (estop_states msg))
))
