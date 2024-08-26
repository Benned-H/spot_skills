;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SetVelocity)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SetVelocity (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SETVELOCITY")
  (make-package "SPOT_MSGS::SETVELOCITY"))
(unless (find-package "SPOT_MSGS::SETVELOCITYREQUEST")
  (make-package "SPOT_MSGS::SETVELOCITYREQUEST"))
(unless (find-package "SPOT_MSGS::SETVELOCITYRESPONSE")
  (make-package "SPOT_MSGS::SETVELOCITYRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass spot_msgs::SetVelocityRequest
  :super ros::object
  :slots (_velocity_limit ))

(defmethod spot_msgs::SetVelocityRequest
  (:init
   (&key
    ((:velocity_limit __velocity_limit) (instance geometry_msgs::Twist :init))
    )
   (send-super :init)
   (setq _velocity_limit __velocity_limit)
   self)
  (:velocity_limit
   (&rest __velocity_limit)
   (if (keywordp (car __velocity_limit))
       (send* _velocity_limit __velocity_limit)
     (progn
       (if __velocity_limit (setq _velocity_limit (car __velocity_limit)))
       _velocity_limit)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Twist _velocity_limit
    (send _velocity_limit :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Twist _velocity_limit
       (send _velocity_limit :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Twist _velocity_limit
     (send _velocity_limit :deserialize buf ptr-) (incf ptr- (send _velocity_limit :serialization-length))
   ;;
   self)
  )

(defclass spot_msgs::SetVelocityResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::SetVelocityResponse
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

(defclass spot_msgs::SetVelocity
  :super ros::object
  :slots ())

(setf (get spot_msgs::SetVelocity :md5sum-) "b42f41ffa01f8de6dcbf642f589646a1")
(setf (get spot_msgs::SetVelocity :datatype-) "spot_msgs/SetVelocity")
(setf (get spot_msgs::SetVelocity :request) spot_msgs::SetVelocityRequest)
(setf (get spot_msgs::SetVelocity :response) spot_msgs::SetVelocityResponse)

(defmethod spot_msgs::SetVelocityRequest
  (:response () (instance spot_msgs::SetVelocityResponse :init)))

(setf (get spot_msgs::SetVelocityRequest :md5sum-) "b42f41ffa01f8de6dcbf642f589646a1")
(setf (get spot_msgs::SetVelocityRequest :datatype-) "spot_msgs/SetVelocityRequest")
(setf (get spot_msgs::SetVelocityRequest :definition-)
      "# The api only takes into account x and y for linear velocity, and z for angular.
# Other values are ignored.
geometry_msgs/Twist velocity_limit

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
---
bool success
string message
")

(setf (get spot_msgs::SetVelocityResponse :md5sum-) "b42f41ffa01f8de6dcbf642f589646a1")
(setf (get spot_msgs::SetVelocityResponse :datatype-) "spot_msgs/SetVelocityResponse")
(setf (get spot_msgs::SetVelocityResponse :definition-)
      "# The api only takes into account x and y for linear velocity, and z for angular.
# Other values are ignored.
geometry_msgs/Twist velocity_limit

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
---
bool success
string message
")



(provide :spot_msgs/SetVelocity "b42f41ffa01f8de6dcbf642f589646a1")


