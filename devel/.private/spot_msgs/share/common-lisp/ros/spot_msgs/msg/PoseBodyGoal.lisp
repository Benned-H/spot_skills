; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude PoseBodyGoal.msg.html

(cl:defclass <PoseBodyGoal> (roslisp-msg-protocol:ros-message)
  ((body_pose
    :reader body_pose
    :initarg :body_pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (roll
    :reader roll
    :initarg :roll
    :type cl:fixnum
    :initform 0)
   (pitch
    :reader pitch
    :initarg :pitch
    :type cl:fixnum
    :initform 0)
   (yaw
    :reader yaw
    :initarg :yaw
    :type cl:fixnum
    :initform 0)
   (body_height
    :reader body_height
    :initarg :body_height
    :type cl:float
    :initform 0.0))
)

(cl:defclass PoseBodyGoal (<PoseBodyGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PoseBodyGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PoseBodyGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<PoseBodyGoal> is deprecated: use spot_msgs-msg:PoseBodyGoal instead.")))

(cl:ensure-generic-function 'body_pose-val :lambda-list '(m))
(cl:defmethod body_pose-val ((m <PoseBodyGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:body_pose-val is deprecated.  Use spot_msgs-msg:body_pose instead.")
  (body_pose m))

(cl:ensure-generic-function 'roll-val :lambda-list '(m))
(cl:defmethod roll-val ((m <PoseBodyGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:roll-val is deprecated.  Use spot_msgs-msg:roll instead.")
  (roll m))

(cl:ensure-generic-function 'pitch-val :lambda-list '(m))
(cl:defmethod pitch-val ((m <PoseBodyGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:pitch-val is deprecated.  Use spot_msgs-msg:pitch instead.")
  (pitch m))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <PoseBodyGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:yaw-val is deprecated.  Use spot_msgs-msg:yaw instead.")
  (yaw m))

(cl:ensure-generic-function 'body_height-val :lambda-list '(m))
(cl:defmethod body_height-val ((m <PoseBodyGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:body_height-val is deprecated.  Use spot_msgs-msg:body_height instead.")
  (body_height m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PoseBodyGoal>) ostream)
  "Serializes a message object of type '<PoseBodyGoal>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'body_pose) ostream)
  (cl:let* ((signed (cl:slot-value msg 'roll)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'pitch)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'yaw)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'body_height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PoseBodyGoal>) istream)
  "Deserializes a message object of type '<PoseBodyGoal>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'body_pose) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'roll) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pitch) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'yaw) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'body_height) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PoseBodyGoal>)))
  "Returns string type for a message object of type '<PoseBodyGoal>"
  "spot_msgs/PoseBodyGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PoseBodyGoal)))
  "Returns string type for a message object of type 'PoseBodyGoal"
  "spot_msgs/PoseBodyGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PoseBodyGoal>)))
  "Returns md5sum for a message object of type '<PoseBodyGoal>"
  "2aaa468be31e97608ddb9e68aa66e756")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PoseBodyGoal)))
  "Returns md5sum for a message object of type 'PoseBodyGoal"
  "2aaa468be31e97608ddb9e68aa66e756")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PoseBodyGoal>)))
  "Returns full string definition for message of type '<PoseBodyGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# The pose the body should be moved to. Only the orientation and the z component (body height) of position is considered.~%# If this is unset, the rpy/body height values will be used instead.~%geometry_msgs/Pose body_pose~%~%# Alternative specification of the body pose with rpy (in degrees). These values are ignored if the body_pose is set~%int8 roll~%int8 pitch~%int8 yaw~%float32 body_height~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PoseBodyGoal)))
  "Returns full string definition for message of type 'PoseBodyGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# The pose the body should be moved to. Only the orientation and the z component (body height) of position is considered.~%# If this is unset, the rpy/body height values will be used instead.~%geometry_msgs/Pose body_pose~%~%# Alternative specification of the body pose with rpy (in degrees). These values are ignored if the body_pose is set~%int8 roll~%int8 pitch~%int8 yaw~%float32 body_height~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PoseBodyGoal>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'body_pose))
     1
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PoseBodyGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'PoseBodyGoal
    (cl:cons ':body_pose (body_pose msg))
    (cl:cons ':roll (roll msg))
    (cl:cons ':pitch (pitch msg))
    (cl:cons ':yaw (yaw msg))
    (cl:cons ':body_height (body_height msg))
))
