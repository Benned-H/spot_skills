;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetString)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetString (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETSTRING")
  (make-package "SPOT_CAM::SETSTRING"))
(unless (find-package "SPOT_CAM::SETSTRINGREQUEST")
  (make-package "SPOT_CAM::SETSTRINGREQUEST"))
(unless (find-package "SPOT_CAM::SETSTRINGRESPONSE")
  (make-package "SPOT_CAM::SETSTRINGRESPONSE"))

(in-package "ROS")





(defclass spot_cam::SetStringRequest
  :super ros::object
  :slots (_value ))

(defmethod spot_cam::SetStringRequest
  (:init
   (&key
    ((:value __value) "")
    )
   (send-super :init)
   (setq _value (string __value))
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; string _value
    4 (length _value)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _value
       (write-long (length _value) s) (princ _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_cam::SetStringResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetStringResponse
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

(defclass spot_cam::SetString
  :super ros::object
  :slots ())

(setf (get spot_cam::SetString :md5sum-) "43ad6a9b380ac342e4b20e501a2fd46c")
(setf (get spot_cam::SetString :datatype-) "spot_cam/SetString")
(setf (get spot_cam::SetString :request) spot_cam::SetStringRequest)
(setf (get spot_cam::SetString :response) spot_cam::SetStringResponse)

(defmethod spot_cam::SetStringRequest
  (:response () (instance spot_cam::SetStringResponse :init)))

(setf (get spot_cam::SetStringRequest :md5sum-) "43ad6a9b380ac342e4b20e501a2fd46c")
(setf (get spot_cam::SetStringRequest :datatype-) "spot_cam/SetStringRequest")
(setf (get spot_cam::SetStringRequest :definition-)
      "string value
---
bool success
string message
")

(setf (get spot_cam::SetStringResponse :md5sum-) "43ad6a9b380ac342e4b20e501a2fd46c")
(setf (get spot_cam::SetStringResponse :datatype-) "spot_cam/SetStringResponse")
(setf (get spot_cam::SetStringResponse :definition-)
      "string value
---
bool success
string message
")



(provide :spot_cam/SetString "43ad6a9b380ac342e4b20e501a2fd46c")


