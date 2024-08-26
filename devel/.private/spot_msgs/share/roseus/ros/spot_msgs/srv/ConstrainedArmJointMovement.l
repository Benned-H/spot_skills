;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ConstrainedArmJointMovement)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ConstrainedArmJointMovement (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::CONSTRAINEDARMJOINTMOVEMENT")
  (make-package "SPOT_MSGS::CONSTRAINEDARMJOINTMOVEMENT"))
(unless (find-package "SPOT_MSGS::CONSTRAINEDARMJOINTMOVEMENTREQUEST")
  (make-package "SPOT_MSGS::CONSTRAINEDARMJOINTMOVEMENTREQUEST"))
(unless (find-package "SPOT_MSGS::CONSTRAINEDARMJOINTMOVEMENTRESPONSE")
  (make-package "SPOT_MSGS::CONSTRAINEDARMJOINTMOVEMENTRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::ConstrainedArmJointMovementRequest
  :super ros::object
  :slots (_joint_target _max_execution_time _max_velocity _max_acceleration ))

(defmethod spot_msgs::ConstrainedArmJointMovementRequest
  (:init
   (&key
    ((:joint_target __joint_target) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:max_execution_time __max_execution_time) 0.0)
    ((:max_velocity __max_velocity) 0.0)
    ((:max_acceleration __max_acceleration) 0.0)
    )
   (send-super :init)
   (setq _joint_target __joint_target)
   (setq _max_execution_time (float __max_execution_time))
   (setq _max_velocity (float __max_velocity))
   (setq _max_acceleration (float __max_acceleration))
   self)
  (:joint_target
   (&optional __joint_target)
   (if __joint_target (setq _joint_target __joint_target)) _joint_target)
  (:max_execution_time
   (&optional __max_execution_time)
   (if __max_execution_time (setq _max_execution_time __max_execution_time)) _max_execution_time)
  (:max_velocity
   (&optional __max_velocity)
   (if __max_velocity (setq _max_velocity __max_velocity)) _max_velocity)
  (:max_acceleration
   (&optional __max_acceleration)
   (if __max_acceleration (setq _max_acceleration __max_acceleration)) _max_acceleration)
  (:serialization-length
   ()
   (+
    ;; float64[] _joint_target
    (* 8    (length _joint_target)) 4
    ;; float64 _max_execution_time
    8
    ;; float64 _max_velocity
    8
    ;; float64 _max_acceleration
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _joint_target
     (write-long (length _joint_target) s)
     (dotimes (i (length _joint_target))
       (sys::poke (elt _joint_target i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64 _max_execution_time
       (sys::poke _max_execution_time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _max_velocity
       (sys::poke _max_velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _max_acceleration
       (sys::poke _max_acceleration (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _joint_target
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _joint_target (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _joint_target i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64 _max_execution_time
     (setq _max_execution_time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _max_velocity
     (setq _max_velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _max_acceleration
     (setq _max_acceleration (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass spot_msgs::ConstrainedArmJointMovementResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::ConstrainedArmJointMovementResponse
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

(defclass spot_msgs::ConstrainedArmJointMovement
  :super ros::object
  :slots ())

(setf (get spot_msgs::ConstrainedArmJointMovement :md5sum-) "9e4ce278a819d084143e339b61079523")
(setf (get spot_msgs::ConstrainedArmJointMovement :datatype-) "spot_msgs/ConstrainedArmJointMovement")
(setf (get spot_msgs::ConstrainedArmJointMovement :request) spot_msgs::ConstrainedArmJointMovementRequest)
(setf (get spot_msgs::ConstrainedArmJointMovement :response) spot_msgs::ConstrainedArmJointMovementResponse)

(defmethod spot_msgs::ConstrainedArmJointMovementRequest
  (:response () (instance spot_msgs::ConstrainedArmJointMovementResponse :init)))

(setf (get spot_msgs::ConstrainedArmJointMovementRequest :md5sum-) "9e4ce278a819d084143e339b61079523")
(setf (get spot_msgs::ConstrainedArmJointMovementRequest :datatype-) "spot_msgs/ConstrainedArmJointMovementRequest")
(setf (get spot_msgs::ConstrainedArmJointMovementRequest :definition-)
      "float64[] joint_target
float64 max_execution_time
float64 max_velocity
float64 max_acceleration
---
bool success
string message
")

(setf (get spot_msgs::ConstrainedArmJointMovementResponse :md5sum-) "9e4ce278a819d084143e339b61079523")
(setf (get spot_msgs::ConstrainedArmJointMovementResponse :datatype-) "spot_msgs/ConstrainedArmJointMovementResponse")
(setf (get spot_msgs::ConstrainedArmJointMovementResponse :definition-)
      "float64[] joint_target
float64 max_execution_time
float64 max_velocity
float64 max_acceleration
---
bool success
string message
")



(provide :spot_msgs/ConstrainedArmJointMovement "9e4ce278a819d084143e339b61079523")


