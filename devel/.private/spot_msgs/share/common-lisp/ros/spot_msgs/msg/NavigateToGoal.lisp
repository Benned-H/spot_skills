; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude NavigateToGoal.msg.html

(cl:defclass <NavigateToGoal> (roslisp-msg-protocol:ros-message)
  ((navigate_to
    :reader navigate_to
    :initarg :navigate_to
    :type cl:string
    :initform ""))
)

(cl:defclass NavigateToGoal (<NavigateToGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavigateToGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavigateToGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<NavigateToGoal> is deprecated: use spot_msgs-msg:NavigateToGoal instead.")))

(cl:ensure-generic-function 'navigate_to-val :lambda-list '(m))
(cl:defmethod navigate_to-val ((m <NavigateToGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:navigate_to-val is deprecated.  Use spot_msgs-msg:navigate_to instead.")
  (navigate_to m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavigateToGoal>) ostream)
  "Serializes a message object of type '<NavigateToGoal>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'navigate_to))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'navigate_to))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavigateToGoal>) istream)
  "Deserializes a message object of type '<NavigateToGoal>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'navigate_to) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'navigate_to) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavigateToGoal>)))
  "Returns string type for a message object of type '<NavigateToGoal>"
  "spot_msgs/NavigateToGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavigateToGoal)))
  "Returns string type for a message object of type 'NavigateToGoal"
  "spot_msgs/NavigateToGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavigateToGoal>)))
  "Returns md5sum for a message object of type '<NavigateToGoal>"
  "21ae8f84643ff7c2f08b8a6d6567f4ff")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavigateToGoal)))
  "Returns md5sum for a message object of type 'NavigateToGoal"
  "21ae8f84643ff7c2f08b8a6d6567f4ff")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavigateToGoal>)))
  "Returns full string definition for message of type '<NavigateToGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%string navigate_to # Waypoint id string for where to go~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavigateToGoal)))
  "Returns full string definition for message of type 'NavigateToGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%string navigate_to # Waypoint id string for where to go~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavigateToGoal>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'navigate_to))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavigateToGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'NavigateToGoal
    (cl:cons ':navigate_to (navigate_to msg))
))
