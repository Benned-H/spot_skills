;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PTZDescription)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PTZDescription (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::PTZDESCRIPTION")
  (make-package "SPOT_CAM::PTZDESCRIPTION"))

(in-package "ROS")
;;//! \htmlinclude PTZDescription.msg.html


(defclass spot_cam::PTZDescription
  :super ros::object
  :slots (_name _pan_limit _tilt_limit _zoom_limit ))

(defmethod spot_cam::PTZDescription
  (:init
   (&key
    ((:name __name) "")
    ((:pan_limit __pan_limit) (instance spot_cam::PTZLimits :init))
    ((:tilt_limit __tilt_limit) (instance spot_cam::PTZLimits :init))
    ((:zoom_limit __zoom_limit) (instance spot_cam::PTZLimits :init))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _pan_limit __pan_limit)
   (setq _tilt_limit __tilt_limit)
   (setq _zoom_limit __zoom_limit)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:pan_limit
   (&rest __pan_limit)
   (if (keywordp (car __pan_limit))
       (send* _pan_limit __pan_limit)
     (progn
       (if __pan_limit (setq _pan_limit (car __pan_limit)))
       _pan_limit)))
  (:tilt_limit
   (&rest __tilt_limit)
   (if (keywordp (car __tilt_limit))
       (send* _tilt_limit __tilt_limit)
     (progn
       (if __tilt_limit (setq _tilt_limit (car __tilt_limit)))
       _tilt_limit)))
  (:zoom_limit
   (&rest __zoom_limit)
   (if (keywordp (car __zoom_limit))
       (send* _zoom_limit __zoom_limit)
     (progn
       (if __zoom_limit (setq _zoom_limit (car __zoom_limit)))
       _zoom_limit)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; spot_cam/PTZLimits _pan_limit
    (send _pan_limit :serialization-length)
    ;; spot_cam/PTZLimits _tilt_limit
    (send _tilt_limit :serialization-length)
    ;; spot_cam/PTZLimits _zoom_limit
    (send _zoom_limit :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; spot_cam/PTZLimits _pan_limit
       (send _pan_limit :serialize s)
     ;; spot_cam/PTZLimits _tilt_limit
       (send _tilt_limit :serialize s)
     ;; spot_cam/PTZLimits _zoom_limit
       (send _zoom_limit :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; spot_cam/PTZLimits _pan_limit
     (send _pan_limit :deserialize buf ptr-) (incf ptr- (send _pan_limit :serialization-length))
   ;; spot_cam/PTZLimits _tilt_limit
     (send _tilt_limit :deserialize buf ptr-) (incf ptr- (send _tilt_limit :serialization-length))
   ;; spot_cam/PTZLimits _zoom_limit
     (send _zoom_limit :deserialize buf ptr-) (incf ptr- (send _zoom_limit :serialization-length))
   ;;
   self)
  )

(setf (get spot_cam::PTZDescription :md5sum-) "e115be93750ee1ae6231f38b8b89491a")
(setf (get spot_cam::PTZDescription :datatype-) "spot_cam/PTZDescription")
(setf (get spot_cam::PTZDescription :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
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



(provide :spot_cam/PTZDescription "e115be93750ee1ae6231f38b8b89491a")


