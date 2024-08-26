;; Auto-generated. Do not edit!


(when (boundp 'spot_cam::PlaySound)
  (if (not (find-package "SPOT_CAM"))
    (make-package "SPOT_CAM"))
  (shadow 'PlaySound (find-package "SPOT_CAM")))
(unless (find-package "SPOT_CAM::PLAYSOUND")
  (make-package "SPOT_CAM::PLAYSOUND"))
(unless (find-package "SPOT_CAM::PLAYSOUNDREQUEST")
  (make-package "SPOT_CAM::PLAYSOUNDREQUEST"))
(unless (find-package "SPOT_CAM::PLAYSOUNDRESPONSE")
  (make-package "SPOT_CAM::PLAYSOUNDRESPONSE"))

(in-package "ROS")





(defclass spot_cam::PlaySoundRequest
  :super ros::object
  :slots (_name _gain ))

(defmethod spot_cam::PlaySoundRequest
  (:init
   (&key
    ((:name __name) "")
    ((:gain __gain) 0.0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _gain (float __gain))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:gain
   (&optional __gain)
   (if __gain (setq _gain __gain)) _gain)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; float32 _gain
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; float32 _gain
       (sys::poke _gain (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _gain
     (setq _gain (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_cam::PlaySoundResponse
  :super ros::object
  :slots (_success _message ))

(defmethod spot_cam::PlaySoundResponse
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

(defclass spot_cam::PlaySound
  :super ros::object
  :slots ())

(setf (get spot_cam::PlaySound :md5sum-) "2fa7527a0fde73dd5206e9498d885ad7")
(setf (get spot_cam::PlaySound :datatype-) "spot_cam/PlaySound")
(setf (get spot_cam::PlaySound :request) spot_cam::PlaySoundRequest)
(setf (get spot_cam::PlaySound :response) spot_cam::PlaySoundResponse)

(defmethod spot_cam::PlaySoundRequest
  (:response () (instance spot_cam::PlaySoundResponse :init)))

(setf (get spot_cam::PlaySoundRequest :md5sum-) "2fa7527a0fde73dd5206e9498d885ad7")
(setf (get spot_cam::PlaySoundRequest :datatype-) "spot_cam/PlaySoundRequest")
(setf (get spot_cam::PlaySoundRequest :definition-)
      "# Name of the sound to play
string name
# Multiplier on the sound volume
float32 gain
---
bool success
string message
")

(setf (get spot_cam::PlaySoundResponse :md5sum-) "2fa7527a0fde73dd5206e9498d885ad7")
(setf (get spot_cam::PlaySoundResponse :datatype-) "spot_cam/PlaySoundResponse")
(setf (get spot_cam::PlaySoundResponse :definition-)
      "# Name of the sound to play
string name
# Multiplier on the sound volume
float32 gain
---
bool success
string message
")



(provide :spot_cam/PlaySound "2fa7527a0fde73dd5206e9498d885ad7")


