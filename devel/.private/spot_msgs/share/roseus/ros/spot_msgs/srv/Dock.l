;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::Dock)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'Dock (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::DOCK")
  (make-package "SPOT_MSGS::DOCK"))
(unless (find-package "SPOT_MSGS::DOCKREQUEST")
  (make-package "SPOT_MSGS::DOCKREQUEST"))
(unless (find-package "SPOT_MSGS::DOCKRESPONSE")
  (make-package "SPOT_MSGS::DOCKRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::DockRequest
  :super ros::object
  :slots (_dock_id ))

(defmethod spot_msgs::DockRequest
  (:init
   (&key
    ((:dock_id __dock_id) 0)
    )
   (send-super :init)
   (setq _dock_id (round __dock_id))
   self)
  (:dock_id
   (&optional __dock_id)
   (if __dock_id (setq _dock_id __dock_id)) _dock_id)
  (:serialization-length
   ()
   (+
    ;; uint32 _dock_id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _dock_id
       (write-long _dock_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _dock_id
     (setq _dock_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_msgs::DockResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::DockResponse
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

(defclass spot_msgs::Dock
  :super ros::object
  :slots ())

(setf (get spot_msgs::Dock :md5sum-) "c1102efdad60fe70c4c44187beb3e1e8")
(setf (get spot_msgs::Dock :datatype-) "spot_msgs/Dock")
(setf (get spot_msgs::Dock :request) spot_msgs::DockRequest)
(setf (get spot_msgs::Dock :response) spot_msgs::DockResponse)

(defmethod spot_msgs::DockRequest
  (:response () (instance spot_msgs::DockResponse :init)))

(setf (get spot_msgs::DockRequest :md5sum-) "c1102efdad60fe70c4c44187beb3e1e8")
(setf (get spot_msgs::DockRequest :datatype-) "spot_msgs/DockRequest")
(setf (get spot_msgs::DockRequest :definition-)
      "uint32 dock_id # dock fiducials id
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages

")

(setf (get spot_msgs::DockResponse :md5sum-) "c1102efdad60fe70c4c44187beb3e1e8")
(setf (get spot_msgs::DockResponse :datatype-) "spot_msgs/DockResponse")
(setf (get spot_msgs::DockResponse :definition-)
      "uint32 dock_id # dock fiducials id
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages

")



(provide :spot_msgs/Dock "c1102efdad60fe70c4c44187beb3e1e8")


