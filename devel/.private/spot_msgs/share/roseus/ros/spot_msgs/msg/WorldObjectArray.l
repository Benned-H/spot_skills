;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::WorldObjectArray)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'WorldObjectArray (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::WORLDOBJECTARRAY")
  (make-package "SPOT_MSGS::WORLDOBJECTARRAY"))

(in-package "ROS")
;;//! \htmlinclude WorldObjectArray.msg.html


(defclass spot_msgs::WorldObjectArray
  :super ros::object
  :slots (_world_objects ))

(defmethod spot_msgs::WorldObjectArray
  (:init
   (&key
    ((:world_objects __world_objects) ())
    )
   (send-super :init)
   (setq _world_objects __world_objects)
   self)
  (:world_objects
   (&rest __world_objects)
   (if (keywordp (car __world_objects))
       (send* _world_objects __world_objects)
     (progn
       (if __world_objects (setq _world_objects (car __world_objects)))
       _world_objects)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/WorldObject[] _world_objects
    (apply #'+ (send-all _world_objects :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/WorldObject[] _world_objects
     (write-long (length _world_objects) s)
     (dolist (elem _world_objects)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/WorldObject[] _world_objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _world_objects (let (r) (dotimes (i n) (push (instance spot_msgs::WorldObject :init) r)) r))
     (dolist (elem- _world_objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::WorldObjectArray :md5sum-) "d864d05495a41dfc3c5ac3126d50b37f")
(setf (get spot_msgs::WorldObjectArray :datatype-) "spot_msgs/WorldObjectArray")
(setf (get spot_msgs::WorldObjectArray :definition-)
      "# World objects list
WorldObject[] world_objects
================================================================================
MSG: spot_msgs/WorldObject
int32 id
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



(provide :spot_msgs/WorldObjectArray "d864d05495a41dfc3c5ac3126d50b37f")


