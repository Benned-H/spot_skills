;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::TerrainState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'TerrainState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::TERRAINSTATE")
  (make-package "SPOT_MSGS::TERRAINSTATE"))

(in-package "ROS")
;;//! \htmlinclude TerrainState.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass spot_msgs::TerrainState
  :super ros::object
  :slots (_ground_mu_est _frame_name _foot_slip_distance_rt_frame _foot_slip_velocity_rt_frame _ground_contact_normal_rt_frame _visual_surface_ground_penetration_mean _visual_surface_ground_penetration_std ))

(defmethod spot_msgs::TerrainState
  (:init
   (&key
    ((:ground_mu_est __ground_mu_est) 0.0)
    ((:frame_name __frame_name) "")
    ((:foot_slip_distance_rt_frame __foot_slip_distance_rt_frame) (instance geometry_msgs::Vector3 :init))
    ((:foot_slip_velocity_rt_frame __foot_slip_velocity_rt_frame) (instance geometry_msgs::Vector3 :init))
    ((:ground_contact_normal_rt_frame __ground_contact_normal_rt_frame) (instance geometry_msgs::Vector3 :init))
    ((:visual_surface_ground_penetration_mean __visual_surface_ground_penetration_mean) 0.0)
    ((:visual_surface_ground_penetration_std __visual_surface_ground_penetration_std) 0.0)
    )
   (send-super :init)
   (setq _ground_mu_est (float __ground_mu_est))
   (setq _frame_name (string __frame_name))
   (setq _foot_slip_distance_rt_frame __foot_slip_distance_rt_frame)
   (setq _foot_slip_velocity_rt_frame __foot_slip_velocity_rt_frame)
   (setq _ground_contact_normal_rt_frame __ground_contact_normal_rt_frame)
   (setq _visual_surface_ground_penetration_mean (float __visual_surface_ground_penetration_mean))
   (setq _visual_surface_ground_penetration_std (float __visual_surface_ground_penetration_std))
   self)
  (:ground_mu_est
   (&optional __ground_mu_est)
   (if __ground_mu_est (setq _ground_mu_est __ground_mu_est)) _ground_mu_est)
  (:frame_name
   (&optional __frame_name)
   (if __frame_name (setq _frame_name __frame_name)) _frame_name)
  (:foot_slip_distance_rt_frame
   (&rest __foot_slip_distance_rt_frame)
   (if (keywordp (car __foot_slip_distance_rt_frame))
       (send* _foot_slip_distance_rt_frame __foot_slip_distance_rt_frame)
     (progn
       (if __foot_slip_distance_rt_frame (setq _foot_slip_distance_rt_frame (car __foot_slip_distance_rt_frame)))
       _foot_slip_distance_rt_frame)))
  (:foot_slip_velocity_rt_frame
   (&rest __foot_slip_velocity_rt_frame)
   (if (keywordp (car __foot_slip_velocity_rt_frame))
       (send* _foot_slip_velocity_rt_frame __foot_slip_velocity_rt_frame)
     (progn
       (if __foot_slip_velocity_rt_frame (setq _foot_slip_velocity_rt_frame (car __foot_slip_velocity_rt_frame)))
       _foot_slip_velocity_rt_frame)))
  (:ground_contact_normal_rt_frame
   (&rest __ground_contact_normal_rt_frame)
   (if (keywordp (car __ground_contact_normal_rt_frame))
       (send* _ground_contact_normal_rt_frame __ground_contact_normal_rt_frame)
     (progn
       (if __ground_contact_normal_rt_frame (setq _ground_contact_normal_rt_frame (car __ground_contact_normal_rt_frame)))
       _ground_contact_normal_rt_frame)))
  (:visual_surface_ground_penetration_mean
   (&optional __visual_surface_ground_penetration_mean)
   (if __visual_surface_ground_penetration_mean (setq _visual_surface_ground_penetration_mean __visual_surface_ground_penetration_mean)) _visual_surface_ground_penetration_mean)
  (:visual_surface_ground_penetration_std
   (&optional __visual_surface_ground_penetration_std)
   (if __visual_surface_ground_penetration_std (setq _visual_surface_ground_penetration_std __visual_surface_ground_penetration_std)) _visual_surface_ground_penetration_std)
  (:serialization-length
   ()
   (+
    ;; float32 _ground_mu_est
    4
    ;; string _frame_name
    4 (length _frame_name)
    ;; geometry_msgs/Vector3 _foot_slip_distance_rt_frame
    (send _foot_slip_distance_rt_frame :serialization-length)
    ;; geometry_msgs/Vector3 _foot_slip_velocity_rt_frame
    (send _foot_slip_velocity_rt_frame :serialization-length)
    ;; geometry_msgs/Vector3 _ground_contact_normal_rt_frame
    (send _ground_contact_normal_rt_frame :serialization-length)
    ;; float32 _visual_surface_ground_penetration_mean
    4
    ;; float32 _visual_surface_ground_penetration_std
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _ground_mu_est
       (sys::poke _ground_mu_est (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _frame_name
       (write-long (length _frame_name) s) (princ _frame_name s)
     ;; geometry_msgs/Vector3 _foot_slip_distance_rt_frame
       (send _foot_slip_distance_rt_frame :serialize s)
     ;; geometry_msgs/Vector3 _foot_slip_velocity_rt_frame
       (send _foot_slip_velocity_rt_frame :serialize s)
     ;; geometry_msgs/Vector3 _ground_contact_normal_rt_frame
       (send _ground_contact_normal_rt_frame :serialize s)
     ;; float32 _visual_surface_ground_penetration_mean
       (sys::poke _visual_surface_ground_penetration_mean (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _visual_surface_ground_penetration_std
       (sys::poke _visual_surface_ground_penetration_std (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _ground_mu_est
     (setq _ground_mu_est (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _frame_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Vector3 _foot_slip_distance_rt_frame
     (send _foot_slip_distance_rt_frame :deserialize buf ptr-) (incf ptr- (send _foot_slip_distance_rt_frame :serialization-length))
   ;; geometry_msgs/Vector3 _foot_slip_velocity_rt_frame
     (send _foot_slip_velocity_rt_frame :deserialize buf ptr-) (incf ptr- (send _foot_slip_velocity_rt_frame :serialization-length))
   ;; geometry_msgs/Vector3 _ground_contact_normal_rt_frame
     (send _ground_contact_normal_rt_frame :deserialize buf ptr-) (incf ptr- (send _ground_contact_normal_rt_frame :serialization-length))
   ;; float32 _visual_surface_ground_penetration_mean
     (setq _visual_surface_ground_penetration_mean (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _visual_surface_ground_penetration_std
     (setq _visual_surface_ground_penetration_std (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get spot_msgs::TerrainState :md5sum-) "8ace1ec594dcaee88134d9f49cb542d9")
(setf (get spot_msgs::TerrainState :datatype-) "spot_msgs/TerrainState")
(setf (get spot_msgs::TerrainState :definition-)
      "# See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=foot_state#footstate-terrainstate

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



(provide :spot_msgs/TerrainState "8ace1ec594dcaee88134d9f49cb542d9")


