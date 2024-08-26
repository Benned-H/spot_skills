; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude LeaseArray.msg.html

(cl:defclass <LeaseArray> (roslisp-msg-protocol:ros-message)
  ((resources
    :reader resources
    :initarg :resources
    :type (cl:vector spot_msgs-msg:LeaseResource)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:LeaseResource :initial-element (cl:make-instance 'spot_msgs-msg:LeaseResource))))
)

(cl:defclass LeaseArray (<LeaseArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LeaseArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LeaseArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<LeaseArray> is deprecated: use spot_msgs-msg:LeaseArray instead.")))

(cl:ensure-generic-function 'resources-val :lambda-list '(m))
(cl:defmethod resources-val ((m <LeaseArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:resources-val is deprecated.  Use spot_msgs-msg:resources instead.")
  (resources m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LeaseArray>) ostream)
  "Serializes a message object of type '<LeaseArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'resources))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'resources))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LeaseArray>) istream)
  "Deserializes a message object of type '<LeaseArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'resources) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'resources)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:LeaseResource))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LeaseArray>)))
  "Returns string type for a message object of type '<LeaseArray>"
  "spot_msgs/LeaseArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LeaseArray)))
  "Returns string type for a message object of type 'LeaseArray"
  "spot_msgs/LeaseArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LeaseArray>)))
  "Returns md5sum for a message object of type '<LeaseArray>"
  "1e9c3bf77fbef8b5aa6a3bea6c733c8a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LeaseArray)))
  "Returns md5sum for a message object of type 'LeaseArray"
  "1e9c3bf77fbef8b5aa6a3bea6c733c8a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LeaseArray>)))
  "Returns full string definition for message of type '<LeaseArray>"
  (cl:format cl:nil "LeaseResource[] resources~%~%================================================================================~%MSG: spot_msgs/LeaseResource~%string resource~%Lease lease~%LeaseOwner lease_owner~%~%================================================================================~%MSG: spot_msgs/Lease~%string resource~%string epoch~%uint32[] sequence~%~%================================================================================~%MSG: spot_msgs/LeaseOwner~%string client_name~%string user_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LeaseArray)))
  "Returns full string definition for message of type 'LeaseArray"
  (cl:format cl:nil "LeaseResource[] resources~%~%================================================================================~%MSG: spot_msgs/LeaseResource~%string resource~%Lease lease~%LeaseOwner lease_owner~%~%================================================================================~%MSG: spot_msgs/Lease~%string resource~%string epoch~%uint32[] sequence~%~%================================================================================~%MSG: spot_msgs/LeaseOwner~%string client_name~%string user_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LeaseArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'resources) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LeaseArray>))
  "Converts a ROS message object to a list"
  (cl:list 'LeaseArray
    (cl:cons ':resources (resources msg))
))
