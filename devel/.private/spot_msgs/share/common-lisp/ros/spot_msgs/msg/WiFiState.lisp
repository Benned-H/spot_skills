; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude WiFiState.msg.html

(cl:defclass <WiFiState> (roslisp-msg-protocol:ros-message)
  ((current_mode
    :reader current_mode
    :initarg :current_mode
    :type cl:fixnum
    :initform 0)
   (essid
    :reader essid
    :initarg :essid
    :type cl:string
    :initform ""))
)

(cl:defclass WiFiState (<WiFiState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WiFiState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WiFiState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<WiFiState> is deprecated: use spot_msgs-msg:WiFiState instead.")))

(cl:ensure-generic-function 'current_mode-val :lambda-list '(m))
(cl:defmethod current_mode-val ((m <WiFiState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:current_mode-val is deprecated.  Use spot_msgs-msg:current_mode instead.")
  (current_mode m))

(cl:ensure-generic-function 'essid-val :lambda-list '(m))
(cl:defmethod essid-val ((m <WiFiState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:essid-val is deprecated.  Use spot_msgs-msg:essid instead.")
  (essid m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WiFiState>)))
    "Constants for message type '<WiFiState>"
  '((:MODE_UNKNOWN . 0)
    (:MODE_ACCESS_POINT . 1)
    (:MODE_CLIENT . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WiFiState)))
    "Constants for message type 'WiFiState"
  '((:MODE_UNKNOWN . 0)
    (:MODE_ACCESS_POINT . 1)
    (:MODE_CLIENT . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WiFiState>) ostream)
  "Serializes a message object of type '<WiFiState>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'current_mode)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'essid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'essid))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WiFiState>) istream)
  "Deserializes a message object of type '<WiFiState>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'current_mode)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'essid) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'essid) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WiFiState>)))
  "Returns string type for a message object of type '<WiFiState>"
  "spot_msgs/WiFiState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WiFiState)))
  "Returns string type for a message object of type 'WiFiState"
  "spot_msgs/WiFiState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WiFiState>)))
  "Returns md5sum for a message object of type '<WiFiState>"
  "ba66be2de3368e3a5a22e1ccf928954a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WiFiState)))
  "Returns md5sum for a message object of type 'WiFiState"
  "ba66be2de3368e3a5a22e1ccf928954a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WiFiState>)))
  "Returns full string definition for message of type '<WiFiState>"
  (cl:format cl:nil "# Mode~%uint8 MODE_UNKNOWN = 0~%uint8 MODE_ACCESS_POINT = 1~%uint8 MODE_CLIENT = 2~%~%uint8 current_mode~%string essid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WiFiState)))
  "Returns full string definition for message of type 'WiFiState"
  (cl:format cl:nil "# Mode~%uint8 MODE_UNKNOWN = 0~%uint8 MODE_ACCESS_POINT = 1~%uint8 MODE_CLIENT = 2~%~%uint8 current_mode~%string essid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WiFiState>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'essid))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WiFiState>))
  "Converts a ROS message object to a list"
  (cl:list 'WiFiState
    (cl:cons ':current_mode (current_mode msg))
    (cl:cons ':essid (essid msg))
))
