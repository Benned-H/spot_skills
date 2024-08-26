;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ObstacleParams)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ObstacleParams (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::OBSTACLEPARAMS")
  (make-package "SPOT_MSGS::OBSTACLEPARAMS"))

(in-package "ROS")
;;//! \htmlinclude ObstacleParams.msg.html


(defclass spot_msgs::ObstacleParams
  :super ros::object
  :slots (_disable_vision_foot_obstacle_avoidance _disable_vision_foot_constraint_avoidance _disable_vision_body_obstacle_avoidance _obstacle_avoidance_padding _disable_vision_foot_obstacle_body_assist _disable_vision_negative_obstacles ))

(defmethod spot_msgs::ObstacleParams
  (:init
   (&key
    ((:disable_vision_foot_obstacle_avoidance __disable_vision_foot_obstacle_avoidance) nil)
    ((:disable_vision_foot_constraint_avoidance __disable_vision_foot_constraint_avoidance) nil)
    ((:disable_vision_body_obstacle_avoidance __disable_vision_body_obstacle_avoidance) nil)
    ((:obstacle_avoidance_padding __obstacle_avoidance_padding) 0.0)
    ((:disable_vision_foot_obstacle_body_assist __disable_vision_foot_obstacle_body_assist) nil)
    ((:disable_vision_negative_obstacles __disable_vision_negative_obstacles) nil)
    )
   (send-super :init)
   (setq _disable_vision_foot_obstacle_avoidance __disable_vision_foot_obstacle_avoidance)
   (setq _disable_vision_foot_constraint_avoidance __disable_vision_foot_constraint_avoidance)
   (setq _disable_vision_body_obstacle_avoidance __disable_vision_body_obstacle_avoidance)
   (setq _obstacle_avoidance_padding (float __obstacle_avoidance_padding))
   (setq _disable_vision_foot_obstacle_body_assist __disable_vision_foot_obstacle_body_assist)
   (setq _disable_vision_negative_obstacles __disable_vision_negative_obstacles)
   self)
  (:disable_vision_foot_obstacle_avoidance
   (&optional (__disable_vision_foot_obstacle_avoidance :null))
   (if (not (eq __disable_vision_foot_obstacle_avoidance :null)) (setq _disable_vision_foot_obstacle_avoidance __disable_vision_foot_obstacle_avoidance)) _disable_vision_foot_obstacle_avoidance)
  (:disable_vision_foot_constraint_avoidance
   (&optional (__disable_vision_foot_constraint_avoidance :null))
   (if (not (eq __disable_vision_foot_constraint_avoidance :null)) (setq _disable_vision_foot_constraint_avoidance __disable_vision_foot_constraint_avoidance)) _disable_vision_foot_constraint_avoidance)
  (:disable_vision_body_obstacle_avoidance
   (&optional (__disable_vision_body_obstacle_avoidance :null))
   (if (not (eq __disable_vision_body_obstacle_avoidance :null)) (setq _disable_vision_body_obstacle_avoidance __disable_vision_body_obstacle_avoidance)) _disable_vision_body_obstacle_avoidance)
  (:obstacle_avoidance_padding
   (&optional __obstacle_avoidance_padding)
   (if __obstacle_avoidance_padding (setq _obstacle_avoidance_padding __obstacle_avoidance_padding)) _obstacle_avoidance_padding)
  (:disable_vision_foot_obstacle_body_assist
   (&optional (__disable_vision_foot_obstacle_body_assist :null))
   (if (not (eq __disable_vision_foot_obstacle_body_assist :null)) (setq _disable_vision_foot_obstacle_body_assist __disable_vision_foot_obstacle_body_assist)) _disable_vision_foot_obstacle_body_assist)
  (:disable_vision_negative_obstacles
   (&optional (__disable_vision_negative_obstacles :null))
   (if (not (eq __disable_vision_negative_obstacles :null)) (setq _disable_vision_negative_obstacles __disable_vision_negative_obstacles)) _disable_vision_negative_obstacles)
  (:serialization-length
   ()
   (+
    ;; bool _disable_vision_foot_obstacle_avoidance
    1
    ;; bool _disable_vision_foot_constraint_avoidance
    1
    ;; bool _disable_vision_body_obstacle_avoidance
    1
    ;; float32 _obstacle_avoidance_padding
    4
    ;; bool _disable_vision_foot_obstacle_body_assist
    1
    ;; bool _disable_vision_negative_obstacles
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _disable_vision_foot_obstacle_avoidance
       (if _disable_vision_foot_obstacle_avoidance (write-byte -1 s) (write-byte 0 s))
     ;; bool _disable_vision_foot_constraint_avoidance
       (if _disable_vision_foot_constraint_avoidance (write-byte -1 s) (write-byte 0 s))
     ;; bool _disable_vision_body_obstacle_avoidance
       (if _disable_vision_body_obstacle_avoidance (write-byte -1 s) (write-byte 0 s))
     ;; float32 _obstacle_avoidance_padding
       (sys::poke _obstacle_avoidance_padding (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _disable_vision_foot_obstacle_body_assist
       (if _disable_vision_foot_obstacle_body_assist (write-byte -1 s) (write-byte 0 s))
     ;; bool _disable_vision_negative_obstacles
       (if _disable_vision_negative_obstacles (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _disable_vision_foot_obstacle_avoidance
     (setq _disable_vision_foot_obstacle_avoidance (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _disable_vision_foot_constraint_avoidance
     (setq _disable_vision_foot_constraint_avoidance (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _disable_vision_body_obstacle_avoidance
     (setq _disable_vision_body_obstacle_avoidance (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _obstacle_avoidance_padding
     (setq _obstacle_avoidance_padding (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _disable_vision_foot_obstacle_body_assist
     (setq _disable_vision_foot_obstacle_body_assist (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _disable_vision_negative_obstacles
     (setq _disable_vision_negative_obstacles (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_msgs::ObstacleParams :md5sum-) "9b3390759d58138d9a7a53bad6b0edad")
(setf (get spot_msgs::ObstacleParams :datatype-) "spot_msgs/ObstacleParams")
(setf (get spot_msgs::ObstacleParams :definition-)
      "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams
bool disable_vision_foot_obstacle_avoidance
bool disable_vision_foot_constraint_avoidance
bool disable_vision_body_obstacle_avoidance
float32 obstacle_avoidance_padding
bool disable_vision_foot_obstacle_body_assist
bool disable_vision_negative_obstacles
")



(provide :spot_msgs/ObstacleParams "9b3390759d58138d9a7a53bad6b0edad")


