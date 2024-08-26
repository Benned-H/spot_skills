; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude SpotCheckHipROM.msg.html

(cl:defclass <SpotCheckHipROM> (roslisp-msg-protocol:ros-message)
  ((error
    :reader error
    :initarg :error
    :type cl:fixnum
    :initform 0)
   (hx
    :reader hx
    :initarg :hx
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (hy
    :reader hy
    :initarg :hy
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass SpotCheckHipROM (<SpotCheckHipROM>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheckHipROM>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheckHipROM)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<SpotCheckHipROM> is deprecated: use spot_msgs-msg:SpotCheckHipROM instead.")))

(cl:ensure-generic-function 'error-val :lambda-list '(m))
(cl:defmethod error-val ((m <SpotCheckHipROM>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:error-val is deprecated.  Use spot_msgs-msg:error instead.")
  (error m))

(cl:ensure-generic-function 'hx-val :lambda-list '(m))
(cl:defmethod hx-val ((m <SpotCheckHipROM>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:hx-val is deprecated.  Use spot_msgs-msg:hx instead.")
  (hx m))

(cl:ensure-generic-function 'hy-val :lambda-list '(m))
(cl:defmethod hy-val ((m <SpotCheckHipROM>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:hy-val is deprecated.  Use spot_msgs-msg:hy instead.")
  (hy m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SpotCheckHipROM>)))
    "Constants for message type '<SpotCheckHipROM>"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_OBSTRUCTED . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SpotCheckHipROM)))
    "Constants for message type 'SpotCheckHipROM"
  '((:ERROR_UNKNOWN . 0)
    (:ERROR_NONE . 1)
    (:ERROR_OBSTRUCTED . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheckHipROM>) ostream)
  "Serializes a message object of type '<SpotCheckHipROM>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'hx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'hx))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'hy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'hy))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheckHipROM>) istream)
  "Deserializes a message object of type '<SpotCheckHipROM>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'error)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'hx) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'hx)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'hy) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'hy)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheckHipROM>)))
  "Returns string type for a message object of type '<SpotCheckHipROM>"
  "spot_msgs/SpotCheckHipROM")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheckHipROM)))
  "Returns string type for a message object of type 'SpotCheckHipROM"
  "spot_msgs/SpotCheckHipROM")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheckHipROM>)))
  "Returns md5sum for a message object of type '<SpotCheckHipROM>"
  "2bffa893cfa8c1ee57352f3ccf3348bc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheckHipROM)))
  "Returns md5sum for a message object of type 'SpotCheckHipROM"
  "2bffa893cfa8c1ee57352f3ccf3348bc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheckHipROM>)))
  "Returns full string definition for message of type '<SpotCheckHipROM>"
  (cl:format cl:nil "# Errors reflect an issue with hip range of motion~%uint8 ERROR_UNKNOWN = 0~%uint8 ERROR_NONE = 1~%uint8 ERROR_OBSTRUCTED = 2~%~%uint8 error~%~%# The measured angles (radians) of the HX and HY joints where the obstruction was detected~%float32[] hx~%float32[] hy~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheckHipROM)))
  "Returns full string definition for message of type 'SpotCheckHipROM"
  (cl:format cl:nil "# Errors reflect an issue with hip range of motion~%uint8 ERROR_UNKNOWN = 0~%uint8 ERROR_NONE = 1~%uint8 ERROR_OBSTRUCTED = 2~%~%uint8 error~%~%# The measured angles (radians) of the HX and HY joints where the obstruction was detected~%float32[] hx~%float32[] hy~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheckHipROM>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'hx) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'hy) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheckHipROM>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheckHipROM
    (cl:cons ':error (error msg))
    (cl:cons ':hx (hx msg))
    (cl:cons ':hy (hy msg))
))
