;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::TemperatureArray)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'TemperatureArray (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::TEMPERATUREARRAY")
  (make-package "SPOT_CAM::TEMPERATUREARRAY"))

(in-package "ROS")
;;//! \htmlinclude TemperatureArray.msg.html


(defclass spot_cam::TemperatureArray
  :super ros::object
  :slots (_temperatures ))

(defmethod spot_cam::TemperatureArray
  (:init
   (&key
    ((:temperatures __temperatures) ())
    )
   (send-super :init)
   (setq _temperatures __temperatures)
   self)
  (:temperatures
   (&rest __temperatures)
   (if (keywordp (car __temperatures))
       (send* _temperatures __temperatures)
     (progn
       (if __temperatures (setq _temperatures (car __temperatures)))
       _temperatures)))
  (:serialization-length
   ()
   (+
    ;; spot_cam/Temperature[] _temperatures
    (apply #'+ (send-all _temperatures :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_cam/Temperature[] _temperatures
     (write-long (length _temperatures) s)
     (dolist (elem _temperatures)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_cam/Temperature[] _temperatures
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _temperatures (let (r) (dotimes (i n) (push (instance spot_cam::Temperature :init) r)) r))
     (dolist (elem- _temperatures)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_cam::TemperatureArray :md5sum-) "73e05ea32a31a886a7c7b59b78f7eb0b")
(setf (get spot_cam::TemperatureArray :datatype-) "spot_cam/TemperatureArray")
(setf (get spot_cam::TemperatureArray :definition-)
      "spot_cam/Temperature[] temperatures
================================================================================
MSG: spot_cam/Temperature
string channel_name
float32 temperature
")



(provide :spot_cam/TemperatureArray "73e05ea32a31a886a7c7b59b78f7eb0b")


