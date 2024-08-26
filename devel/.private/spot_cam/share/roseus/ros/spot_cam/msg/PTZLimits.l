;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PTZLimits)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PTZLimits (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::PTZLIMITS")
  (make-package "SPOT_CAM::PTZLIMITS"))

(in-package "ROS")
;;//! \htmlinclude PTZLimits.msg.html


(defclass spot_cam::PTZLimits
  :super ros::object
  :slots (_min _max ))

(defmethod spot_cam::PTZLimits
  (:init
   (&key
    ((:min __min) 0.0)
    ((:max __max) 0.0)
    )
   (send-super :init)
   (setq _min (float __min))
   (setq _max (float __max))
   self)
  (:min
   (&optional __min)
   (if __min (setq _min __min)) _min)
  (:max
   (&optional __max)
   (if __max (setq _max __max)) _max)
  (:serialization-length
   ()
   (+
    ;; float32 _min
    4
    ;; float32 _max
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _min
       (sys::poke _min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _max
       (sys::poke _max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _min
     (setq _min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _max
     (setq _max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_cam::PTZLimits :md5sum-) "b3ee9ed25575b46bb47c7673ad202faa")
(setf (get spot_cam::PTZLimits :datatype-) "spot_cam/PTZLimits")
(setf (get spot_cam::PTZLimits :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits
# If both max and min are zero, this means the limit is unset. The documentation states that if a limit
# is unset, then all positions are valid.
# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
# Minimum value for the axis
float32 min
# Maximum value for the axis
float32 max
")



(provide :spot_cam/PTZLimits "b3ee9ed25575b46bb47c7673ad202faa")


