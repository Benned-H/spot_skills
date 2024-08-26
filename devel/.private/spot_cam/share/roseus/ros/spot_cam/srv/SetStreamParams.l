;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetStreamParams)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetStreamParams (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETSTREAMPARAMS")
  (make-package "SPOT_CAM::SETSTREAMPARAMS"))
(unless (find-package "SPOT_CAM::SETSTREAMPARAMSREQUEST")
  (make-package "SPOT_CAM::SETSTREAMPARAMSREQUEST"))
(unless (find-package "SPOT_CAM::SETSTREAMPARAMSRESPONSE")
  (make-package "SPOT_CAM::SETSTREAMPARAMSRESPONSE"))

(in-package "ROS")





(defclass spot_cam::SetStreamParamsRequest
  :super ros::object
  :slots (_params ))

(defmethod spot_cam::SetStreamParamsRequest
  (:init
   (&key
    ((:params __params) (instance spot_cam::StreamParams :init))
    )
   (send-super :init)
   (setq _params __params)
   self)
  (:params
   (&rest __params)
   (if (keywordp (car __params))
       (send* _params __params)
     (progn
       (if __params (setq _params (car __params)))
       _params)))
  (:serialization-length
   ()
   (+
    ;; spot_cam/StreamParams _params
    (send _params :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_cam/StreamParams _params
       (send _params :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_cam/StreamParams _params
     (send _params :deserialize buf ptr-) (incf ptr- (send _params :serialization-length))
   ;;
   self)
  )

(defclass spot_cam::SetStreamParamsResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetStreamParamsResponse
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

(defclass spot_cam::SetStreamParams
  :super ros::object
  :slots ())

(setf (get spot_cam::SetStreamParams :md5sum-) "bde49dd2a9f9234c2f23c257153388e8")
(setf (get spot_cam::SetStreamParams :datatype-) "spot_cam/SetStreamParams")
(setf (get spot_cam::SetStreamParams :request) spot_cam::SetStreamParamsRequest)
(setf (get spot_cam::SetStreamParams :response) spot_cam::SetStreamParamsResponse)

(defmethod spot_cam::SetStreamParamsRequest
  (:response () (instance spot_cam::SetStreamParamsResponse :init)))

(setf (get spot_cam::SetStreamParamsRequest :md5sum-) "bde49dd2a9f9234c2f23c257153388e8")
(setf (get spot_cam::SetStreamParamsRequest :datatype-) "spot_cam/SetStreamParamsRequest")
(setf (get spot_cam::SetStreamParamsRequest :definition-)
      "spot_cam/StreamParams params

================================================================================
MSG: spot_cam/StreamParams
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams
# White balance modes
int8 OFF=-1
# This is not provided, but we add it to be able to distinguish when setting the white balance
int8 UNSET=0
int8 AUTO=1
int8 INCANDESCENT=2
int8 FLUORESCENT=3
int8 WARM_FLUORESCENT=4
int8 DAYLIGHT=5
int8 CLOUDY=6
int8 TWILIGHT=7
int8 SHADE=8
int8 DARK=9

# Compression level target in bits per second
int64 target_bitrate
# How often should the entire feed be refreshed (in frames)
int64 refresh_interval
# How often should an IDR message be sent (in frames)
int64 idr_interval
# Automatic white balance
---
bool success
string message
")

(setf (get spot_cam::SetStreamParamsResponse :md5sum-) "bde49dd2a9f9234c2f23c257153388e8")
(setf (get spot_cam::SetStreamParamsResponse :datatype-) "spot_cam/SetStreamParamsResponse")
(setf (get spot_cam::SetStreamParamsResponse :definition-)
      "spot_cam/StreamParams params

================================================================================
MSG: spot_cam/StreamParams
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams
# White balance modes
int8 OFF=-1
# This is not provided, but we add it to be able to distinguish when setting the white balance
int8 UNSET=0
int8 AUTO=1
int8 INCANDESCENT=2
int8 FLUORESCENT=3
int8 WARM_FLUORESCENT=4
int8 DAYLIGHT=5
int8 CLOUDY=6
int8 TWILIGHT=7
int8 SHADE=8
int8 DARK=9

# Compression level target in bits per second
int64 target_bitrate
# How often should the entire feed be refreshed (in frames)
int64 refresh_interval
# How often should an IDR message be sent (in frames)
int64 idr_interval
# Automatic white balance
---
bool success
string message
")



(provide :spot_cam/SetStreamParams "bde49dd2a9f9234c2f23c257153388e8")


