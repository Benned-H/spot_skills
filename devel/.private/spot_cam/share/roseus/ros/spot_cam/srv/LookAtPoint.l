;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::LookAtPoint)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'LookAtPoint (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::LOOKATPOINT")
  (make-package "SPOT_CAM::LOOKATPOINT"))
(unless (find-package "SPOT_CAM::LOOKATPOINTREQUEST")
  (make-package "SPOT_CAM::LOOKATPOINTREQUEST"))
(unless (find-package "SPOT_CAM::LOOKATPOINTRESPONSE")
  (make-package "SPOT_CAM::LOOKATPOINTRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass spot_cam::LookAtPointRequest
  :super ros::object
  :slots (_target _image_width _zoom_level _track ))

(defmethod spot_cam::LookAtPointRequest
  (:init
   (&key
    ((:target __target) (instance geometry_msgs::PointStamped :init))
    ((:image_width __image_width) 0.0)
    ((:zoom_level __zoom_level) 0.0)
    ((:track __track) nil)
    )
   (send-super :init)
   (setq _target __target)
   (setq _image_width (float __image_width))
   (setq _zoom_level (float __zoom_level))
   (setq _track __track)
   self)
  (:target
   (&rest __target)
   (if (keywordp (car __target))
       (send* _target __target)
     (progn
       (if __target (setq _target (car __target)))
       _target)))
  (:image_width
   (&optional __image_width)
   (if __image_width (setq _image_width __image_width)) _image_width)
  (:zoom_level
   (&optional __zoom_level)
   (if __zoom_level (setq _zoom_level __zoom_level)) _zoom_level)
  (:track
   (&optional (__track :null))
   (if (not (eq __track :null)) (setq _track __track)) _track)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/PointStamped _target
    (send _target :serialization-length)
    ;; float32 _image_width
    4
    ;; float32 _zoom_level
    4
    ;; bool _track
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/PointStamped _target
       (send _target :serialize s)
     ;; float32 _image_width
       (sys::poke _image_width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _zoom_level
       (sys::poke _zoom_level (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _track
       (if _track (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/PointStamped _target
     (send _target :deserialize buf ptr-) (incf ptr- (send _target :serialization-length))
   ;; float32 _image_width
     (setq _image_width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _zoom_level
     (setq _zoom_level (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _track
     (setq _track (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_cam::LookAtPointResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::LookAtPointResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_cam::LookAtPoint
  :super ros::object
  :slots ())

(setf (get spot_cam::LookAtPoint :md5sum-) "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(setf (get spot_cam::LookAtPoint :datatype-) "spot_cam/LookAtPoint")
(setf (get spot_cam::LookAtPoint :request) spot_cam::LookAtPointRequest)
(setf (get spot_cam::LookAtPoint :response) spot_cam::LookAtPointResponse)

(defmethod spot_cam::LookAtPointRequest
  (:response () (instance spot_cam::LookAtPointResponse :init)))

(setf (get spot_cam::LookAtPointRequest :md5sum-) "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(setf (get spot_cam::LookAtPointRequest :datatype-) "spot_cam/LookAtPointRequest")
(setf (get spot_cam::LookAtPointRequest :definition-)
      "# Point the spot cam PTZ at a specific point in space
# The target at which the PTZ should be pointed
geometry_msgs/PointStamped target
# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,
# this will be used
float32 image_width
# Optical zoom level between 1 and 30 to use
float32 zoom_level
# If true, the camera will track this point as the robot moves
bool track

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---
bool success
string message
")

(setf (get spot_cam::LookAtPointResponse :md5sum-) "0dc127af1bc4082ad4ce1ba11dbd2e9b")
(setf (get spot_cam::LookAtPointResponse :datatype-) "spot_cam/LookAtPointResponse")
(setf (get spot_cam::LookAtPointResponse :definition-)
      "# Point the spot cam PTZ at a specific point in space
# The target at which the PTZ should be pointed
geometry_msgs/PointStamped target
# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,
# this will be used
float32 image_width
# Optical zoom level between 1 and 30 to use
float32 zoom_level
# If true, the camera will track this point as the robot moves
bool track

================================================================================
MSG: geometry_msgs/PointStamped
# This represents a Point with reference coordinate frame and timestamp
Header header
Point point

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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---
bool success
string message
")



(provide :spot_cam/LookAtPoint "0dc127af1bc4082ad4ce1ba11dbd2e9b")


