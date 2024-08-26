; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude BatteryStateArray.msg.html

(cl:defclass <BatteryStateArray> (roslisp-msg-protocol:ros-message)
  ((battery_states
    :reader battery_states
    :initarg :battery_states
    :type (cl:vector spot_msgs-msg:BatteryState)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:BatteryState :initial-element (cl:make-instance 'spot_msgs-msg:BatteryState))))
)

(cl:defclass BatteryStateArray (<BatteryStateArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BatteryStateArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BatteryStateArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<BatteryStateArray> is deprecated: use spot_msgs-msg:BatteryStateArray instead.")))

(cl:ensure-generic-function 'battery_states-val :lambda-list '(m))
(cl:defmethod battery_states-val ((m <BatteryStateArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:battery_states-val is deprecated.  Use spot_msgs-msg:battery_states instead.")
  (battery_states m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BatteryStateArray>) ostream)
  "Serializes a message object of type '<BatteryStateArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'battery_states))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'battery_states))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BatteryStateArray>) istream)
  "Deserializes a message object of type '<BatteryStateArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'battery_states) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'battery_states)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:BatteryState))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BatteryStateArray>)))
  "Returns string type for a message object of type '<BatteryStateArray>"
  "spot_msgs/BatteryStateArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BatteryStateArray)))
  "Returns string type for a message object of type 'BatteryStateArray"
  "spot_msgs/BatteryStateArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BatteryStateArray>)))
  "Returns md5sum for a message object of type '<BatteryStateArray>"
  "5be00bcb9a392f14ba6707e020a94106")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BatteryStateArray)))
  "Returns md5sum for a message object of type 'BatteryStateArray"
  "5be00bcb9a392f14ba6707e020a94106")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BatteryStateArray>)))
  "Returns full string definition for message of type '<BatteryStateArray>"
  (cl:format cl:nil "BatteryState[] battery_states~%~%================================================================================~%MSG: spot_msgs/BatteryState~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_MISSING = 1~%uint8 STATUS_CHARGING = 2~%uint8 STATUS_DISCHARGING = 3~%uint8 STATUS_BOOTING = 4~%~%Header header~%string identifier~%float64 charge_percentage~%duration estimated_runtime~%float64 current~%float64 voltage~%float64[] temperatures~%uint8 status~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BatteryStateArray)))
  "Returns full string definition for message of type 'BatteryStateArray"
  (cl:format cl:nil "BatteryState[] battery_states~%~%================================================================================~%MSG: spot_msgs/BatteryState~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_MISSING = 1~%uint8 STATUS_CHARGING = 2~%uint8 STATUS_DISCHARGING = 3~%uint8 STATUS_BOOTING = 4~%~%Header header~%string identifier~%float64 charge_percentage~%duration estimated_runtime~%float64 current~%float64 voltage~%float64[] temperatures~%uint8 status~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BatteryStateArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'battery_states) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BatteryStateArray>))
  "Converts a ROS message object to a list"
  (cl:list 'BatteryStateArray
    (cl:cons ':battery_states (battery_states msg))
))
