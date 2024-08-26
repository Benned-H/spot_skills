;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::LeaseOwner)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'LeaseOwner (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::LEASEOWNER")
  (make-package "SPOT_MSGS::LEASEOWNER"))

(in-package "ROS")
;;//! \htmlinclude LeaseOwner.msg.html


(defclass spot_msgs::LeaseOwner
  :super ros::object
  :slots (_client_name _user_name ))

(defmethod spot_msgs::LeaseOwner
  (:init
   (&key
    ((:client_name __client_name) "")
    ((:user_name __user_name) "")
    )
   (send-super :init)
   (setq _client_name (string __client_name))
   (setq _user_name (string __user_name))
   self)
  (:client_name
   (&optional __client_name)
   (if __client_name (setq _client_name __client_name)) _client_name)
  (:user_name
   (&optional __user_name)
   (if __user_name (setq _user_name __user_name)) _user_name)
  (:serialization-length
   ()
   (+
    ;; string _client_name
    4 (length _client_name)
    ;; string _user_name
    4 (length _user_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _client_name
       (write-long (length _client_name) s) (princ _client_name s)
     ;; string _user_name
       (write-long (length _user_name) s) (princ _user_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _client_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _client_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _user_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _user_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::LeaseOwner :md5sum-) "5cea27b2d1a89312b1101c1d985fe078")
(setf (get spot_msgs::LeaseOwner :datatype-) "spot_msgs/LeaseOwner")
(setf (get spot_msgs::LeaseOwner :definition-)
      "string client_name
string user_name

")



(provide :spot_msgs/LeaseOwner "5cea27b2d1a89312b1101c1d985fe078")


