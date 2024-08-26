;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SetObstacleParams)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SetObstacleParams (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SETOBSTACLEPARAMS")
  (make-package "SPOT_MSGS::SETOBSTACLEPARAMS"))
(unless (find-package "SPOT_MSGS::SETOBSTACLEPARAMSREQUEST")
  (make-package "SPOT_MSGS::SETOBSTACLEPARAMSREQUEST"))
(unless (find-package "SPOT_MSGS::SETOBSTACLEPARAMSRESPONSE")
  (make-package "SPOT_MSGS::SETOBSTACLEPARAMSRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::SetObstacleParamsRequest
  :super ros::object
  :slots (_obstacle_params ))

(defmethod spot_msgs::SetObstacleParamsRequest
  (:init
   (&key
    ((:obstacle_params __obstacle_params) (instance spot_msgs::ObstacleParams :init))
    )
   (send-super :init)
   (setq _obstacle_params __obstacle_params)
   self)
  (:obstacle_params
   (&rest __obstacle_params)
   (if (keywordp (car __obstacle_params))
       (send* _obstacle_params __obstacle_params)
     (progn
       (if __obstacle_params (setq _obstacle_params (car __obstacle_params)))
       _obstacle_params)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/ObstacleParams _obstacle_params
    (send _obstacle_params :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/ObstacleParams _obstacle_params
       (send _obstacle_params :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/ObstacleParams _obstacle_params
     (send _obstacle_params :deserialize buf ptr-) (incf ptr- (send _obstacle_params :serialization-length))
   ;;
   self)
  )

(defclass spot_msgs::SetObstacleParamsResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::SetObstacleParamsResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_msgs::SetObstacleParams
  :super ros::object
  :slots ())

(setf (get spot_msgs::SetObstacleParams :md5sum-) "8ca30ec022a12ccabed5c0af340a4796")
(setf (get spot_msgs::SetObstacleParams :datatype-) "spot_msgs/SetObstacleParams")
(setf (get spot_msgs::SetObstacleParams :request) spot_msgs::SetObstacleParamsRequest)
(setf (get spot_msgs::SetObstacleParams :response) spot_msgs::SetObstacleParamsResponse)

(defmethod spot_msgs::SetObstacleParamsRequest
  (:response () (instance spot_msgs::SetObstacleParamsResponse :init)))

(setf (get spot_msgs::SetObstacleParamsRequest :md5sum-) "8ca30ec022a12ccabed5c0af340a4796")
(setf (get spot_msgs::SetObstacleParamsRequest :datatype-) "spot_msgs/SetObstacleParamsRequest")
(setf (get spot_msgs::SetObstacleParamsRequest :definition-)
      "spot_msgs/ObstacleParams obstacle_params

================================================================================
MSG: spot_msgs/ObstacleParams
# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams
bool disable_vision_foot_obstacle_avoidance
bool disable_vision_foot_constraint_avoidance
bool disable_vision_body_obstacle_avoidance
float32 obstacle_avoidance_padding
bool disable_vision_foot_obstacle_body_assist
---
bool success
string message
")

(setf (get spot_msgs::SetObstacleParamsResponse :md5sum-) "8ca30ec022a12ccabed5c0af340a4796")
(setf (get spot_msgs::SetObstacleParamsResponse :datatype-) "spot_msgs/SetObstacleParamsResponse")
(setf (get spot_msgs::SetObstacleParamsResponse :definition-)
      "spot_msgs/ObstacleParams obstacle_params

================================================================================
MSG: spot_msgs/ObstacleParams
# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams
bool disable_vision_foot_obstacle_avoidance
bool disable_vision_foot_constraint_avoidance
bool disable_vision_body_obstacle_avoidance
float32 obstacle_avoidance_padding
bool disable_vision_foot_obstacle_body_assist
---
bool success
string message
")



(provide :spot_msgs/SetObstacleParams "8ca30ec022a12ccabed5c0af340a4796")


