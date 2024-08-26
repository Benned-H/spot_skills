;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::DockState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'DockState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::DOCKSTATE")
  (make-package "SPOT_MSGS::DOCKSTATE"))

(in-package "ROS")
;;//! \htmlinclude DockState.msg.html


(intern "*DOCK_STATUS_UNKNOWN*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_STATUS_UNKNOWN* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_STATUS_UNKNOWN* 0)
(intern "*DOCK_STATUS_DOCKED*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_STATUS_DOCKED* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_STATUS_DOCKED* 1)
(intern "*DOCK_STATUS_DOCKING*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_STATUS_DOCKING* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_STATUS_DOCKING* 2)
(intern "*DOCK_STATUS_UNDOCKED*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_STATUS_UNDOCKED* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_STATUS_UNDOCKED* 3)
(intern "*DOCK_STATUS_UNDOCKING*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_STATUS_UNDOCKING* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_STATUS_UNDOCKING* 4)
(intern "*DOCK_TYPE_UNKNOWN*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_TYPE_UNKNOWN* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_TYPE_UNKNOWN* 0)
(intern "*DOCK_TYPE_CONTACT_PROTOTYPE*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_TYPE_CONTACT_PROTOTYPE* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_TYPE_CONTACT_PROTOTYPE* 2)
(intern "*DOCK_TYPE_SPOT_DOCK*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*DOCK_TYPE_SPOT_DOCK* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*DOCK_TYPE_SPOT_DOCK* 3)
(intern "*LINK_STATUS_UNKNOWN*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*LINK_STATUS_UNKNOWN* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*LINK_STATUS_UNKNOWN* 0)
(intern "*LINK_STATUS_CONNECTED*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*LINK_STATUS_CONNECTED* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*LINK_STATUS_CONNECTED* 1)
(intern "*LINK_STATUS_ERROR*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*LINK_STATUS_ERROR* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*LINK_STATUS_ERROR* 2)
(intern "*LINK_STATUS_DETECTING*" (find-package "SPOT_MSGS::DOCKSTATE"))
(shadow '*LINK_STATUS_DETECTING* (find-package "SPOT_MSGS::DOCKSTATE"))
(defconstant spot_msgs::DockState::*LINK_STATUS_DETECTING* 3)

(defun spot_msgs::DockState-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::DockState::*DOCK_STATUS_UNKNOWN*)
        ((= const 1) 'spot_msgs::DockState::*DOCK_STATUS_DOCKED*)
        ((= const 2) 'spot_msgs::DockState::*DOCK_STATUS_DOCKING*)
        ((= const 3) 'spot_msgs::DockState::*DOCK_STATUS_UNDOCKED*)
        ((= const 4) 'spot_msgs::DockState::*DOCK_STATUS_UNDOCKING*)
        ((= const 0) 'spot_msgs::DockState::*DOCK_TYPE_UNKNOWN*)
        ((= const 2) 'spot_msgs::DockState::*DOCK_TYPE_CONTACT_PROTOTYPE*)
        ((= const 3) 'spot_msgs::DockState::*DOCK_TYPE_SPOT_DOCK*)
        ((= const 0) 'spot_msgs::DockState::*LINK_STATUS_UNKNOWN*)
        ((= const 1) 'spot_msgs::DockState::*LINK_STATUS_CONNECTED*)
        ((= const 2) 'spot_msgs::DockState::*LINK_STATUS_ERROR*)
        ((= const 3) 'spot_msgs::DockState::*LINK_STATUS_DETECTING*)
        (t nil)))

(defclass spot_msgs::DockState
  :super ros::object
  :slots (_status _dock_type _dock_id _power_status ))

(defmethod spot_msgs::DockState
  (:init
   (&key
    ((:status __status) 0)
    ((:dock_type __dock_type) 0)
    ((:dock_id __dock_id) 0)
    ((:power_status __power_status) 0)
    )
   (send-super :init)
   (setq _status (round __status))
   (setq _dock_type (round __dock_type))
   (setq _dock_id (round __dock_id))
   (setq _power_status (round __power_status))
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:dock_type
   (&optional __dock_type)
   (if __dock_type (setq _dock_type __dock_type)) _dock_type)
  (:dock_id
   (&optional __dock_id)
   (if __dock_id (setq _dock_id __dock_id)) _dock_id)
  (:power_status
   (&optional __power_status)
   (if __power_status (setq _power_status __power_status)) _power_status)
  (:serialization-length
   ()
   (+
    ;; uint8 _status
    1
    ;; uint8 _dock_type
    1
    ;; uint32 _dock_id
    4
    ;; uint8 _power_status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _status
       (write-byte _status s)
     ;; uint8 _dock_type
       (write-byte _dock_type s)
     ;; uint32 _dock_id
       (write-long _dock_id s)
     ;; uint8 _power_status
       (write-byte _power_status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _dock_type
     (setq _dock_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint32 _dock_id
     (setq _dock_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _power_status
     (setq _power_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_msgs::DockState :md5sum-) "a5cf6a3afaa5e6b3ccda4170a976059d")
(setf (get spot_msgs::DockState :datatype-) "spot_msgs/DockState")
(setf (get spot_msgs::DockState :definition-)
      "# Status
uint8 DOCK_STATUS_UNKNOWN = 0
uint8 DOCK_STATUS_DOCKED = 1
uint8 DOCK_STATUS_DOCKING = 2
uint8 DOCK_STATUS_UNDOCKED = 3
uint8 DOCK_STATUS_UNDOCKING = 4

# DockType
uint8 DOCK_TYPE_UNKNOWN = 0
uint8 DOCK_TYPE_CONTACT_PROTOTYPE = 2
uint8 DOCK_TYPE_SPOT_DOCK = 3

# LinkStatus
uint8 LINK_STATUS_UNKNOWN = 0
uint8 LINK_STATUS_CONNECTED = 1
uint8 LINK_STATUS_ERROR = 2
uint8 LINK_STATUS_DETECTING = 3

uint8 status
uint8 dock_type
uint32 dock_id
uint8 power_status
")



(provide :spot_msgs/DockState "a5cf6a3afaa5e6b3ccda4170a976059d")


