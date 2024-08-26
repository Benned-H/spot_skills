;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetFloat)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetFloat (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETFLOAT")
  (make-package "SPOT_CAM::SETFLOAT"))
(unless (find-package "SPOT_CAM::SETFLOATREQUEST")
  (make-package "SPOT_CAM::SETFLOATREQUEST"))
(unless (find-package "SPOT_CAM::SETFLOATRESPONSE")
  (make-package "SPOT_CAM::SETFLOATRESPONSE"))

(in-package "ROS")





(defclass spot_cam::SetFloatRequest
  :super ros::object
  :slots (_value ))

(defmethod spot_cam::SetFloatRequest
  (:init
   (&key
    ((:value __value) 0.0)
    )
   (send-super :init)
   (setq _value (float __value))
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; float32 _value
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _value
       (sys::poke _value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _value
     (setq _value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_cam::SetFloatResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetFloatResponse
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

(defclass spot_cam::SetFloat
  :super ros::object
  :slots ())

(setf (get spot_cam::SetFloat :md5sum-) "345a3274594e7cc629d8cd38d3b1fe73")
(setf (get spot_cam::SetFloat :datatype-) "spot_cam/SetFloat")
(setf (get spot_cam::SetFloat :request) spot_cam::SetFloatRequest)
(setf (get spot_cam::SetFloat :response) spot_cam::SetFloatResponse)

(defmethod spot_cam::SetFloatRequest
  (:response () (instance spot_cam::SetFloatResponse :init)))

(setf (get spot_cam::SetFloatRequest :md5sum-) "345a3274594e7cc629d8cd38d3b1fe73")
(setf (get spot_cam::SetFloatRequest :datatype-) "spot_cam/SetFloatRequest")
(setf (get spot_cam::SetFloatRequest :definition-)
      "float32 value
---
bool success
string message
")

(setf (get spot_cam::SetFloatResponse :md5sum-) "345a3274594e7cc629d8cd38d3b1fe73")
(setf (get spot_cam::SetFloatResponse :datatype-) "spot_cam/SetFloatResponse")
(setf (get spot_cam::SetFloatResponse :definition-)
      "float32 value
---
bool success
string message
")



(provide :spot_cam/SetFloat "345a3274594e7cc629d8cd38d3b1fe73")


