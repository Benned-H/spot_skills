; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude WorldObject.msg.html

(cl:defclass <WorldObject> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (acquisition_time
    :reader acquisition_time
    :initarg :acquisition_time
    :type cl:real
    :initform 0)
   (frame_tree_snapshot
    :reader frame_tree_snapshot
    :initarg :frame_tree_snapshot
    :type spot_msgs-msg:FrameTreeSnapshot
    :initform (cl:make-instance 'spot_msgs-msg:FrameTreeSnapshot))
   (apriltag_properties
    :reader apriltag_properties
    :initarg :apriltag_properties
    :type spot_msgs-msg:AprilTagProperties
    :initform (cl:make-instance 'spot_msgs-msg:AprilTagProperties))
   (image_properties
    :reader image_properties
    :initarg :image_properties
    :type spot_msgs-msg:ImageProperties
    :initform (cl:make-instance 'spot_msgs-msg:ImageProperties))
   (dock_id
    :reader dock_id
    :initarg :dock_id
    :type cl:integer
    :initform 0)
   (dock_type
    :reader dock_type
    :initarg :dock_type
    :type cl:fixnum
    :initform 0)
   (frame_name_dock
    :reader frame_name_dock
    :initarg :frame_name_dock
    :type cl:string
    :initform "")
   (dock_unavailable
    :reader dock_unavailable
    :initarg :dock_unavailable
    :type cl:boolean
    :initform cl:nil)
   (from_prior_detection
    :reader from_prior_detection
    :initarg :from_prior_detection
    :type cl:boolean
    :initform cl:nil)
   (ray_frame
    :reader ray_frame
    :initarg :ray_frame
    :type cl:string
    :initform "")
   (ray_origin
    :reader ray_origin
    :initarg :ray_origin
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (ray_direction
    :reader ray_direction
    :initarg :ray_direction
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (bounding_box_frame
    :reader bounding_box_frame
    :initarg :bounding_box_frame
    :type cl:string
    :initform "")
   (bounding_box_size_ewrt_frame
    :reader bounding_box_size_ewrt_frame
    :initarg :bounding_box_size_ewrt_frame
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3)))
)

(cl:defclass WorldObject (<WorldObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WorldObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WorldObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<WorldObject> is deprecated: use spot_msgs-msg:WorldObject instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:id-val is deprecated.  Use spot_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:name-val is deprecated.  Use spot_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'acquisition_time-val :lambda-list '(m))
(cl:defmethod acquisition_time-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:acquisition_time-val is deprecated.  Use spot_msgs-msg:acquisition_time instead.")
  (acquisition_time m))

(cl:ensure-generic-function 'frame_tree_snapshot-val :lambda-list '(m))
(cl:defmethod frame_tree_snapshot-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_tree_snapshot-val is deprecated.  Use spot_msgs-msg:frame_tree_snapshot instead.")
  (frame_tree_snapshot m))

(cl:ensure-generic-function 'apriltag_properties-val :lambda-list '(m))
(cl:defmethod apriltag_properties-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:apriltag_properties-val is deprecated.  Use spot_msgs-msg:apriltag_properties instead.")
  (apriltag_properties m))

(cl:ensure-generic-function 'image_properties-val :lambda-list '(m))
(cl:defmethod image_properties-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:image_properties-val is deprecated.  Use spot_msgs-msg:image_properties instead.")
  (image_properties m))

(cl:ensure-generic-function 'dock_id-val :lambda-list '(m))
(cl:defmethod dock_id-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:dock_id-val is deprecated.  Use spot_msgs-msg:dock_id instead.")
  (dock_id m))

(cl:ensure-generic-function 'dock_type-val :lambda-list '(m))
(cl:defmethod dock_type-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:dock_type-val is deprecated.  Use spot_msgs-msg:dock_type instead.")
  (dock_type m))

(cl:ensure-generic-function 'frame_name_dock-val :lambda-list '(m))
(cl:defmethod frame_name_dock-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:frame_name_dock-val is deprecated.  Use spot_msgs-msg:frame_name_dock instead.")
  (frame_name_dock m))

(cl:ensure-generic-function 'dock_unavailable-val :lambda-list '(m))
(cl:defmethod dock_unavailable-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:dock_unavailable-val is deprecated.  Use spot_msgs-msg:dock_unavailable instead.")
  (dock_unavailable m))

(cl:ensure-generic-function 'from_prior_detection-val :lambda-list '(m))
(cl:defmethod from_prior_detection-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:from_prior_detection-val is deprecated.  Use spot_msgs-msg:from_prior_detection instead.")
  (from_prior_detection m))

(cl:ensure-generic-function 'ray_frame-val :lambda-list '(m))
(cl:defmethod ray_frame-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:ray_frame-val is deprecated.  Use spot_msgs-msg:ray_frame instead.")
  (ray_frame m))

(cl:ensure-generic-function 'ray_origin-val :lambda-list '(m))
(cl:defmethod ray_origin-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:ray_origin-val is deprecated.  Use spot_msgs-msg:ray_origin instead.")
  (ray_origin m))

(cl:ensure-generic-function 'ray_direction-val :lambda-list '(m))
(cl:defmethod ray_direction-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:ray_direction-val is deprecated.  Use spot_msgs-msg:ray_direction instead.")
  (ray_direction m))

(cl:ensure-generic-function 'bounding_box_frame-val :lambda-list '(m))
(cl:defmethod bounding_box_frame-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:bounding_box_frame-val is deprecated.  Use spot_msgs-msg:bounding_box_frame instead.")
  (bounding_box_frame m))

(cl:ensure-generic-function 'bounding_box_size_ewrt_frame-val :lambda-list '(m))
(cl:defmethod bounding_box_size_ewrt_frame-val ((m <WorldObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:bounding_box_size_ewrt_frame-val is deprecated.  Use spot_msgs-msg:bounding_box_size_ewrt_frame instead.")
  (bounding_box_size_ewrt_frame m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WorldObject>)))
    "Constants for message type '<WorldObject>"
  '((:DOCK_TYPE_UNKNOWN . 0)
    (:DOCK_TYPE_CONTACT_PROTOTYPE . 2)
    (:DOCK_TYPE_SPOT_DOCK . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WorldObject)))
    "Constants for message type 'WorldObject"
  '((:DOCK_TYPE_UNKNOWN . 0)
    (:DOCK_TYPE_CONTACT_PROTOTYPE . 2)
    (:DOCK_TYPE_SPOT_DOCK . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WorldObject>) ostream)
  "Serializes a message object of type '<WorldObject>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
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
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frame_tree_snapshot) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'apriltag_properties) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image_properties) ostream)
  (cl:let* ((signed (cl:slot-value msg 'dock_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_type)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'frame_name_dock))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'frame_name_dock))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'dock_unavailable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'from_prior_detection) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'ray_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'ray_frame))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ray_origin) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ray_direction) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'bounding_box_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'bounding_box_frame))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'bounding_box_size_ewrt_frame) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WorldObject>) istream)
  "Deserializes a message object of type '<WorldObject>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frame_tree_snapshot) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'apriltag_properties) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image_properties) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dock_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'dock_type)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_name_dock) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'frame_name_dock) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'dock_unavailable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'from_prior_detection) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ray_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'ray_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ray_origin) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ray_direction) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bounding_box_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'bounding_box_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'bounding_box_size_ewrt_frame) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WorldObject>)))
  "Returns string type for a message object of type '<WorldObject>"
  "spot_msgs/WorldObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WorldObject)))
  "Returns string type for a message object of type 'WorldObject"
  "spot_msgs/WorldObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WorldObject>)))
  "Returns md5sum for a message object of type '<WorldObject>"
  "6886a66dad17ad58030255815149c776")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WorldObject)))
  "Returns md5sum for a message object of type 'WorldObject"
  "6886a66dad17ad58030255815149c776")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WorldObject>)))
  "Returns full string definition for message of type '<WorldObject>"
  (cl:format cl:nil "int32 id~%string name~%time acquisition_time~%~%### Frame tree~%FrameTreeSnapshot frame_tree_snapshot~%~%### AprilTag properties~%AprilTagProperties apriltag_properties~%~%### Image properties~%ImageProperties image_properties~%~%### Dock properties~%# Dock type enum~%uint8 DOCK_TYPE_UNKNOWN=0~%uint8 DOCK_TYPE_CONTACT_PROTOTYPE=2~%uint8 DOCK_TYPE_SPOT_DOCK=3~%~%int32 dock_id~%uint8 dock_type~%~%string frame_name_dock~%bool dock_unavailable~%bool from_prior_detection~%~%### Ray properties~%string ray_frame~%geometry_msgs/Vector3 ray_origin~%geometry_msgs/Vector3 ray_direction~%~%### Bounding box properties~%string bounding_box_frame~%geometry_msgs/Vector3 bounding_box_size_ewrt_frame~%~%================================================================================~%MSG: spot_msgs/FrameTreeSnapshot~%string[] child_edges~%ParentEdge[] parent_edges~%================================================================================~%MSG: spot_msgs/ParentEdge~%string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: spot_msgs/AprilTagProperties~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_OK = 1~%uint8 STATUS_AMBIGUOUS = 2~%uint8 STATUS_HIGH_ERROR = 3~%~%int32 tag_id~%float64 x~%float64 y~%~%string frame_name_fiducial~%uint8 fiducial_pose_status~%~%string frame_name_fiducial_filtered~%uint8 fiducial_filtered_pose_status~%~%string frame_name_camera~%~%geometry_msgs/PoseWithCovariance detection_covariance~%string detection_covariance_reference_frame~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: spot_msgs/ImageProperties~%string camera_source~%~%# Polygon coordinates~%geometry_msgs/Polygon image_data_coordinates~%~%# Keypoint coordinates~%uint8 KEYPOINT_UNKNOWN=0~%uint8 KEYPOINT_SIMPLE=1~%uint8 KEYPOINT_ORB=2~%~%uint8 image_data_keypoint_type~%int32[] keypoint_coordinate_x~%int32[] keypoint_coordinate_y~%string[] binary_descriptor~%float64[] keypoint_score~%float64[] keypoint_size~%float64[] keypoint_angle~%~%ImageSource image_source~%ImageCapture image_capture~%~%string frame_name_image_coordinates~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: spot_msgs/ImageSource~%# Image type enums~%uint8 IMAGE_TYPE_UNKNOWN = 0~%uint8 IMAGE_TYPE_VISUAL = 1~%uint8 IMAGE_TYPE_DEPTH = 2~%~%# Pixel format enums~%uint8 PIXEL_FORMAT_UNKNOWN = 0~%uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1~%uint8 PIXEL_FORMAT_RGB_U8 = 3~%uint8 PIXEL_FORMAT_RGBA_U8 = 4~%uint8 PIXEL_FORMAT_DEPTH_U16 = 5~%uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6~%~%# Image format enums~%uint8 FORMAT_UNKNOWN = 0~%uint8 FORMAT_JPEG = 1~%uint8 FORMAT_RAW = 2~%uint8 FORMAT_RLE = 3~%~%string name~%int32 cols~%int32 rows~%float64 depth_scale~%~%# Camera pinhole model parameters~%float64 focal_length_x~%float64 focal_length_y~%float64 principal_point_x~%float64 principal_point_y~%float64 skew_x~%float64 skew_y~%~%uint8 image_type~%uint8[] pixel_formats~%uint8[] image_formats~%~%================================================================================~%MSG: spot_msgs/ImageCapture~%time acquisition_time~%~%FrameTreeSnapshot transforms_snapshot~%string frame_name_image_sensor~%~%sensor_msgs/Image image~%~%duration capture_exposure_duration~%float64 capture_sensor_gain~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WorldObject)))
  "Returns full string definition for message of type 'WorldObject"
  (cl:format cl:nil "int32 id~%string name~%time acquisition_time~%~%### Frame tree~%FrameTreeSnapshot frame_tree_snapshot~%~%### AprilTag properties~%AprilTagProperties apriltag_properties~%~%### Image properties~%ImageProperties image_properties~%~%### Dock properties~%# Dock type enum~%uint8 DOCK_TYPE_UNKNOWN=0~%uint8 DOCK_TYPE_CONTACT_PROTOTYPE=2~%uint8 DOCK_TYPE_SPOT_DOCK=3~%~%int32 dock_id~%uint8 dock_type~%~%string frame_name_dock~%bool dock_unavailable~%bool from_prior_detection~%~%### Ray properties~%string ray_frame~%geometry_msgs/Vector3 ray_origin~%geometry_msgs/Vector3 ray_direction~%~%### Bounding box properties~%string bounding_box_frame~%geometry_msgs/Vector3 bounding_box_size_ewrt_frame~%~%================================================================================~%MSG: spot_msgs/FrameTreeSnapshot~%string[] child_edges~%ParentEdge[] parent_edges~%================================================================================~%MSG: spot_msgs/ParentEdge~%string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: spot_msgs/AprilTagProperties~%# Status~%uint8 STATUS_UNKNOWN = 0~%uint8 STATUS_OK = 1~%uint8 STATUS_AMBIGUOUS = 2~%uint8 STATUS_HIGH_ERROR = 3~%~%int32 tag_id~%float64 x~%float64 y~%~%string frame_name_fiducial~%uint8 fiducial_pose_status~%~%string frame_name_fiducial_filtered~%uint8 fiducial_filtered_pose_status~%~%string frame_name_camera~%~%geometry_msgs/PoseWithCovariance detection_covariance~%string detection_covariance_reference_frame~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: spot_msgs/ImageProperties~%string camera_source~%~%# Polygon coordinates~%geometry_msgs/Polygon image_data_coordinates~%~%# Keypoint coordinates~%uint8 KEYPOINT_UNKNOWN=0~%uint8 KEYPOINT_SIMPLE=1~%uint8 KEYPOINT_ORB=2~%~%uint8 image_data_keypoint_type~%int32[] keypoint_coordinate_x~%int32[] keypoint_coordinate_y~%string[] binary_descriptor~%float64[] keypoint_score~%float64[] keypoint_size~%float64[] keypoint_angle~%~%ImageSource image_source~%ImageCapture image_capture~%~%string frame_name_image_coordinates~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: spot_msgs/ImageSource~%# Image type enums~%uint8 IMAGE_TYPE_UNKNOWN = 0~%uint8 IMAGE_TYPE_VISUAL = 1~%uint8 IMAGE_TYPE_DEPTH = 2~%~%# Pixel format enums~%uint8 PIXEL_FORMAT_UNKNOWN = 0~%uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1~%uint8 PIXEL_FORMAT_RGB_U8 = 3~%uint8 PIXEL_FORMAT_RGBA_U8 = 4~%uint8 PIXEL_FORMAT_DEPTH_U16 = 5~%uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6~%~%# Image format enums~%uint8 FORMAT_UNKNOWN = 0~%uint8 FORMAT_JPEG = 1~%uint8 FORMAT_RAW = 2~%uint8 FORMAT_RLE = 3~%~%string name~%int32 cols~%int32 rows~%float64 depth_scale~%~%# Camera pinhole model parameters~%float64 focal_length_x~%float64 focal_length_y~%float64 principal_point_x~%float64 principal_point_y~%float64 skew_x~%float64 skew_y~%~%uint8 image_type~%uint8[] pixel_formats~%uint8[] image_formats~%~%================================================================================~%MSG: spot_msgs/ImageCapture~%time acquisition_time~%~%FrameTreeSnapshot transforms_snapshot~%string frame_name_image_sensor~%~%sensor_msgs/Image image~%~%duration capture_exposure_duration~%float64 capture_sensor_gain~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WorldObject>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'name))
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frame_tree_snapshot))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'apriltag_properties))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image_properties))
     4
     1
     4 (cl:length (cl:slot-value msg 'frame_name_dock))
     1
     1
     4 (cl:length (cl:slot-value msg 'ray_frame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ray_origin))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ray_direction))
     4 (cl:length (cl:slot-value msg 'bounding_box_frame))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'bounding_box_size_ewrt_frame))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WorldObject>))
  "Converts a ROS message object to a list"
  (cl:list 'WorldObject
    (cl:cons ':id (id msg))
    (cl:cons ':name (name msg))
    (cl:cons ':acquisition_time (acquisition_time msg))
    (cl:cons ':frame_tree_snapshot (frame_tree_snapshot msg))
    (cl:cons ':apriltag_properties (apriltag_properties msg))
    (cl:cons ':image_properties (image_properties msg))
    (cl:cons ':dock_id (dock_id msg))
    (cl:cons ':dock_type (dock_type msg))
    (cl:cons ':frame_name_dock (frame_name_dock msg))
    (cl:cons ':dock_unavailable (dock_unavailable msg))
    (cl:cons ':from_prior_detection (from_prior_detection msg))
    (cl:cons ':ray_frame (ray_frame msg))
    (cl:cons ':ray_origin (ray_origin msg))
    (cl:cons ':ray_direction (ray_direction msg))
    (cl:cons ':bounding_box_frame (bounding_box_frame msg))
    (cl:cons ':bounding_box_size_ewrt_frame (bounding_box_size_ewrt_frame msg))
))
