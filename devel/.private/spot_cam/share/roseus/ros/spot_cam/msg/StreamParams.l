;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::StreamParams)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'StreamParams (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::STREAMPARAMS")
  (make-package "SPOT_CAM::STREAMPARAMS"))

(in-package "ROS")
;;//! \htmlinclude StreamParams.msg.html


(intern "*OFF*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*OFF* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*OFF* -1)
(intern "*UNSET*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*UNSET* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*UNSET* 0)
(intern "*AUTO*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*AUTO* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*AUTO* 1)
(intern "*INCANDESCENT*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*INCANDESCENT* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*INCANDESCENT* 2)
(intern "*FLUORESCENT*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*FLUORESCENT* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*FLUORESCENT* 3)
(intern "*WARM_FLUORESCENT*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*WARM_FLUORESCENT* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*WARM_FLUORESCENT* 4)
(intern "*DAYLIGHT*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*DAYLIGHT* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*DAYLIGHT* 5)
(intern "*CLOUDY*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*CLOUDY* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*CLOUDY* 6)
(intern "*TWILIGHT*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*TWILIGHT* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*TWILIGHT* 7)
(intern "*SHADE*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*SHADE* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*SHADE* 8)
(intern "*DARK*" (find-package "SPOT_CAM::STREAMPARAMS"))
(shadow '*DARK* (find-package "SPOT_CAM::STREAMPARAMS"))
(defconstant spot_cam::StreamParams::*DARK* 9)

(defun spot_cam::StreamParams-to-symbol (const)
  (cond
        ((= const -1) 'spot_cam::StreamParams::*OFF*)
        ((= const 0) 'spot_cam::StreamParams::*UNSET*)
        ((= const 1) 'spot_cam::StreamParams::*AUTO*)
        ((= const 2) 'spot_cam::StreamParams::*INCANDESCENT*)
        ((= const 3) 'spot_cam::StreamParams::*FLUORESCENT*)
        ((= const 4) 'spot_cam::StreamParams::*WARM_FLUORESCENT*)
        ((= const 5) 'spot_cam::StreamParams::*DAYLIGHT*)
        ((= const 6) 'spot_cam::StreamParams::*CLOUDY*)
        ((= const 7) 'spot_cam::StreamParams::*TWILIGHT*)
        ((= const 8) 'spot_cam::StreamParams::*SHADE*)
        ((= const 9) 'spot_cam::StreamParams::*DARK*)
        (t nil)))

(defclass spot_cam::StreamParams
  :super ros::object
  :slots (_target_bitrate _refresh_interval _idr_interval _awb ))

(defmethod spot_cam::StreamParams
  (:init
   (&key
    ((:target_bitrate __target_bitrate) 0)
    ((:refresh_interval __refresh_interval) 0)
    ((:idr_interval __idr_interval) 0)
    ((:awb __awb) 0)
    )
   (send-super :init)
   (setq _target_bitrate (round __target_bitrate))
   (setq _refresh_interval (round __refresh_interval))
   (setq _idr_interval (round __idr_interval))
   (setq _awb (round __awb))
   self)
  (:target_bitrate
   (&optional __target_bitrate)
   (if __target_bitrate (setq _target_bitrate __target_bitrate)) _target_bitrate)
  (:refresh_interval
   (&optional __refresh_interval)
   (if __refresh_interval (setq _refresh_interval __refresh_interval)) _refresh_interval)
  (:idr_interval
   (&optional __idr_interval)
   (if __idr_interval (setq _idr_interval __idr_interval)) _idr_interval)
  (:awb
   (&optional __awb)
   (if __awb (setq _awb __awb)) _awb)
  (:serialization-length
   ()
   (+
    ;; int64 _target_bitrate
    8
    ;; int64 _refresh_interval
    8
    ;; int64 _idr_interval
    8
    ;; int8 _awb
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _target_bitrate
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _target_bitrate (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _target_bitrate) (= (length (_target_bitrate . bv)) 2)) ;; bignum
              (write-long (ash (elt (_target_bitrate . bv) 0) 0) s)
              (write-long (ash (elt (_target_bitrate . bv) 1) -1) s))
             ((and (class _target_bitrate) (= (length (_target_bitrate . bv)) 1)) ;; big1
              (write-long (elt (_target_bitrate . bv) 0) s)
              (write-long (if (>= _target_bitrate 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _target_bitrate s)(write-long (if (>= _target_bitrate 0) 0 #xffffffff) s)))
     ;; int64 _refresh_interval
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _refresh_interval (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _refresh_interval) (= (length (_refresh_interval . bv)) 2)) ;; bignum
              (write-long (ash (elt (_refresh_interval . bv) 0) 0) s)
              (write-long (ash (elt (_refresh_interval . bv) 1) -1) s))
             ((and (class _refresh_interval) (= (length (_refresh_interval . bv)) 1)) ;; big1
              (write-long (elt (_refresh_interval . bv) 0) s)
              (write-long (if (>= _refresh_interval 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _refresh_interval s)(write-long (if (>= _refresh_interval 0) 0 #xffffffff) s)))
     ;; int64 _idr_interval
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _idr_interval (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _idr_interval) (= (length (_idr_interval . bv)) 2)) ;; bignum
              (write-long (ash (elt (_idr_interval . bv) 0) 0) s)
              (write-long (ash (elt (_idr_interval . bv) 1) -1) s))
             ((and (class _idr_interval) (= (length (_idr_interval . bv)) 1)) ;; big1
              (write-long (elt (_idr_interval . bv) 0) s)
              (write-long (if (>= _idr_interval 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _idr_interval s)(write-long (if (>= _idr_interval 0) 0 #xffffffff) s)))
     ;; int8 _awb
       (write-byte _awb s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _target_bitrate
#+(or :alpha :irix6 :x86_64)
      (setf _target_bitrate (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _target_bitrate (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _refresh_interval
#+(or :alpha :irix6 :x86_64)
      (setf _refresh_interval (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _refresh_interval (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _idr_interval
#+(or :alpha :irix6 :x86_64)
      (setf _idr_interval (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _idr_interval (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int8 _awb
     (setq _awb (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _awb 127) (setq _awb (- _awb 256)))
   ;;
   self)
  )

(setf (get spot_cam::StreamParams :md5sum-) "7fa7ed9c6dbde8368621018918a2a544")
(setf (get spot_cam::StreamParams :datatype-) "spot_cam/StreamParams")
(setf (get spot_cam::StreamParams :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams
# White balance modes
int8 OFF=-1
# This is not provided, but we add it to be able to distinguish when setting the white balance
int8 UNSET=0
int8 AUTO=1
int8 INCANDESCENT=2
int8 FLUORESCENT=3
int8 WARM_FLUORESCENT=4
int8 DAYLIGHT=5
int8 CLOUDY=6
int8 TWILIGHT=7
int8 SHADE=8
int8 DARK=9

# Compression level target in bits per second
int64 target_bitrate
# How often should the entire feed be refreshed (in frames)
int64 refresh_interval
# How often should an IDR message be sent (in frames)
int64 idr_interval
# Automatic white balance
int8 awb
")



(provide :spot_cam/StreamParams "7fa7ed9c6dbde8368621018918a2a544")


