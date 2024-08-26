;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PTZDescriptionArray)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PTZDescriptionArray (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::PTZDESCRIPTIONARRAY")
  (make-package "SPOT_CAM::PTZDESCRIPTIONARRAY"))

(in-package "ROS")
;;//! \htmlinclude PTZDescriptionArray.msg.html


(defclass spot_cam::PTZDescriptionArray
  :super ros::object
  :slots (_ptzs ))

(defmethod spot_cam::PTZDescriptionArray
  (:init
   (&key
    ((:ptzs __ptzs) ())
    )
   (send-super :init)
   (setq _ptzs __ptzs)
   self)
  (:ptzs
   (&rest __ptzs)
   (if (keywordp (car __ptzs))
       (send* _ptzs __ptzs)
     (progn
       (if __ptzs (setq _ptzs (car __ptzs)))
       _ptzs)))
  (:serialization-length
   ()
   (+
    ;; spot_cam/PTZDescription[] _ptzs
    (apply #'+ (send-all _ptzs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_cam/PTZDescription[] _ptzs
     (write-long (length _ptzs) s)
     (dolist (elem _ptzs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_cam/PTZDescription[] _ptzs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ptzs (let (r) (dotimes (i n) (push (instance spot_cam::PTZDescription :init) r)) r))
     (dolist (elem- _ptzs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_cam::PTZDescriptionArray :md5sum-) "bb84fb6777d2423bbf5218a0dc2508f6")
(setf (get spot_cam::PTZDescriptionArray :datatype-) "spot_cam/PTZDescriptionArray")
(setf (get spot_cam::PTZDescriptionArray :definition-)
      "spot_cam/PTZDescription[] ptzs
================================================================================
MSG: spot_cam/PTZDescription
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
# Name of this ptz (can be virtual)
string name
# Limits in degrees on the pan axis
spot_cam/PTZLimits pan_limit
# Limits in degrees on the pan axis
spot_cam/PTZLimits tilt_limit
# Limits in degrees on the pan axis
spot_cam/PTZLimits zoom_limit
================================================================================
MSG: spot_cam/PTZLimits
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits
# If both max and min are zero, this means the limit is unset. The documentation states that if a limit
# is unset, then all positions are valid.
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
# Minimum value for the axis
float32 min
# Maximum value for the axis
float32 max
")



(provide :spot_cam/PTZDescriptionArray "bb84fb6777d2423bbf5218a0dc2508f6")


