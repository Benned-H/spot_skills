;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::SetIRColormap)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'SetIRColormap (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::SETIRCOLORMAP")
  (make-package "SPOT_CAM::SETIRCOLORMAP"))
(unless (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST")
  (make-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(unless (find-package "SPOT_CAM::SETIRCOLORMAPRESPONSE")
  (make-package "SPOT_CAM::SETIRCOLORMAPRESPONSE"))

(in-package "ROS")





(intern "*COLORMAP_UNKNOWN*" (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(shadow '*COLORMAP_UNKNOWN* (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(defconstant spot_cam::SetIRColormapRequest::*COLORMAP_UNKNOWN* 0)
(intern "*COLORMAP_GREYSCALE*" (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(shadow '*COLORMAP_GREYSCALE* (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(defconstant spot_cam::SetIRColormapRequest::*COLORMAP_GREYSCALE* 1)
(intern "*COLORMAP_JET*" (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(shadow '*COLORMAP_JET* (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(defconstant spot_cam::SetIRColormapRequest::*COLORMAP_JET* 2)
(intern "*COLORMAP_INFERNO*" (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(shadow '*COLORMAP_INFERNO* (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(defconstant spot_cam::SetIRColormapRequest::*COLORMAP_INFERNO* 3)
(intern "*COLORMAP_TURBO*" (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(shadow '*COLORMAP_TURBO* (find-package "SPOT_CAM::SETIRCOLORMAPREQUEST"))
(defconstant spot_cam::SetIRColormapRequest::*COLORMAP_TURBO* 4)

(defun spot_cam::SetIRColormapRequest-to-symbol (const)
  (cond
        ((= const 0) 'spot_cam::SetIRColormapRequest::*COLORMAP_UNKNOWN*)
        ((= const 1) 'spot_cam::SetIRColormapRequest::*COLORMAP_GREYSCALE*)
        ((= const 2) 'spot_cam::SetIRColormapRequest::*COLORMAP_JET*)
        ((= const 3) 'spot_cam::SetIRColormapRequest::*COLORMAP_INFERNO*)
        ((= const 4) 'spot_cam::SetIRColormapRequest::*COLORMAP_TURBO*)
        (t nil)))

(defclass spot_cam::SetIRColormapRequest
  :super ros::object
  :slots (_colormap _min _max _auto_scale ))

(defmethod spot_cam::SetIRColormapRequest
  (:init
   (&key
    ((:colormap __colormap) 0)
    ((:min __min) 0.0)
    ((:max __max) 0.0)
    ((:auto_scale __auto_scale) nil)
    )
   (send-super :init)
   (setq _colormap (round __colormap))
   (setq _min (float __min))
   (setq _max (float __max))
   (setq _auto_scale __auto_scale)
   self)
  (:colormap
   (&optional __colormap)
   (if __colormap (setq _colormap __colormap)) _colormap)
  (:min
   (&optional __min)
   (if __min (setq _min __min)) _min)
  (:max
   (&optional __max)
   (if __max (setq _max __max)) _max)
  (:auto_scale
   (&optional (__auto_scale :null))
   (if (not (eq __auto_scale :null)) (setq _auto_scale __auto_scale)) _auto_scale)
  (:serialization-length
   ()
   (+
    ;; uint8 _colormap
    1
    ;; float32 _min
    4
    ;; float32 _max
    4
    ;; bool _auto_scale
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _colormap
       (write-byte _colormap s)
     ;; float32 _min
       (sys::poke _min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _max
       (sys::poke _max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _auto_scale
       (if _auto_scale (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _colormap
     (setq _colormap (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _min
     (setq _min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _max
     (setq _max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _auto_scale
     (setq _auto_scale (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_cam::SetIRColormapResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::SetIRColormapResponse
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

(defclass spot_cam::SetIRColormap
  :super ros::object
  :slots ())

(setf (get spot_cam::SetIRColormap :md5sum-) "e8a4267610857cdc61a42ef5adcd242f")
(setf (get spot_cam::SetIRColormap :datatype-) "spot_cam/SetIRColormap")
(setf (get spot_cam::SetIRColormap :request) spot_cam::SetIRColormapRequest)
(setf (get spot_cam::SetIRColormap :response) spot_cam::SetIRColormapResponse)

(defmethod spot_cam::SetIRColormapRequest
  (:response () (instance spot_cam::SetIRColormapResponse :init)))

(setf (get spot_cam::SetIRColormapRequest :md5sum-) "e8a4267610857cdc61a42ef5adcd242f")
(setf (get spot_cam::SetIRColormapRequest :datatype-) "spot_cam/SetIRColormapRequest")
(setf (get spot_cam::SetIRColormapRequest :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ircolormap for definition
uint8 COLORMAP_UNKNOWN=0
# The greyscale colormap maps the minimum value (defined below) to black and the maximum value (defined below) to white
uint8 COLORMAP_GREYSCALE=1
# The jet colormap uses blues for values closer to the minimum, and red values for values closer to the maximum.
uint8 COLORMAP_JET=2
# The inferno colormap maps the minimum value to black and the maximum value to light yellow RGB(252, 252, 164).
# It is also easier to view by those with color blindness
uint8 COLORMAP_INFERNO=3
# The turbo colormap uses blues for values closer to the minumum, red values for values closer to the maximum,
# and addresses some short comings of the jet color map such as false detail, banding and color blindness
uint8 COLORMAP_TURBO=4

# The colormap to use for the IR display
uint8 colormap
# Minimum value for the color mapping in degrees celsius
float32 min
# Maximum value for the color mapping in degrees celsius
float32 max
# If true, automatically derive min and max from the image data. Min and max values are ignored
bool auto_scale
---
bool success
string message
")

(setf (get spot_cam::SetIRColormapResponse :md5sum-) "e8a4267610857cdc61a42ef5adcd242f")
(setf (get spot_cam::SetIRColormapResponse :datatype-) "spot_cam/SetIRColormapResponse")
(setf (get spot_cam::SetIRColormapResponse :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ircolormap for definition
uint8 COLORMAP_UNKNOWN=0
# The greyscale colormap maps the minimum value (defined below) to black and the maximum value (defined below) to white
uint8 COLORMAP_GREYSCALE=1
# The jet colormap uses blues for values closer to the minimum, and red values for values closer to the maximum.
uint8 COLORMAP_JET=2
# The inferno colormap maps the minimum value to black and the maximum value to light yellow RGB(252, 252, 164).
# It is also easier to view by those with color blindness
uint8 COLORMAP_INFERNO=3
# The turbo colormap uses blues for values closer to the minumum, red values for values closer to the maximum,
# and addresses some short comings of the jet color map such as false detail, banding and color blindness
uint8 COLORMAP_TURBO=4

# The colormap to use for the IR display
uint8 colormap
# Minimum value for the color mapping in degrees celsius
float32 min
# Maximum value for the color mapping in degrees celsius
float32 max
# If true, automatically derive min and max from the image data. Min and max values are ignored
bool auto_scale
---
bool success
string message
")



(provide :spot_cam/SetIRColormap "e8a4267610857cdc61a42ef5adcd242f")


