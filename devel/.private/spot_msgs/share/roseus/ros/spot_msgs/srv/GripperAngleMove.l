;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::GripperAngleMove)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'GripperAngleMove (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::GRIPPERANGLEMOVE")
  (make-package "SPOT_MSGS::GRIPPERANGLEMOVE"))
(unless (find-package "SPOT_MSGS::GRIPPERANGLEMOVEREQUEST")
  (make-package "SPOT_MSGS::GRIPPERANGLEMOVEREQUEST"))
(unless (find-package "SPOT_MSGS::GRIPPERANGLEMOVERESPONSE")
  (make-package "SPOT_MSGS::GRIPPERANGLEMOVERESPONSE"))

(in-package "ROS")





(defclass spot_msgs::GripperAngleMoveRequest
  :super ros::object
  :slots (_gripper_angle ))

(defmethod spot_msgs::GripperAngleMoveRequest
  (:init
   (&key
    ((:gripper_angle __gripper_angle) 0.0)
    )
   (send-super :init)
   (setq _gripper_angle (float __gripper_angle))
   self)
  (:gripper_angle
   (&optional __gripper_angle)
   (if __gripper_angle (setq _gripper_angle __gripper_angle)) _gripper_angle)
  (:serialization-length
   ()
   (+
    ;; float64 _gripper_angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _gripper_angle
       (sys::poke _gripper_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _gripper_angle
     (setq _gripper_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass spot_msgs::GripperAngleMoveResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::GripperAngleMoveResponse
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

(defclass spot_msgs::GripperAngleMove
  :super ros::object
  :slots ())

(setf (get spot_msgs::GripperAngleMove :md5sum-) "7900bbc2924d6597df7f80ea6945ab2b")
(setf (get spot_msgs::GripperAngleMove :datatype-) "spot_msgs/GripperAngleMove")
(setf (get spot_msgs::GripperAngleMove :request) spot_msgs::GripperAngleMoveRequest)
(setf (get spot_msgs::GripperAngleMove :response) spot_msgs::GripperAngleMoveResponse)

(defmethod spot_msgs::GripperAngleMoveRequest
  (:response () (instance spot_msgs::GripperAngleMoveResponse :init)))

(setf (get spot_msgs::GripperAngleMoveRequest :md5sum-) "7900bbc2924d6597df7f80ea6945ab2b")
(setf (get spot_msgs::GripperAngleMoveRequest :datatype-) "spot_msgs/GripperAngleMoveRequest")
(setf (get spot_msgs::GripperAngleMoveRequest :definition-)
      "float64 gripper_angle
---
bool success
string message

")

(setf (get spot_msgs::GripperAngleMoveResponse :md5sum-) "7900bbc2924d6597df7f80ea6945ab2b")
(setf (get spot_msgs::GripperAngleMoveResponse :datatype-) "spot_msgs/GripperAngleMoveResponse")
(setf (get spot_msgs::GripperAngleMoveResponse :definition-)
      "float64 gripper_angle
---
bool success
string message

")



(provide :spot_msgs/GripperAngleMove "7900bbc2924d6597df7f80ea6945ab2b")


