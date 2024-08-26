;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::Degradation)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'Degradation (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::DEGRADATION")
  (make-package "SPOT_CAM::DEGRADATION"))

(in-package "ROS")
;;//! \htmlinclude Degradation.msg.html


(intern "*TYPE_STORAGE*" (find-package "SPOT_CAM::DEGRADATION"))
(shadow '*TYPE_STORAGE* (find-package "SPOT_CAM::DEGRADATION"))
(defconstant spot_cam::Degradation::*TYPE_STORAGE* 0)
(intern "*TYPE_PTZ*" (find-package "SPOT_CAM::DEGRADATION"))
(shadow '*TYPE_PTZ* (find-package "SPOT_CAM::DEGRADATION"))
(defconstant spot_cam::Degradation::*TYPE_PTZ* 1)
(intern "*TYPE_LED*" (find-package "SPOT_CAM::DEGRADATION"))
(shadow '*TYPE_LED* (find-package "SPOT_CAM::DEGRADATION"))
(defconstant spot_cam::Degradation::*TYPE_LED* 2)

(defun spot_cam::Degradation-to-symbol (const)
  (cond
        ((= const 0) 'spot_cam::Degradation::*TYPE_STORAGE*)
        ((= const 1) 'spot_cam::Degradation::*TYPE_PTZ*)
        ((= const 2) 'spot_cam::Degradation::*TYPE_LED*)
        (t nil)))

(defclass spot_cam::Degradation
  :super ros::object
  :slots (_type _description ))

(defmethod spot_cam::Degradation
  (:init
   (&key
    ((:type __type) 0)
    ((:description __description) "")
    )
   (send-super :init)
   (setq _type (round __type))
   (setq _description (string __description))
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:description
   (&optional __description)
   (if __description (setq _description __description)) _description)
  (:serialization-length
   ()
   (+
    ;; uint8 _type
    1
    ;; string _description
    4 (length _description)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _type
       (write-byte _type s)
     ;; string _description
       (write-long (length _description) s) (princ _description s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _description
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _description (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_cam::Degradation :md5sum-) "2a0265bf7185a5f0daab5380cc4e7983")
(setf (get spot_cam::Degradation :datatype-) "spot_cam/Degradation")
(setf (get spot_cam::Degradation :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation
# Different degradation types
uint8 TYPE_STORAGE=0
uint8 TYPE_PTZ=1
uint8 TYPE_LED=2

# The system affected by the degradation
uint8 type
# What degradation is being experienced
string description
")



(provide :spot_cam/Degradation "2a0265bf7185a5f0daab5380cc4e7983")


