;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SystemFault)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SystemFault (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SYSTEMFAULT")
  (make-package "SPOT_MSGS::SYSTEMFAULT"))

(in-package "ROS")
;;//! \htmlinclude SystemFault.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*SEVERITY_UNKNOWN*" (find-package "SPOT_MSGS::SYSTEMFAULT"))
(shadow '*SEVERITY_UNKNOWN* (find-package "SPOT_MSGS::SYSTEMFAULT"))
(defconstant spot_msgs::SystemFault::*SEVERITY_UNKNOWN* 0)
(intern "*SEVERITY_INFO*" (find-package "SPOT_MSGS::SYSTEMFAULT"))
(shadow '*SEVERITY_INFO* (find-package "SPOT_MSGS::SYSTEMFAULT"))
(defconstant spot_msgs::SystemFault::*SEVERITY_INFO* 1)
(intern "*SEVERITY_WARN*" (find-package "SPOT_MSGS::SYSTEMFAULT"))
(shadow '*SEVERITY_WARN* (find-package "SPOT_MSGS::SYSTEMFAULT"))
(defconstant spot_msgs::SystemFault::*SEVERITY_WARN* 2)
(intern "*SEVERITY_CRITICAL*" (find-package "SPOT_MSGS::SYSTEMFAULT"))
(shadow '*SEVERITY_CRITICAL* (find-package "SPOT_MSGS::SYSTEMFAULT"))
(defconstant spot_msgs::SystemFault::*SEVERITY_CRITICAL* 3)

(defun spot_msgs::SystemFault-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::SystemFault::*SEVERITY_UNKNOWN*)
        ((= const 1) 'spot_msgs::SystemFault::*SEVERITY_INFO*)
        ((= const 2) 'spot_msgs::SystemFault::*SEVERITY_WARN*)
        ((= const 3) 'spot_msgs::SystemFault::*SEVERITY_CRITICAL*)
        (t nil)))

(defclass spot_msgs::SystemFault
  :super ros::object
  :slots (_header _name _duration _code _uid _error_message _attributes _severity ))

(defmethod spot_msgs::SystemFault
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:name __name) "")
    ((:duration __duration) (instance ros::time :init))
    ((:code __code) 0)
    ((:uid __uid) 0)
    ((:error_message __error_message) "")
    ((:attributes __attributes) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:severity __severity) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _name (string __name))
   (setq _duration __duration)
   (setq _code (round __code))
   (setq _uid (round __uid))
   (setq _error_message (string __error_message))
   (setq _attributes __attributes)
   (setq _severity (round __severity))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:code
   (&optional __code)
   (if __code (setq _code __code)) _code)
  (:uid
   (&optional __uid)
   (if __uid (setq _uid __uid)) _uid)
  (:error_message
   (&optional __error_message)
   (if __error_message (setq _error_message __error_message)) _error_message)
  (:attributes
   (&optional __attributes)
   (if __attributes (setq _attributes __attributes)) _attributes)
  (:severity
   (&optional __severity)
   (if __severity (setq _severity __severity)) _severity)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _name
    4 (length _name)
    ;; duration _duration
    8
    ;; int32 _code
    4
    ;; uint64 _uid
    8
    ;; string _error_message
    4 (length _error_message)
    ;; string[] _attributes
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _attributes)) 4
    ;; uint8 _severity
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; duration _duration
       (write-long (send _duration :sec) s) (write-long (send _duration :nsec) s)
     ;; int32 _code
       (write-long _code s)
     ;; uint64 _uid
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _uid (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _uid) (= (length (_uid . bv)) 2)) ;; bignum
              (write-long (ash (elt (_uid . bv) 0) 0) s)
              (write-long (ash (elt (_uid . bv) 1) -1) s))
             ((and (class _uid) (= (length (_uid . bv)) 1)) ;; big1
              (write-long (elt (_uid . bv) 0) s)
              (write-long (if (>= _uid 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _uid s)(write-long (if (>= _uid 0) 0 #xffffffff) s)))
     ;; string _error_message
       (write-long (length _error_message) s) (princ _error_message s)
     ;; string[] _attributes
     (write-long (length _attributes) s)
     (dolist (elem _attributes)
       (write-long (length elem) s) (princ elem s)
       )
     ;; uint8 _severity
       (write-byte _severity s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; duration _duration
     (send _duration :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _duration :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _code
     (setq _code (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint64 _uid
     
#+(or :alpha :irix6 :x86_64)
      (setf _uid (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _uid (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string _error_message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _error_message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string[] _attributes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _attributes (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _attributes i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; uint8 _severity
     (setq _severity (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_msgs::SystemFault :md5sum-) "d4409a7e7087c0e4485ccf8e05022a5d")
(setf (get spot_msgs::SystemFault :datatype-) "spot_msgs/SystemFault")
(setf (get spot_msgs::SystemFault :definition-)
      "# Severity
uint8 SEVERITY_UNKNOWN = 0
uint8 SEVERITY_INFO = 1
uint8 SEVERITY_WARN = 2
uint8 SEVERITY_CRITICAL = 3

Header header
string name
duration duration
int32 code
uint64 uid
string error_message
string[] attributes
uint8 severity

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :spot_msgs/SystemFault "d4409a7e7087c0e4485ccf8e05022a5d")


