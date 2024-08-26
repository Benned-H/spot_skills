;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SpotCheckDepth)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SpotCheckDepth (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SPOTCHECKDEPTH")
  (make-package "SPOT_MSGS::SPOTCHECKDEPTH"))

(in-package "ROS")
;;//! \htmlinclude SpotCheckDepth.msg.html


(intern "*STATUS_UNKNOWN*" (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(shadow '*STATUS_UNKNOWN* (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(defconstant spot_msgs::SpotCheckDepth::*STATUS_UNKNOWN* 0)
(intern "*STATUS_OK*" (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(shadow '*STATUS_OK* (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(defconstant spot_msgs::SpotCheckDepth::*STATUS_OK* 1)
(intern "*STATUS_WARNING*" (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(shadow '*STATUS_WARNING* (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(defconstant spot_msgs::SpotCheckDepth::*STATUS_WARNING* 2)
(intern "*STATUS_ERROR*" (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(shadow '*STATUS_ERROR* (find-package "SPOT_MSGS::SPOTCHECKDEPTH"))
(defconstant spot_msgs::SpotCheckDepth::*STATUS_ERROR* 3)

(defun spot_msgs::SpotCheckDepth-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SpotCheckDepth::*STATUS_UNKNOWN*)
        ((= const 1) 'spot_msgs::SpotCheckDepth::*STATUS_OK*)
        ((= const 2) 'spot_msgs::SpotCheckDepth::*STATUS_WARNING*)
        ((= const 3) 'spot_msgs::SpotCheckDepth::*STATUS_ERROR*)
        (t nil)))

(defclass spot_msgs::SpotCheckDepth
  :super ros::object
  :slots (_status _severity_score ))

(defmethod spot_msgs::SpotCheckDepth
  (:init
   (&key
    ((:status __status) 0)
    ((:severity_score __severity_score) 0.0)
    )
   (send-super :init)
   (setq _status (round __status))
   (setq _severity_score (float __severity_score))
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:severity_score
   (&optional __severity_score)
   (if __severity_score (setq _severity_score __severity_score)) _severity_score)
  (:serialization-length
   ()
   (+
    ;; uint8 _status
    1
    ;; float32 _severity_score
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _status
       (write-byte _status s)
     ;; float32 _severity_score
       (sys::poke _severity_score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _severity_score
     (setq _severity_score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::SpotCheckDepth :md5sum-) "1df6ba22c62edcdd0f95e8c8502952ed")
(setf (get spot_msgs::SpotCheckDepth :datatype-) "spot_msgs/SpotCheckDepth")
(setf (get spot_msgs::SpotCheckDepth :definition-)
      "uint8 STATUS_UNKNOWN = 0     # Unused enum.
uint8 STATUS_OK = 1          # No detected calibration error.
uint8 STATUS_WARNING = 2     # Possible calibration error detected.
uint8 STATUS_ERROR = 3       # Error with robot calibration.

uint8 status
float32 severity_score
")



(provide :spot_msgs/SpotCheckDepth "1df6ba22c62edcdd0f95e8c8502952ed")


