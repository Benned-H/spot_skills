;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::PosedStand)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'PosedStand (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::POSEDSTAND")
  (make-package "SPOT_MSGS::POSEDSTAND"))
(unless (find-package "SPOT_MSGS::POSEDSTANDREQUEST")
  (make-package "SPOT_MSGS::POSEDSTANDREQUEST"))
(unless (find-package "SPOT_MSGS::POSEDSTANDRESPONSE")
  (make-package "SPOT_MSGS::POSEDSTANDRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::PosedStandRequest
  :super ros::object
  :slots (_body_height _body_yaw _body_pitch _body_roll ))

(defmethod spot_msgs::PosedStandRequest
  (:init
   (&key
    ((:body_height __body_height) 0.0)
    ((:body_yaw __body_yaw) 0.0)
    ((:body_pitch __body_pitch) 0.0)
    ((:body_roll __body_roll) 0.0)
    )
   (send-super :init)
   (setq _body_height (float __body_height))
   (setq _body_yaw (float __body_yaw))
   (setq _body_pitch (float __body_pitch))
   (setq _body_roll (float __body_roll))
   self)
  (:body_height
   (&optional __body_height)
   (if __body_height (setq _body_height __body_height)) _body_height)
  (:body_yaw
   (&optional __body_yaw)
   (if __body_yaw (setq _body_yaw __body_yaw)) _body_yaw)
  (:body_pitch
   (&optional __body_pitch)
   (if __body_pitch (setq _body_pitch __body_pitch)) _body_pitch)
  (:body_roll
   (&optional __body_roll)
   (if __body_roll (setq _body_roll __body_roll)) _body_roll)
  (:serialization-length
   ()
   (+
    ;; float32 _body_height
    4
    ;; float32 _body_yaw
    4
    ;; float32 _body_pitch
    4
    ;; float32 _body_roll
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _body_height
       (sys::poke _body_height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _body_yaw
       (sys::poke _body_yaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _body_pitch
       (sys::poke _body_pitch (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _body_roll
       (sys::poke _body_roll (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _body_height
     (setq _body_height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _body_yaw
     (setq _body_yaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _body_pitch
     (setq _body_pitch (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _body_roll
     (setq _body_roll (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_msgs::PosedStandResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::PosedStandResponse
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

(defclass spot_msgs::PosedStand
  :super ros::object
  :slots ())

(setf (get spot_msgs::PosedStand :md5sum-) "832f607027428cf7110c7d6907d1c083")
(setf (get spot_msgs::PosedStand :datatype-) "spot_msgs/PosedStand")
(setf (get spot_msgs::PosedStand :request) spot_msgs::PosedStandRequest)
(setf (get spot_msgs::PosedStand :response) spot_msgs::PosedStandResponse)

(defmethod spot_msgs::PosedStandRequest
  (:response () (instance spot_msgs::PosedStandResponse :init)))

(setf (get spot_msgs::PosedStandRequest :md5sum-) "832f607027428cf7110c7d6907d1c083")
(setf (get spot_msgs::PosedStandRequest :datatype-) "spot_msgs/PosedStandRequest")
(setf (get spot_msgs::PosedStandRequest :definition-)
      "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command.html?highlight=feedback#bosdyn.client.robot_command.RobotCommandBuilder.stand_command

# Offset of the body from the default stand height, in metres
float32 body_height

# RPY of the body relative to the robot's default stand pose
float32 body_yaw
float32 body_pitch
float32 body_roll
---
bool success
string message
")

(setf (get spot_msgs::PosedStandResponse :md5sum-) "832f607027428cf7110c7d6907d1c083")
(setf (get spot_msgs::PosedStandResponse :datatype-) "spot_msgs/PosedStandResponse")
(setf (get spot_msgs::PosedStandResponse :definition-)
      "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command.html?highlight=feedback#bosdyn.client.robot_command.RobotCommandBuilder.stand_command

# Offset of the body from the default stand height, in metres
float32 body_height

# RPY of the body relative to the robot's default stand pose
float32 body_yaw
float32 body_pitch
float32 body_roll
---
bool success
string message
")



(provide :spot_msgs/PosedStand "832f607027428cf7110c7d6907d1c083")


