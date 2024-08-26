; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude Feedback.msg.html

(cl:defclass <Feedback> (roslisp-msg-protocol:ros-message)
  ((standing
    :reader standing
    :initarg :standing
    :type cl:boolean
    :initform cl:nil)
   (sitting
    :reader sitting
    :initarg :sitting
    :type cl:boolean
    :initform cl:nil)
   (moving
    :reader moving
    :initarg :moving
    :type cl:boolean
    :initform cl:nil)
   (serial_number
    :reader serial_number
    :initarg :serial_number
    :type cl:string
    :initform "")
   (species
    :reader species
    :initarg :species
    :type cl:string
    :initform "")
   (version
    :reader version
    :initarg :version
    :type cl:string
    :initform "")
   (nickname
    :reader nickname
    :initarg :nickname
    :type cl:string
    :initform "")
   (computer_serial_number
    :reader computer_serial_number
    :initarg :computer_serial_number
    :type cl:string
    :initform ""))
)

(cl:defclass Feedback (<Feedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Feedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Feedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<Feedback> is deprecated: use spot_msgs-msg:Feedback instead.")))

(cl:ensure-generic-function 'standing-val :lambda-list '(m))
(cl:defmethod standing-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:standing-val is deprecated.  Use spot_msgs-msg:standing instead.")
  (standing m))

(cl:ensure-generic-function 'sitting-val :lambda-list '(m))
(cl:defmethod sitting-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:sitting-val is deprecated.  Use spot_msgs-msg:sitting instead.")
  (sitting m))

(cl:ensure-generic-function 'moving-val :lambda-list '(m))
(cl:defmethod moving-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:moving-val is deprecated.  Use spot_msgs-msg:moving instead.")
  (moving m))

(cl:ensure-generic-function 'serial_number-val :lambda-list '(m))
(cl:defmethod serial_number-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:serial_number-val is deprecated.  Use spot_msgs-msg:serial_number instead.")
  (serial_number m))

(cl:ensure-generic-function 'species-val :lambda-list '(m))
(cl:defmethod species-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:species-val is deprecated.  Use spot_msgs-msg:species instead.")
  (species m))

(cl:ensure-generic-function 'version-val :lambda-list '(m))
(cl:defmethod version-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:version-val is deprecated.  Use spot_msgs-msg:version instead.")
  (version m))

(cl:ensure-generic-function 'nickname-val :lambda-list '(m))
(cl:defmethod nickname-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:nickname-val is deprecated.  Use spot_msgs-msg:nickname instead.")
  (nickname m))

(cl:ensure-generic-function 'computer_serial_number-val :lambda-list '(m))
(cl:defmethod computer_serial_number-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:computer_serial_number-val is deprecated.  Use spot_msgs-msg:computer_serial_number instead.")
  (computer_serial_number m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Feedback>) ostream)
  "Serializes a message object of type '<Feedback>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'standing) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'sitting) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'moving) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'serial_number))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'serial_number))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'species))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'species))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'version))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'version))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'nickname))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'nickname))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'computer_serial_number))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'computer_serial_number))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Feedback>) istream)
  "Deserializes a message object of type '<Feedback>"
    (cl:setf (cl:slot-value msg 'standing) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'sitting) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'moving) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'serial_number) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'serial_number) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'species) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'species) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'version) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'version) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nickname) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'nickname) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'computer_serial_number) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'computer_serial_number) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Feedback>)))
  "Returns string type for a message object of type '<Feedback>"
  "spot_msgs/Feedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Feedback)))
  "Returns string type for a message object of type 'Feedback"
  "spot_msgs/Feedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Feedback>)))
  "Returns md5sum for a message object of type '<Feedback>"
  "16779e4df8e3f77c9ee8c1811559bd21")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Feedback)))
  "Returns md5sum for a message object of type 'Feedback"
  "16779e4df8e3f77c9ee8c1811559bd21")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Feedback>)))
  "Returns full string definition for message of type '<Feedback>"
  (cl:format cl:nil "bool standing~%bool sitting~%bool moving~%~%string serial_number~%string species~%string version~%string nickname~%string computer_serial_number~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Feedback)))
  "Returns full string definition for message of type 'Feedback"
  (cl:format cl:nil "bool standing~%bool sitting~%bool moving~%~%string serial_number~%string species~%string version~%string nickname~%string computer_serial_number~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Feedback>))
  (cl:+ 0
     1
     1
     1
     4 (cl:length (cl:slot-value msg 'serial_number))
     4 (cl:length (cl:slot-value msg 'species))
     4 (cl:length (cl:slot-value msg 'version))
     4 (cl:length (cl:slot-value msg 'nickname))
     4 (cl:length (cl:slot-value msg 'computer_serial_number))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Feedback>))
  "Converts a ROS message object to a list"
  (cl:list 'Feedback
    (cl:cons ':standing (standing msg))
    (cl:cons ':sitting (sitting msg))
    (cl:cons ':moving (moving msg))
    (cl:cons ':serial_number (serial_number msg))
    (cl:cons ':species (species msg))
    (cl:cons ':version (version msg))
    (cl:cons ':nickname (nickname msg))
    (cl:cons ':computer_serial_number (computer_serial_number msg))
))
