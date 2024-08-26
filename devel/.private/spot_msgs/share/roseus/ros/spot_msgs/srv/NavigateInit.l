;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::NavigateInit)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'NavigateInit (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::NAVIGATEINIT")
  (make-package "SPOT_MSGS::NAVIGATEINIT"))
(unless (find-package "SPOT_MSGS::NAVIGATEINITREQUEST")
  (make-package "SPOT_MSGS::NAVIGATEINITREQUEST"))
(unless (find-package "SPOT_MSGS::NAVIGATEINITRESPONSE")
  (make-package "SPOT_MSGS::NAVIGATEINITRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::NavigateInitRequest
  :super ros::object
  :slots (_upload_path _initial_localization_fiducial _initial_localization_waypoint ))

(defmethod spot_msgs::NavigateInitRequest
  (:init
   (&key
    ((:upload_path __upload_path) "")
    ((:initial_localization_fiducial __initial_localization_fiducial) nil)
    ((:initial_localization_waypoint __initial_localization_waypoint) "")
    )
   (send-super :init)
   (setq _upload_path (string __upload_path))
   (setq _initial_localization_fiducial __initial_localization_fiducial)
   (setq _initial_localization_waypoint (string __initial_localization_waypoint))
   self)
  (:upload_path
   (&optional __upload_path)
   (if __upload_path (setq _upload_path __upload_path)) _upload_path)
  (:initial_localization_fiducial
   (&optional (__initial_localization_fiducial :null))
   (if (not (eq __initial_localization_fiducial :null)) (setq _initial_localization_fiducial __initial_localization_fiducial)) _initial_localization_fiducial)
  (:initial_localization_waypoint
   (&optional __initial_localization_waypoint)
   (if __initial_localization_waypoint (setq _initial_localization_waypoint __initial_localization_waypoint)) _initial_localization_waypoint)
  (:serialization-length
   ()
   (+
    ;; string _upload_path
    4 (length _upload_path)
    ;; bool _initial_localization_fiducial
    1
    ;; string _initial_localization_waypoint
    4 (length _initial_localization_waypoint)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _upload_path
       (write-long (length _upload_path) s) (princ _upload_path s)
     ;; bool _initial_localization_fiducial
       (if _initial_localization_fiducial (write-byte -1 s) (write-byte 0 s))
     ;; string _initial_localization_waypoint
       (write-long (length _initial_localization_waypoint) s) (princ _initial_localization_waypoint s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _upload_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _upload_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _initial_localization_fiducial
     (setq _initial_localization_fiducial (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _initial_localization_waypoint
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _initial_localization_waypoint (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_msgs::NavigateInitResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::NavigateInitResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_msgs::NavigateInit
  :super ros::object
  :slots ())

(setf (get spot_msgs::NavigateInit :md5sum-) "c444c9070e6d223b1750275fad5b1484")
(setf (get spot_msgs::NavigateInit :datatype-) "spot_msgs/NavigateInit")
(setf (get spot_msgs::NavigateInit :request) spot_msgs::NavigateInitRequest)
(setf (get spot_msgs::NavigateInit :response) spot_msgs::NavigateInitResponse)

(defmethod spot_msgs::NavigateInitRequest
  (:response () (instance spot_msgs::NavigateInitResponse :init)))

(setf (get spot_msgs::NavigateInitRequest :md5sum-) "c444c9070e6d223b1750275fad5b1484")
(setf (get spot_msgs::NavigateInitRequest :datatype-) "spot_msgs/NavigateInitRequest")
(setf (get spot_msgs::NavigateInitRequest :definition-)
      "string upload_path # Absolute path to map_directory, which is downloaded from tablet controller
bool initial_localization_fiducial   # Tells the initializer whether to use fiducials
string initial_localization_waypoint # Waypoint id to trigger localization 
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages
")

(setf (get spot_msgs::NavigateInitResponse :md5sum-) "c444c9070e6d223b1750275fad5b1484")
(setf (get spot_msgs::NavigateInitResponse :datatype-) "spot_msgs/NavigateInitResponse")
(setf (get spot_msgs::NavigateInitResponse :definition-)
      "string upload_path # Absolute path to map_directory, which is downloaded from tablet controller
bool initial_localization_fiducial   # Tells the initializer whether to use fiducials
string initial_localization_waypoint # Waypoint id to trigger localization 
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages
")



(provide :spot_msgs/NavigateInit "c444c9070e6d223b1750275fad5b1484")


