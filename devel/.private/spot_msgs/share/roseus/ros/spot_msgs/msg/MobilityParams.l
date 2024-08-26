;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::MobilityParams)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'MobilityParams (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::MOBILITYPARAMS")
  (make-package "SPOT_MSGS::MOBILITYPARAMS"))

(in-package "ROS")
;;//! \htmlinclude MobilityParams.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass spot_msgs::MobilityParams
  :super ros::object
  :slots (_body_control _locomotion_hint _swing_height _stair_hint _velocity_limit _obstacle_params _terrain_params ))

(defmethod spot_msgs::MobilityParams
  (:init
   (&key
    ((:body_control __body_control) (instance geometry_msgs::Pose :init))
    ((:locomotion_hint __locomotion_hint) 0)
    ((:swing_height __swing_height) 0)
    ((:stair_hint __stair_hint) nil)
    ((:velocity_limit __velocity_limit) (instance geometry_msgs::Twist :init))
    ((:obstacle_params __obstacle_params) (instance spot_msgs::ObstacleParams :init))
    ((:terrain_params __terrain_params) (instance spot_msgs::TerrainParams :init))
    )
   (send-super :init)
   (setq _body_control __body_control)
   (setq _locomotion_hint (round __locomotion_hint))
   (setq _swing_height (round __swing_height))
   (setq _stair_hint __stair_hint)
   (setq _velocity_limit __velocity_limit)
   (setq _obstacle_params __obstacle_params)
   (setq _terrain_params __terrain_params)
   self)
  (:body_control
   (&rest __body_control)
   (if (keywordp (car __body_control))
       (send* _body_control __body_control)
     (progn
       (if __body_control (setq _body_control (car __body_control)))
       _body_control)))
  (:locomotion_hint
   (&optional __locomotion_hint)
   (if __locomotion_hint (setq _locomotion_hint __locomotion_hint)) _locomotion_hint)
  (:swing_height
   (&optional __swing_height)
   (if __swing_height (setq _swing_height __swing_height)) _swing_height)
  (:stair_hint
   (&optional (__stair_hint :null))
   (if (not (eq __stair_hint :null)) (setq _stair_hint __stair_hint)) _stair_hint)
  (:velocity_limit
   (&rest __velocity_limit)
   (if (keywordp (car __velocity_limit))
       (send* _velocity_limit __velocity_limit)
     (progn
       (if __velocity_limit (setq _velocity_limit (car __velocity_limit)))
       _velocity_limit)))
  (:obstacle_params
   (&rest __obstacle_params)
   (if (keywordp (car __obstacle_params))
       (send* _obstacle_params __obstacle_params)
     (progn
       (if __obstacle_params (setq _obstacle_params (car __obstacle_params)))
       _obstacle_params)))
  (:terrain_params
   (&rest __terrain_params)
   (if (keywordp (car __terrain_params))
       (send* _terrain_params __terrain_params)
     (progn
       (if __terrain_params (setq _terrain_params (car __terrain_params)))
       _terrain_params)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose _body_control
    (send _body_control :serialization-length)
    ;; uint32 _locomotion_hint
    4
    ;; uint8 _swing_height
    1
    ;; bool _stair_hint
    1
    ;; geometry_msgs/Twist _velocity_limit
    (send _velocity_limit :serialization-length)
    ;; spot_msgs/ObstacleParams _obstacle_params
    (send _obstacle_params :serialization-length)
    ;; spot_msgs/TerrainParams _terrain_params
    (send _terrain_params :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose _body_control
       (send _body_control :serialize s)
     ;; uint32 _locomotion_hint
       (write-long _locomotion_hint s)
     ;; uint8 _swing_height
       (write-byte _swing_height s)
     ;; bool _stair_hint
       (if _stair_hint (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/Twist _velocity_limit
       (send _velocity_limit :serialize s)
     ;; spot_msgs/ObstacleParams _obstacle_params
       (send _obstacle_params :serialize s)
     ;; spot_msgs/TerrainParams _terrain_params
       (send _terrain_params :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose _body_control
     (send _body_control :deserialize buf ptr-) (incf ptr- (send _body_control :serialization-length))
   ;; uint32 _locomotion_hint
     (setq _locomotion_hint (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _swing_height
     (setq _swing_height (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _stair_hint
     (setq _stair_hint (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; geometry_msgs/Twist _velocity_limit
     (send _velocity_limit :deserialize buf ptr-) (incf ptr- (send _velocity_limit :serialization-length))
   ;; spot_msgs/ObstacleParams _obstacle_params
     (send _obstacle_params :deserialize buf ptr-) (incf ptr- (send _obstacle_params :serialization-length))
   ;; spot_msgs/TerrainParams _terrain_params
     (send _terrain_params :deserialize buf ptr-) (incf ptr- (send _terrain_params :serialization-length))
   ;;
   self)
  )

(setf (get spot_msgs::MobilityParams :md5sum-) "cd45019f5c330befb9646917a064a94d")
(setf (get spot_msgs::MobilityParams :datatype-) "spot_msgs/MobilityParams")
(setf (get spot_msgs::MobilityParams :definition-)
      "geometry_msgs/Pose body_control
uint32 locomotion_hint
uint8 swing_height
bool stair_hint
geometry_msgs/Twist velocity_limit
spot_msgs/ObstacleParams obstacle_params
spot_msgs/TerrainParams terrain_params
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

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
================================================================================
MSG: spot_msgs/ObstacleParams
# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams
bool disable_vision_foot_obstacle_avoidance
bool disable_vision_foot_constraint_avoidance
bool disable_vision_body_obstacle_avoidance
float32 obstacle_avoidance_padding
bool disable_vision_foot_obstacle_body_assist
bool disable_vision_negative_obstacles
================================================================================
MSG: spot_msgs/TerrainParams
# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams
uint8 GRATED_SURFACES_MODE_UNKNOWN=0
uint8 GRATED_SURFACES_MODE_OFF=1
uint8 GRATED_SURFACES_MODE_ON=2
uint8 GRATED_SURFACES_MODE_AUTO=3

float32 ground_mu_hint
uint8 grated_surfaces_mode
")



(provide :spot_msgs/MobilityParams "cd45019f5c330befb9646917a064a94d")


