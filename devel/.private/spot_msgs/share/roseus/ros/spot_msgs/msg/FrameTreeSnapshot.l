;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::FrameTreeSnapshot)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'FrameTreeSnapshot (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::FRAMETREESNAPSHOT")
  (make-package "SPOT_MSGS::FRAMETREESNAPSHOT"))

(in-package "ROS")
;;//! \htmlinclude FrameTreeSnapshot.msg.html


(defclass spot_msgs::FrameTreeSnapshot
  :super ros::object
  :slots (_child_edges _parent_edges ))

(defmethod spot_msgs::FrameTreeSnapshot
  (:init
   (&key
    ((:child_edges __child_edges) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:parent_edges __parent_edges) ())
    )
   (send-super :init)
   (setq _child_edges __child_edges)
   (setq _parent_edges __parent_edges)
   self)
  (:child_edges
   (&optional __child_edges)
   (if __child_edges (setq _child_edges __child_edges)) _child_edges)
  (:parent_edges
   (&rest __parent_edges)
   (if (keywordp (car __parent_edges))
       (send* _parent_edges __parent_edges)
     (progn
       (if __parent_edges (setq _parent_edges (car __parent_edges)))
       _parent_edges)))
  (:serialization-length
   ()
   (+
    ;; string[] _child_edges
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _child_edges)) 4
    ;; spot_msgs/ParentEdge[] _parent_edges
    (apply #'+ (send-all _parent_edges :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _child_edges
     (write-long (length _child_edges) s)
     (dolist (elem _child_edges)
       (write-long (length elem) s) (princ elem s)
       )
     ;; spot_msgs/ParentEdge[] _parent_edges
     (write-long (length _parent_edges) s)
     (dolist (elem _parent_edges)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _child_edges
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _child_edges (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _child_edges i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; spot_msgs/ParentEdge[] _parent_edges
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _parent_edges (let (r) (dotimes (i n) (push (instance spot_msgs::ParentEdge :init) r)) r))
     (dolist (elem- _parent_edges)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::FrameTreeSnapshot :md5sum-) "211a7cb63ae362a8f92513c0e74a29a9")
(setf (get spot_msgs::FrameTreeSnapshot :datatype-) "spot_msgs/FrameTreeSnapshot")
(setf (get spot_msgs::FrameTreeSnapshot :definition-)
      "string[] child_edges
ParentEdge[] parent_edges
================================================================================
MSG: spot_msgs/ParentEdge
string parent_frame_name
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



(provide :spot_msgs/FrameTreeSnapshot "211a7cb63ae362a8f92513c0e74a29a9")


