;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ArmJointMovement)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ArmJointMovement (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::ARMJOINTMOVEMENT")
  (make-package "SPOT_MSGS::ARMJOINTMOVEMENT"))
(unless (find-package "SPOT_MSGS::ARMJOINTMOVEMENTREQUEST")
  (make-package "SPOT_MSGS::ARMJOINTMOVEMENTREQUEST"))
(unless (find-package "SPOT_MSGS::ARMJOINTMOVEMENTRESPONSE")
  (make-package "SPOT_MSGS::ARMJOINTMOVEMENTRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::ArmJointMovementRequest
  :super ros::object
  :slots (_joint_target ))

(defmethod spot_msgs::ArmJointMovementRequest
  (:init
   (&key
    ((:joint_target __joint_target) (make-array 6 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _joint_target __joint_target)
   self)
  (:joint_target
   (&optional __joint_target)
   (if __joint_target (setq _joint_target __joint_target)) _joint_target)
  (:serialization-length
   ()
   (+
    ;; float64[6] _joint_target
    (* 8    6)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[6] _joint_target
     (dotimes (i 6)
       (sys::poke (elt _joint_target i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[6] _joint_target
   (dotimes (i (length _joint_target))
     (setf (elt _joint_target i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(defclass spot_msgs::ArmJointMovementResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::ArmJointMovementResponse
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

(defclass spot_msgs::ArmJointMovement
  :super ros::object
  :slots ())

(setf (get spot_msgs::ArmJointMovement :md5sum-) "d47819994e77542a6388625321902fe1")
(setf (get spot_msgs::ArmJointMovement :datatype-) "spot_msgs/ArmJointMovement")
(setf (get spot_msgs::ArmJointMovement :request) spot_msgs::ArmJointMovementRequest)
(setf (get spot_msgs::ArmJointMovement :response) spot_msgs::ArmJointMovementResponse)

(defmethod spot_msgs::ArmJointMovementRequest
  (:response () (instance spot_msgs::ArmJointMovementResponse :init)))

(setf (get spot_msgs::ArmJointMovementRequest :md5sum-) "d47819994e77542a6388625321902fe1")
(setf (get spot_msgs::ArmJointMovementRequest :datatype-) "spot_msgs/ArmJointMovementRequest")
(setf (get spot_msgs::ArmJointMovementRequest :definition-)
      "float64[6] joint_target
---
bool success
string message
")

(setf (get spot_msgs::ArmJointMovementResponse :md5sum-) "d47819994e77542a6388625321902fe1")
(setf (get spot_msgs::ArmJointMovementResponse :datatype-) "spot_msgs/ArmJointMovementResponse")
(setf (get spot_msgs::ArmJointMovementResponse :definition-)
      "float64[6] joint_target
---
bool success
string message
")



(provide :spot_msgs/ArmJointMovement "d47819994e77542a6388625321902fe1")


