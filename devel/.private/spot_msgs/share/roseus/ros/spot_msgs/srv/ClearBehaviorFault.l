;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::ClearBehaviorFault)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'ClearBehaviorFault (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::CLEARBEHAVIORFAULT")
  (make-package "SPOT_MSGS::CLEARBEHAVIORFAULT"))
(unless (find-package "SPOT_MSGS::CLEARBEHAVIORFAULTREQUEST")
  (make-package "SPOT_MSGS::CLEARBEHAVIORFAULTREQUEST"))
(unless (find-package "SPOT_MSGS::CLEARBEHAVIORFAULTRESPONSE")
  (make-package "SPOT_MSGS::CLEARBEHAVIORFAULTRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::ClearBehaviorFaultRequest
  :super ros::object
  :slots (_id ))

(defmethod spot_msgs::ClearBehaviorFaultRequest
  (:init
   (&key
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _id (round __id))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; uint32 _id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _id
       (write-long _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_msgs::ClearBehaviorFaultResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::ClearBehaviorFaultResponse
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

(defclass spot_msgs::ClearBehaviorFault
  :super ros::object
  :slots ())

(setf (get spot_msgs::ClearBehaviorFault :md5sum-) "7cc61c4cb728bc0f5321bac4af610a6e")
(setf (get spot_msgs::ClearBehaviorFault :datatype-) "spot_msgs/ClearBehaviorFault")
(setf (get spot_msgs::ClearBehaviorFault :request) spot_msgs::ClearBehaviorFaultRequest)
(setf (get spot_msgs::ClearBehaviorFault :response) spot_msgs::ClearBehaviorFaultResponse)

(defmethod spot_msgs::ClearBehaviorFaultRequest
  (:response () (instance spot_msgs::ClearBehaviorFaultResponse :init)))

(setf (get spot_msgs::ClearBehaviorFaultRequest :md5sum-) "7cc61c4cb728bc0f5321bac4af610a6e")
(setf (get spot_msgs::ClearBehaviorFaultRequest :datatype-) "spot_msgs/ClearBehaviorFaultRequest")
(setf (get spot_msgs::ClearBehaviorFaultRequest :definition-)
      "uint32 id
---
bool success
string message

")

(setf (get spot_msgs::ClearBehaviorFaultResponse :md5sum-) "7cc61c4cb728bc0f5321bac4af610a6e")
(setf (get spot_msgs::ClearBehaviorFaultResponse :datatype-) "spot_msgs/ClearBehaviorFaultResponse")
(setf (get spot_msgs::ClearBehaviorFaultResponse :definition-)
      "uint32 id
---
bool success
string message

")



(provide :spot_msgs/ClearBehaviorFault "7cc61c4cb728bc0f5321bac4af610a6e")


