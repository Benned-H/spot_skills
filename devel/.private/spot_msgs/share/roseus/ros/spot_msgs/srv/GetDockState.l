;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::GetDockState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'GetDockState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::GETDOCKSTATE")
  (make-package "SPOT_MSGS::GETDOCKSTATE"))
(unless (find-package "SPOT_MSGS::GETDOCKSTATEREQUEST")
  (make-package "SPOT_MSGS::GETDOCKSTATEREQUEST"))
(unless (find-package "SPOT_MSGS::GETDOCKSTATERESPONSE")
  (make-package "SPOT_MSGS::GETDOCKSTATERESPONSE"))

(in-package "ROS")





(defclass spot_msgs::GetDockStateRequest
  :super ros::object
  :slots ())

(defmethod spot_msgs::GetDockStateRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass spot_msgs::GetDockStateResponse
  :super ros::object
  :slots (_dock_state ))

(defmethod spot_msgs::GetDockStateResponse
  (:init
   (&key
    ((:dock_state __dock_state) (instance spot_msgs::DockState :init))
    )
   (send-super :init)
   (setq _dock_state __dock_state)
   self)
  (:dock_state
   (&rest __dock_state)
   (if (keywordp (car __dock_state))
       (send* _dock_state __dock_state)
     (progn
       (if __dock_state (setq _dock_state (car __dock_state)))
       _dock_state)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/DockState _dock_state
    (send _dock_state :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/DockState _dock_state
       (send _dock_state :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/DockState _dock_state
     (send _dock_state :deserialize buf ptr-) (incf ptr- (send _dock_state :serialization-length))
   ;;
   self)
  )

(defclass spot_msgs::GetDockState
  :super ros::object
  :slots ())

(setf (get spot_msgs::GetDockState :md5sum-) "01a4a21c7545e2e6d9b2173fc84d1af7")
(setf (get spot_msgs::GetDockState :datatype-) "spot_msgs/GetDockState")
(setf (get spot_msgs::GetDockState :request) spot_msgs::GetDockStateRequest)
(setf (get spot_msgs::GetDockState :response) spot_msgs::GetDockStateResponse)

(defmethod spot_msgs::GetDockStateRequest
  (:response () (instance spot_msgs::GetDockStateResponse :init)))

(setf (get spot_msgs::GetDockStateRequest :md5sum-) "01a4a21c7545e2e6d9b2173fc84d1af7")
(setf (get spot_msgs::GetDockStateRequest :datatype-) "spot_msgs/GetDockStateRequest")
(setf (get spot_msgs::GetDockStateRequest :definition-)
      "---
DockState dock_state

================================================================================
MSG: spot_msgs/DockState
# Status
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
")

(setf (get spot_msgs::GetDockStateResponse :md5sum-) "01a4a21c7545e2e6d9b2173fc84d1af7")
(setf (get spot_msgs::GetDockStateResponse :datatype-) "spot_msgs/GetDockStateResponse")
(setf (get spot_msgs::GetDockStateResponse :definition-)
      "---
DockState dock_state

================================================================================
MSG: spot_msgs/DockState
# Status
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
")



(provide :spot_msgs/GetDockState "01a4a21c7545e2e6d9b2173fc84d1af7")


