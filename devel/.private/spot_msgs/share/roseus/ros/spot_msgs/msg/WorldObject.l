;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::WorldObject)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'WorldObject (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::WORLDOBJECT")
  (make-package "SPOT_MSGS::WORLDOBJECT"))

(in-package "ROS")
;;//! \htmlinclude WorldObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*DOCK_TYPE_UNKNOWN*" (find-package "SPOT_MSGS::WORLDOBJECT"))
(shadow '*DOCK_TYPE_UNKNOWN* (find-package "SPOT_MSGS::WORLDOBJECT"))
(defconstant spot_msgs::WorldObject::*DOCK_TYPE_UNKNOWN* 0)
(intern "*DOCK_TYPE_CONTACT_PROTOTYPE*" (find-package "SPOT_MSGS::WORLDOBJECT"))
(shadow '*DOCK_TYPE_CONTACT_PROTOTYPE* (find-package "SPOT_MSGS::WORLDOBJECT"))
(defconstant spot_msgs::WorldObject::*DOCK_TYPE_CONTACT_PROTOTYPE* 2)
(intern "*DOCK_TYPE_SPOT_DOCK*" (find-package "SPOT_MSGS::WORLDOBJECT"))
(shadow '*DOCK_TYPE_SPOT_DOCK* (find-package "SPOT_MSGS::WORLDOBJECT"))
(defconstant spot_msgs::WorldObject::*DOCK_TYPE_SPOT_DOCK* 3)

(defun spot_msgs::WorldObject-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::WorldObject::*DOCK_TYPE_UNKNOWN*)
        ((= const 2) 'spot_msgs::WorldObject::*DOCK_TYPE_CONTACT_PROTOTYPE*)
        ((= const 3) 'spot_msgs::WorldObject::*DOCK_TYPE_SPOT_DOCK*)
        (t nil)))

(defclass spot_msgs::WorldObject
  :super ros::object
  :slots (_id _name _acquisition_time _frame_tree_snapshot _apriltag_properties _image_properties _dock_id _dock_type _frame_name_dock _dock_unavailable _from_prior_detection _ray_frame _ray_origin _ray_direction _bounding_box_frame _bounding_box_size_ewrt_frame ))

(defmethod spot_msgs::WorldObject
  (:init
   (&key
    ((:id __id) 0)
    ((:name __name) "")
    ((:acquisition_time __acquisition_time) (instance ros::time :init))
    ((:frame_tree_snapshot __frame_tree_snapshot) (instance spot_msgs::FrameTreeSnapshot :init))
    ((:apriltag_properties __apriltag_properties) (instance spot_msgs::AprilTagProperties :init))
    ((:image_properties __image_properties) (instance spot_msgs::ImageProperties :init))
    ((:dock_id __dock_id) 0)
    ((:dock_type __dock_type) 0)
    ((:frame_name_dock __frame_name_dock) "")
    ((:dock_unavailable __dock_unavailable) nil)
    ((:from_prior_detection __from_prior_detection) nil)
    ((:ray_frame __ray_frame) "")
    ((:ray_origin __ray_origin) (instance geometry_msgs::Vector3 :init))
    ((:ray_direction __ray_direction) (instance geometry_msgs::Vector3 :init))
    ((:bounding_box_frame __bounding_box_frame) "")
    ((:bounding_box_size_ewrt_frame __bounding_box_size_ewrt_frame) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _name (string __name))
   (setq _acquisition_time __acquisition_time)
   (setq _frame_tree_snapshot __frame_tree_snapshot)
   (setq _apriltag_properties __apriltag_properties)
   (setq _image_properties __image_properties)
   (setq _dock_id (round __dock_id))
   (setq _dock_type (round __dock_type))
   (setq _frame_name_dock (string __frame_name_dock))
   (setq _dock_unavailable __dock_unavailable)
   (setq _from_prior_detection __from_prior_detection)
   (setq _ray_frame (string __ray_frame))
   (setq _ray_origin __ray_origin)
   (setq _ray_direction __ray_direction)
   (setq _bounding_box_frame (string __bounding_box_frame))
   (setq _bounding_box_size_ewrt_frame __bounding_box_size_ewrt_frame)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:acquisition_time
   (&optional __acquisition_time)
   (if __acquisition_time (setq _acquisition_time __acquisition_time)) _acquisition_time)
  (:frame_tree_snapshot
   (&rest __frame_tree_snapshot)
   (if (keywordp (car __frame_tree_snapshot))
       (send* _frame_tree_snapshot __frame_tree_snapshot)
     (progn
       (if __frame_tree_snapshot (setq _frame_tree_snapshot (car __frame_tree_snapshot)))
       _frame_tree_snapshot)))
  (:apriltag_properties
   (&rest __apriltag_properties)
   (if (keywordp (car __apriltag_properties))
       (send* _apriltag_properties __apriltag_properties)
     (progn
       (if __apriltag_properties (setq _apriltag_properties (car __apriltag_properties)))
       _apriltag_properties)))
  (:image_properties
   (&rest __image_properties)
   (if (keywordp (car __image_properties))
       (send* _image_properties __image_properties)
     (progn
       (if __image_properties (setq _image_properties (car __image_properties)))
       _image_properties)))
  (:dock_id
   (&optional __dock_id)
   (if __dock_id (setq _dock_id __dock_id)) _dock_id)
  (:dock_type
   (&optional __dock_type)
   (if __dock_type (setq _dock_type __dock_type)) _dock_type)
  (:frame_name_dock
   (&optional __frame_name_dock)
   (if __frame_name_dock (setq _frame_name_dock __frame_name_dock)) _frame_name_dock)
  (:dock_unavailable
   (&optional (__dock_unavailable :null))
   (if (not (eq __dock_unavailable :null)) (setq _dock_unavailable __dock_unavailable)) _dock_unavailable)
  (:from_prior_detection
   (&optional (__from_prior_detection :null))
   (if (not (eq __from_prior_detection :null)) (setq _from_prior_detection __from_prior_detection)) _from_prior_detection)
  (:ray_frame
   (&optional __ray_frame)
   (if __ray_frame (setq _ray_frame __ray_frame)) _ray_frame)
  (:ray_origin
   (&rest __ray_origin)
   (if (keywordp (car __ray_origin))
       (send* _ray_origin __ray_origin)
     (progn
       (if __ray_origin (setq _ray_origin (car __ray_origin)))
       _ray_origin)))
  (:ray_direction
   (&rest __ray_direction)
   (if (keywordp (car __ray_direction))
       (send* _ray_direction __ray_direction)
     (progn
       (if __ray_direction (setq _ray_direction (car __ray_direction)))
       _ray_direction)))
  (:bounding_box_frame
   (&optional __bounding_box_frame)
   (if __bounding_box_frame (setq _bounding_box_frame __bounding_box_frame)) _bounding_box_frame)
  (:bounding_box_size_ewrt_frame
   (&rest __bounding_box_size_ewrt_frame)
   (if (keywordp (car __bounding_box_size_ewrt_frame))
       (send* _bounding_box_size_ewrt_frame __bounding_box_size_ewrt_frame)
     (progn
       (if __bounding_box_size_ewrt_frame (setq _bounding_box_size_ewrt_frame (car __bounding_box_size_ewrt_frame)))
       _bounding_box_size_ewrt_frame)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; string _name
    4 (length _name)
    ;; time _acquisition_time
    8
    ;; spot_msgs/FrameTreeSnapshot _frame_tree_snapshot
    (send _frame_tree_snapshot :serialization-length)
    ;; spot_msgs/AprilTagProperties _apriltag_properties
    (send _apriltag_properties :serialization-length)
    ;; spot_msgs/ImageProperties _image_properties
    (send _image_properties :serialization-length)
    ;; int32 _dock_id
    4
    ;; uint8 _dock_type
    1
    ;; string _frame_name_dock
    4 (length _frame_name_dock)
    ;; bool _dock_unavailable
    1
    ;; bool _from_prior_detection
    1
    ;; string _ray_frame
    4 (length _ray_frame)
    ;; geometry_msgs/Vector3 _ray_origin
    (send _ray_origin :serialization-length)
    ;; geometry_msgs/Vector3 _ray_direction
    (send _ray_direction :serialization-length)
    ;; string _bounding_box_frame
    4 (length _bounding_box_frame)
    ;; geometry_msgs/Vector3 _bounding_box_size_ewrt_frame
    (send _bounding_box_size_ewrt_frame :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; time _acquisition_time
       (write-long (send _acquisition_time :sec) s) (write-long (send _acquisition_time :nsec) s)
     ;; spot_msgs/FrameTreeSnapshot _frame_tree_snapshot
       (send _frame_tree_snapshot :serialize s)
     ;; spot_msgs/AprilTagProperties _apriltag_properties
       (send _apriltag_properties :serialize s)
     ;; spot_msgs/ImageProperties _image_properties
       (send _image_properties :serialize s)
     ;; int32 _dock_id
       (write-long _dock_id s)
     ;; uint8 _dock_type
       (write-byte _dock_type s)
     ;; string _frame_name_dock
       (write-long (length _frame_name_dock) s) (princ _frame_name_dock s)
     ;; bool _dock_unavailable
       (if _dock_unavailable (write-byte -1 s) (write-byte 0 s))
     ;; bool _from_prior_detection
       (if _from_prior_detection (write-byte -1 s) (write-byte 0 s))
     ;; string _ray_frame
       (write-long (length _ray_frame) s) (princ _ray_frame s)
     ;; geometry_msgs/Vector3 _ray_origin
       (send _ray_origin :serialize s)
     ;; geometry_msgs/Vector3 _ray_direction
       (send _ray_direction :serialize s)
     ;; string _bounding_box_frame
       (write-long (length _bounding_box_frame) s) (princ _bounding_box_frame s)
     ;; geometry_msgs/Vector3 _bounding_box_size_ewrt_frame
       (send _bounding_box_size_ewrt_frame :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; time _acquisition_time
     (send _acquisition_time :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _acquisition_time :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; spot_msgs/FrameTreeSnapshot _frame_tree_snapshot
     (send _frame_tree_snapshot :deserialize buf ptr-) (incf ptr- (send _frame_tree_snapshot :serialization-length))
   ;; spot_msgs/AprilTagProperties _apriltag_properties
     (send _apriltag_properties :deserialize buf ptr-) (incf ptr- (send _apriltag_properties :serialization-length))
   ;; spot_msgs/ImageProperties _image_properties
     (send _image_properties :deserialize buf ptr-) (incf ptr- (send _image_properties :serialization-length))
   ;; int32 _dock_id
     (setq _dock_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _dock_type
     (setq _dock_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _frame_name_dock
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name_dock (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _dock_unavailable
     (setq _dock_unavailable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _from_prior_detection
     (setq _from_prior_detection (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _ray_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _ray_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Vector3 _ray_origin
     (send _ray_origin :deserialize buf ptr-) (incf ptr- (send _ray_origin :serialization-length))
   ;; geometry_msgs/Vector3 _ray_direction
     (send _ray_direction :deserialize buf ptr-) (incf ptr- (send _ray_direction :serialization-length))
   ;; string _bounding_box_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _bounding_box_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Vector3 _bounding_box_size_ewrt_frame
     (send _bounding_box_size_ewrt_frame :deserialize buf ptr-) (incf ptr- (send _bounding_box_size_ewrt_frame :serialization-length))
   ;;
   self)
  )

(setf (get spot_msgs::WorldObject :md5sum-) "6886a66dad17ad58030255815149c776")
(setf (get spot_msgs::WorldObject :datatype-) "spot_msgs/WorldObject")
(setf (get spot_msgs::WorldObject :definition-)
      "int32 id
string name
time acquisition_time

### Frame tree
FrameTreeSnapshot frame_tree_snapshot

### AprilTag properties
AprilTagProperties apriltag_properties

### Image properties
ImageProperties image_properties

### Dock properties
# Dock type enum
uint8 DOCK_TYPE_UNKNOWN=0
uint8 DOCK_TYPE_CONTACT_PROTOTYPE=2
uint8 DOCK_TYPE_SPOT_DOCK=3

int32 dock_id
uint8 dock_type

string frame_name_dock
bool dock_unavailable
bool from_prior_detection

### Ray properties
string ray_frame
geometry_msgs/Vector3 ray_origin
geometry_msgs/Vector3 ray_direction

### Bounding box properties
string bounding_box_frame
geometry_msgs/Vector3 bounding_box_size_ewrt_frame

================================================================================
MSG: spot_msgs/FrameTreeSnapshot
string[] child_edges
ParentEdge[] parent_edges
================================================================================
MSG: spot_msgs/ParentEdge
string parent_frame_name
geometry_msgs/Pose parent_tform_child
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: spot_msgs/AprilTagProperties
# Status
uint8 STATUS_UNKNOWN = 0
uint8 STATUS_OK = 1
uint8 STATUS_AMBIGUOUS = 2
uint8 STATUS_HIGH_ERROR = 3

int32 tag_id
float64 x
float64 y

string frame_name_fiducial
uint8 fiducial_pose_status

string frame_name_fiducial_filtered
uint8 fiducial_filtered_pose_status

string frame_name_camera

geometry_msgs/PoseWithCovariance detection_covariance
string detection_covariance_reference_frame
================================================================================
MSG: geometry_msgs/PoseWithCovariance
# This represents a pose in free space with uncertainty.

Pose pose

# Row-major representation of the 6x6 covariance matrix
# The orientation parameters use a fixed-axis representation.
# In order, the parameters are:
# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
float64[36] covariance

================================================================================
MSG: spot_msgs/ImageProperties
string camera_source

# Polygon coordinates
geometry_msgs/Polygon image_data_coordinates

# Keypoint coordinates
uint8 KEYPOINT_UNKNOWN=0
uint8 KEYPOINT_SIMPLE=1
uint8 KEYPOINT_ORB=2

uint8 image_data_keypoint_type
int32[] keypoint_coordinate_x
int32[] keypoint_coordinate_y
string[] binary_descriptor
float64[] keypoint_score
float64[] keypoint_size
float64[] keypoint_angle

ImageSource image_source
ImageCapture image_capture

string frame_name_image_coordinates
================================================================================
MSG: geometry_msgs/Polygon
#A specification of a polygon where the first and last points are assumed to be connected
Point32[] points

================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
================================================================================
MSG: spot_msgs/ImageSource
# Image type enums
uint8 IMAGE_TYPE_UNKNOWN = 0
uint8 IMAGE_TYPE_VISUAL = 1
uint8 IMAGE_TYPE_DEPTH = 2

# Pixel format enums
uint8 PIXEL_FORMAT_UNKNOWN = 0
uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1
uint8 PIXEL_FORMAT_RGB_U8 = 3
uint8 PIXEL_FORMAT_RGBA_U8 = 4
uint8 PIXEL_FORMAT_DEPTH_U16 = 5
uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6

# Image format enums
uint8 FORMAT_UNKNOWN = 0
uint8 FORMAT_JPEG = 1
uint8 FORMAT_RAW = 2
uint8 FORMAT_RLE = 3

string name
int32 cols
int32 rows
float64 depth_scale

# Camera pinhole model parameters
float64 focal_length_x
float64 focal_length_y
float64 principal_point_x
float64 principal_point_y
float64 skew_x
float64 skew_y

uint8 image_type
uint8[] pixel_formats
uint8[] image_formats

================================================================================
MSG: spot_msgs/ImageCapture
time acquisition_time

FrameTreeSnapshot transforms_snapshot
string frame_name_image_sensor

sensor_msgs/Image image

duration capture_exposure_duration
float64 capture_sensor_gain

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :spot_msgs/WorldObject "6886a66dad17ad58030255815149c776")


