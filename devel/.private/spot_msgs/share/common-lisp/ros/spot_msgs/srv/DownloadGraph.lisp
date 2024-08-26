; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude DownloadGraph-request.msg.html

(cl:defclass <DownloadGraph-request> (roslisp-msg-protocol:ros-message)
  ((download_filepath
    :reader download_filepath
    :initarg :download_filepath
    :type cl:string
    :initform ""))
)

(cl:defclass DownloadGraph-request (<DownloadGraph-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DownloadGraph-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DownloadGraph-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<DownloadGraph-request> is deprecated: use spot_msgs-srv:DownloadGraph-request instead.")))

(cl:ensure-generic-function 'download_filepath-val :lambda-list '(m))
(cl:defmethod download_filepath-val ((m <DownloadGraph-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:download_filepath-val is deprecated.  Use spot_msgs-srv:download_filepath instead.")
  (download_filepath m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DownloadGraph-request>) ostream)
  "Serializes a message object of type '<DownloadGraph-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'download_filepath))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'download_filepath))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DownloadGraph-request>) istream)
  "Deserializes a message object of type '<DownloadGraph-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'download_filepath) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'download_filepath) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DownloadGraph-request>)))
  "Returns string type for a service object of type '<DownloadGraph-request>"
  "spot_msgs/DownloadGraphRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DownloadGraph-request)))
  "Returns string type for a service object of type 'DownloadGraph-request"
  "spot_msgs/DownloadGraphRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DownloadGraph-request>)))
  "Returns md5sum for a message object of type '<DownloadGraph-request>"
  "a39595a31eb3fe78c31f978ce5465539")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DownloadGraph-request)))
  "Returns md5sum for a message object of type 'DownloadGraph-request"
  "a39595a31eb3fe78c31f978ce5465539")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DownloadGraph-request>)))
  "Returns full string definition for message of type '<DownloadGraph-request>"
  (cl:format cl:nil "string download_filepath~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DownloadGraph-request)))
  "Returns full string definition for message of type 'DownloadGraph-request"
  (cl:format cl:nil "string download_filepath~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DownloadGraph-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'download_filepath))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DownloadGraph-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DownloadGraph-request
    (cl:cons ':download_filepath (download_filepath msg))
))
;//! \htmlinclude DownloadGraph-response.msg.html

(cl:defclass <DownloadGraph-response> (roslisp-msg-protocol:ros-message)
  ((waypoint_ids
    :reader waypoint_ids
    :initarg :waypoint_ids
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass DownloadGraph-response (<DownloadGraph-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DownloadGraph-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DownloadGraph-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<DownloadGraph-response> is deprecated: use spot_msgs-srv:DownloadGraph-response instead.")))

(cl:ensure-generic-function 'waypoint_ids-val :lambda-list '(m))
(cl:defmethod waypoint_ids-val ((m <DownloadGraph-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:waypoint_ids-val is deprecated.  Use spot_msgs-srv:waypoint_ids instead.")
  (waypoint_ids m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DownloadGraph-response>) ostream)
  "Serializes a message object of type '<DownloadGraph-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DownloadGraph-response>) istream)
  "Deserializes a message object of type '<DownloadGraph-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DownloadGraph-response>)))
  "Returns string type for a service object of type '<DownloadGraph-response>"
  "spot_msgs/DownloadGraphResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DownloadGraph-response)))
  "Returns string type for a service object of type 'DownloadGraph-response"
  "spot_msgs/DownloadGraphResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DownloadGraph-response>)))
  "Returns md5sum for a message object of type '<DownloadGraph-response>"
  "a39595a31eb3fe78c31f978ce5465539")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DownloadGraph-response)))
  "Returns md5sum for a message object of type 'DownloadGraph-response"
  "a39595a31eb3fe78c31f978ce5465539")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DownloadGraph-response>)))
  "Returns full string definition for message of type '<DownloadGraph-response>"
  (cl:format cl:nil "string[] waypoint_ids~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DownloadGraph-response)))
  "Returns full string definition for message of type 'DownloadGraph-response"
  (cl:format cl:nil "string[] waypoint_ids~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DownloadGraph-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoint_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DownloadGraph-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DownloadGraph-response
    (cl:cons ':waypoint_ids (waypoint_ids msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DownloadGraph)))
  'DownloadGraph-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DownloadGraph)))
  'DownloadGraph-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DownloadGraph)))
  "Returns string type for a service object of type '<DownloadGraph>"
  "spot_msgs/DownloadGraph")