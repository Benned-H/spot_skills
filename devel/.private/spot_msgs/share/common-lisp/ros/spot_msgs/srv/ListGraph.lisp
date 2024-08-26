; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude ListGraph-request.msg.html

(cl:defclass <ListGraph-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ListGraph-request (<ListGraph-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListGraph-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListGraph-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ListGraph-request> is deprecated: use spot_msgs-srv:ListGraph-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListGraph-request>) ostream)
  "Serializes a message object of type '<ListGraph-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListGraph-request>) istream)
  "Deserializes a message object of type '<ListGraph-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListGraph-request>)))
  "Returns string type for a service object of type '<ListGraph-request>"
  "spot_msgs/ListGraphRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListGraph-request)))
  "Returns string type for a service object of type 'ListGraph-request"
  "spot_msgs/ListGraphRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListGraph-request>)))
  "Returns md5sum for a message object of type '<ListGraph-request>"
  "118b8bcfd9aa792758857e91da4c7a89")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListGraph-request)))
  "Returns md5sum for a message object of type 'ListGraph-request"
  "118b8bcfd9aa792758857e91da4c7a89")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListGraph-request>)))
  "Returns full string definition for message of type '<ListGraph-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListGraph-request)))
  "Returns full string definition for message of type 'ListGraph-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListGraph-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListGraph-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ListGraph-request
))
;//! \htmlinclude ListGraph-response.msg.html

(cl:defclass <ListGraph-response> (roslisp-msg-protocol:ros-message)
  ((waypoint_ids
    :reader waypoint_ids
    :initarg :waypoint_ids
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass ListGraph-response (<ListGraph-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListGraph-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListGraph-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<ListGraph-response> is deprecated: use spot_msgs-srv:ListGraph-response instead.")))

(cl:ensure-generic-function 'waypoint_ids-val :lambda-list '(m))
(cl:defmethod waypoint_ids-val ((m <ListGraph-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:waypoint_ids-val is deprecated.  Use spot_msgs-srv:waypoint_ids instead.")
  (waypoint_ids m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListGraph-response>) ostream)
  "Serializes a message object of type '<ListGraph-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoint_ids))))
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
   (cl:slot-value msg 'waypoint_ids))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListGraph-response>) istream)
  "Deserializes a message object of type '<ListGraph-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoint_ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoint_ids)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListGraph-response>)))
  "Returns string type for a service object of type '<ListGraph-response>"
  "spot_msgs/ListGraphResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListGraph-response)))
  "Returns string type for a service object of type 'ListGraph-response"
  "spot_msgs/ListGraphResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListGraph-response>)))
  "Returns md5sum for a message object of type '<ListGraph-response>"
  "118b8bcfd9aa792758857e91da4c7a89")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListGraph-response)))
  "Returns md5sum for a message object of type 'ListGraph-response"
  "118b8bcfd9aa792758857e91da4c7a89")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListGraph-response>)))
  "Returns full string definition for message of type '<ListGraph-response>"
  (cl:format cl:nil "string[] waypoint_ids~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListGraph-response)))
  "Returns full string definition for message of type 'ListGraph-response"
  (cl:format cl:nil "string[] waypoint_ids~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListGraph-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoint_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListGraph-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ListGraph-response
    (cl:cons ':waypoint_ids (waypoint_ids msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ListGraph)))
  'ListGraph-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ListGraph)))
  'ListGraph-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListGraph)))
  "Returns string type for a service object of type '<ListGraph>"
  "spot_msgs/ListGraph")