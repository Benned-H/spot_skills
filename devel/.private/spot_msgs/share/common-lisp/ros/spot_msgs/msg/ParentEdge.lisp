; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude ParentEdge.msg.html

(cl:defclass <ParentEdge> (roslisp-msg-protocol:ros-message)
  ((parent_frame_name
    :reader parent_frame_name
    :initarg :parent_frame_name
    :type cl:string
    :initform "")
   (parent_tform_child
    :reader parent_tform_child
    :initarg :parent_tform_child
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass ParentEdge (<ParentEdge>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParentEdge>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParentEdge)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<ParentEdge> is deprecated: use spot_msgs-msg:ParentEdge instead.")))

(cl:ensure-generic-function 'parent_frame_name-val :lambda-list '(m))
(cl:defmethod parent_frame_name-val ((m <ParentEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:parent_frame_name-val is deprecated.  Use spot_msgs-msg:parent_frame_name instead.")
  (parent_frame_name m))

(cl:ensure-generic-function 'parent_tform_child-val :lambda-list '(m))
(cl:defmethod parent_tform_child-val ((m <ParentEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:parent_tform_child-val is deprecated.  Use spot_msgs-msg:parent_tform_child instead.")
  (parent_tform_child m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParentEdge>) ostream)
  "Serializes a message object of type '<ParentEdge>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'parent_frame_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'parent_frame_name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'parent_tform_child) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParentEdge>) istream)
  "Deserializes a message object of type '<ParentEdge>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'parent_frame_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'parent_frame_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'parent_tform_child) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParentEdge>)))
  "Returns string type for a message object of type '<ParentEdge>"
  "spot_msgs/ParentEdge")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParentEdge)))
  "Returns string type for a message object of type 'ParentEdge"
  "spot_msgs/ParentEdge")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParentEdge>)))
  "Returns md5sum for a message object of type '<ParentEdge>"
  "14b32cd1337d19fdeb4701a1cb7d7dd2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParentEdge)))
  "Returns md5sum for a message object of type 'ParentEdge"
  "14b32cd1337d19fdeb4701a1cb7d7dd2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParentEdge>)))
  "Returns full string definition for message of type '<ParentEdge>"
  (cl:format cl:nil "string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParentEdge)))
  "Returns full string definition for message of type 'ParentEdge"
  (cl:format cl:nil "string parent_frame_name~%geometry_msgs/Pose parent_tform_child~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParentEdge>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'parent_frame_name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'parent_tform_child))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParentEdge>))
  "Converts a ROS message object to a list"
  (cl:list 'ParentEdge
    (cl:cons ':parent_frame_name (parent_frame_name msg))
    (cl:cons ':parent_tform_child (parent_tform_child msg))
))
