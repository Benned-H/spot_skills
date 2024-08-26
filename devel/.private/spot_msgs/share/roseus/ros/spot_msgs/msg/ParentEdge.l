;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ParentEdge)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ParentEdge (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::PARENTEDGE")
  (make-package "SPOT_MSGS::PARENTEDGE"))

(in-package "ROS")
;;//! \htmlinclude ParentEdge.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass spot_msgs::ParentEdge
  :super ros::object
  :slots (_parent_frame_name _parent_tform_child ))

(defmethod spot_msgs::ParentEdge
  (:init
   (&key
    ((:parent_frame_name __parent_frame_name) "")
    ((:parent_tform_child __parent_tform_child) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _parent_frame_name (string __parent_frame_name))
   (setq _parent_tform_child __parent_tform_child)
   self)
  (:parent_frame_name
   (&optional __parent_frame_name)
   (if __parent_frame_name (setq _parent_frame_name __parent_frame_name)) _parent_frame_name)
  (:parent_tform_child
   (&rest __parent_tform_child)
   (if (keywordp (car __parent_tform_child))
       (send* _parent_tform_child __parent_tform_child)
     (progn
       (if __parent_tform_child (setq _parent_tform_child (car __parent_tform_child)))
       _parent_tform_child)))
  (:serialization-length
   ()
   (+
    ;; string _parent_frame_name
    4 (length _parent_frame_name)
    ;; geometry_msgs/Pose _parent_tform_child
    (send _parent_tform_child :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _parent_frame_name
       (write-long (length _parent_frame_name) s) (princ _parent_frame_name s)
     ;; geometry_msgs/Pose _parent_tform_child
       (send _parent_tform_child :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _parent_frame_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _parent_frame_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Pose _parent_tform_child
     (send _parent_tform_child :deserialize buf ptr-) (incf ptr- (send _parent_tform_child :serialization-length))
   ;;
   self)
  )

(setf (get spot_msgs::ParentEdge :md5sum-) "14b32cd1337d19fdeb4701a1cb7d7dd2")
(setf (get spot_msgs::ParentEdge :datatype-) "spot_msgs/ParentEdge")
(setf (get spot_msgs::ParentEdge :definition-)
      "string parent_frame_name
geometry_msgs/Pose parent_tform_child
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

")



(provide :spot_msgs/ParentEdge "14b32cd1337d19fdeb4701a1cb7d7dd2")


