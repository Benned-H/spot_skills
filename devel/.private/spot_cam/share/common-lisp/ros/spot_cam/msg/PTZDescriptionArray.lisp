; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude PTZDescriptionArray.msg.html

(cl:defclass <PTZDescriptionArray> (roslisp-msg-protocol:ros-message)
  ((ptzs
    :reader ptzs
    :initarg :ptzs
    :type (cl:vector spot_cam-msg:PTZDescription)
   :initform (cl:make-array 0 :element-type 'spot_cam-msg:PTZDescription :initial-element (cl:make-instance 'spot_cam-msg:PTZDescription))))
)

(cl:defclass PTZDescriptionArray (<PTZDescriptionArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PTZDescriptionArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PTZDescriptionArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<PTZDescriptionArray> is deprecated: use spot_cam-msg:PTZDescriptionArray instead.")))

(cl:ensure-generic-function 'ptzs-val :lambda-list '(m))
(cl:defmethod ptzs-val ((m <PTZDescriptionArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:ptzs-val is deprecated.  Use spot_cam-msg:ptzs instead.")
  (ptzs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PTZDescriptionArray>) ostream)
  "Serializes a message object of type '<PTZDescriptionArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ptzs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ptzs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PTZDescriptionArray>) istream)
  "Deserializes a message object of type '<PTZDescriptionArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ptzs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ptzs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_cam-msg:PTZDescription))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PTZDescriptionArray>)))
  "Returns string type for a message object of type '<PTZDescriptionArray>"
  "spot_cam/PTZDescriptionArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PTZDescriptionArray)))
  "Returns string type for a message object of type 'PTZDescriptionArray"
  "spot_cam/PTZDescriptionArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PTZDescriptionArray>)))
  "Returns md5sum for a message object of type '<PTZDescriptionArray>"
  "bb84fb6777d2423bbf5218a0dc2508f6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PTZDescriptionArray)))
  "Returns md5sum for a message object of type 'PTZDescriptionArray"
  "bb84fb6777d2423bbf5218a0dc2508f6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PTZDescriptionArray>)))
  "Returns full string definition for message of type '<PTZDescriptionArray>"
  (cl:format cl:nil "spot_cam/PTZDescription[] ptzs~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PTZDescriptionArray)))
  "Returns full string definition for message of type 'PTZDescriptionArray"
  (cl:format cl:nil "spot_cam/PTZDescription[] ptzs~%================================================================================~%MSG: spot_cam/PTZDescription~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Name of this ptz (can be virtual)~%string name~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits pan_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits tilt_limit~%# Limits in degrees on the pan axis~%spot_cam/PTZLimits zoom_limit~%================================================================================~%MSG: spot_cam/PTZLimits~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits~%# If both max and min are zero, this means the limit is unset. The documentation states that if a limit~%# is unset, then all positions are valid.~%# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription~%# Minimum value for the axis~%float32 min~%# Maximum value for the axis~%float32 max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PTZDescriptionArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ptzs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PTZDescriptionArray>))
  "Converts a ROS message object to a list"
  (cl:list 'PTZDescriptionArray
    (cl:cons ':ptzs (ptzs msg))
))
