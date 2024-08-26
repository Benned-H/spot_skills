;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SpotCheckLoadCell)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SpotCheckLoadCell (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SPOTCHECKLOADCELL")
  (make-package "SPOT_MSGS::SPOTCHECKLOADCELL"))

(in-package "ROS")
;;//! \htmlinclude SpotCheckLoadCell.msg.html


(intern "*ERROR_UNKNOWN*" (find-package "SPOT_MSGS::SPOTCHECKLOADCELL"))
(shadow '*ERROR_UNKNOWN* (find-package "SPOT_MSGS::SPOTCHECKLOADCELL"))
(defconstant spot_msgs::SpotCheckLoadCell::*ERROR_UNKNOWN* 0)
(intern "*ERROR_NONE*" (find-package "SPOT_MSGS::SPOTCHECKLOADCELL"))
(shadow '*ERROR_NONE* (find-package "SPOT_MSGS::SPOTCHECKLOADCELL"))
(defconstant spot_msgs::SpotCheckLoadCell::*ERROR_NONE* 1)
(intern "*ERROR_ZERO_OUT_OF_RANGE*" (find-package "SPOT_MSGS::SPOTCHECKLOADCELL"))
(shadow '*ERROR_ZERO_OUT_OF_RANGE* (find-package "SPOT_MSGS::SPOTCHECKLOADCELL"))
(defconstant spot_msgs::SpotCheckLoadCell::*ERROR_ZERO_OUT_OF_RANGE* 2)

(defun spot_msgs::SpotCheckLoadCell-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SpotCheckLoadCell::*ERROR_UNKNOWN*)
        ((= const 1) 'spot_msgs::SpotCheckLoadCell::*ERROR_NONE*)
        ((= const 2) 'spot_msgs::SpotCheckLoadCell::*ERROR_ZERO_OUT_OF_RANGE*)
        (t nil)))

(defclass spot_msgs::SpotCheckLoadCell
  :super ros::object
  :slots (_error _zero _old_zero ))

(defmethod spot_msgs::SpotCheckLoadCell
  (:init
   (&key
    ((:error __error) 0)
    ((:zero __zero) 0.0)
    ((:old_zero __old_zero) 0.0)
    )
   (send-super :init)
   (setq _error (round __error))
   (setq _zero (float __zero))
   (setq _old_zero (float __old_zero))
   self)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:zero
   (&optional __zero)
   (if __zero (setq _zero __zero)) _zero)
  (:old_zero
   (&optional __old_zero)
   (if __old_zero (setq _old_zero __old_zero)) _old_zero)
  (:serialization-length
   ()
   (+
    ;; uint8 _error
    1
    ;; float32 _zero
    4
    ;; float32 _old_zero
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _error
       (write-byte _error s)
     ;; float32 _zero
       (sys::poke _zero (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _old_zero
       (sys::poke _old_zero (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _error
     (setq _error (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _zero
     (setq _zero (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _old_zero
     (setq _old_zero (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::SpotCheckLoadCell :md5sum-) "bfb62ba66777d3800f98e3fc7140667a")
(setf (get spot_msgs::SpotCheckLoadCell :datatype-) "spot_msgs/SpotCheckLoadCell")
(setf (get spot_msgs::SpotCheckLoadCell :definition-)
      "uint8 ERROR_UNKNOWN = 0              # Unused enum.
uint8 ERROR_NONE = 1                 # No hardware error detected.
uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.

# The loadcell error code
uint8 error
# The current loadcell zero as fraction of full range [0-1]
float32 zero
# The previous loadcell zero as fraction of full range [0-1]
float32 old_zero
")



(provide :spot_msgs/SpotCheckLoadCell "bfb62ba66777d3800f98e3fc7140667a")


