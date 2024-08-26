;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SpotCheckPayload)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SpotCheckPayload (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD")
  (make-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))

(in-package "ROS")
;;//! \htmlinclude SpotCheckPayload.msg.html


(intern "*ERROR_UNKNOWN*" (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))
(shadow '*ERROR_UNKNOWN* (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))
(defconstant spot_msgs::SpotCheckPayload::*ERROR_UNKNOWN* 0)
(intern "*ERROR_NONE*" (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))
(shadow '*ERROR_NONE* (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))
(defconstant spot_msgs::SpotCheckPayload::*ERROR_NONE* 1)
(intern "*ERROR_MASS_DISCREPANCY*" (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))
(shadow '*ERROR_MASS_DISCREPANCY* (find-package "SPOT_MSGS::SPOTCHECKPAYLOAD"))
(defconstant spot_msgs::SpotCheckPayload::*ERROR_MASS_DISCREPANCY* 2)

(defun spot_msgs::SpotCheckPayload-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SpotCheckPayload::*ERROR_UNKNOWN*)
        ((= const 1) 'spot_msgs::SpotCheckPayload::*ERROR_NONE*)
        ((= const 2) 'spot_msgs::SpotCheckPayload::*ERROR_MASS_DISCREPANCY*)
        (t nil)))

(defclass spot_msgs::SpotCheckPayload
  :super ros::object
  :slots (_error _extra_payload ))

(defmethod spot_msgs::SpotCheckPayload
  (:init
   (&key
    ((:error __error) 0)
    ((:extra_payload __extra_payload) 0.0)
    )
   (send-super :init)
   (setq _error (round __error))
   (setq _extra_payload (float __extra_payload))
   self)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:extra_payload
   (&optional __extra_payload)
   (if __extra_payload (setq _extra_payload __extra_payload)) _extra_payload)
  (:serialization-length
   ()
   (+
    ;; uint8 _error
    1
    ;; float32 _extra_payload
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _error
       (write-byte _error s)
     ;; float32 _extra_payload
       (sys::poke _extra_payload (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _error
     (setq _error (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _extra_payload
     (setq _extra_payload (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::SpotCheckPayload :md5sum-) "8a5462c1672d0b3443d0f93dc832b167")
(setf (get spot_msgs::SpotCheckPayload :datatype-) "spot_msgs/SpotCheckPayload")
(setf (get spot_msgs::SpotCheckPayload :definition-)
      "# Errors reflect an issue with payload configuration.

# Unused enum.
uint8 ERROR_UNKNOWN = 0
# No error found in the payloads.
uint8 ERROR_NONE = 1
# There is a mass discrepancy between the registered payload and what is estimated.
uint8 ERROR_MASS_DISCREPANCY = 2

# A flag to indicate if configuration has an error.
uint8 error

# Indicates how much extra payload (in kg) we think the robot has
# Positive indicates robot has more payload than it is configured.
# Negative indicates robot has less payload than it is configured.
float32 extra_payload
")



(provide :spot_msgs/SpotCheckPayload "8a5462c1672d0b3443d0f93dc832b167")


