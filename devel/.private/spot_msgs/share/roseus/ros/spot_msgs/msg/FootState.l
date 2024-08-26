;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::FootState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'FootState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::FOOTSTATE")
  (make-package "SPOT_MSGS::FOOTSTATE"))

(in-package "ROS")
;;//! \htmlinclude FootState.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*CONTACT_UNKNOWN*" (find-package "SPOT_MSGS::FOOTSTATE"))
(shadow '*CONTACT_UNKNOWN* (find-package "SPOT_MSGS::FOOTSTATE"))
(defconstant spot_msgs::FootState::*CONTACT_UNKNOWN* 0)
(intern "*CONTACT_MADE*" (find-package "SPOT_MSGS::FOOTSTATE"))
(shadow '*CONTACT_MADE* (find-package "SPOT_MSGS::FOOTSTATE"))
(defconstant spot_msgs::FootState::*CONTACT_MADE* 1)
(intern "*CONTACT_LOST*" (find-package "SPOT_MSGS::FOOTSTATE"))
(shadow '*CONTACT_LOST* (find-package "SPOT_MSGS::FOOTSTATE"))
(defconstant spot_msgs::FootState::*CONTACT_LOST* 2)

(defun spot_msgs::FootState-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::FootState::*CONTACT_UNKNOWN*)
        ((= const 1) 'spot_msgs::FootState::*CONTACT_MADE*)
        ((= const 2) 'spot_msgs::FootState::*CONTACT_LOST*)
        (t nil)))

(defclass spot_msgs::FootState
  :super ros::object
  :slots (_foot_position_rt_body _contact _terrain ))

(defmethod spot_msgs::FootState
  (:init
   (&key
    ((:foot_position_rt_body __foot_position_rt_body) (instance geometry_msgs::Point :init))
    ((:contact __contact) 0)
    ((:terrain __terrain) (instance spot_msgs::TerrainState :init))
    )
   (send-super :init)
   (setq _foot_position_rt_body __foot_position_rt_body)
   (setq _contact (round __contact))
   (setq _terrain __terrain)
   self)
  (:foot_position_rt_body
   (&rest __foot_position_rt_body)
   (if (keywordp (car __foot_position_rt_body))
       (send* _foot_position_rt_body __foot_position_rt_body)
     (progn
       (if __foot_position_rt_body (setq _foot_position_rt_body (car __foot_position_rt_body)))
       _foot_position_rt_body)))
  (:contact
   (&optional __contact)
   (if __contact (setq _contact __contact)) _contact)
  (:terrain
   (&rest __terrain)
   (if (keywordp (car __terrain))
       (send* _terrain __terrain)
     (progn
       (if __terrain (setq _terrain (car __terrain)))
       _terrain)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point _foot_position_rt_body
    (send _foot_position_rt_body :serialization-length)
    ;; uint8 _contact
    1
    ;; spot_msgs/TerrainState _terrain
    (send _terrain :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point _foot_position_rt_body
       (send _foot_position_rt_body :serialize s)
     ;; uint8 _contact
       (write-byte _contact s)
     ;; spot_msgs/TerrainState _terrain
       (send _terrain :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point _foot_position_rt_body
     (send _foot_position_rt_body :deserialize buf ptr-) (incf ptr- (send _foot_position_rt_body :serialization-length))
   ;; uint8 _contact
     (setq _contact (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; spot_msgs/TerrainState _terrain
     (send _terrain :deserialize buf ptr-) (incf ptr- (send _terrain :serialization-length))
   ;;
   self)
  )

(setf (get spot_msgs::FootState :md5sum-) "b315748465703ff0724bcad0b58e8e71")
(setf (get spot_msgs::FootState :datatype-) "spot_msgs/FootState")
(setf (get spot_msgs::FootState :definition-)
      "# Contact
uint8 CONTACT_UNKNOWN = 0
uint8 CONTACT_MADE = 1
uint8 CONTACT_LOST = 2

geometry_msgs/Point foot_position_rt_body
uint8 contact
spot_msgs/TerrainState terrain

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: spot_msgs/TerrainState
# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=foot_state#footstate-terrainstate

float32 ground_mu_est
string frame_name
geometry_msgs/Vector3 foot_slip_distance_rt_frame
geometry_msgs/Vector3 foot_slip_velocity_rt_frame
geometry_msgs/Vector3 ground_contact_normal_rt_frame
float32 visual_surface_ground_penetration_mean
float32 visual_surface_ground_penetration_std
================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :spot_msgs/FootState "b315748465703ff0724bcad0b58e8e71")


