; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude ImageCapture.msg.html

(cl:defclass <ImageCapture> (roslisp-msg-protocol:ros-message)
  ((acquisition_time
    :reader acquisition_time
    :initarg :acquisition_time
    :type cl:real
    :initform 0)
   (transforms_snapshot
    :reader transforms_snapshot
    :initarg :transforms_snapshot
    :type spot_msgs-msg:FrameTreeSnapshot
    :initform (cl:make-instance 'spot_msgs-msg:FrameTreeSnapshot))
   (frame_name_image_sensor
    :reader frame_name_image_sensor
    :initarg :frame_name_image_sensor
    :type cl:string
    :initform "")
   (image
    :reader image
    :initarg :image
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image))
   (capture_exposure_duration
    :reader capture_exposure_duration
    :initarg :capture_exposure_duration
    :type cl:real
    :initform 0)
   (capture_sensor_gain
    :reader capture_sensor_gain
    :initarg :capture_sensor_gain
    :type cl:float
    :initform 0.0))
)

(cl:defclass ImageCapture (<ImageCapture>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImageCapture>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImageCapture)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<ImageCapture> is deprecated: use spot_msgs-msg:ImageCapture instead.")))

(cl:ensure-generic-function 'acquisition_time-val :lambda-list '(m))
(cl:defmethod acquisition_time-val ((m <ImageCapture>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:acquisition_time-val is deprecated.  Use spot_msgs-msg:acquisition_time instead.")
  (acquisition_time m))

(cl:ensure-generic-function 'transforms_snapshot-val :lambda-list '(m))
(cl:defmethod transforms_snapshot-val ((m <ImageCapture>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:transforms_snapshot-val is deprecated.  Use spot_msgs-msg:transforms_snapshot instead.")
  (transforms_snapshot m))

(cl:ensure-generic-function 'frame_name_image_sensor-val :lambda-list '(m))
(cl:defmethod frame_name_image_sensor-val ((m <ImageCapture>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_name_image_sensor-val is deprecated.  Use spot_msgs-msg:frame_name_image_sensor instead.")
  (frame_name_image_sensor m))

(cl:ensure-generic-function 'image-val :lambda-list '(m))
(cl:defmethod image-val ((m <ImageCapture>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:image-val is deprecated.  Use spot_msgs-msg:image instead.")
  (image m))

(cl:ensure-generic-function 'capture_exposure_duration-val :lambda-list '(m))
(cl:defmethod capture_exposure_duration-val ((m <ImageCapture>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:capture_exposure_duration-val is deprecated.  Use spot_msgs-msg:capture_exposure_duration instead.")
  (capture_exposure_duration m))

(cl:ensure-generic-function 'capture_sensor_gain-val :lambda-list '(m))
(cl:defmethod capture_sensor_gain-val ((m <ImageCapture>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:capture_sensor_gain-val is deprecated.  Use spot_msgs-msg:capture_sensor_gain instead.")
  (capture_sensor_gain m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImageCapture>) ostream)
  "Serializes a message object of type '<ImageCapture>"
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'acquisition_time)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'acquisition_time) (cl:floor (cl:slot-value msg 'acquisition_time)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'transforms_snapshot) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name_image_sensor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name_image_sensor))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image) ostream)
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'capture_exposure_duration)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'capture_exposure_duration) (cl:floor (cl:slot-value msg 'capture_exposure_duration)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'capture_sensor_gain))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImageCapture>) istream)
  "Deserializes a message object of type '<ImageCapture>"
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'acquisition_time) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'transforms_snapshot) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name_image_sensor) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name_image_sensor) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image) istream)
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'capture_exposure_duration) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'capture_sensor_gain) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImageCapture>)))
  "Returns string type for a message object of type '<ImageCapture>"
  "spot_msgs/ImageCapture")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageCapture)))
  "Returns string type for a message object of type 'ImageCapture"
  "spot_msgs/ImageCapture")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImageCapture>)))
  "Returns md5sum for a message object of type '<ImageCapture>"
  "3f615a6b98619410c2ebd532b7113b6e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImageCapture)))
  "Returns md5sum for a message object of type 'ImageCapture"
  "3f615a6b98619410c2ebd532b7113b6e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImageCapture>)))
  "Returns full string definition for message of type '<ImageCapture>"
  (cl:format cl:nil "time acquisition_time~%~%FrameTreeSnapshot transforms_snapshot~%string frame_name_image_sensor~%~%sensor_msgs/Image image~%~%duration capture_exposure_duration~%float64 capture_sensor_gain~%~%================================================================================~%MSG: spot_msgs/FrameTreeSnapshot~%string[] child_edges~%ParentEdge[] parent_edges~%================================================================================~%MSG: spot_msgs/ParentEdge~%string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImageCapture)))
  "Returns full string definition for message of type 'ImageCapture"
  (cl:format cl:nil "time acquisition_time~%~%FrameTreeSnapshot transforms_snapshot~%string frame_name_image_sensor~%~%sensor_msgs/Image image~%~%duration capture_exposure_duration~%float64 capture_sensor_gain~%~%================================================================================~%MSG: spot_msgs/FrameTreeSnapshot~%string[] child_edges~%ParentEdge[] parent_edges~%================================================================================~%MSG: spot_msgs/ParentEdge~%string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImageCapture>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'transforms_snapshot))
     4 (cl:length (cl:slot-value msg 'frame_name_image_sensor))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image))
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImageCapture>))
  "Converts a ROS message object to a list"
  (cl:list 'ImageCapture
    (cl:cons ':acquisition_time (acquisition_time msg))
    (cl:cons ':transforms_snapshot (transforms_snapshot msg))
    (cl:cons ':frame_name_image_sensor (frame_name_image_sensor msg))
    (cl:cons ':image (image msg))
    (cl:cons ':capture_exposure_duration (capture_exposure_duration msg))
    (cl:cons ':capture_sensor_gain (capture_sensor_gain msg))
))
