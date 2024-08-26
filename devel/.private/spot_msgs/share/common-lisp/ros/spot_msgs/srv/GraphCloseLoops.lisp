; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude GraphCloseLoops-request.msg.html

(cl:defclass <GraphCloseLoops-request> (roslisp-msg-protocol:ros-message)
  ((close_fiducial_loops
    :reader close_fiducial_loops
    :initarg :close_fiducial_loops
    :type cl:boolean
    :initform cl:nil)
   (close_odometry_loops
    :reader close_odometry_loops
    :initarg :close_odometry_loops
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GraphCloseLoops-request (<GraphCloseLoops-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GraphCloseLoops-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GraphCloseLoops-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<GraphCloseLoops-request> is deprecated: use spot_msgs-srv:GraphCloseLoops-request instead.")))

(cl:ensure-generic-function 'close_fiducial_loops-val :lambda-list '(m))
(cl:defmethod close_fiducial_loops-val ((m <GraphCloseLoops-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:close_fiducial_loops-val is deprecated.  Use spot_msgs-srv:close_fiducial_loops instead.")
  (close_fiducial_loops m))

(cl:ensure-generic-function 'close_odometry_loops-val :lambda-list '(m))
(cl:defmethod close_odometry_loops-val ((m <GraphCloseLoops-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:close_odometry_loops-val is deprecated.  Use spot_msgs-srv:close_odometry_loops instead.")
  (close_odometry_loops m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GraphCloseLoops-request>) ostream)
  "Serializes a message object of type '<GraphCloseLoops-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'close_fiducial_loops) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'close_odometry_loops) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GraphCloseLoops-request>) istream)
  "Deserializes a message object of type '<GraphCloseLoops-request>"
    (cl:setf (cl:slot-value msg 'close_fiducial_loops) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'close_odometry_loops) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GraphCloseLoops-request>)))
  "Returns string type for a service object of type '<GraphCloseLoops-request>"
  "spot_msgs/GraphCloseLoopsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphCloseLoops-request)))
  "Returns string type for a service object of type 'GraphCloseLoops-request"
  "spot_msgs/GraphCloseLoopsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GraphCloseLoops-request>)))
  "Returns md5sum for a message object of type '<GraphCloseLoops-request>"
  "dcd1b935b0d8f62ecaa9864406b50eae")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GraphCloseLoops-request)))
  "Returns md5sum for a message object of type 'GraphCloseLoops-request"
  "dcd1b935b0d8f62ecaa9864406b50eae")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GraphCloseLoops-request>)))
  "Returns full string definition for message of type '<GraphCloseLoops-request>"
  (cl:format cl:nil "bool close_fiducial_loops~%bool close_odometry_loops~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GraphCloseLoops-request)))
  "Returns full string definition for message of type 'GraphCloseLoops-request"
  (cl:format cl:nil "bool close_fiducial_loops~%bool close_odometry_loops~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GraphCloseLoops-request>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GraphCloseLoops-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GraphCloseLoops-request
    (cl:cons ':close_fiducial_loops (close_fiducial_loops msg))
    (cl:cons ':close_odometry_loops (close_odometry_loops msg))
))
;//! \htmlinclude GraphCloseLoops-response.msg.html

(cl:defclass <GraphCloseLoops-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass GraphCloseLoops-response (<GraphCloseLoops-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GraphCloseLoops-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GraphCloseLoops-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<GraphCloseLoops-response> is deprecated: use spot_msgs-srv:GraphCloseLoops-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <GraphCloseLoops-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <GraphCloseLoops-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GraphCloseLoops-response>) ostream)
  "Serializes a message object of type '<GraphCloseLoops-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GraphCloseLoops-response>) istream)
  "Deserializes a message object of type '<GraphCloseLoops-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GraphCloseLoops-response>)))
  "Returns string type for a service object of type '<GraphCloseLoops-response>"
  "spot_msgs/GraphCloseLoopsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphCloseLoops-response)))
  "Returns string type for a service object of type 'GraphCloseLoops-response"
  "spot_msgs/GraphCloseLoopsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GraphCloseLoops-response>)))
  "Returns md5sum for a message object of type '<GraphCloseLoops-response>"
  "dcd1b935b0d8f62ecaa9864406b50eae")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GraphCloseLoops-response)))
  "Returns md5sum for a message object of type 'GraphCloseLoops-response"
  "dcd1b935b0d8f62ecaa9864406b50eae")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GraphCloseLoops-response>)))
  "Returns full string definition for message of type '<GraphCloseLoops-response>"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GraphCloseLoops-response)))
  "Returns full string definition for message of type 'GraphCloseLoops-response"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GraphCloseLoops-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GraphCloseLoops-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GraphCloseLoops-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GraphCloseLoops)))
  'GraphCloseLoops-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GraphCloseLoops)))
  'GraphCloseLoops-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphCloseLoops)))
  "Returns string type for a service object of type '<GraphCloseLoops>"
  "spot_msgs/GraphCloseLoops")