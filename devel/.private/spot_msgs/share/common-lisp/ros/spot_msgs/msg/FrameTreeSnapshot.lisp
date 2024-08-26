; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude FrameTreeSnapshot.msg.html

(cl:defclass <FrameTreeSnapshot> (roslisp-msg-protocol:ros-message)
  ((child_edges
    :reader child_edges
    :initarg :child_edges
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (parent_edges
    :reader parent_edges
    :initarg :parent_edges
    :type (cl:vector spot_msgs-msg:ParentEdge)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:ParentEdge :initial-element (cl:make-instance 'spot_msgs-msg:ParentEdge))))
)

(cl:defclass FrameTreeSnapshot (<FrameTreeSnapshot>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FrameTreeSnapshot>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FrameTreeSnapshot)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<FrameTreeSnapshot> is deprecated: use spot_msgs-msg:FrameTreeSnapshot instead.")))

(cl:ensure-generic-function 'child_edges-val :lambda-list '(m))
(cl:defmethod child_edges-val ((m <FrameTreeSnapshot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:child_edges-val is deprecated.  Use spot_msgs-msg:child_edges instead.")
  (child_edges m))

(cl:ensure-generic-function 'parent_edges-val :lambda-list '(m))
(cl:defmethod parent_edges-val ((m <FrameTreeSnapshot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:parent_edges-val is deprecated.  Use spot_msgs-msg:parent_edges instead.")
  (parent_edges m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FrameTreeSnapshot>) ostream)
  "Serializes a message object of type '<FrameTreeSnapshot>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'child_edges))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'child_edges))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'parent_edges))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'parent_edges))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FrameTreeSnapshot>) istream)
  "Deserializes a message object of type '<FrameTreeSnapshot>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'child_edges) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'child_edges)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'parent_edges) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'parent_edges)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:ParentEdge))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FrameTreeSnapshot>)))
  "Returns string type for a message object of type '<FrameTreeSnapshot>"
  "spot_msgs/FrameTreeSnapshot")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FrameTreeSnapshot)))
  "Returns string type for a message object of type 'FrameTreeSnapshot"
  "spot_msgs/FrameTreeSnapshot")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FrameTreeSnapshot>)))
  "Returns md5sum for a message object of type '<FrameTreeSnapshot>"
  "211a7cb63ae362a8f92513c0e74a29a9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FrameTreeSnapshot)))
  "Returns md5sum for a message object of type 'FrameTreeSnapshot"
  "211a7cb63ae362a8f92513c0e74a29a9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FrameTreeSnapshot>)))
  "Returns full string definition for message of type '<FrameTreeSnapshot>"
  (cl:format cl:nil "string[] child_edges~%ParentEdge[] parent_edges~%================================================================================~%MSG: spot_msgs/ParentEdge~%string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FrameTreeSnapshot)))
  "Returns full string definition for message of type 'FrameTreeSnapshot"
  (cl:format cl:nil "string[] child_edges~%ParentEdge[] parent_edges~%================================================================================~%MSG: spot_msgs/ParentEdge~%string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FrameTreeSnapshot>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'child_edges) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parent_edges) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FrameTreeSnapshot>))
  "Converts a ROS message object to a list"
  (cl:list 'FrameTreeSnapshot
    (cl:cons ':child_edges (child_edges msg))
    (cl:cons ':parent_edges (parent_edges msg))
))
