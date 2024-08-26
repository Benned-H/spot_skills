;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SetSwingHeight)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SetSwingHeight (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SETSWINGHEIGHT")
  (make-package "SPOT_MSGS::SETSWINGHEIGHT"))
(unless (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST")
  (make-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(unless (find-package "SPOT_MSGS::SETSWINGHEIGHTRESPONSE")
  (make-package "SPOT_MSGS::SETSWINGHEIGHTRESPONSE"))

(in-package "ROS")





(intern "*SWING_HEIGHT_UNKNOWN*" (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(shadow '*SWING_HEIGHT_UNKNOWN* (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(defconstant spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_UNKNOWN* 0)
(intern "*SWING_HEIGHT_LOW*" (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(shadow '*SWING_HEIGHT_LOW* (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(defconstant spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_LOW* 1)
(intern "*SWING_HEIGHT_MEDIUM*" (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(shadow '*SWING_HEIGHT_MEDIUM* (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(defconstant spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_MEDIUM* 2)
(intern "*SWING_HEIGHT_HIGH*" (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(shadow '*SWING_HEIGHT_HIGH* (find-package "SPOT_MSGS::SETSWINGHEIGHTREQUEST"))
(defconstant spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_HIGH* 3)

(defun spot_msgs::SetSwingHeightRequest-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_UNKNOWN*)
        ((= const 1) 'spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_LOW*)
        ((= const 2) 'spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_MEDIUM*)
        ((= const 3) 'spot_msgs::SetSwingHeightRequest::*SWING_HEIGHT_HIGH*)
        (t nil)))

(defclass spot_msgs::SetSwingHeightRequest
  :super ros::object
  :slots (_swing_height ))

(defmethod spot_msgs::SetSwingHeightRequest
  (:init
   (&key
    ((:swing_height __swing_height) 0)
    )
   (send-super :init)
   (setq _swing_height (round __swing_height))
   self)
  (:swing_height
   (&optional __swing_height)
   (if __swing_height (setq _swing_height __swing_height)) _swing_height)
  (:serialization-length
   ()
   (+
    ;; uint8 _swing_height
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _swing_height
       (write-byte _swing_height s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _swing_height
     (setq _swing_height (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_msgs::SetSwingHeightResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::SetSwingHeightResponse
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

(defclass spot_msgs::SetSwingHeight
  :super ros::object
  :slots ())

(setf (get spot_msgs::SetSwingHeight :md5sum-) "27a6a29042cae7012a31b7fb7aa42680")
(setf (get spot_msgs::SetSwingHeight :datatype-) "spot_msgs/SetSwingHeight")
(setf (get spot_msgs::SetSwingHeight :request) spot_msgs::SetSwingHeightRequest)
(setf (get spot_msgs::SetSwingHeight :response) spot_msgs::SetSwingHeightResponse)

(defmethod spot_msgs::SetSwingHeightRequest
  (:response () (instance spot_msgs::SetSwingHeightResponse :init)))

(setf (get spot_msgs::SetSwingHeightRequest :md5sum-) "27a6a29042cae7012a31b7fb7aa42680")
(setf (get spot_msgs::SetSwingHeightRequest :datatype-) "spot_msgs/SetSwingHeightRequest")
(setf (get spot_msgs::SetSwingHeightRequest :definition-)
      "#see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#swingheight
uint8 SWING_HEIGHT_UNKNOWN=0
uint8 SWING_HEIGHT_LOW=1
uint8 SWING_HEIGHT_MEDIUM=2
uint8 SWING_HEIGHT_HIGH=3

uint8 swing_height
---
bool success
string message
")

(setf (get spot_msgs::SetSwingHeightResponse :md5sum-) "27a6a29042cae7012a31b7fb7aa42680")
(setf (get spot_msgs::SetSwingHeightResponse :datatype-) "spot_msgs/SetSwingHeightResponse")
(setf (get spot_msgs::SetSwingHeightResponse :definition-)
      "#see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#swingheight
uint8 SWING_HEIGHT_UNKNOWN=0
uint8 SWING_HEIGHT_LOW=1
uint8 SWING_HEIGHT_MEDIUM=2
uint8 SWING_HEIGHT_HIGH=3

uint8 swing_height
---
bool success
string message
")



(provide :spot_msgs/SetSwingHeight "27a6a29042cae7012a31b7fb7aa42680")


