; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude NavigateInit-request.msg.html

(cl:defclass <NavigateInit-request> (roslisp-msg-protocol:ros-message)
  ((upload_path
    :reader upload_path
    :initarg :upload_path
    :type cl:string
    :initform "")
   (initial_localization_fiducial
    :reader initial_localization_fiducial
    :initarg :initial_localization_fiducial
    :type cl:boolean
    :initform cl:nil)
   (initial_localization_waypoint
    :reader initial_localization_waypoint
    :initarg :initial_localization_waypoint
    :type cl:string
    :initform ""))
)

(cl:defclass NavigateInit-request (<NavigateInit-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavigateInit-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavigateInit-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<NavigateInit-request> is deprecated: use spot_msgs-srv:NavigateInit-request instead.")))

(cl:ensure-generic-function 'upload_path-val :lambda-list '(m))
(cl:defmethod upload_path-val ((m <NavigateInit-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:upload_path-val is deprecated.  Use spot_msgs-srv:upload_path instead.")
  (upload_path m))

(cl:ensure-generic-function 'initial_localization_fiducial-val :lambda-list '(m))
(cl:defmethod initial_localization_fiducial-val ((m <NavigateInit-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:initial_localization_fiducial-val is deprecated.  Use spot_msgs-srv:initial_localization_fiducial instead.")
  (initial_localization_fiducial m))

(cl:ensure-generic-function 'initial_localization_waypoint-val :lambda-list '(m))
(cl:defmethod initial_localization_waypoint-val ((m <NavigateInit-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:initial_localization_waypoint-val is deprecated.  Use spot_msgs-srv:initial_localization_waypoint instead.")
  (initial_localization_waypoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavigateInit-request>) ostream)
  "Serializes a message object of type '<NavigateInit-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'upload_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'upload_path))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'initial_localization_fiducial) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'initial_localization_waypoint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'initial_localization_waypoint))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavigateInit-request>) istream)
  "Deserializes a message object of type '<NavigateInit-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'upload_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'upload_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'initial_localization_fiducial) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'initial_localization_waypoint) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'initial_localization_waypoint) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavigateInit-request>)))
  "Returns string type for a service object of type '<NavigateInit-request>"
  "spot_msgs/NavigateInitRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavigateInit-request)))
  "Returns string type for a service object of type 'NavigateInit-request"
  "spot_msgs/NavigateInitRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavigateInit-request>)))
  "Returns md5sum for a message object of type '<NavigateInit-request>"
  "c444c9070e6d223b1750275fad5b1484")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavigateInit-request)))
  "Returns md5sum for a message object of type 'NavigateInit-request"
  "c444c9070e6d223b1750275fad5b1484")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavigateInit-request>)))
  "Returns full string definition for message of type '<NavigateInit-request>"
  (cl:format cl:nil "string upload_path # Absolute path to map_directory, which is downloaded from tablet controller~%bool initial_localization_fiducial   # Tells the initializer whether to use fiducials~%string initial_localization_waypoint # Waypoint id to trigger localization ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavigateInit-request)))
  "Returns full string definition for message of type 'NavigateInit-request"
  (cl:format cl:nil "string upload_path # Absolute path to map_directory, which is downloaded from tablet controller~%bool initial_localization_fiducial   # Tells the initializer whether to use fiducials~%string initial_localization_waypoint # Waypoint id to trigger localization ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavigateInit-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'upload_path))
     1
     4 (cl:length (cl:slot-value msg 'initial_localization_waypoint))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavigateInit-request>))
  "Converts a ROS message object to a list"
  (cl:list 'NavigateInit-request
    (cl:cons ':upload_path (upload_path msg))
    (cl:cons ':initial_localization_fiducial (initial_localization_fiducial msg))
    (cl:cons ':initial_localization_waypoint (initial_localization_waypoint msg))
))
;//! \htmlinclude NavigateInit-response.msg.html

(cl:defclass <NavigateInit-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass NavigateInit-response (<NavigateInit-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavigateInit-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavigateInit-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<NavigateInit-response> is deprecated: use spot_msgs-srv:NavigateInit-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <NavigateInit-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <NavigateInit-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavigateInit-response>) ostream)
  "Serializes a message object of type '<NavigateInit-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavigateInit-response>) istream)
  "Deserializes a message object of type '<NavigateInit-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavigateInit-response>)))
  "Returns string type for a service object of type '<NavigateInit-response>"
  "spot_msgs/NavigateInitResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavigateInit-response)))
  "Returns string type for a service object of type 'NavigateInit-response"
  "spot_msgs/NavigateInitResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavigateInit-response>)))
  "Returns md5sum for a message object of type '<NavigateInit-response>"
  "c444c9070e6d223b1750275fad5b1484")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavigateInit-response)))
  "Returns md5sum for a message object of type 'NavigateInit-response"
  "c444c9070e6d223b1750275fad5b1484")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavigateInit-response>)))
  "Returns full string definition for message of type '<NavigateInit-response>"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavigateInit-response)))
  "Returns full string definition for message of type 'NavigateInit-response"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavigateInit-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavigateInit-response>))
  "Converts a ROS message object to a list"
  (cl:list 'NavigateInit-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'NavigateInit)))
  'NavigateInit-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'NavigateInit)))
  'NavigateInit-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavigateInit)))
  "Returns string type for a service object of type '<NavigateInit>"
  "spot_msgs/NavigateInit")