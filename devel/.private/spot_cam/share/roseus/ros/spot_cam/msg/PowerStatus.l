;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PowerStatus)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PowerStatus (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::POWERSTATUS")
  (make-package "SPOT_CAM::POWERSTATUS"))

(in-package "ROS")
;;//! \htmlinclude PowerStatus.msg.html


(intern "*NO_ACTION*" (find-package "SPOT_CAM::POWERSTATUS"))
(shadow '*NO_ACTION* (find-package "SPOT_CAM::POWERSTATUS"))
(defconstant spot_cam::PowerStatus::*NO_ACTION* 0)
(intern "*POWER_ON*" (find-package "SPOT_CAM::POWERSTATUS"))
(shadow '*POWER_ON* (find-package "SPOT_CAM::POWERSTATUS"))
(defconstant spot_cam::PowerStatus::*POWER_ON* 1)
(intern "*POWER_OFF*" (find-package "SPOT_CAM::POWERSTATUS"))
(shadow '*POWER_OFF* (find-package "SPOT_CAM::POWERSTATUS"))
(defconstant spot_cam::PowerStatus::*POWER_OFF* 2)

(defun spot_cam::PowerStatus-to-symbol (const)
  (cond
        ((= const 0) 'spot_cam::PowerStatus::*NO_ACTION*)
        ((= const 1) 'spot_cam::PowerStatus::*POWER_ON*)
        ((= const 2) 'spot_cam::PowerStatus::*POWER_OFF*)
        (t nil)))

(defclass spot_cam::PowerStatus
  :super ros::object
  :slots (_ptz _aux1 _aux2 _external_mic ))

(defmethod spot_cam::PowerStatus
  (:init
   (&key
    ((:ptz __ptz) 0)
    ((:aux1 __aux1) 0)
    ((:aux2 __aux2) 0)
    ((:external_mic __external_mic) 0)
    )
   (send-super :init)
   (setq _ptz (round __ptz))
   (setq _aux1 (round __aux1))
   (setq _aux2 (round __aux2))
   (setq _external_mic (round __external_mic))
   self)
  (:ptz
   (&optional __ptz)
   (if __ptz (setq _ptz __ptz)) _ptz)
  (:aux1
   (&optional __aux1)
   (if __aux1 (setq _aux1 __aux1)) _aux1)
  (:aux2
   (&optional __aux2)
   (if __aux2 (setq _aux2 __aux2)) _aux2)
  (:external_mic
   (&optional __external_mic)
   (if __external_mic (setq _external_mic __external_mic)) _external_mic)
  (:serialization-length
   ()
   (+
    ;; uint8 _ptz
    1
    ;; uint8 _aux1
    1
    ;; uint8 _aux2
    1
    ;; uint8 _external_mic
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _ptz
       (write-byte _ptz s)
     ;; uint8 _aux1
       (write-byte _aux1 s)
     ;; uint8 _aux2
       (write-byte _aux2 s)
     ;; uint8 _external_mic
       (write-byte _external_mic s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _ptz
     (setq _ptz (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _aux1
     (setq _aux1 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _aux2
     (setq _aux2 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _external_mic
     (setq _external_mic (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_cam::PowerStatus :md5sum-) "cff241b1526dd8ec49e990b4e13bfa92")
(setf (get spot_cam::PowerStatus :datatype-) "spot_cam/PowerStatus")
(setf (get spot_cam::PowerStatus :definition-)
      "# Use when requesting a change to the power state. Indicates that no action should be taken on that device. This is
# necessary because the BD API uses a bool to set the power state, where false is off. It would be impossible to know from
# a bool in a request to change power state whether the user wanted to turn the device off or leave it as it was.
uint8 NO_ACTION=0
# Indicates that the power is on, or requests the power to be turned on
uint8 POWER_ON=1
# Indicates that the power is off, or requests the power to be turned off
uint8 POWER_OFF=2

uint8 ptz
uint8 aux1
uint8 aux2
uint8 external_mic
")



(provide :spot_cam/PowerStatus "cff241b1526dd8ec49e990b4e13bfa92")


