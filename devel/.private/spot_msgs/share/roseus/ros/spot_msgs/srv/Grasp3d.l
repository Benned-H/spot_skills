;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::Grasp3d)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'Grasp3d (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::GRASP3D")
  (make-package "SPOT_MSGS::GRASP3D"))
(unless (find-package "SPOT_MSGS::GRASP3DREQUEST")
  (make-package "SPOT_MSGS::GRASP3DREQUEST"))
(unless (find-package "SPOT_MSGS::GRASP3DRESPONSE")
  (make-package "SPOT_MSGS::GRASP3DRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::Grasp3dRequest
  :super ros::object
  :slots (_frame_name _object_rt_frame ))

(defmethod spot_msgs::Grasp3dRequest
  (:init
   (&key
    ((:frame_name __frame_name) "")
    ((:object_rt_frame __object_rt_frame) (make-array 3 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _frame_name (string __frame_name))
   (setq _object_rt_frame __object_rt_frame)
   self)
  (:frame_name
   (&optional __frame_name)
   (if __frame_name (setq _frame_name __frame_name)) _frame_name)
  (:object_rt_frame
   (&optional __object_rt_frame)
   (if __object_rt_frame (setq _object_rt_frame __object_rt_frame)) _object_rt_frame)
  (:serialization-length
   ()
   (+
    ;; string _frame_name
    4 (length _frame_name)
    ;; float64[3] _object_rt_frame
    (* 8    3)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _frame_name
       (write-long (length _frame_name) s) (princ _frame_name s)
     ;; float64[3] _object_rt_frame
     (dotimes (i 3)
       (sys::poke (elt _object_rt_frame i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _frame_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64[3] _object_rt_frame
   (dotimes (i (length _object_rt_frame))
     (setf (elt _object_rt_frame i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(defclass spot_msgs::Grasp3dResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_msgs::Grasp3dResponse
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

(defclass spot_msgs::Grasp3d
  :super ros::object
  :slots ())

(setf (get spot_msgs::Grasp3d :md5sum-) "7cdad498436e31571e25a54239d53a58")
(setf (get spot_msgs::Grasp3d :datatype-) "spot_msgs/Grasp3d")
(setf (get spot_msgs::Grasp3d :request) spot_msgs::Grasp3dRequest)
(setf (get spot_msgs::Grasp3d :response) spot_msgs::Grasp3dResponse)

(defmethod spot_msgs::Grasp3dRequest
  (:response () (instance spot_msgs::Grasp3dResponse :init)))

(setf (get spot_msgs::Grasp3dRequest :md5sum-) "7cdad498436e31571e25a54239d53a58")
(setf (get spot_msgs::Grasp3dRequest :datatype-) "spot_msgs/Grasp3dRequest")
(setf (get spot_msgs::Grasp3dRequest :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#pickobject
string frame_name # name of the tf frame
float64[3] object_rt_frame # x,y,z of the object in the frame named above
---
bool success
string message
")

(setf (get spot_msgs::Grasp3dResponse :md5sum-) "7cdad498436e31571e25a54239d53a58")
(setf (get spot_msgs::Grasp3dResponse :datatype-) "spot_msgs/Grasp3dResponse")
(setf (get spot_msgs::Grasp3dResponse :definition-)
      "# https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#pickobject
string frame_name # name of the tf frame
float64[3] object_rt_frame # x,y,z of the object in the frame named above
---
bool success
string message
")



(provide :spot_msgs/Grasp3d "7cdad498436e31571e25a54239d53a58")


