;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ImageSource)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ImageSource (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::IMAGESOURCE")
  (make-package "SPOT_MSGS::IMAGESOURCE"))

(in-package "ROS")
;;//! \htmlinclude ImageSource.msg.html


(intern "*IMAGE_TYPE_UNKNOWN*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*IMAGE_TYPE_UNKNOWN* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*IMAGE_TYPE_UNKNOWN* 0)
(intern "*IMAGE_TYPE_VISUAL*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*IMAGE_TYPE_VISUAL* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*IMAGE_TYPE_VISUAL* 1)
(intern "*IMAGE_TYPE_DEPTH*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*IMAGE_TYPE_DEPTH* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*IMAGE_TYPE_DEPTH* 2)
(intern "*PIXEL_FORMAT_UNKNOWN*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*PIXEL_FORMAT_UNKNOWN* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*PIXEL_FORMAT_UNKNOWN* 0)
(intern "*PIXEL_FORMAT_GREYSCALE_U8*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*PIXEL_FORMAT_GREYSCALE_U8* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*PIXEL_FORMAT_GREYSCALE_U8* 1)
(intern "*PIXEL_FORMAT_RGB_U8*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*PIXEL_FORMAT_RGB_U8* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*PIXEL_FORMAT_RGB_U8* 3)
(intern "*PIXEL_FORMAT_RGBA_U8*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*PIXEL_FORMAT_RGBA_U8* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*PIXEL_FORMAT_RGBA_U8* 4)
(intern "*PIXEL_FORMAT_DEPTH_U16*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*PIXEL_FORMAT_DEPTH_U16* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*PIXEL_FORMAT_DEPTH_U16* 5)
(intern "*PIXEL_FORMAT_GREYSCALE_U16*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*PIXEL_FORMAT_GREYSCALE_U16* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*PIXEL_FORMAT_GREYSCALE_U16* 6)
(intern "*FORMAT_UNKNOWN*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*FORMAT_UNKNOWN* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*FORMAT_UNKNOWN* 0)
(intern "*FORMAT_JPEG*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*FORMAT_JPEG* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*FORMAT_JPEG* 1)
(intern "*FORMAT_RAW*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*FORMAT_RAW* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*FORMAT_RAW* 2)
(intern "*FORMAT_RLE*" (find-package "SPOT_MSGS::IMAGESOURCE"))
(shadow '*FORMAT_RLE* (find-package "SPOT_MSGS::IMAGESOURCE"))
(defconstant spot_msgs::ImageSource::*FORMAT_RLE* 3)

(defun spot_msgs::ImageSource-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::ImageSource::*IMAGE_TYPE_UNKNOWN*)
        ((= const 1) 'spot_msgs::ImageSource::*IMAGE_TYPE_VISUAL*)
        ((= const 2) 'spot_msgs::ImageSource::*IMAGE_TYPE_DEPTH*)
        ((= const 0) 'spot_msgs::ImageSource::*PIXEL_FORMAT_UNKNOWN*)
        ((= const 1) 'spot_msgs::ImageSource::*PIXEL_FORMAT_GREYSCALE_U8*)
        ((= const 3) 'spot_msgs::ImageSource::*PIXEL_FORMAT_RGB_U8*)
        ((= const 4) 'spot_msgs::ImageSource::*PIXEL_FORMAT_RGBA_U8*)
        ((= const 5) 'spot_msgs::ImageSource::*PIXEL_FORMAT_DEPTH_U16*)
        ((= const 6) 'spot_msgs::ImageSource::*PIXEL_FORMAT_GREYSCALE_U16*)
        ((= const 0) 'spot_msgs::ImageSource::*FORMAT_UNKNOWN*)
        ((= const 1) 'spot_msgs::ImageSource::*FORMAT_JPEG*)
        ((= const 2) 'spot_msgs::ImageSource::*FORMAT_RAW*)
        ((= const 3) 'spot_msgs::ImageSource::*FORMAT_RLE*)
        (t nil)))

(defclass spot_msgs::ImageSource
  :super ros::object
  :slots (_name _cols _rows _depth_scale _focal_length_x _focal_length_y _principal_point_x _principal_point_y _skew_x _skew_y _image_type _pixel_formats _image_formats ))

(defmethod spot_msgs::ImageSource
  (:init
   (&key
    ((:name __name) "")
    ((:cols __cols) 0)
    ((:rows __rows) 0)
    ((:depth_scale __depth_scale) 0.0)
    ((:focal_length_x __focal_length_x) 0.0)
    ((:focal_length_y __focal_length_y) 0.0)
    ((:principal_point_x __principal_point_x) 0.0)
    ((:principal_point_y __principal_point_y) 0.0)
    ((:skew_x __skew_x) 0.0)
    ((:skew_y __skew_y) 0.0)
    ((:image_type __image_type) 0)
    ((:pixel_formats __pixel_formats) (make-array 0 :initial-element 0 :element-type :char))
    ((:image_formats __image_formats) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _cols (round __cols))
   (setq _rows (round __rows))
   (setq _depth_scale (float __depth_scale))
   (setq _focal_length_x (float __focal_length_x))
   (setq _focal_length_y (float __focal_length_y))
   (setq _principal_point_x (float __principal_point_x))
   (setq _principal_point_y (float __principal_point_y))
   (setq _skew_x (float __skew_x))
   (setq _skew_y (float __skew_y))
   (setq _image_type (round __image_type))
   (setq _pixel_formats __pixel_formats)
   (setq _image_formats __image_formats)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:cols
   (&optional __cols)
   (if __cols (setq _cols __cols)) _cols)
  (:rows
   (&optional __rows)
   (if __rows (setq _rows __rows)) _rows)
  (:depth_scale
   (&optional __depth_scale)
   (if __depth_scale (setq _depth_scale __depth_scale)) _depth_scale)
  (:focal_length_x
   (&optional __focal_length_x)
   (if __focal_length_x (setq _focal_length_x __focal_length_x)) _focal_length_x)
  (:focal_length_y
   (&optional __focal_length_y)
   (if __focal_length_y (setq _focal_length_y __focal_length_y)) _focal_length_y)
  (:principal_point_x
   (&optional __principal_point_x)
   (if __principal_point_x (setq _principal_point_x __principal_point_x)) _principal_point_x)
  (:principal_point_y
   (&optional __principal_point_y)
   (if __principal_point_y (setq _principal_point_y __principal_point_y)) _principal_point_y)
  (:skew_x
   (&optional __skew_x)
   (if __skew_x (setq _skew_x __skew_x)) _skew_x)
  (:skew_y
   (&optional __skew_y)
   (if __skew_y (setq _skew_y __skew_y)) _skew_y)
  (:image_type
   (&optional __image_type)
   (if __image_type (setq _image_type __image_type)) _image_type)
  (:pixel_formats
   (&optional __pixel_formats)
   (if __pixel_formats (setq _pixel_formats __pixel_formats)) _pixel_formats)
  (:image_formats
   (&optional __image_formats)
   (if __image_formats (setq _image_formats __image_formats)) _image_formats)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; int32 _cols
    4
    ;; int32 _rows
    4
    ;; float64 _depth_scale
    8
    ;; float64 _focal_length_x
    8
    ;; float64 _focal_length_y
    8
    ;; float64 _principal_point_x
    8
    ;; float64 _principal_point_y
    8
    ;; float64 _skew_x
    8
    ;; float64 _skew_y
    8
    ;; uint8 _image_type
    1
    ;; uint8[] _pixel_formats
    (* 1    (length _pixel_formats)) 4
    ;; uint8[] _image_formats
    (* 1    (length _image_formats)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; int32 _cols
       (write-long _cols s)
     ;; int32 _rows
       (write-long _rows s)
     ;; float64 _depth_scale
       (sys::poke _depth_scale (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _focal_length_x
       (sys::poke _focal_length_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _focal_length_y
       (sys::poke _focal_length_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _principal_point_x
       (sys::poke _principal_point_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _principal_point_y
       (sys::poke _principal_point_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _skew_x
       (sys::poke _skew_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _skew_y
       (sys::poke _skew_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint8 _image_type
       (write-byte _image_type s)
     ;; uint8[] _pixel_formats
     (write-long (length _pixel_formats) s)
     (princ _pixel_formats s)
     ;; uint8[] _image_formats
     (write-long (length _image_formats) s)
     (princ _image_formats s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _cols
     (setq _cols (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _rows
     (setq _rows (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _depth_scale
     (setq _depth_scale (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _focal_length_x
     (setq _focal_length_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _focal_length_y
     (setq _focal_length_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _principal_point_x
     (setq _principal_point_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _principal_point_y
     (setq _principal_point_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _skew_x
     (setq _skew_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _skew_y
     (setq _skew_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint8 _image_type
     (setq _image_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8[] _pixel_formats
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _pixel_formats (make-array n :element-type :char))
     (replace _pixel_formats buf :start2 ptr-) (incf ptr- n))
   ;; uint8[] _image_formats
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _image_formats (make-array n :element-type :char))
     (replace _image_formats buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::ImageSource :md5sum-) "24779006d77c58e3fd81f011ebfc2932")
(setf (get spot_msgs::ImageSource :datatype-) "spot_msgs/ImageSource")
(setf (get spot_msgs::ImageSource :definition-)
      "# Image type enums
uint8 IMAGE_TYPE_UNKNOWN = 0
uint8 IMAGE_TYPE_VISUAL = 1
uint8 IMAGE_TYPE_DEPTH = 2

# Pixel format enums
uint8 PIXEL_FORMAT_UNKNOWN = 0
uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1
uint8 PIXEL_FORMAT_RGB_U8 = 3
uint8 PIXEL_FORMAT_RGBA_U8 = 4
uint8 PIXEL_FORMAT_DEPTH_U16 = 5
uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6

# Image format enums
uint8 FORMAT_UNKNOWN = 0
uint8 FORMAT_JPEG = 1
uint8 FORMAT_RAW = 2
uint8 FORMAT_RLE = 3

string name
int32 cols
int32 rows
float64 depth_scale

# Camera pinhole model parameters
float64 focal_length_x
float64 focal_length_y
float64 principal_point_x
float64 principal_point_y
float64 skew_x
float64 skew_y

uint8 image_type
uint8[] pixel_formats
uint8[] image_formats

")



(provide :spot_msgs/ImageSource "24779006d77c58e3fd81f011ebfc2932")


