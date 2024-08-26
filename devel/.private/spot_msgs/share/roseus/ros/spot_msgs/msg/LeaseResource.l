;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::LeaseResource)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'LeaseResource (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::LEASERESOURCE")
  (make-package "SPOT_MSGS::LEASERESOURCE"))

(in-package "ROS")
;;//! \htmlinclude LeaseResource.msg.html


(defclass spot_msgs::LeaseResource
  :super ros::object
  :slots (_resource _lease _lease_owner ))

(defmethod spot_msgs::LeaseResource
  (:init
   (&key
    ((:resource __resource) "")
    ((:lease __lease) (instance spot_msgs::Lease :init))
    ((:lease_owner __lease_owner) (instance spot_msgs::LeaseOwner :init))
    )
   (send-super :init)
   (setq _resource (string __resource))
   (setq _lease __lease)
   (setq _lease_owner __lease_owner)
   self)
  (:resource
   (&optional __resource)
   (if __resource (setq _resource __resource)) _resource)
  (:lease
   (&rest __lease)
   (if (keywordp (car __lease))
       (send* _lease __lease)
     (progn
       (if __lease (setq _lease (car __lease)))
       _lease)))
  (:lease_owner
   (&rest __lease_owner)
   (if (keywordp (car __lease_owner))
       (send* _lease_owner __lease_owner)
     (progn
       (if __lease_owner (setq _lease_owner (car __lease_owner)))
       _lease_owner)))
  (:serialization-length
   ()
   (+
    ;; string _resource
    4 (length _resource)
    ;; spot_msgs/Lease _lease
    (send _lease :serialization-length)
    ;; spot_msgs/LeaseOwner _lease_owner
    (send _lease_owner :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _resource
       (write-long (length _resource) s) (princ _resource s)
     ;; spot_msgs/Lease _lease
       (send _lease :serialize s)
     ;; spot_msgs/LeaseOwner _lease_owner
       (send _lease_owner :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _resource
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _resource (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; spot_msgs/Lease _lease
     (send _lease :deserialize buf ptr-) (incf ptr- (send _lease :serialization-length))
   ;; spot_msgs/LeaseOwner _lease_owner
     (send _lease_owner :deserialize buf ptr-) (incf ptr- (send _lease_owner :serialization-length))
   ;;
   self)
  )

(setf (get spot_msgs::LeaseResource :md5sum-) "e2b2b151bf21111e26403b0a4feba023")
(setf (get spot_msgs::LeaseResource :datatype-) "spot_msgs/LeaseResource")
(setf (get spot_msgs::LeaseResource :definition-)
      "string resource
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



(provide :spot_msgs/LeaseResource "e2b2b151bf21111e26403b0a4feba023")


