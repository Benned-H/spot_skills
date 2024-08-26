; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude LookAtPointGoal.msg.html

(cl:defclass <LookAtPointGoal> (roslisp-msg-protocol:ros-message)
  ((target
    :reader target
    :initarg :target
    :type geometry_msgs-msg:PointStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PointStamped))
   (image_width
    :reader image_width
    :initarg :image_width
    :type cl:float
    :initform 0.0)
   (zoom_level
    :reader zoom_level
    :initarg :zoom_level
    :type cl:float
    :initform 0.0)
   (track
    :reader track
    :initarg :track
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass LookAtPointGoal (<LookAtPointGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LookAtPointGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LookAtPointGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<LookAtPointGoal> is deprecated: use spot_cam-msg:LookAtPointGoal instead.")))

(cl:ensure-generic-function 'target-val :lambda-list '(m))
(cl:defmethod target-val ((m <LookAtPointGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:target-val is deprecated.  Use spot_cam-msg:target instead.")
  (target m))

(cl:ensure-generic-function 'image_width-val :lambda-list '(m))
(cl:defmethod image_width-val ((m <LookAtPointGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:image_width-val is deprecated.  Use spot_cam-msg:image_width instead.")
  (image_width m))

(cl:ensure-generic-function 'zoom_level-val :lambda-list '(m))
(cl:defmethod zoom_level-val ((m <LookAtPointGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:zoom_level-val is deprecated.  Use spot_cam-msg:zoom_level instead.")
  (zoom_level m))

(cl:ensure-generic-function 'track-val :lambda-list '(m))
(cl:defmethod track-val ((m <LookAtPointGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:track-val is deprecated.  Use spot_cam-msg:track instead.")
  (track m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LookAtPointGoal>) ostream)
  "Serializes a message object of type '<LookAtPointGoal>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'target) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'image_width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'zoom_level))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'track) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LookAtPointGoal>) istream)
  "Deserializes a message object of type '<LookAtPointGoal>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'target) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'image_width) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'zoom_level) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'track) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LookAtPointGoal>)))
  "Returns string type for a message object of type '<LookAtPointGoal>"
  "spot_cam/LookAtPointGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LookAtPointGoal)))
  "Returns string type for a message object of type 'LookAtPointGoal"
  "spot_cam/LookAtPointGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LookAtPointGoal>)))
  "Returns md5sum for a message object of type '<LookAtPointGoal>"
  "216e8536a7d77a61af59b6f7aa3d17c4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LookAtPointGoal)))
  "Returns md5sum for a message object of type 'LookAtPointGoal"
  "216e8536a7d77a61af59b6f7aa3d17c4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LookAtPointGoal>)))
  "Returns full string definition for message of type '<LookAtPointGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# Point the spot cam PTZ at a specific point in space~%# The target at which the PTZ should be pointed~%geometry_msgs/PointStamped target~%# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,~%# this will be used~%float32 image_width~%# Optical zoom level between 1 and 30 to use~%float32 zoom_level~%# If true, the camera will track this point as the robot moves~%bool track~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LookAtPointGoal)))
  "Returns full string definition for message of type 'LookAtPointGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# Point the spot cam PTZ at a specific point in space~%# The target at which the PTZ should be pointed~%geometry_msgs/PointStamped target~%# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,~%# this will be used~%float32 image_width~%# Optical zoom level between 1 and 30 to use~%float32 zoom_level~%# If true, the camera will track this point as the robot moves~%bool track~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LookAtPointGoal>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'target))
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LookAtPointGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'LookAtPointGoal
    (cl:cons ':target (target msg))
    (cl:cons ':image_width (image_width msg))
    (cl:cons ':zoom_level (zoom_level msg))
    (cl:cons ':track (track msg))
))
