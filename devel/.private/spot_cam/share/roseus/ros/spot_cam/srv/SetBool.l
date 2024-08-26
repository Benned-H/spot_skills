;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetBool)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetBool (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETBOOL")
  (make-package "SPOT_CAM::SETBOOL"))
(unless (find-package "SPOT_CAM::SETBOOLREQUEST")
  (make-package "SPOT_CAM::SETBOOLREQUEST"))
(unless (find-package "SPOT_CAM::SETBOOLRESPONSE")
  (make-package "SPOT_CAM::SETBOOLRESPONSE"))

(in-package "ROS")





(defclass spot_cam::SetBoolRequest
  :super ros::object
  :slots (_value ))

(defmethod spot_cam::SetBoolRequest
  (:init
   (&key
    ((:value __value) nil)
    )
   (send-super :init)
   (setq _value __value)
   self)
  (:value
   (&optional (__value :null))
   (if (not (eq __value :null)) (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; bool _value
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _value
       (if _value (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _value
     (setq _value (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_cam::SetBoolResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetBoolResponse
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

(defclass spot_cam::SetBool
  :super ros::object
  :slots ())

(setf (get spot_cam::SetBool :md5sum-) "5818564455354be7201484c2bf028604")
(setf (get spot_cam::SetBool :datatype-) "spot_cam/SetBool")
(setf (get spot_cam::SetBool :request) spot_cam::SetBoolRequest)
(setf (get spot_cam::SetBool :response) spot_cam::SetBoolResponse)

(defmethod spot_cam::SetBoolRequest
  (:response () (instance spot_cam::SetBoolResponse :init)))

(setf (get spot_cam::SetBoolRequest :md5sum-) "5818564455354be7201484c2bf028604")
(setf (get spot_cam::SetBoolRequest :datatype-) "spot_cam/SetBoolRequest")
(setf (get spot_cam::SetBoolRequest :definition-)
      "bool value
---
bool success
string message
")

(setf (get spot_cam::SetBoolResponse :md5sum-) "5818564455354be7201484c2bf028604")
(setf (get spot_cam::SetBoolResponse :datatype-) "spot_cam/SetBoolResponse")
(setf (get spot_cam::SetBoolResponse :definition-)
      "bool value
---
bool success
string message
")



(provide :spot_cam/SetBool "5818564455354be7201484c2bf028604")


