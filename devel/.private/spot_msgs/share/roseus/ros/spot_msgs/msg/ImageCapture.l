;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ImageCapture)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ImageCapture (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::IMAGECAPTURE")
  (make-package "SPOT_MSGS::IMAGECAPTURE"))

(in-package "ROS")
;;//! \htmlinclude ImageCapture.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass spot_msgs::ImageCapture
  :super ros::object
  :slots (_acquisition_time _transforms_snapshot _frame_name_image_sensor _image _capture_exposure_duration _capture_sensor_gain ))

(defmethod spot_msgs::ImageCapture
  (:init
   (&key
    ((:acquisition_time __acquisition_time) (instance ros::time :init))
    ((:transforms_snapshot __transforms_snapshot) (instance spot_msgs::FrameTreeSnapshot :init))
    ((:frame_name_image_sensor __frame_name_image_sensor) "")
    ((:image __image) (instance sensor_msgs::Image :init))
    ((:capture_exposure_duration __capture_exposure_duration) (instance ros::time :init))
    ((:capture_sensor_gain __capture_sensor_gain) 0.0)
    )
   (send-super :init)
   (setq _acquisition_time __acquisition_time)
   (setq _transforms_snapshot __transforms_snapshot)
   (setq _frame_name_image_sensor (string __frame_name_image_sensor))
   (setq _image __image)
   (setq _capture_exposure_duration __capture_exposure_duration)
   (setq _capture_sensor_gain (float __capture_sensor_gain))
   self)
  (:acquisition_time
   (&optional __acquisition_time)
   (if __acquisition_time (setq _acquisition_time __acquisition_time)) _acquisition_time)
  (:transforms_snapshot
   (&rest __transforms_snapshot)
   (if (keywordp (car __transforms_snapshot))
       (send* _transforms_snapshot __transforms_snapshot)
     (progn
       (if __transforms_snapshot (setq _transforms_snapshot (car __transforms_snapshot)))
       _transforms_snapshot)))
  (:frame_name_image_sensor
   (&optional __frame_name_image_sensor)
   (if __frame_name_image_sensor (setq _frame_name_image_sensor __frame_name_image_sensor)) _frame_name_image_sensor)
  (:image
   (&rest __image)
   (if (keywordp (car __image))
       (send* _image __image)
     (progn
       (if __image (setq _image (car __image)))
       _image)))
  (:capture_exposure_duration
   (&optional __capture_exposure_duration)
   (if __capture_exposure_duration (setq _capture_exposure_duration __capture_exposure_duration)) _capture_exposure_duration)
  (:capture_sensor_gain
   (&optional __capture_sensor_gain)
   (if __capture_sensor_gain (setq _capture_sensor_gain __capture_sensor_gain)) _capture_sensor_gain)
  (:serialization-length
   ()
   (+
    ;; time _acquisition_time
    8
    ;; spot_msgs/FrameTreeSnapshot _transforms_snapshot
    (send _transforms_snapshot :serialization-length)
    ;; string _frame_name_image_sensor
    4 (length _frame_name_image_sensor)
    ;; sensor_msgs/Image _image
    (send _image :serialization-length)
    ;; duration _capture_exposure_duration
    8
    ;; float64 _capture_sensor_gain
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; time _acquisition_time
       (write-long (send _acquisition_time :sec) s) (write-long (send _acquisition_time :nsec) s)
     ;; spot_msgs/FrameTreeSnapshot _transforms_snapshot
       (send _transforms_snapshot :serialize s)
     ;; string _frame_name_image_sensor
       (write-long (length _frame_name_image_sensor) s) (princ _frame_name_image_sensor s)
     ;; sensor_msgs/Image _image
       (send _image :serialize s)
     ;; duration _capture_exposure_duration
       (write-long (send _capture_exposure_duration :sec) s) (write-long (send _capture_exposure_duration :nsec) s)
     ;; float64 _capture_sensor_gain
       (sys::poke _capture_sensor_gain (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; time _acquisition_time
     (send _acquisition_time :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _acquisition_time :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; spot_msgs/FrameTreeSnapshot _transforms_snapshot
     (send _transforms_snapshot :deserialize buf ptr-) (incf ptr- (send _transforms_snapshot :serialization-length))
   ;; string _frame_name_image_sensor
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name_image_sensor (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; sensor_msgs/Image _image
     (send _image :deserialize buf ptr-) (incf ptr- (send _image :serialization-length))
   ;; duration _capture_exposure_duration
     (send _capture_exposure_duration :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _capture_exposure_duration :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _capture_sensor_gain
     (setq _capture_sensor_gain (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get spot_msgs::ImageCapture :md5sum-) "3f615a6b98619410c2ebd532b7113b6e")
(setf (get spot_msgs::ImageCapture :datatype-) "spot_msgs/ImageCapture")
(setf (get spot_msgs::ImageCapture :definition-)
      "time acquisition_time

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



(provide :spot_msgs/ImageCapture "3f615a6b98619410c2ebd532b7113b6e")


