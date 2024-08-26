;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::LeaseArray)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'LeaseArray (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::LEASEARRAY")
  (make-package "SPOT_MSGS::LEASEARRAY"))

(in-package "ROS")
;;//! \htmlinclude LeaseArray.msg.html


(defclass spot_msgs::LeaseArray
  :super ros::object
  :slots (_resources ))

(defmethod spot_msgs::LeaseArray
  (:init
   (&key
    ((:resources __resources) ())
    )
   (send-super :init)
   (setq _resources __resources)
   self)
  (:resources
   (&rest __resources)
   (if (keywordp (car __resources))
       (send* _resources __resources)
     (progn
       (if __resources (setq _resources (car __resources)))
       _resources)))
  (:serialization-length
   ()
   (+
    ;; spot_msgs/LeaseResource[] _resources
    (apply #'+ (send-all _resources :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; spot_msgs/LeaseResource[] _resources
     (write-long (length _resources) s)
     (dolist (elem _resources)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; spot_msgs/LeaseResource[] _resources
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _resources (let (r) (dotimes (i n) (push (instance spot_msgs::LeaseResource :init) r)) r))
     (dolist (elem- _resources)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get spot_msgs::LeaseArray :md5sum-) "1e9c3bf77fbef8b5aa6a3bea6c733c8a")
(setf (get spot_msgs::LeaseArray :datatype-) "spot_msgs/LeaseArray")
(setf (get spot_msgs::LeaseArray :definition-)
      "LeaseResource[] resources

================================================================================
MSG: spot_msgs/LeaseResource
string resource
Lease lease
LeaseOwner lease_owner

================================================================================
MSG: spot_msgs/Lease
string resource
string epoch
uint32[] sequence

================================================================================
MSG: spot_msgs/LeaseOwner
string client_name
string user_name

")



(provide :spot_msgs/LeaseArray "1e9c3bf77fbef8b5aa6a3bea6c733c8a")


