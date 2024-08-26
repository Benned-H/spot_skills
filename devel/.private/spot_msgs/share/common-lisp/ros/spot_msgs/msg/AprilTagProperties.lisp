; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude AprilTagProperties.msg.html

(cl:defclass <AprilTagProperties> (roslisp-msg-protocol:ros-message)
  ((tag_id
    :reader tag_id
    :initarg :tag_id
    :type cl:integer
    :initform 0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (frame_name_fiducial
    :reader frame_name_fiducial
    :initarg :frame_name_fiducial
    :type cl:string
    :initform "")
   (fiducial_pose_status
    :reader fiducial_pose_status
    :initarg :fiducial_pose_status
    :type cl:fixnum
    :initform 0)
   (frame_name_fiducial_filtered
    :reader frame_name_fiducial_filtered
    :initarg :frame_name_fiducial_filtered
    :type cl:string
    :initform "")
   (fiducial_filtered_pose_status
    :reader fiducial_filtered_pose_status
    :initarg :fiducial_filtered_pose_status
    :type cl:fixnum
    :initform 0)
   (frame_name_camera
    :reader frame_name_camera
    :initarg :frame_name_camera
    :type cl:string
    :initform "")
   (detection_covariance
    :reader detection_covariance
    :initarg :detection_covariance
    :type geometry_msgs-msg:PoseWithCovariance
    :initform (cl:make-instance 'geometry_msgs-msg:PoseWithCovariance))
   (detection_covariance_reference_frame
    :reader detection_covariance_reference_frame
    :initarg :detection_covariance_reference_frame
    :type cl:string
    :initform ""))
)

(cl:defclass AprilTagProperties (<AprilTagProperties>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AprilTagProperties>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AprilTagProperties)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<AprilTagProperties> is deprecated: use spot_msgs-msg:AprilTagProperties instead.")))

(cl:ensure-generic-function 'tag_id-val :lambda-list '(m))
(cl:defmethod tag_id-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:tag_id-val is deprecated.  Use spot_msgs-msg:tag_id instead.")
  (tag_id m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:x-val is deprecated.  Use spot_msgs-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:y-val is deprecated.  Use spot_msgs-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'frame_name_fiducial-val :lambda-list '(m))
(cl:defmethod frame_name_fiducial-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_name_fiducial-val is deprecated.  Use spot_msgs-msg:frame_name_fiducial instead.")
  (frame_name_fiducial m))

(cl:ensure-generic-function 'fiducial_pose_status-val :lambda-list '(m))
(cl:defmethod fiducial_pose_status-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:fiducial_pose_status-val is deprecated.  Use spot_msgs-msg:fiducial_pose_status instead.")
  (fiducial_pose_status m))

(cl:ensure-generic-function 'frame_name_fiducial_filtered-val :lambda-list '(m))
(cl:defmethod frame_name_fiducial_filtered-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_name_fiducial_filtered-val is deprecated.  Use spot_msgs-msg:frame_name_fiducial_filtered instead.")
  (frame_name_fiducial_filtered m))

(cl:ensure-generic-function 'fiducial_filtered_pose_status-val :lambda-list '(m))
(cl:defmethod fiducial_filtered_pose_status-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:fiducial_filtered_pose_status-val is deprecated.  Use spot_msgs-msg:fiducial_filtered_pose_status instead.")
  (fiducial_filtered_pose_status m))

(cl:ensure-generic-function 'frame_name_camera-val :lambda-list '(m))
(cl:defmethod frame_name_camera-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_name_camera-val is deprecated.  Use spot_msgs-msg:frame_name_camera instead.")
  (frame_name_camera m))

(cl:ensure-generic-function 'detection_covariance-val :lambda-list '(m))
(cl:defmethod detection_covariance-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:detection_covariance-val is deprecated.  Use spot_msgs-msg:detection_covariance instead.")
  (detection_covariance m))

(cl:ensure-generic-function 'detection_covariance_reference_frame-val :lambda-list '(m))
(cl:defmethod detection_covariance_reference_frame-val ((m <AprilTagProperties>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:detection_covariance_reference_frame-val is deprecated.  Use spot_msgs-msg:detection_covariance_reference_frame instead.")
  (detection_covariance_reference_frame m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<AprilTagProperties>)))
    "Constants for message type '<AprilTagProperties>"
  '((:STATUS_UNKNOWN . 0)
    (:STATUS_OK . 1)
    (:STATUS_AMBIGUOUS . 2)
    (:STATUS_HIGH_ERROR . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'AprilTagProperties)))
    "Constants for message type 'AprilTagProperties"
  '((:STATUS_UNKNOWN . 0)
    (:STATUS_OK . 1)
    (:STATUS_AMBIGUOUS . 2)
    (:STATUS_HIGH_ERROR . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AprilTagProperties>) ostream)
  "Serializes a message object of type '<AprilTagProperties>"
  (cl:let* ((signed (cl:slot-value msg 'tag_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name_fiducial))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name_fiducial))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fiducial_pose_status)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name_fiducial_filtered))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name_fiducial_filtered))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fiducial_filtered_pose_status)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name_camera))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name_camera))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'detection_covariance) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'detection_covariance_reference_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'detection_covariance_reference_frame))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AprilTagProperties>) istream)
  "Deserializes a message object of type '<AprilTagProperties>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tag_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name_fiducial) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name_fiducial) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fiducial_pose_status)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name_fiducial_filtered) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name_fiducial_filtered) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fiducial_filtered_pose_status)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name_camera) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name_camera) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'detection_covariance) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'detection_covariance_reference_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'detection_covariance_reference_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AprilTagProperties>)))
  "Returns string type for a message object of type '<AprilTagProperties>"
  "spot_msgs/AprilTagProperties")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AprilTagProperties)))
  "Returns string type for a message object of type 'AprilTagProperties"
  "spot_msgs/AprilTagProperties")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AprilTagProperties>)))
  "Returns md5sum for a message object of type '<AprilTagProperties>"
  "035439ca15acb004b11a25a16f3fd1de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AprilTagProperties)))
  "Returns md5sum for a message object of type 'AprilTagProperties"
  "035439ca15acb004b11a25a16f3fd1de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AprilTagProperties>)))
  "Returns full string definition for message of type '<AprilTagProperties>"
  (cl:format cl:nil "# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_OK = 1~%uint8 STATUS_AMBIGUOUS = 2~%uint8 STATUS_HIGH_ERROR = 3~%~%int32 tag_id~%float64 x~%float64 y~%~%string frame_name_fiducial~%uint8 fiducial_pose_status~%~%string frame_name_fiducial_filtered~%uint8 fiducial_filtered_pose_status~%~%string frame_name_camera~%~%geometry_msgs/PoseWithCovariance detection_covariance~%string detection_covariance_reference_frame~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AprilTagProperties)))
  "Returns full string definition for message of type 'AprilTagProperties"
  (cl:format cl:nil "# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_OK = 1~%uint8 STATUS_AMBIGUOUS = 2~%uint8 STATUS_HIGH_ERROR = 3~%~%int32 tag_id~%float64 x~%float64 y~%~%string frame_name_fiducial~%uint8 fiducial_pose_status~%~%string frame_name_fiducial_filtered~%uint8 fiducial_filtered_pose_status~%~%string frame_name_camera~%~%geometry_msgs/PoseWithCovariance detection_covariance~%string detection_covariance_reference_frame~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AprilTagProperties>))
  (cl:+ 0
     4
     8
     8
     4 (cl:length (cl:slot-value msg 'frame_name_fiducial))
     1
     4 (cl:length (cl:slot-value msg 'frame_name_fiducial_filtered))
     1
     4 (cl:length (cl:slot-value msg 'frame_name_camera))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'detection_covariance))
     4 (cl:length (cl:slot-value msg 'detection_covariance_reference_frame))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AprilTagProperties>))
  "Converts a ROS message object to a list"
  (cl:list 'AprilTagProperties
    (cl:cons ':tag_id (tag_id msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':frame_name_fiducial (frame_name_fiducial msg))
    (cl:cons ':fiducial_pose_status (fiducial_pose_status msg))
    (cl:cons ':frame_name_fiducial_filtered (frame_name_fiducial_filtered msg))
    (cl:cons ':fiducial_filtered_pose_status (fiducial_filtered_pose_status msg))
    (cl:cons ':frame_name_camera (frame_name_camera msg))
    (cl:cons ':detection_covariance (detection_covariance msg))
    (cl:cons ':detection_covariance_reference_frame (detection_covariance_reference_frame msg))
))
