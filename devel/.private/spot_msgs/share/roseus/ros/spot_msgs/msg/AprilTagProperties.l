;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::AprilTagProperties)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'AprilTagProperties (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::APRILTAGPROPERTIES")
  (make-package "SPOT_MSGS::APRILTAGPROPERTIES"))

(in-package "ROS")
;;//! \htmlinclude AprilTagProperties.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*STATUS_UNKNOWN*" (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(shadow '*STATUS_UNKNOWN* (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(defconstant spot_msgs::AprilTagProperties::*STATUS_UNKNOWN* 0)
(intern "*STATUS_OK*" (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(shadow '*STATUS_OK* (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(defconstant spot_msgs::AprilTagProperties::*STATUS_OK* 1)
(intern "*STATUS_AMBIGUOUS*" (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(shadow '*STATUS_AMBIGUOUS* (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(defconstant spot_msgs::AprilTagProperties::*STATUS_AMBIGUOUS* 2)
(intern "*STATUS_HIGH_ERROR*" (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(shadow '*STATUS_HIGH_ERROR* (find-package "SPOT_MSGS::APRILTAGPROPERTIES"))
(defconstant spot_msgs::AprilTagProperties::*STATUS_HIGH_ERROR* 3)

(defun spot_msgs::AprilTagProperties-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::AprilTagProperties::*STATUS_UNKNOWN*)
        ((= const 1) 'spot_msgs::AprilTagProperties::*STATUS_OK*)
        ((= const 2) 'spot_msgs::AprilTagProperties::*STATUS_AMBIGUOUS*)
        ((= const 3) 'spot_msgs::AprilTagProperties::*STATUS_HIGH_ERROR*)
        (t nil)))

(defclass spot_msgs::AprilTagProperties
  :super ros::object
  :slots (_tag_id _x _y _frame_name_fiducial _fiducial_pose_status _frame_name_fiducial_filtered _fiducial_filtered_pose_status _frame_name_camera _detection_covariance _detection_covariance_reference_frame ))

(defmethod spot_msgs::AprilTagProperties
  (:init
   (&key
    ((:tag_id __tag_id) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:frame_name_fiducial __frame_name_fiducial) "")
    ((:fiducial_pose_status __fiducial_pose_status) 0)
    ((:frame_name_fiducial_filtered __frame_name_fiducial_filtered) "")
    ((:fiducial_filtered_pose_status __fiducial_filtered_pose_status) 0)
    ((:frame_name_camera __frame_name_camera) "")
    ((:detection_covariance __detection_covariance) (instance geometry_msgs::PoseWithCovariance :init))
    ((:detection_covariance_reference_frame __detection_covariance_reference_frame) "")
    )
   (send-super :init)
   (setq _tag_id (round __tag_id))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _frame_name_fiducial (string __frame_name_fiducial))
   (setq _fiducial_pose_status (round __fiducial_pose_status))
   (setq _frame_name_fiducial_filtered (string __frame_name_fiducial_filtered))
   (setq _fiducial_filtered_pose_status (round __fiducial_filtered_pose_status))
   (setq _frame_name_camera (string __frame_name_camera))
   (setq _detection_covariance __detection_covariance)
   (setq _detection_covariance_reference_frame (string __detection_covariance_reference_frame))
   self)
  (:tag_id
   (&optional __tag_id)
   (if __tag_id (setq _tag_id __tag_id)) _tag_id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:frame_name_fiducial
   (&optional __frame_name_fiducial)
   (if __frame_name_fiducial (setq _frame_name_fiducial __frame_name_fiducial)) _frame_name_fiducial)
  (:fiducial_pose_status
   (&optional __fiducial_pose_status)
   (if __fiducial_pose_status (setq _fiducial_pose_status __fiducial_pose_status)) _fiducial_pose_status)
  (:frame_name_fiducial_filtered
   (&optional __frame_name_fiducial_filtered)
   (if __frame_name_fiducial_filtered (setq _frame_name_fiducial_filtered __frame_name_fiducial_filtered)) _frame_name_fiducial_filtered)
  (:fiducial_filtered_pose_status
   (&optional __fiducial_filtered_pose_status)
   (if __fiducial_filtered_pose_status (setq _fiducial_filtered_pose_status __fiducial_filtered_pose_status)) _fiducial_filtered_pose_status)
  (:frame_name_camera
   (&optional __frame_name_camera)
   (if __frame_name_camera (setq _frame_name_camera __frame_name_camera)) _frame_name_camera)
  (:detection_covariance
   (&rest __detection_covariance)
   (if (keywordp (car __detection_covariance))
       (send* _detection_covariance __detection_covariance)
     (progn
       (if __detection_covariance (setq _detection_covariance (car __detection_covariance)))
       _detection_covariance)))
  (:detection_covariance_reference_frame
   (&optional __detection_covariance_reference_frame)
   (if __detection_covariance_reference_frame (setq _detection_covariance_reference_frame __detection_covariance_reference_frame)) _detection_covariance_reference_frame)
  (:serialization-length
   ()
   (+
    ;; int32 _tag_id
    4
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; string _frame_name_fiducial
    4 (length _frame_name_fiducial)
    ;; uint8 _fiducial_pose_status
    1
    ;; string _frame_name_fiducial_filtered
    4 (length _frame_name_fiducial_filtered)
    ;; uint8 _fiducial_filtered_pose_status
    1
    ;; string _frame_name_camera
    4 (length _frame_name_camera)
    ;; geometry_msgs/PoseWithCovariance _detection_covariance
    (send _detection_covariance :serialization-length)
    ;; string _detection_covariance_reference_frame
    4 (length _detection_covariance_reference_frame)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _tag_id
       (write-long _tag_id s)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _frame_name_fiducial
       (write-long (length _frame_name_fiducial) s) (princ _frame_name_fiducial s)
     ;; uint8 _fiducial_pose_status
       (write-byte _fiducial_pose_status s)
     ;; string _frame_name_fiducial_filtered
       (write-long (length _frame_name_fiducial_filtered) s) (princ _frame_name_fiducial_filtered s)
     ;; uint8 _fiducial_filtered_pose_status
       (write-byte _fiducial_filtered_pose_status s)
     ;; string _frame_name_camera
       (write-long (length _frame_name_camera) s) (princ _frame_name_camera s)
     ;; geometry_msgs/PoseWithCovariance _detection_covariance
       (send _detection_covariance :serialize s)
     ;; string _detection_covariance_reference_frame
       (write-long (length _detection_covariance_reference_frame) s) (princ _detection_covariance_reference_frame s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _tag_id
     (setq _tag_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _frame_name_fiducial
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name_fiducial (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _fiducial_pose_status
     (setq _fiducial_pose_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _frame_name_fiducial_filtered
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name_fiducial_filtered (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _fiducial_filtered_pose_status
     (setq _fiducial_filtered_pose_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _frame_name_camera
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name_camera (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/PoseWithCovariance _detection_covariance
     (send _detection_covariance :deserialize buf ptr-) (incf ptr- (send _detection_covariance :serialization-length))
   ;; string _detection_covariance_reference_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _detection_covariance_reference_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::AprilTagProperties :md5sum-) "035439ca15acb004b11a25a16f3fd1de")
(setf (get spot_msgs::AprilTagProperties :datatype-) "spot_msgs/AprilTagProperties")
(setf (get spot_msgs::AprilTagProperties :definition-)
      "# Status
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

")



(provide :spot_msgs/AprilTagProperties "035439ca15acb004b11a25a16f3fd1de")


