;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::LoadSound)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'LoadSound (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::LOADSOUND")
  (make-package "SPOT_CAM::LOADSOUND"))
(unless (find-package "SPOT_CAM::LOADSOUNDREQUEST")
  (make-package "SPOT_CAM::LOADSOUNDREQUEST"))
(unless (find-package "SPOT_CAM::LOADSOUNDRESPONSE")
  (make-package "SPOT_CAM::LOADSOUNDRESPONSE"))

(in-package "ROS")





(defclass spot_cam::LoadSoundRequest
  :super ros::object
  :slots (_name _wav_path ))

(defmethod spot_cam::LoadSoundRequest
  (:init
   (&key
    ((:name __name) "")
    ((:wav_path __wav_path) "")
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _wav_path (string __wav_path))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:wav_path
   (&optional __wav_path)
   (if __wav_path (setq _wav_path __wav_path)) _wav_path)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; string _wav_path
    4 (length _wav_path)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; string _wav_path
       (write-long (length _wav_path) s) (princ _wav_path s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _wav_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _wav_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_cam::LoadSoundResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::LoadSoundResponse
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

(defclass spot_cam::LoadSound
  :super ros::object
  :slots ())

(setf (get spot_cam::LoadSound :md5sum-) "0a42f973c61b7597fb7a93f3219d3bc0")
(setf (get spot_cam::LoadSound :datatype-) "spot_cam/LoadSound")
(setf (get spot_cam::LoadSound :request) spot_cam::LoadSoundRequest)
(setf (get spot_cam::LoadSound :response) spot_cam::LoadSoundResponse)

(defmethod spot_cam::LoadSoundRequest
  (:response () (instance spot_cam::LoadSoundResponse :init)))

(setf (get spot_cam::LoadSoundRequest :md5sum-) "0a42f973c61b7597fb7a93f3219d3bc0")
(setf (get spot_cam::LoadSoundRequest :datatype-) "spot_cam/LoadSoundRequest")
(setf (get spot_cam::LoadSoundRequest :definition-)
      "# Name to use for this sound
string name
# Path to the wav file to load onto the device
string wav_path
---
bool success
string message
")

(setf (get spot_cam::LoadSoundResponse :md5sum-) "0a42f973c61b7597fb7a93f3219d3bc0")
(setf (get spot_cam::LoadSoundResponse :datatype-) "spot_cam/LoadSoundResponse")
(setf (get spot_cam::LoadSoundResponse :definition-)
      "# Name to use for this sound
string name
# Path to the wav file to load onto the device
string wav_path
---
bool success
string message
")



(provide :spot_cam/LoadSound "0a42f973c61b7597fb7a93f3219d3bc0")


