;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ArmForceTrajectory)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ArmForceTrajectory (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::ARMFORCETRAJECTORY")
  (make-package "SPOT_MSGS::ARMFORCETRAJECTORY"))
(unless (find-package "SPOT_MSGS::ARMFORCETRAJECTORYREQUEST")
  (make-package "SPOT_MSGS::ARMFORCETRAJECTORYREQUEST"))
(unless (find-package "SPOT_MSGS::ARMFORCETRAJECTORYRESPONSE")
  (make-package "SPOT_MSGS::ARMFORCETRAJECTORYRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::ArmForceTrajectoryRequest
  :super ros::object
  :slots (_duration _frame _forces_pt0 _torques_pt0 _forces_pt1 _torques_pt1 ))

(defmethod spot_msgs::ArmForceTrajectoryRequest
  (:init
   (&key
    ((:duration __duration) 0.0)
    ((:frame __frame) "")
    ((:forces_pt0 __forces_pt0) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:torques_pt0 __torques_pt0) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:forces_pt1 __forces_pt1) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:torques_pt1 __torques_pt1) (make-array 3 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _duration (float __duration))
   (setq _frame (string __frame))
   (setq _forces_pt0 __forces_pt0)
   (setq _torques_pt0 __torques_pt0)
   (setq _forces_pt1 __forces_pt1)
   (setq _torques_pt1 __torques_pt1)
   self)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:frame
   (&optional __frame)
   (if __frame (setq _frame __frame)) _frame)
  (:forces_pt0
   (&optional __forces_pt0)
   (if __forces_pt0 (setq _forces_pt0 __forces_pt0)) _forces_pt0)
  (:torques_pt0
   (&optional __torques_pt0)
   (if __torques_pt0 (setq _torques_pt0 __torques_pt0)) _torques_pt0)
  (:forces_pt1
   (&optional __forces_pt1)
   (if __forces_pt1 (setq _forces_pt1 __forces_pt1)) _forces_pt1)
  (:torques_pt1
   (&optional __torques_pt1)
   (if __torques_pt1 (setq _torques_pt1 __torques_pt1)) _torques_pt1)
  (:serialization-length
   ()
   (+
    ;; float64 _duration
    8
    ;; string _frame
    4 (length _frame)
    ;; float64[3] _forces_pt0
    (* 8    3)
    ;; float64[3] _torques_pt0
    (* 8    3)
    ;; float64[3] _forces_pt1
    (* 8    3)
    ;; float64[3] _torques_pt1
    (* 8    3)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _frame
       (write-long (length _frame) s) (princ _frame s)
     ;; float64[3] _forces_pt0
     (dotimes (i 3)
       (sys::poke (elt _forces_pt0 i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[3] _torques_pt0
     (dotimes (i 3)
       (sys::poke (elt _torques_pt0 i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[3] _forces_pt1
     (dotimes (i 3)
       (sys::poke (elt _forces_pt1 i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[3] _torques_pt1
     (dotimes (i 3)
       (sys::poke (elt _torques_pt1 i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _duration
     (setq _duration (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64[3] _forces_pt0
   (dotimes (i (length _forces_pt0))
     (setf (elt _forces_pt0 i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[3] _torques_pt0
   (dotimes (i (length _torques_pt0))
     (setf (elt _torques_pt0 i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[3] _forces_pt1
   (dotimes (i (length _forces_pt1))
     (setf (elt _forces_pt1 i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[3] _torques_pt1
   (dotimes (i (length _torques_pt1))
     (setf (elt _torques_pt1 i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(defclass spot_msgs::ArmForceTrajectoryResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::ArmForceTrajectoryResponse
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

(defclass spot_msgs::ArmForceTrajectory
  :super ros::object
  :slots ())

(setf (get spot_msgs::ArmForceTrajectory :md5sum-) "5ec2796f0480118f129c21c2f87b4cf7")
(setf (get spot_msgs::ArmForceTrajectory :datatype-) "spot_msgs/ArmForceTrajectory")
(setf (get spot_msgs::ArmForceTrajectory :request) spot_msgs::ArmForceTrajectoryRequest)
(setf (get spot_msgs::ArmForceTrajectory :response) spot_msgs::ArmForceTrajectoryResponse)

(defmethod spot_msgs::ArmForceTrajectoryRequest
  (:response () (instance spot_msgs::ArmForceTrajectoryResponse :init)))

(setf (get spot_msgs::ArmForceTrajectoryRequest :md5sum-) "5ec2796f0480118f129c21c2f87b4cf7")
(setf (get spot_msgs::ArmForceTrajectoryRequest :datatype-) "spot_msgs/ArmForceTrajectoryRequest")
(setf (get spot_msgs::ArmForceTrajectoryRequest :definition-)
      "float64 duration
string frame
float64[3] forces_pt0 # fx fy fz
float64[3] torques_pt0 # tx ty yz
float64[3] forces_pt1 # fx fy fz
float64[3] torques_pt1 # tx ty yz
---
bool success
string message

")

(setf (get spot_msgs::ArmForceTrajectoryResponse :md5sum-) "5ec2796f0480118f129c21c2f87b4cf7")
(setf (get spot_msgs::ArmForceTrajectoryResponse :datatype-) "spot_msgs/ArmForceTrajectoryResponse")
(setf (get spot_msgs::ArmForceTrajectoryResponse :definition-)
      "float64 duration
string frame
float64[3] forces_pt0 # fx fy fz
float64[3] torques_pt0 # tx ty yz
float64[3] forces_pt1 # fx fy fz
float64[3] torques_pt1 # tx ty yz
---
bool success
string message

")



(provide :spot_msgs/ArmForceTrajectory "5ec2796f0480118f129c21c2f87b4cf7")


