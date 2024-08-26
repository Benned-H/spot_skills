; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude TemperatureArray.msg.html

(cl:defclass <TemperatureArray> (roslisp-msg-protocol:ros-message)
  ((temperatures
    :reader temperatures
    :initarg :temperatures
    :type (cl:vector spot_cam-msg:Temperature)
   :initform (cl:make-array 0 :element-type 'spot_cam-msg:Temperature :initial-element (cl:make-instance 'spot_cam-msg:Temperature))))
)

(cl:defclass TemperatureArray (<TemperatureArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TemperatureArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TemperatureArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<TemperatureArray> is deprecated: use spot_cam-msg:TemperatureArray instead.")))

(cl:ensure-generic-function 'temperatures-val :lambda-list '(m))
(cl:defmethod temperatures-val ((m <TemperatureArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:temperatures-val is deprecated.  Use spot_cam-msg:temperatures instead.")
  (temperatures m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TemperatureArray>) ostream)
  "Serializes a message object of type '<TemperatureArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'temperatures))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'temperatures))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TemperatureArray>) istream)
  "Deserializes a message object of type '<TemperatureArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'temperatures) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'temperatures)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_cam-msg:Temperature))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TemperatureArray>)))
  "Returns string type for a message object of type '<TemperatureArray>"
  "spot_cam/TemperatureArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TemperatureArray)))
  "Returns string type for a message object of type 'TemperatureArray"
  "spot_cam/TemperatureArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TemperatureArray>)))
  "Returns md5sum for a message object of type '<TemperatureArray>"
  "73e05ea32a31a886a7c7b59b78f7eb0b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TemperatureArray)))
  "Returns md5sum for a message object of type 'TemperatureArray"
  "73e05ea32a31a886a7c7b59b78f7eb0b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TemperatureArray>)))
  "Returns full string definition for message of type '<TemperatureArray>"
  (cl:format cl:nil "spot_cam/Temperature[] temperatures~%================================================================================~%MSG: spot_cam/Temperature~%string channel_name~%float32 temperature~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TemperatureArray)))
  "Returns full string definition for message of type 'TemperatureArray"
  (cl:format cl:nil "spot_cam/Temperature[] temperatures~%================================================================================~%MSG: spot_cam/Temperature~%string channel_name~%float32 temperature~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TemperatureArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'temperatures) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TemperatureArray>))
  "Converts a ROS message object to a list"
  (cl:list 'TemperatureArray
    (cl:cons ':temperatures (temperatures msg))
))
