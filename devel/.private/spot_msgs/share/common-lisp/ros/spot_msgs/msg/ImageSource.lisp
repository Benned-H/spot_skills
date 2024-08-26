; Auto-generated. Do not edit!


(cl:in-package spot_msgs-msg)


;//! \htmlinclude ImageSource.msg.html

(cl:defclass <ImageSource> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (cols
    :reader cols
    :initarg :cols
    :type cl:integer
    :initform 0)
   (rows
    :reader rows
    :initarg :rows
    :type cl:integer
    :initform 0)
   (depth_scale
    :reader depth_scale
    :initarg :depth_scale
    :type cl:float
    :initform 0.0)
   (focal_length_x
    :reader focal_length_x
    :initarg :focal_length_x
    :type cl:float
    :initform 0.0)
   (focal_length_y
    :reader focal_length_y
    :initarg :focal_length_y
    :type cl:float
    :initform 0.0)
   (principal_point_x
    :reader principal_point_x
    :initarg :principal_point_x
    :type cl:float
    :initform 0.0)
   (principal_point_y
    :reader principal_point_y
    :initarg :principal_point_y
    :type cl:float
    :initform 0.0)
   (skew_x
    :reader skew_x
    :initarg :skew_x
    :type cl:float
    :initform 0.0)
   (skew_y
    :reader skew_y
    :initarg :skew_y
    :type cl:float
    :initform 0.0)
   (image_type
    :reader image_type
    :initarg :image_type
    :type cl:fixnum
    :initform 0)
   (pixel_formats
    :reader pixel_formats
    :initarg :pixel_formats
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (image_formats
    :reader image_formats
    :initarg :image_formats
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass ImageSource (<ImageSource>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ImageSource>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ImageSource)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-msg:<ImageSource> is deprecated: use spot_msgs-msg:ImageSource instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:name-val is deprecated.  Use spot_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'cols-val :lambda-list '(m))
(cl:defmethod cols-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:cols-val is deprecated.  Use spot_msgs-msg:cols instead.")
  (cols m))

(cl:ensure-generic-function 'rows-val :lambda-list '(m))
(cl:defmethod rows-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:rows-val is deprecated.  Use spot_msgs-msg:rows instead.")
  (rows m))

(cl:ensure-generic-function 'depth_scale-val :lambda-list '(m))
(cl:defmethod depth_scale-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:depth_scale-val is deprecated.  Use spot_msgs-msg:depth_scale instead.")
  (depth_scale m))

(cl:ensure-generic-function 'focal_length_x-val :lambda-list '(m))
(cl:defmethod focal_length_x-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:focal_length_x-val is deprecated.  Use spot_msgs-msg:focal_length_x instead.")
  (focal_length_x m))

(cl:ensure-generic-function 'focal_length_y-val :lambda-list '(m))
(cl:defmethod focal_length_y-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:focal_length_y-val is deprecated.  Use spot_msgs-msg:focal_length_y instead.")
  (focal_length_y m))

(cl:ensure-generic-function 'principal_point_x-val :lambda-list '(m))
(cl:defmethod principal_point_x-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:principal_point_x-val is deprecated.  Use spot_msgs-msg:principal_point_x instead.")
  (principal_point_x m))

(cl:ensure-generic-function 'principal_point_y-val :lambda-list '(m))
(cl:defmethod principal_point_y-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:principal_point_y-val is deprecated.  Use spot_msgs-msg:principal_point_y instead.")
  (principal_point_y m))

(cl:ensure-generic-function 'skew_x-val :lambda-list '(m))
(cl:defmethod skew_x-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:skew_x-val is deprecated.  Use spot_msgs-msg:skew_x instead.")
  (skew_x m))

(cl:ensure-generic-function 'skew_y-val :lambda-list '(m))
(cl:defmethod skew_y-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:skew_y-val is deprecated.  Use spot_msgs-msg:skew_y instead.")
  (skew_y m))

(cl:ensure-generic-function 'image_type-val :lambda-list '(m))
(cl:defmethod image_type-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:image_type-val is deprecated.  Use spot_msgs-msg:image_type instead.")
  (image_type m))

(cl:ensure-generic-function 'pixel_formats-val :lambda-list '(m))
(cl:defmethod pixel_formats-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:pixel_formats-val is deprecated.  Use spot_msgs-msg:pixel_formats instead.")
  (pixel_formats m))

(cl:ensure-generic-function 'image_formats-val :lambda-list '(m))
(cl:defmethod image_formats-val ((m <ImageSource>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-msg:image_formats-val is deprecated.  Use spot_msgs-msg:image_formats instead.")
  (image_formats m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ImageSource>)))
    "Constants for message type '<ImageSource>"
  '((:IMAGE_TYPE_UNKNOWN . 0)
    (:IMAGE_TYPE_VISUAL . 1)
    (:IMAGE_TYPE_DEPTH . 2)
    (:PIXEL_FORMAT_UNKNOWN . 0)
    (:PIXEL_FORMAT_GREYSCALE_U8 . 1)
    (:PIXEL_FORMAT_RGB_U8 . 3)
    (:PIXEL_FORMAT_RGBA_U8 . 4)
    (:PIXEL_FORMAT_DEPTH_U16 . 5)
    (:PIXEL_FORMAT_GREYSCALE_U16 . 6)
    (:FORMAT_UNKNOWN . 0)
    (:FORMAT_JPEG . 1)
    (:FORMAT_RAW . 2)
    (:FORMAT_RLE . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ImageSource)))
    "Constants for message type 'ImageSource"
  '((:IMAGE_TYPE_UNKNOWN . 0)
    (:IMAGE_TYPE_VISUAL . 1)
    (:IMAGE_TYPE_DEPTH . 2)
    (:PIXEL_FORMAT_UNKNOWN . 0)
    (:PIXEL_FORMAT_GREYSCALE_U8 . 1)
    (:PIXEL_FORMAT_RGB_U8 . 3)
    (:PIXEL_FORMAT_RGBA_U8 . 4)
    (:PIXEL_FORMAT_DEPTH_U16 . 5)
    (:PIXEL_FORMAT_GREYSCALE_U16 . 6)
    (:FORMAT_UNKNOWN . 0)
    (:FORMAT_JPEG . 1)
    (:FORMAT_RAW . 2)
    (:FORMAT_RLE . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ImageSource>) ostream)
  "Serializes a message object of type '<ImageSource>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let* ((signed (cl:slot-value msg 'cols)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'rows)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'depth_scale))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'focal_length_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'focal_length_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'principal_point_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'principal_point_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'skew_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'skew_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'image_type)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pixel_formats))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'pixel_formats))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'image_formats))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'image_formats))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ImageSource>) istream)
  "Deserializes a message object of type '<ImageSource>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'cols) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rows) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'depth_scale) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'focal_length_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'focal_length_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'principal_point_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'principal_point_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'skew_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'skew_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'image_type)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pixel_formats) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pixel_formats)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'image_formats) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'image_formats)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ImageSource>)))
  "Returns string type for a message object of type '<ImageSource>"
  "spot_msgs/ImageSource")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ImageSource)))
  "Returns string type for a message object of type 'ImageSource"
  "spot_msgs/ImageSource")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ImageSource>)))
  "Returns md5sum for a message object of type '<ImageSource>"
  "24779006d77c58e3fd81f011ebfc2932")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ImageSource)))
  "Returns md5sum for a message object of type 'ImageSource"
  "24779006d77c58e3fd81f011ebfc2932")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ImageSource>)))
  "Returns full string definition for message of type '<ImageSource>"
  (cl:format cl:nil "# Image type enums~%uint8 IMAGE_TYPE_UNKNOWN = 0~%uint8 IMAGE_TYPE_VISUAL = 1~%uint8 IMAGE_TYPE_DEPTH = 2~%~%# Pixel format enums~%uint8 PIXEL_FORMAT_UNKNOWN = 0~%uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1~%uint8 PIXEL_FORMAT_RGB_U8 = 3~%uint8 PIXEL_FORMAT_RGBA_U8 = 4~%uint8 PIXEL_FORMAT_DEPTH_U16 = 5~%uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6~%~%# Image format enums~%uint8 FORMAT_UNKNOWN = 0~%uint8 FORMAT_JPEG = 1~%uint8 FORMAT_RAW = 2~%uint8 FORMAT_RLE = 3~%~%string name~%int32 cols~%int32 rows~%float64 depth_scale~%~%# Camera pinhole model parameters~%float64 focal_length_x~%float64 focal_length_y~%float64 principal_point_x~%float64 principal_point_y~%float64 skew_x~%float64 skew_y~%~%uint8 image_type~%uint8[] pixel_formats~%uint8[] image_formats~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ImageSource)))
  "Returns full string definition for message of type 'ImageSource"
  (cl:format cl:nil "# Image type enums~%uint8 IMAGE_TYPE_UNKNOWN = 0~%uint8 IMAGE_TYPE_VISUAL = 1~%uint8 IMAGE_TYPE_DEPTH = 2~%~%# Pixel format enums~%uint8 PIXEL_FORMAT_UNKNOWN = 0~%uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1~%uint8 PIXEL_FORMAT_RGB_U8 = 3~%uint8 PIXEL_FORMAT_RGBA_U8 = 4~%uint8 PIXEL_FORMAT_DEPTH_U16 = 5~%uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6~%~%# Image format enums~%uint8 FORMAT_UNKNOWN = 0~%uint8 FORMAT_JPEG = 1~%uint8 FORMAT_RAW = 2~%uint8 FORMAT_RLE = 3~%~%string name~%int32 cols~%int32 rows~%float64 depth_scale~%~%# Camera pinhole model parameters~%float64 focal_length_x~%float64 focal_length_y~%float64 principal_point_x~%float64 principal_point_y~%float64 skew_x~%float64 skew_y~%~%uint8 image_type~%uint8[] pixel_formats~%uint8[] image_formats~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ImageSource>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4
     4
     8
     8
     8
     8
     8
     8
     8
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pixel_formats) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'image_formats) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ImageSource>))
  "Converts a ROS message object to a list"
  (cl:list 'ImageSource
    (cl:cons ':name (name msg))
    (cl:cons ':cols (cols msg))
    (cl:cons ':rows (rows msg))
    (cl:cons ':depth_scale (depth_scale msg))
    (cl:cons ':focal_length_x (focal_length_x msg))
    (cl:cons ':focal_length_y (focal_length_y msg))
    (cl:cons ':principal_point_x (principal_point_x msg))
    (cl:cons ':principal_point_y (principal_point_y msg))
    (cl:cons ':skew_x (skew_x msg))
    (cl:cons ':skew_y (skew_y msg))
    (cl:cons ':image_type (image_type msg))
    (cl:cons ':pixel_formats (pixel_formats msg))
    (cl:cons ':image_formats (image_formats msg))
))
