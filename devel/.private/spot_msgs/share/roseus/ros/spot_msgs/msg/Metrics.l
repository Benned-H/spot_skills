;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::Metrics)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'Metrics (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::METRICS")
  (make-package "SPOT_MSGS::METRICS"))

(in-package "ROS")
;;//! \htmlinclude Metrics.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass spot_msgs::Metrics
  :super ros::object
  :slots (_header _distance _gait_cycles _time_moving _electric_power ))

(defmethod spot_msgs::Metrics
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:distance __distance) 0.0)
    ((:gait_cycles __gait_cycles) 0)
    ((:time_moving __time_moving) (instance ros::time :init))
    ((:electric_power __electric_power) (instance ros::time :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _distance (float __distance))
   (setq _gait_cycles (round __gait_cycles))
   (setq _time_moving __time_moving)
   (setq _electric_power __electric_power)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:gait_cycles
   (&optional __gait_cycles)
   (if __gait_cycles (setq _gait_cycles __gait_cycles)) _gait_cycles)
  (:time_moving
   (&optional __time_moving)
   (if __time_moving (setq _time_moving __time_moving)) _time_moving)
  (:electric_power
   (&optional __electric_power)
   (if __electric_power (setq _electric_power __electric_power)) _electric_power)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _distance
    4
    ;; int32 _gait_cycles
    4
    ;; duration _time_moving
    8
    ;; duration _electric_power
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _gait_cycles
       (write-long _gait_cycles s)
     ;; duration _time_moving
       (write-long (send _time_moving :sec) s) (write-long (send _time_moving :nsec) s)
     ;; duration _electric_power
       (write-long (send _electric_power :sec) s) (write-long (send _electric_power :nsec) s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _distance
     (setq _distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _gait_cycles
     (setq _gait_cycles (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; duration _time_moving
     (send _time_moving :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _time_moving :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; duration _electric_power
     (send _electric_power :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _electric_power :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::Metrics :md5sum-) "493e599307ab2a6dbe49405e7b5a9b6d")
(setf (get spot_msgs::Metrics :datatype-) "spot_msgs/Metrics")
(setf (get spot_msgs::Metrics :definition-)
      "Header header
float32 distance
int32 gait_cycles
duration time_moving
duration electric_power

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :spot_msgs/Metrics "493e599307ab2a6dbe49405e7b5a9b6d")


