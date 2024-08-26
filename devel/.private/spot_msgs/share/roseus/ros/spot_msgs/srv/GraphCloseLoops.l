;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::GraphCloseLoops)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'GraphCloseLoops (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::GRAPHCLOSELOOPS")
  (make-package "SPOT_MSGS::GRAPHCLOSELOOPS"))
(unless (find-package "SPOT_MSGS::GRAPHCLOSELOOPSREQUEST")
  (make-package "SPOT_MSGS::GRAPHCLOSELOOPSREQUEST"))
(unless (find-package "SPOT_MSGS::GRAPHCLOSELOOPSRESPONSE")
  (make-package "SPOT_MSGS::GRAPHCLOSELOOPSRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::GraphCloseLoopsRequest
  :super ros::object
  :slots (_close_fiducial_loops _close_odometry_loops ))

(defmethod spot_msgs::GraphCloseLoopsRequest
  (:init
   (&key
    ((:close_fiducial_loops __close_fiducial_loops) nil)
    ((:close_odometry_loops __close_odometry_loops) nil)
    )
   (send-super :init)
   (setq _close_fiducial_loops __close_fiducial_loops)
   (setq _close_odometry_loops __close_odometry_loops)
   self)
  (:close_fiducial_loops
   (&optional (__close_fiducial_loops :null))
   (if (not (eq __close_fiducial_loops :null)) (setq _close_fiducial_loops __close_fiducial_loops)) _close_fiducial_loops)
  (:close_odometry_loops
   (&optional (__close_odometry_loops :null))
   (if (not (eq __close_odometry_loops :null)) (setq _close_odometry_loops __close_odometry_loops)) _close_odometry_loops)
  (:serialization-length
   ()
   (+
    ;; bool _close_fiducial_loops
    1
    ;; bool _close_odometry_loops
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _close_fiducial_loops
       (if _close_fiducial_loops (write-byte -1 s) (write-byte 0 s))
     ;; bool _close_odometry_loops
       (if _close_odometry_loops (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _close_fiducial_loops
     (setq _close_fiducial_loops (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _close_odometry_loops
     (setq _close_odometry_loops (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_msgs::GraphCloseLoopsResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::GraphCloseLoopsResponse
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

(defclass spot_msgs::GraphCloseLoops
  :super ros::object
  :slots ())

(setf (get spot_msgs::GraphCloseLoops :md5sum-) "dcd1b935b0d8f62ecaa9864406b50eae")
(setf (get spot_msgs::GraphCloseLoops :datatype-) "spot_msgs/GraphCloseLoops")
(setf (get spot_msgs::GraphCloseLoops :request) spot_msgs::GraphCloseLoopsRequest)
(setf (get spot_msgs::GraphCloseLoops :response) spot_msgs::GraphCloseLoopsResponse)

(defmethod spot_msgs::GraphCloseLoopsRequest
  (:response () (instance spot_msgs::GraphCloseLoopsResponse :init)))

(setf (get spot_msgs::GraphCloseLoopsRequest :md5sum-) "dcd1b935b0d8f62ecaa9864406b50eae")
(setf (get spot_msgs::GraphCloseLoopsRequest :datatype-) "spot_msgs/GraphCloseLoopsRequest")
(setf (get spot_msgs::GraphCloseLoopsRequest :definition-)
      "bool close_fiducial_loops
bool close_odometry_loops
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages

")

(setf (get spot_msgs::GraphCloseLoopsResponse :md5sum-) "dcd1b935b0d8f62ecaa9864406b50eae")
(setf (get spot_msgs::GraphCloseLoopsResponse :datatype-) "spot_msgs/GraphCloseLoopsResponse")
(setf (get spot_msgs::GraphCloseLoopsResponse :definition-)
      "bool close_fiducial_loops
bool close_odometry_loops
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages

")



(provide :spot_msgs/GraphCloseLoops "dcd1b935b0d8f62ecaa9864406b50eae")


