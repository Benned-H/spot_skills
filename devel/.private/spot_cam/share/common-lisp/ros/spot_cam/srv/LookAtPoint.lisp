; Auto-generated. Do not edit!


(cl:in-package spot_cam-srv)


;//! \htmlinclude LookAtPoint-request.msg.html

(cl:defclass <LookAtPoint-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass LookAtPoint-request (<LookAtPoint-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LookAtPoint-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LookAtPoint-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<LookAtPoint-request> is deprecated: use spot_cam-srv:LookAtPoint-request instead.")))

(cl:ensure-generic-function 'target-val :lambda-list '(m))
(cl:defmethod target-val ((m <LookAtPoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:target-val is deprecated.  Use spot_cam-srv:target instead.")
  (target m))

(cl:ensure-generic-function 'image_width-val :lambda-list '(m))
(cl:defmethod image_width-val ((m <LookAtPoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:image_width-val is deprecated.  Use spot_cam-srv:image_width instead.")
  (image_width m))

(cl:ensure-generic-function 'zoom_level-val :lambda-list '(m))
(cl:defmethod zoom_level-val ((m <LookAtPoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:zoom_level-val is deprecated.  Use spot_cam-srv:zoom_level instead.")
  (zoom_level m))

(cl:ensure-generic-function 'track-val :lambda-list '(m))
(cl:defmethod track-val ((m <LookAtPoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:track-val is deprecated.  Use spot_cam-srv:track instead.")
  (track m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LookAtPoint-request>) ostream)
  "Serializes a message object of type '<LookAtPoint-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LookAtPoint-request>) istream)
  "Deserializes a message object of type '<LookAtPoint-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LookAtPoint-request>)))
  "Returns string type for a service object of type '<LookAtPoint-request>"
  "spot_cam/LookAtPointRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LookAtPoint-request)))
  "Returns string type for a service object of type 'LookAtPoint-request"
  "spot_cam/LookAtPointRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LookAtPoint-request>)))
  "Returns md5sum for a message object of type '<LookAtPoint-request>"
  "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LookAtPoint-request)))
  "Returns md5sum for a message object of type 'LookAtPoint-request"
  "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LookAtPoint-request>)))
  "Returns full string definition for message of type '<LookAtPoint-request>"
  (cl:format cl:nil "# Point the spot cam PTZ at a specific point in space~%# The target at which the PTZ should be pointed~%geometry_msgs/PointStamped target~%# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,~%# this will be used~%float32 image_width~%# Optical zoom level between 1 and 30 to use~%float32 zoom_level~%# If true, the camera will track this point as the robot moves~%bool track~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LookAtPoint-request)))
  "Returns full string definition for message of type 'LookAtPoint-request"
  (cl:format cl:nil "# Point the spot cam PTZ at a specific point in space~%# The target at which the PTZ should be pointed~%geometry_msgs/PointStamped target~%# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,~%# this will be used~%float32 image_width~%# Optical zoom level between 1 and 30 to use~%float32 zoom_level~%# If true, the camera will track this point as the robot moves~%bool track~%~%================================================================================~%MSG: geometry_msgs/PointStamped~%# This represents a Point with reference coordinate frame and timestamp~%Header header~%Point point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LookAtPoint-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'target))
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LookAtPoint-request>))
  "Converts a ROS message object to a list"
  (cl:list 'LookAtPoint-request
    (cl:cons ':target (target msg))
    (cl:cons ':image_width (image_width msg))
    (cl:cons ':zoom_level (zoom_level msg))
    (cl:cons ':track (track msg))
))
;//! \htmlinclude LookAtPoint-response.msg.html

(cl:defclass <LookAtPoint-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass LookAtPoint-response (<LookAtPoint-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LookAtPoint-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LookAtPoint-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-srv:<LookAtPoint-response> is deprecated: use spot_cam-srv:LookAtPoint-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <LookAtPoint-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:success-val is deprecated.  Use spot_cam-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <LookAtPoint-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-srv:message-val is deprecated.  Use spot_cam-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LookAtPoint-response>) ostream)
  "Serializes a message object of type '<LookAtPoint-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LookAtPoint-response>) istream)
  "Deserializes a message object of type '<LookAtPoint-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LookAtPoint-response>)))
  "Returns string type for a service object of type '<LookAtPoint-response>"
  "spot_cam/LookAtPointResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LookAtPoint-response)))
  "Returns string type for a service object of type 'LookAtPoint-response"
  "spot_cam/LookAtPointResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LookAtPoint-response>)))
  "Returns md5sum for a message object of type '<LookAtPoint-response>"
  "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LookAtPoint-response)))
  "Returns md5sum for a message object of type 'LookAtPoint-response"
  "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LookAtPoint-response>)))
  "Returns full string definition for message of type '<LookAtPoint-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LookAtPoint-response)))
  "Returns full string definition for message of type 'LookAtPoint-response"
  (cl:format cl:nil "bool success~%string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LookAtPoint-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LookAtPoint-response>))
  "Converts a ROS message object to a list"
  (cl:list 'LookAtPoint-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'LookAtPoint)))
  'LookAtPoint-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'LookAtPoint)))
  'LookAtPoint-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LookAtPoint)))
  "Returns string type for a service object of type '<LookAtPoint>"
  "spot_cam/LookAtPoint")