;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetIRMeterOverlay)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetIRMeterOverlay (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETIRMETEROVERLAY")
  (make-package "SPOT_CAM::SETIRMETEROVERLAY"))
(unless (find-package "SPOT_CAM::SETIRMETEROVERLAYREQUEST")
  (make-package "SPOT_CAM::SETIRMETEROVERLAYREQUEST"))
(unless (find-package "SPOT_CAM::SETIRMETEROVERLAYRESPONSE")
  (make-package "SPOT_CAM::SETIRMETEROVERLAYRESPONSE"))

(in-package "ROS")





(defclass spot_cam::SetIRMeterOverlayRequest
  :super ros::object
  :slots (_x _y _enable ))

(defmethod spot_cam::SetIRMeterOverlayRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:enable __enable) nil)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _enable __enable)
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:enable
   (&optional (__enable :null))
   (if (not (eq __enable :null)) (setq _enable __enable)) _enable)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; bool _enable
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enable
       (if _enable (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enable
     (setq _enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_cam::SetIRMeterOverlayResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetIRMeterOverlayResponse
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

(defclass spot_cam::SetIRMeterOverlay
  :super ros::object
  :slots ())

(setf (get spot_cam::SetIRMeterOverlay :md5sum-) "d78148bbe8e3d55b83a79817052ec369")
(setf (get spot_cam::SetIRMeterOverlay :datatype-) "spot_cam/SetIRMeterOverlay")
(setf (get spot_cam::SetIRMeterOverlay :request) spot_cam::SetIRMeterOverlayRequest)
(setf (get spot_cam::SetIRMeterOverlay :response) spot_cam::SetIRMeterOverlayResponse)

(defmethod spot_cam::SetIRMeterOverlayRequest
  (:response () (instance spot_cam::SetIRMeterOverlayResponse :init)))

(setf (get spot_cam::SetIRMeterOverlayRequest :md5sum-) "d78148bbe8e3d55b83a79817052ec369")
(setf (get spot_cam::SetIRMeterOverlayRequest :datatype-) "spot_cam/SetIRMeterOverlayRequest")
(setf (get spot_cam::SetIRMeterOverlayRequest :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#irmeteroverlay for definition
# Horizontal coordinate between 0 and 1
float32 x
# Vertical coordinate between 0 and 1
float32 y
# If false, disable the display of the overlay
bool enable
---
bool success
string message

")

(setf (get spot_cam::SetIRMeterOverlayResponse :md5sum-) "d78148bbe8e3d55b83a79817052ec369")
(setf (get spot_cam::SetIRMeterOverlayResponse :datatype-) "spot_cam/SetIRMeterOverlayResponse")
(setf (get spot_cam::SetIRMeterOverlayResponse :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#irmeteroverlay for definition
# Horizontal coordinate between 0 and 1
float32 x
# Vertical coordinate between 0 and 1
float32 y
# If false, disable the display of the overlay
bool enable
---
bool success
string message

")



(provide :spot_cam/SetIRMeterOverlay "d78148bbe8e3d55b83a79817052ec369")


