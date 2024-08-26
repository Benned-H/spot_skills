;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::HandPose)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'HandPose (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::HANDPOSE")
  (make-package "SPOT_MSGS::HANDPOSE"))
(unless (find-package "SPOT_MSGS::HANDPOSEREQUEST")
  (make-package "SPOT_MSGS::HANDPOSEREQUEST"))
(unless (find-package "SPOT_MSGS::HANDPOSERESPONSE")
  (make-package "SPOT_MSGS::HANDPOSERESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass spot_msgs::HandPoseRequest
  :super ros::object
  :slots (_duration _frame _pose_point ))

(defmethod spot_msgs::HandPoseRequest
  (:init
   (&key
    ((:duration __duration) 0.0)
    ((:frame __frame) "")
    ((:pose_point __pose_point) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _duration (float __duration))
   (setq _frame (string __frame))
   (setq _pose_point __pose_point)
   self)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:frame
   (&optional __frame)
   (if __frame (setq _frame __frame)) _frame)
  (:pose_point
   (&rest __pose_point)
   (if (keywordp (car __pose_point))
       (send* _pose_point __pose_point)
     (progn
       (if __pose_point (setq _pose_point (car __pose_point)))
       _pose_point)))
  (:serialization-length
   ()
   (+
    ;; float64 _duration
    8
    ;; string _frame
    4 (length _frame)
    ;; geometry_msgs/Pose _pose_point
    (send _pose_point :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _frame
       (write-long (length _frame) s) (princ _frame s)
     ;; geometry_msgs/Pose _pose_point
       (send _pose_point :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _duration
     (setq _duration (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Pose _pose_point
     (send _pose_point :deserialize buf ptr-) (incf ptr- (send _pose_point :serialization-length))
   ;;
   self)
  )

(defclass spot_msgs::HandPoseResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::HandPoseResponse
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

(defclass spot_msgs::HandPose
  :super ros::object
  :slots ())

(setf (get spot_msgs::HandPose :md5sum-) "6ebc466d74c88961d9a9d6e671fcb41c")
(setf (get spot_msgs::HandPose :datatype-) "spot_msgs/HandPose")
(setf (get spot_msgs::HandPose :request) spot_msgs::HandPoseRequest)
(setf (get spot_msgs::HandPose :response) spot_msgs::HandPoseResponse)

(defmethod spot_msgs::HandPoseRequest
  (:response () (instance spot_msgs::HandPoseResponse :init)))

(setf (get spot_msgs::HandPoseRequest :md5sum-) "6ebc466d74c88961d9a9d6e671fcb41c")
(setf (get spot_msgs::HandPoseRequest :datatype-) "spot_msgs/HandPoseRequest")
(setf (get spot_msgs::HandPoseRequest :definition-)
      "float64 duration
string frame
geometry_msgs/Pose pose_point

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
---
bool success
string message

")

(setf (get spot_msgs::HandPoseResponse :md5sum-) "6ebc466d74c88961d9a9d6e671fcb41c")
(setf (get spot_msgs::HandPoseResponse :datatype-) "spot_msgs/HandPoseResponse")
(setf (get spot_msgs::HandPoseResponse :definition-)
      "float64 duration
string frame
geometry_msgs/Pose pose_point

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
---
bool success
string message

")



(provide :spot_msgs/HandPose "6ebc466d74c88961d9a9d6e671fcb41c")


