; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude Lease.msg.html

(cl:defclass <Lease> (roslisp-msg-protocol:ros-message)
  ((resource
    :reader resource
    :initarg :resource
    :type cl:string
    :initform "")
   (epoch
    :reader epoch
    :initarg :epoch
    :type cl:string
    :initform "")
   (sequence
    :reader sequence
    :initarg :sequence
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass Lease (<Lease>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Lease>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Lease)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<Lease> is deprecated: use spot_msgs-msg:Lease instead.")))

(cl:ensure-generic-function 'resource-val :lambda-list '(m))
(cl:defmethod resource-val ((m <Lease>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:resource-val is deprecated.  Use spot_msgs-msg:resource instead.")
  (resource m))

(cl:ensure-generic-function 'epoch-val :lambda-list '(m))
(cl:defmethod epoch-val ((m <Lease>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:epoch-val is deprecated.  Use spot_msgs-msg:epoch instead.")
  (epoch m))

(cl:ensure-generic-function 'sequence-val :lambda-list '(m))
(cl:defmethod sequence-val ((m <Lease>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:sequence-val is deprecated.  Use spot_msgs-msg:sequence instead.")
  (sequence m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Lease>) ostream)
  "Serializes a message object of type '<Lease>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'resource))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'resource))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'epoch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'epoch))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sequence))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'sequence))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Lease>) istream)
  "Deserializes a message object of type '<Lease>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'resource) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'resource) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'epoch) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'epoch) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sequence) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sequence)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Lease>)))
  "Returns string type for a message object of type '<Lease>"
  "spot_msgs/Lease")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Lease)))
  "Returns string type for a message object of type 'Lease"
  "spot_msgs/Lease")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Lease>)))
  "Returns md5sum for a message object of type '<Lease>"
  "268ed4f702e0ce57ac084653ad1ace93")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Lease)))
  "Returns md5sum for a message object of type 'Lease"
  "268ed4f702e0ce57ac084653ad1ace93")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Lease>)))
  "Returns full string definition for message of type '<Lease>"
  (cl:format cl:nil "string resource~%string epoch~%uint32[] sequence~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Lease)))
  "Returns full string definition for message of type 'Lease"
  (cl:format cl:nil "string resource~%string epoch~%uint32[] sequence~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Lease>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'resource))
     4 (cl:length (cl:slot-value msg 'epoch))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sequence) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Lease>))
  "Converts a ROS message object to a list"
  (cl:list 'Lease
    (cl:cons ':resource (resource msg))
    (cl:cons ':epoch (epoch msg))
    (cl:cons ':sequence (sequence msg))
))
