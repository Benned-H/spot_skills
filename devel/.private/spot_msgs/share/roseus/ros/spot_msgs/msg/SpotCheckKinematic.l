;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SpotCheckKinematic)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SpotCheckKinematic (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC")
  (make-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))

(in-package "ROS")
;;//! \htmlinclude SpotCheckKinematic.msg.html


(intern "*ERROR_UNKNOWN*" (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(shadow '*ERROR_UNKNOWN* (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(defconstant spot_msgs::SpotCheckKinematic::*ERROR_UNKNOWN* 0)
(intern "*ERROR_NONE*" (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(shadow '*ERROR_NONE* (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(defconstant spot_msgs::SpotCheckKinematic::*ERROR_NONE* 1)
(intern "*ERROR_CLUTCH_SLIP*" (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(shadow '*ERROR_CLUTCH_SLIP* (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(defconstant spot_msgs::SpotCheckKinematic::*ERROR_CLUTCH_SLIP* 2)
(intern "*ERROR_INVALID_RANGE_OF_MOTION*" (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(shadow '*ERROR_INVALID_RANGE_OF_MOTION* (find-package "SPOT_MSGS::SPOTCHECKKINEMATIC"))
(defconstant spot_msgs::SpotCheckKinematic::*ERROR_INVALID_RANGE_OF_MOTION* 3)

(defun spot_msgs::SpotCheckKinematic-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SpotCheckKinematic::*ERROR_UNKNOWN*)
        ((= const 1) 'spot_msgs::SpotCheckKinematic::*ERROR_NONE*)
        ((= const 2) 'spot_msgs::SpotCheckKinematic::*ERROR_CLUTCH_SLIP*)
        ((= const 3) 'spot_msgs::SpotCheckKinematic::*ERROR_INVALID_RANGE_OF_MOTION*)
        (t nil)))

(defclass spot_msgs::SpotCheckKinematic
  :super ros::object
  :slots (_error _offset _old_offset _health_score ))

(defmethod spot_msgs::SpotCheckKinematic
  (:init
   (&key
    ((:error __error) 0)
    ((:offset __offset) 0.0)
    ((:old_offset __old_offset) 0.0)
    ((:health_score __health_score) 0.0)
    )
   (send-super :init)
   (setq _error (round __error))
   (setq _offset (float __offset))
   (setq _old_offset (float __old_offset))
   (setq _health_score (float __health_score))
   self)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:offset
   (&optional __offset)
   (if __offset (setq _offset __offset)) _offset)
  (:old_offset
   (&optional __old_offset)
   (if __old_offset (setq _old_offset __old_offset)) _old_offset)
  (:health_score
   (&optional __health_score)
   (if __health_score (setq _health_score __health_score)) _health_score)
  (:serialization-length
   ()
   (+
    ;; uint8 _error
    1
    ;; float32 _offset
    4
    ;; float32 _old_offset
    4
    ;; float32 _health_score
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _error
       (write-byte _error s)
     ;; float32 _offset
       (sys::poke _offset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _old_offset
       (sys::poke _old_offset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _health_score
       (sys::poke _health_score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _error
     (setq _error (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _offset
     (setq _offset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _old_offset
     (setq _old_offset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _health_score
     (setq _health_score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::SpotCheckKinematic :md5sum-) "fe33606761c255ffb331f260e7ee4d23")
(setf (get spot_msgs::SpotCheckKinematic :datatype-) "spot_msgs/SpotCheckKinematic")
(setf (get spot_msgs::SpotCheckKinematic :definition-)
      "# Errors reflect an issue with robot hardware.
uint8 ERROR_UNKNOWN = 0       # Unused enum.
uint8 ERROR_NONE = 1          # No hardware error detected.
uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.
uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.

# A flag to indicate if results has an error.
uint8 error

# The current offset [rad]
float32 offset
# The previous offset [rad]
float32 old_offset

# Joint calibration health score. range [0-1]
# 0 indicates an unhealthy kinematic joint calibration
# 1 indicates a perfect kinematic joint calibration
# Typically, values greater than 0.8 should be expected.
float32 health_score
")



(provide :spot_msgs/SpotCheckKinematic "fe33606761c255ffb331f260e7ee4d23")


