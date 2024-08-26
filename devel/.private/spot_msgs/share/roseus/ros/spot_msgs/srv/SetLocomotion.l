;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SetLocomotion)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SetLocomotion (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SETLOCOMOTION")
  (make-package "SPOT_MSGS::SETLOCOMOTION"))
(unless (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST")
  (make-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(unless (find-package "SPOT_MSGS::SETLOCOMOTIONRESPONSE")
  (make-package "SPOT_MSGS::SETLOCOMOTIONRESPONSE"))

(in-package "ROS")





(intern "*HINT_UNKNOWN*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_UNKNOWN* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_UNKNOWN* 0)
(intern "*HINT_AUTO*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_AUTO* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_AUTO* 1)
(intern "*HINT_TROT*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_TROT* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_TROT* 2)
(intern "*HINT_SPEED_SELECT_TROT*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_SPEED_SELECT_TROT* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_SPEED_SELECT_TROT* 3)
(intern "*HINT_CRAWL*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_CRAWL* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_CRAWL* 4)
(intern "*HINT_AMBLE*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_AMBLE* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_AMBLE* 5)
(intern "*HINT_SPEED_SELECT_AMBLE*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_SPEED_SELECT_AMBLE* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_SPEED_SELECT_AMBLE* 6)
(intern "*HINT_JOG*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_JOG* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_JOG* 7)
(intern "*HINT_HOP*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_HOP* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_HOP* 8)
(intern "*HINT_SPEED_SELECT_CRAWL*" (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(shadow '*HINT_SPEED_SELECT_CRAWL* (find-package "SPOT_MSGS::SETLOCOMOTIONREQUEST"))
(defconstant spot_msgs::SetLocomotionRequest::*HINT_SPEED_SELECT_CRAWL* 10)

(defun spot_msgs::SetLocomotionRequest-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SetLocomotionRequest::*HINT_UNKNOWN*)
        ((= const 1) 'spot_msgs::SetLocomotionRequest::*HINT_AUTO*)
        ((= const 2) 'spot_msgs::SetLocomotionRequest::*HINT_TROT*)
        ((= const 3) 'spot_msgs::SetLocomotionRequest::*HINT_SPEED_SELECT_TROT*)
        ((= const 4) 'spot_msgs::SetLocomotionRequest::*HINT_CRAWL*)
        ((= const 5) 'spot_msgs::SetLocomotionRequest::*HINT_AMBLE*)
        ((= const 6) 'spot_msgs::SetLocomotionRequest::*HINT_SPEED_SELECT_AMBLE*)
        ((= const 7) 'spot_msgs::SetLocomotionRequest::*HINT_JOG*)
        ((= const 8) 'spot_msgs::SetLocomotionRequest::*HINT_HOP*)
        ((= const 10) 'spot_msgs::SetLocomotionRequest::*HINT_SPEED_SELECT_CRAWL*)
        (t nil)))

(defclass spot_msgs::SetLocomotionRequest
  :super ros::object
  :slots (_locomotion_mode ))

(defmethod spot_msgs::SetLocomotionRequest
  (:init
   (&key
    ((:locomotion_mode __locomotion_mode) 0)
    )
   (send-super :init)
   (setq _locomotion_mode (round __locomotion_mode))
   self)
  (:locomotion_mode
   (&optional __locomotion_mode)
   (if __locomotion_mode (setq _locomotion_mode __locomotion_mode)) _locomotion_mode)
  (:serialization-length
   ()
   (+
    ;; uint32 _locomotion_mode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _locomotion_mode
       (write-long _locomotion_mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _locomotion_mode
     (setq _locomotion_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_msgs::SetLocomotionResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::SetLocomotionResponse
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

(defclass spot_msgs::SetLocomotion
  :super ros::object
  :slots ())

(setf (get spot_msgs::SetLocomotion :md5sum-) "e8dfb4cee89cb4df2de99142d065f95d")
(setf (get spot_msgs::SetLocomotion :datatype-) "spot_msgs/SetLocomotion")
(setf (get spot_msgs::SetLocomotion :request) spot_msgs::SetLocomotionRequest)
(setf (get spot_msgs::SetLocomotion :response) spot_msgs::SetLocomotionResponse)

(defmethod spot_msgs::SetLocomotionRequest
  (:response () (instance spot_msgs::SetLocomotionResponse :init)))

(setf (get spot_msgs::SetLocomotionRequest :md5sum-) "e8dfb4cee89cb4df2de99142d065f95d")
(setf (get spot_msgs::SetLocomotionRequest :datatype-) "spot_msgs/SetLocomotionRequest")
(setf (get spot_msgs::SetLocomotionRequest :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=mobilityparams#locomotionhint for details
uint8 HINT_UNKNOWN=0
uint8 HINT_AUTO=1
uint8 HINT_TROT=2
uint8 HINT_SPEED_SELECT_TROT=3
uint8 HINT_CRAWL=4
uint8 HINT_AMBLE=5
uint8 HINT_SPEED_SELECT_AMBLE=6
uint8 HINT_JOG=7
uint8 HINT_HOP=8
uint8 HINT_SPEED_SELECT_CRAWL=10

uint32 locomotion_mode
---
bool success
string message

")

(setf (get spot_msgs::SetLocomotionResponse :md5sum-) "e8dfb4cee89cb4df2de99142d065f95d")
(setf (get spot_msgs::SetLocomotionResponse :datatype-) "spot_msgs/SetLocomotionResponse")
(setf (get spot_msgs::SetLocomotionResponse :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=mobilityparams#locomotionhint for details
uint8 HINT_UNKNOWN=0
uint8 HINT_AUTO=1
uint8 HINT_TROT=2
uint8 HINT_SPEED_SELECT_TROT=3
uint8 HINT_CRAWL=4
uint8 HINT_AMBLE=5
uint8 HINT_SPEED_SELECT_AMBLE=6
uint8 HINT_JOG=7
uint8 HINT_HOP=8
uint8 HINT_SPEED_SELECT_CRAWL=10

uint32 locomotion_mode
---
bool success
string message

")



(provide :spot_msgs/SetLocomotion "e8dfb4cee89cb4df2de99142d065f95d")


