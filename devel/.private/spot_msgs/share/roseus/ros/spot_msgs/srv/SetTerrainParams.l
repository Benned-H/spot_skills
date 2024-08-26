;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SetTerrainParams)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SetTerrainParams (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SETTERRAINPARAMS")
  (make-package "SPOT_MSGS::SETTERRAINPARAMS"))
(unless (find-package "SPOT_MSGS::SETTERRAINPARAMSREQUEST")
  (make-package "SPOT_MSGS::SETTERRAINPARAMSREQUEST"))
(unless (find-package "SPOT_MSGS::SETTERRAINPARAMSRESPONSE")
  (make-package "SPOT_MSGS::SETTERRAINPARAMSRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::SetTerrainParamsRequest
  :super ros::object
  :slots (_terrain_params ))

(defmethod spot_msgs::SetTerrainParamsRequest
  (:init
   (&key
    ((:terrain_params __terrain_params) (instance spot_msgs::TerrainParams :init))
    )
   (send-super :init)
   (setq _terrain_params __terrain_params)
   self)
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
    ;; spot_msgs/TerrainParams _terrain_params
    (send _terrain_params :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/TerrainParams _terrain_params
       (send _terrain_params :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/TerrainParams _terrain_params
     (send _terrain_params :deserialize buf ptr-) (incf ptr- (send _terrain_params :serialization-length))
   ;;
   self)
  )

(defclass spot_msgs::SetTerrainParamsResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::SetTerrainParamsResponse
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

(defclass spot_msgs::SetTerrainParams
  :super ros::object
  :slots ())

(setf (get spot_msgs::SetTerrainParams :md5sum-) "7ab3f769faaa7a5562cf1f71a78cd453")
(setf (get spot_msgs::SetTerrainParams :datatype-) "spot_msgs/SetTerrainParams")
(setf (get spot_msgs::SetTerrainParams :request) spot_msgs::SetTerrainParamsRequest)
(setf (get spot_msgs::SetTerrainParams :response) spot_msgs::SetTerrainParamsResponse)

(defmethod spot_msgs::SetTerrainParamsRequest
  (:response () (instance spot_msgs::SetTerrainParamsResponse :init)))

(setf (get spot_msgs::SetTerrainParamsRequest :md5sum-) "7ab3f769faaa7a5562cf1f71a78cd453")
(setf (get spot_msgs::SetTerrainParamsRequest :datatype-) "spot_msgs/SetTerrainParamsRequest")
(setf (get spot_msgs::SetTerrainParamsRequest :definition-)
      "spot_msgs/TerrainParams terrain_params

================================================================================
MSG: spot_msgs/TerrainParams
# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams
uint8 GRATED_SURFACES_MODE_UNKNOWN=0
uint8 GRATED_SURFACES_MODE_OFF=1
uint8 GRATED_SURFACES_MODE_ON=2
uint8 GRATED_SURFACES_MODE_AUTO=3

float32 ground_mu_hint
---
bool success
string message
")

(setf (get spot_msgs::SetTerrainParamsResponse :md5sum-) "7ab3f769faaa7a5562cf1f71a78cd453")
(setf (get spot_msgs::SetTerrainParamsResponse :datatype-) "spot_msgs/SetTerrainParamsResponse")
(setf (get spot_msgs::SetTerrainParamsResponse :definition-)
      "spot_msgs/TerrainParams terrain_params

================================================================================
MSG: spot_msgs/TerrainParams
# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams
uint8 GRATED_SURFACES_MODE_UNKNOWN=0
uint8 GRATED_SURFACES_MODE_OFF=1
uint8 GRATED_SURFACES_MODE_ON=2
uint8 GRATED_SURFACES_MODE_AUTO=3

float32 ground_mu_hint
---
bool success
string message
")



(provide :spot_msgs/SetTerrainParams "7ab3f769faaa7a5562cf1f71a78cd453")


