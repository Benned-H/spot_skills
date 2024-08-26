;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SpotCheckHipROM)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SpotCheckHipROM (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SPOTCHECKHIPROM")
  (make-package "SPOT_MSGS::SPOTCHECKHIPROM"))

(in-package "ROS")
;;//! \htmlinclude SpotCheckHipROM.msg.html


(intern "*ERROR_UNKNOWN*" (find-package "SPOT_MSGS::SPOTCHECKHIPROM"))
(shadow '*ERROR_UNKNOWN* (find-package "SPOT_MSGS::SPOTCHECKHIPROM"))
(defconstant spot_msgs::SpotCheckHipROM::*ERROR_UNKNOWN* 0)
(intern "*ERROR_NONE*" (find-package "SPOT_MSGS::SPOTCHECKHIPROM"))
(shadow '*ERROR_NONE* (find-package "SPOT_MSGS::SPOTCHECKHIPROM"))
(defconstant spot_msgs::SpotCheckHipROM::*ERROR_NONE* 1)
(intern "*ERROR_OBSTRUCTED*" (find-package "SPOT_MSGS::SPOTCHECKHIPROM"))
(shadow '*ERROR_OBSTRUCTED* (find-package "SPOT_MSGS::SPOTCHECKHIPROM"))
(defconstant spot_msgs::SpotCheckHipROM::*ERROR_OBSTRUCTED* 2)

(defun spot_msgs::SpotCheckHipROM-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SpotCheckHipROM::*ERROR_UNKNOWN*)
        ((= const 1) 'spot_msgs::SpotCheckHipROM::*ERROR_NONE*)
        ((= const 2) 'spot_msgs::SpotCheckHipROM::*ERROR_OBSTRUCTED*)
        (t nil)))

(defclass spot_msgs::SpotCheckHipROM
  :super ros::object
  :slots (_error _hx _hy ))

(defmethod spot_msgs::SpotCheckHipROM
  (:init
   (&key
    ((:error __error) 0)
    ((:hx __hx) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:hy __hy) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _error (round __error))
   (setq _hx __hx)
   (setq _hy __hy)
   self)
  (:error
   (&optional __error)
   (if __error (setq _error __error)) _error)
  (:hx
   (&optional __hx)
   (if __hx (setq _hx __hx)) _hx)
  (:hy
   (&optional __hy)
   (if __hy (setq _hy __hy)) _hy)
  (:serialization-length
   ()
   (+
    ;; uint8 _error
    1
    ;; float32[] _hx
    (* 4    (length _hx)) 4
    ;; float32[] _hy
    (* 4    (length _hy)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _error
       (write-byte _error s)
     ;; float32[] _hx
     (write-long (length _hx) s)
     (dotimes (i (length _hx))
       (sys::poke (elt _hx i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _hy
     (write-long (length _hy) s)
     (dotimes (i (length _hy))
       (sys::poke (elt _hy i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _error
     (setq _error (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[] _hx
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _hx (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _hx i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _hy
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _hy (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _hy i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get spot_msgs::SpotCheckHipROM :md5sum-) "2bffa893cfa8c1ee57352f3ccf3348bc")
(setf (get spot_msgs::SpotCheckHipROM :datatype-) "spot_msgs/SpotCheckHipROM")
(setf (get spot_msgs::SpotCheckHipROM :definition-)
      "# Errors reflect an issue with hip range of motion
uint8 ERROR_UNKNOWN = 0
uint8 ERROR_NONE = 1
uint8 ERROR_OBSTRUCTED = 2

uint8 error

# The measured angles (radians) of the HX and HY joints where the obstruction was detected
float32[] hx
float32[] hy
")



(provide :spot_msgs/SpotCheckHipROM "2bffa893cfa8c1ee57352f3ccf3348bc")


