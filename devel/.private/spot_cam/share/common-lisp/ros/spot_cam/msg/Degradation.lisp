; Auto-generated. Do not edit!


(cl:in-package spot_cam-msg)


;//! \htmlinclude Degradation.msg.html

(cl:defclass <Degradation> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (description
    :reader description
    :initarg :description
    :type cl:string
    :initform ""))
)

(cl:defclass Degradation (<Degradation>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Degradation>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Degradation)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_cam-msg:<Degradation> is deprecated: use spot_cam-msg:Degradation instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Degradation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:type-val is deprecated.  Use spot_cam-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'description-val :lambda-list '(m))
(cl:defmethod description-val ((m <Degradation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_cam-msg:description-val is deprecated.  Use spot_cam-msg:description instead.")
  (description m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Degradation>)))
    "Constants for message type '<Degradation>"
  '((:TYPE_STORAGE . 0)
    (:TYPE_PTZ . 1)
    (:TYPE_LED . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Degradation)))
    "Constants for message type 'Degradation"
  '((:TYPE_STORAGE . 0)
    (:TYPE_PTZ . 1)
    (:TYPE_LED . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Degradation>) ostream)
  "Serializes a message object of type '<Degradation>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'description))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'description))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Degradation>) istream)
  "Deserializes a message object of type '<Degradation>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'description) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'description) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Degradation>)))
  "Returns string type for a message object of type '<Degradation>"
  "spot_cam/Degradation")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Degradation)))
  "Returns string type for a message object of type 'Degradation"
  "spot_cam/Degradation")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Degradation>)))
  "Returns md5sum for a message object of type '<Degradation>"
  "2a0265bf7185a5f0daab5380cc4e7983")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Degradation)))
  "Returns md5sum for a message object of type 'Degradation"
  "2a0265bf7185a5f0daab5380cc4e7983")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Degradation>)))
  "Returns full string definition for message of type '<Degradation>"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation~%# Different degradation types~%uint8 TYPE_STORAGE=0~%uint8 TYPE_PTZ=1~%uint8 TYPE_LED=2~%~%# The system affected by the degradation~%uint8 type~%# What degradation is being experienced~%string description~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Degradation)))
  "Returns full string definition for message of type 'Degradation"
  (cl:format cl:nil "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation~%# Different degradation types~%uint8 TYPE_STORAGE=0~%uint8 TYPE_PTZ=1~%uint8 TYPE_LED=2~%~%# The system affected by the degradation~%uint8 type~%# What degradation is being experienced~%string description~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Degradation>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'description))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Degradation>))
  "Converts a ROS message object to a list"
  (cl:list 'Degradation
    (cl:cons ':type (type msg))
    (cl:cons ':description (description msg))
))
