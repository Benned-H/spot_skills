;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::WiFiState)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'WiFiState (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::WIFISTATE")
  (make-package "SPOT_MSGS::WIFISTATE"))

(in-package "ROS")
;;//! \htmlinclude WiFiState.msg.html


(intern "*MODE_UNKNOWN*" (find-package "SPOT_MSGS::WIFISTATE"))
(shadow '*MODE_UNKNOWN* (find-package "SPOT_MSGS::WIFISTATE"))
(defconstant spot_msgs::WiFiState::*MODE_UNKNOWN* 0)
(intern "*MODE_ACCESS_POINT*" (find-package "SPOT_MSGS::WIFISTATE"))
(shadow '*MODE_ACCESS_POINT* (find-package "SPOT_MSGS::WIFISTATE"))
(defconstant spot_msgs::WiFiState::*MODE_ACCESS_POINT* 1)
(intern "*MODE_CLIENT*" (find-package "SPOT_MSGS::WIFISTATE"))
(shadow '*MODE_CLIENT* (find-package "SPOT_MSGS::WIFISTATE"))
(defconstant spot_msgs::WiFiState::*MODE_CLIENT* 2)

(defun spot_msgs::WiFiState-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::WiFiState::*MODE_UNKNOWN*)
        ((= const 1) 'spot_msgs::WiFiState::*MODE_ACCESS_POINT*)
        ((= const 2) 'spot_msgs::WiFiState::*MODE_CLIENT*)
        (t nil)))

(defclass spot_msgs::WiFiState
  :super ros::object
  :slots (_current_mode _essid ))

(defmethod spot_msgs::WiFiState
  (:init
   (&key
    ((:current_mode __current_mode) 0)
    ((:essid __essid) "")
    )
   (send-super :init)
   (setq _current_mode (round __current_mode))
   (setq _essid (string __essid))
   self)
  (:current_mode
   (&optional __current_mode)
   (if __current_mode (setq _current_mode __current_mode)) _current_mode)
  (:essid
   (&optional __essid)
   (if __essid (setq _essid __essid)) _essid)
  (:serialization-length
   ()
   (+
    ;; uint8 _current_mode
    1
    ;; string _essid
    4 (length _essid)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _current_mode
       (write-byte _current_mode s)
     ;; string _essid
       (write-long (length _essid) s) (princ _essid s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _current_mode
     (setq _current_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _essid
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _essid (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get spot_msgs::WiFiState :md5sum-) "ba66be2de3368e3a5a22e1ccf928954a")
(setf (get spot_msgs::WiFiState :datatype-) "spot_msgs/WiFiState")
(setf (get spot_msgs::WiFiState :definition-)
      "# Mode
uint8 MODE_UNKNOWN = 0
uint8 MODE_ACCESS_POINT = 1
uint8 MODE_CLIENT = 2

uint8 current_mode
string essid

")



(provide :spot_msgs/WiFiState "ba66be2de3368e3a5a22e1ccf928954a")


