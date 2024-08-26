;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::Lease)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'Lease (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::LEASE")
  (make-package "SPOT_MSGS::LEASE"))

(in-package "ROS")
;;//! \htmlinclude Lease.msg.html


(defclass spot_msgs::Lease
  :super ros::object
  :slots (_resource _epoch _sequence ))

(defmethod spot_msgs::Lease
  (:init
   (&key
    ((:resource __resource) "")
    ((:epoch __epoch) "")
    ((:sequence __sequence) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _resource (string __resource))
   (setq _epoch (string __epoch))
   (setq _sequence __sequence)
   self)
  (:resource
   (&optional __resource)
   (if __resource (setq _resource __resource)) _resource)
  (:epoch
   (&optional __epoch)
   (if __epoch (setq _epoch __epoch)) _epoch)
  (:sequence
   (&optional __sequence)
   (if __sequence (setq _sequence __sequence)) _sequence)
  (:serialization-length
   ()
   (+
    ;; string _resource
    4 (length _resource)
    ;; string _epoch
    4 (length _epoch)
    ;; uint32[] _sequence
    (* 4    (length _sequence)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _resource
       (write-long (length _resource) s) (princ _resource s)
     ;; string _epoch
       (write-long (length _epoch) s) (princ _epoch s)
     ;; uint32[] _sequence
     (write-long (length _sequence) s)
     (dotimes (i (length _sequence))
       (write-long (elt _sequence i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _resource
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _resource (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _epoch
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _epoch (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint32[] _sequence
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sequence (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _sequence i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get spot_msgs::Lease :md5sum-) "268ed4f702e0ce57ac084653ad1ace93")
(setf (get spot_msgs::Lease :datatype-) "spot_msgs/Lease")
(setf (get spot_msgs::Lease :definition-)
      "string resource
string epoch
uint32[] sequence

")



(provide :spot_msgs/Lease "268ed4f702e0ce57ac084653ad1ace93")


