;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ImageProperties)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ImageProperties (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::IMAGEPROPERTIES")
  (make-package "SPOT_MSGS::IMAGEPROPERTIES"))

(in-package "ROS")
;;//! \htmlinclude ImageProperties.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*KEYPOINT_UNKNOWN*" (find-package "SPOT_MSGS::IMAGEPROPERTIES"))
(shadow '*KEYPOINT_UNKNOWN* (find-package "SPOT_MSGS::IMAGEPROPERTIES"))
(defconstant spot_msgs::ImageProperties::*KEYPOINT_UNKNOWN* 0)
(intern "*KEYPOINT_SIMPLE*" (find-package "SPOT_MSGS::IMAGEPROPERTIES"))
(shadow '*KEYPOINT_SIMPLE* (find-package "SPOT_MSGS::IMAGEPROPERTIES"))
(defconstant spot_msgs::ImageProperties::*KEYPOINT_SIMPLE* 1)
(intern "*KEYPOINT_ORB*" (find-package "SPOT_MSGS::IMAGEPROPERTIES"))
(shadow '*KEYPOINT_ORB* (find-package "SPOT_MSGS::IMAGEPROPERTIES"))
(defconstant spot_msgs::ImageProperties::*KEYPOINT_ORB* 2)

(defun spot_msgs::ImageProperties-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::ImageProperties::*KEYPOINT_UNKNOWN*)
        ((= const 1) 'spot_msgs::ImageProperties::*KEYPOINT_SIMPLE*)
        ((= const 2) 'spot_msgs::ImageProperties::*KEYPOINT_ORB*)
        (t nil)))

(defclass spot_msgs::ImageProperties
  :super ros::object
  :slots (_camera_source _image_data_coordinates _image_data_keypoint_type _keypoint_coordinate_x _keypoint_coordinate_y _binary_descriptor _keypoint_score _keypoint_size _keypoint_angle _image_source _image_capture _frame_name_image_coordinates ))

(defmethod spot_msgs::ImageProperties
  (:init
   (&key
    ((:camera_source __camera_source) "")
    ((:image_data_coordinates __image_data_coordinates) (instance geometry_msgs::Polygon :init))
    ((:image_data_keypoint_type __image_data_keypoint_type) 0)
    ((:keypoint_coordinate_x __keypoint_coordinate_x) (make-array 0 :initial-element 0 :element-type :integer))
    ((:keypoint_coordinate_y __keypoint_coordinate_y) (make-array 0 :initial-element 0 :element-type :integer))
    ((:binary_descriptor __binary_descriptor) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:keypoint_score __keypoint_score) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:keypoint_size __keypoint_size) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:keypoint_angle __keypoint_angle) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:image_source __image_source) (instance spot_msgs::ImageSource :init))
    ((:image_capture __image_capture) (instance spot_msgs::ImageCapture :init))
    ((:frame_name_image_coordinates __frame_name_image_coordinates) "")
    )
   (send-super :init)
   (setq _camera_source (string __camera_source))
   (setq _image_data_coordinates __image_data_coordinates)
   (setq _image_data_keypoint_type (round __image_data_keypoint_type))
   (setq _keypoint_coordinate_x __keypoint_coordinate_x)
   (setq _keypoint_coordinate_y __keypoint_coordinate_y)
   (setq _binary_descriptor __binary_descriptor)
   (setq _keypoint_score __keypoint_score)
   (setq _keypoint_size __keypoint_size)
   (setq _keypoint_angle __keypoint_angle)
   (setq _image_source __image_source)
   (setq _image_capture __image_capture)
   (setq _frame_name_image_coordinates (string __frame_name_image_coordinates))
   self)
  (:camera_source
   (&optional __camera_source)
   (if __camera_source (setq _camera_source __camera_source)) _camera_source)
  (:image_data_coordinates
   (&rest __image_data_coordinates)
   (if (keywordp (car __image_data_coordinates))
       (send* _image_data_coordinates __image_data_coordinates)
     (progn
       (if __image_data_coordinates (setq _image_data_coordinates (car __image_data_coordinates)))
       _image_data_coordinates)))
  (:image_data_keypoint_type
   (&optional __image_data_keypoint_type)
   (if __image_data_keypoint_type (setq _image_data_keypoint_type __image_data_keypoint_type)) _image_data_keypoint_type)
  (:keypoint_coordinate_x
   (&optional __keypoint_coordinate_x)
   (if __keypoint_coordinate_x (setq _keypoint_coordinate_x __keypoint_coordinate_x)) _keypoint_coordinate_x)
  (:keypoint_coordinate_y
   (&optional __keypoint_coordinate_y)
   (if __keypoint_coordinate_y (setq _keypoint_coordinate_y __keypoint_coordinate_y)) _keypoint_coordinate_y)
  (:binary_descriptor
   (&optional __binary_descriptor)
   (if __binary_descriptor (setq _binary_descriptor __binary_descriptor)) _binary_descriptor)
  (:keypoint_score
   (&optional __keypoint_score)
   (if __keypoint_score (setq _keypoint_score __keypoint_score)) _keypoint_score)
  (:keypoint_size
   (&optional __keypoint_size)
   (if __keypoint_size (setq _keypoint_size __keypoint_size)) _keypoint_size)
  (:keypoint_angle
   (&optional __keypoint_angle)
   (if __keypoint_angle (setq _keypoint_angle __keypoint_angle)) _keypoint_angle)
  (:image_source
   (&rest __image_source)
   (if (keywordp (car __image_source))
       (send* _image_source __image_source)
     (progn
       (if __image_source (setq _image_source (car __image_source)))
       _image_source)))
  (:image_capture
   (&rest __image_capture)
   (if (keywordp (car __image_capture))
       (send* _image_capture __image_capture)
     (progn
       (if __image_capture (setq _image_capture (car __image_capture)))
       _image_capture)))
  (:frame_name_image_coordinates
   (&optional __frame_name_image_coordinates)
   (if __frame_name_image_coordinates (setq _frame_name_image_coordinates __frame_name_image_coordinates)) _frame_name_image_coordinates)
  (:serialization-length
   ()
   (+
    ;; string _camera_source
    4 (length _camera_source)
    ;; geometry_msgs/Polygon _image_data_coordinates
    (send _image_data_coordinates :serialization-length)
    ;; uint8 _image_data_keypoint_type
    1
    ;; int32[] _keypoint_coordinate_x
    (* 4    (length _keypoint_coordinate_x)) 4
    ;; int32[] _keypoint_coordinate_y
    (* 4    (length _keypoint_coordinate_y)) 4
    ;; string[] _binary_descriptor
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _binary_descriptor)) 4
    ;; float64[] _keypoint_score
    (* 8    (length _keypoint_score)) 4
    ;; float64[] _keypoint_size
    (* 8    (length _keypoint_size)) 4
    ;; float64[] _keypoint_angle
    (* 8    (length _keypoint_angle)) 4
    ;; spot_msgs/ImageSource _image_source
    (send _image_source :serialization-length)
    ;; spot_msgs/ImageCapture _image_capture
    (send _image_capture :serialization-length)
    ;; string _frame_name_image_coordinates
    4 (length _frame_name_image_coordinates)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _camera_source
       (write-long (length _camera_source) s) (princ _camera_source s)
     ;; geometry_msgs/Polygon _image_data_coordinates
       (send _image_data_coordinates :serialize s)
     ;; uint8 _image_data_keypoint_type
       (write-byte _image_data_keypoint_type s)
     ;; int32[] _keypoint_coordinate_x
     (write-long (length _keypoint_coordinate_x) s)
     (dotimes (i (length _keypoint_coordinate_x))
       (write-long (elt _keypoint_coordinate_x i) s)
       )
     ;; int32[] _keypoint_coordinate_y
     (write-long (length _keypoint_coordinate_y) s)
     (dotimes (i (length _keypoint_coordinate_y))
       (write-long (elt _keypoint_coordinate_y i) s)
       )
     ;; string[] _binary_descriptor
     (write-long (length _binary_descriptor) s)
     (dolist (elem _binary_descriptor)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float64[] _keypoint_score
     (write-long (length _keypoint_score) s)
     (dotimes (i (length _keypoint_score))
       (sys::poke (elt _keypoint_score i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _keypoint_size
     (write-long (length _keypoint_size) s)
     (dotimes (i (length _keypoint_size))
       (sys::poke (elt _keypoint_size i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _keypoint_angle
     (write-long (length _keypoint_angle) s)
     (dotimes (i (length _keypoint_angle))
       (sys::poke (elt _keypoint_angle i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; spot_msgs/ImageSource _image_source
       (send _image_source :serialize s)
     ;; spot_msgs/ImageCapture _image_capture
       (send _image_capture :serialize s)
     ;; string _frame_name_image_coordinates
       (write-long (length _frame_name_image_coordinates) s) (princ _frame_name_image_coordinates s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _camera_source
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _camera_source (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Polygon _image_data_coordinates
     (send _image_data_coordinates :deserialize buf ptr-) (incf ptr- (send _image_data_coordinates :serialization-length))
   ;; uint8 _image_data_keypoint_type
     (setq _image_data_keypoint_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int32[] _keypoint_coordinate_x
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _keypoint_coordinate_x (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _keypoint_coordinate_x i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _keypoint_coordinate_y
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _keypoint_coordinate_y (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _keypoint_coordinate_y i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; string[] _binary_descriptor
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _binary_descriptor (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _binary_descriptor i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float64[] _keypoint_score
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _keypoint_score (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _keypoint_score i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _keypoint_size
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _keypoint_size (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _keypoint_size i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _keypoint_angle
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _keypoint_angle (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _keypoint_angle i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; spot_msgs/ImageSource _image_source
     (send _image_source :deserialize buf ptr-) (incf ptr- (send _image_source :serialization-length))
   ;; spot_msgs/ImageCapture _image_capture
     (send _image_capture :deserialize buf ptr-) (incf ptr- (send _image_capture :serialization-length))
   ;; string _frame_name_image_coordinates
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name_image_coordinates (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::ImageProperties :md5sum-) "94ff5688662ac7e33ef10bbd7d52e755")
(setf (get spot_msgs::ImageProperties :datatype-) "spot_msgs/ImageProperties")
(setf (get spot_msgs::ImageProperties :definition-)
      "string camera_source

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

")



(provide :spot_msgs/ImageProperties "94ff5688662ac7e33ef10bbd7d52e755")


