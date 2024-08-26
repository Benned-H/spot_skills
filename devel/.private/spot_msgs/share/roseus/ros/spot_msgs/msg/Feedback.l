;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::Feedback)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'Feedback (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::FEEDBACK")
  (make-package "SPOT_MSGS::FEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude Feedback.msg.html


(defclass spot_msgs::Feedback
  :super ros::object
  :slots (_standing _sitting _moving _serial_number _species _version _nickname _computer_serial_number ))

(defmethod spot_msgs::Feedback
  (:init
   (&key
    ((:standing __standing) nil)
    ((:sitting __sitting) nil)
    ((:moving __moving) nil)
    ((:serial_number __serial_number) "")
    ((:species __species) "")
    ((:version __version) "")
    ((:nickname __nickname) "")
    ((:computer_serial_number __computer_serial_number) "")
    )
   (send-super :init)
   (setq _standing __standing)
   (setq _sitting __sitting)
   (setq _moving __moving)
   (setq _serial_number (string __serial_number))
   (setq _species (string __species))
   (setq _version (string __version))
   (setq _nickname (string __nickname))
   (setq _computer_serial_number (string __computer_serial_number))
   self)
  (:standing
   (&optional (__standing :null))
   (if (not (eq __standing :null)) (setq _standing __standing)) _standing)
  (:sitting
   (&optional (__sitting :null))
   (if (not (eq __sitting :null)) (setq _sitting __sitting)) _sitting)
  (:moving
   (&optional (__moving :null))
   (if (not (eq __moving :null)) (setq _moving __moving)) _moving)
  (:serial_number
   (&optional __serial_number)
   (if __serial_number (setq _serial_number __serial_number)) _serial_number)
  (:species
   (&optional __species)
   (if __species (setq _species __species)) _species)
  (:version
   (&optional __version)
   (if __version (setq _version __version)) _version)
  (:nickname
   (&optional __nickname)
   (if __nickname (setq _nickname __nickname)) _nickname)
  (:computer_serial_number
   (&optional __computer_serial_number)
   (if __computer_serial_number (setq _computer_serial_number __computer_serial_number)) _computer_serial_number)
  (:serialization-length
   ()
   (+
    ;; bool _standing
    1
    ;; bool _sitting
    1
    ;; bool _moving
    1
    ;; string _serial_number
    4 (length _serial_number)
    ;; string _species
    4 (length _species)
    ;; string _version
    4 (length _version)
    ;; string _nickname
    4 (length _nickname)
    ;; string _computer_serial_number
    4 (length _computer_serial_number)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _standing
       (if _standing (write-byte -1 s) (write-byte 0 s))
     ;; bool _sitting
       (if _sitting (write-byte -1 s) (write-byte 0 s))
     ;; bool _moving
       (if _moving (write-byte -1 s) (write-byte 0 s))
     ;; string _serial_number
       (write-long (length _serial_number) s) (princ _serial_number s)
     ;; string _species
       (write-long (length _species) s) (princ _species s)
     ;; string _version
       (write-long (length _version) s) (princ _version s)
     ;; string _nickname
       (write-long (length _nickname) s) (princ _nickname s)
     ;; string _computer_serial_number
       (write-long (length _computer_serial_number) s) (princ _computer_serial_number s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _standing
     (setq _standing (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _sitting
     (setq _sitting (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _moving
     (setq _moving (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _serial_number
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _serial_number (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _species
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _species (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _version
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _version (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _nickname
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _nickname (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _computer_serial_number
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _computer_serial_number (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::Feedback :md5sum-) "16779e4df8e3f77c9ee8c1811559bd21")
(setf (get spot_msgs::Feedback :datatype-) "spot_msgs/Feedback")
(setf (get spot_msgs::Feedback :definition-)
      "bool standing
bool sitting
bool moving

string serial_number
string species
string version
string nickname
string computer_serial_number

")



(provide :spot_msgs/Feedback "16779e4df8e3f77c9ee8c1811559bd21")


