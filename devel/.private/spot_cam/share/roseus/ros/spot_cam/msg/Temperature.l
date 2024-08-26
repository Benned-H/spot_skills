;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::Temperature)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'Temperature (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::TEMPERATURE")
  (make-package "SPOT_CAM::TEMPERATURE"))

(in-package "ROS")
;;//! \htmlinclude Temperature.msg.html


(defclass spot_cam::Temperature
  :super ros::object
  :slots (_channel_name _temperature ))

(defmethod spot_cam::Temperature
  (:init
   (&key
    ((:channel_name __channel_name) "")
    ((:temperature __temperature) 0.0)
    )
   (send-super :init)
   (setq _channel_name (string __channel_name))
   (setq _temperature (float __temperature))
   self)
  (:channel_name
   (&optional __channel_name)
   (if __channel_name (setq _channel_name __channel_name)) _channel_name)
  (:temperature
   (&optional __temperature)
   (if __temperature (setq _temperature __temperature)) _temperature)
  (:serialization-length
   ()
   (+
    ;; string _channel_name
    4 (length _channel_name)
    ;; float32 _temperature
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _channel_name
       (write-long (length _channel_name) s) (princ _channel_name s)
     ;; float32 _temperature
       (sys::poke _temperature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _channel_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _channel_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _temperature
     (setq _temperature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_cam::Temperature :md5sum-) "086009cefe0e896fc6b042a5e575d367")
(setf (get spot_cam::Temperature :datatype-) "spot_cam/Temperature")
(setf (get spot_cam::Temperature :definition-)
      "string channel_name
float32 temperature
")



(provide :spot_cam/Temperature "086009cefe0e896fc6b042a5e575d367")


