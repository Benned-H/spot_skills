;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::SpotCheck)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'SpotCheck (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::SPOTCHECK")
  (make-package "SPOT_MSGS::SPOTCHECK"))
(unless (find-package "SPOT_MSGS::SPOTCHECKREQUEST")
  (make-package "SPOT_MSGS::SPOTCHECKREQUEST"))
(unless (find-package "SPOT_MSGS::SPOTCHECKRESPONSE")
  (make-package "SPOT_MSGS::SPOTCHECKRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::SpotCheckRequest
  :super ros::object
  :slots (_start _blocking _revert_calibration _feedback_only ))

(defmethod spot_msgs::SpotCheckRequest
  (:init
   (&key
    ((:start __start) nil)
    ((:blocking __blocking) nil)
    ((:revert_calibration __revert_calibration) nil)
    ((:feedback_only __feedback_only) nil)
    )
   (send-super :init)
   (setq _start __start)
   (setq _blocking __blocking)
   (setq _revert_calibration __revert_calibration)
   (setq _feedback_only __feedback_only)
   self)
  (:start
   (&optional (__start :null))
   (if (not (eq __start :null)) (setq _start __start)) _start)
  (:blocking
   (&optional (__blocking :null))
   (if (not (eq __blocking :null)) (setq _blocking __blocking)) _blocking)
  (:revert_calibration
   (&optional (__revert_calibration :null))
   (if (not (eq __revert_calibration :null)) (setq _revert_calibration __revert_calibration)) _revert_calibration)
  (:feedback_only
   (&optional (__feedback_only :null))
   (if (not (eq __feedback_only :null)) (setq _feedback_only __feedback_only)) _feedback_only)
  (:serialization-length
   ()
   (+
    ;; bool _start
    1
    ;; bool _blocking
    1
    ;; bool _revert_calibration
    1
    ;; bool _feedback_only
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _start
       (if _start (write-byte -1 s) (write-byte 0 s))
     ;; bool _blocking
       (if _blocking (write-byte -1 s) (write-byte 0 s))
     ;; bool _revert_calibration
       (if _revert_calibration (write-byte -1 s) (write-byte 0 s))
     ;; bool _feedback_only
       (if _feedback_only (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _start
     (setq _start (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _blocking
     (setq _blocking (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _revert_calibration
     (setq _revert_calibration (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _feedback_only
     (setq _feedback_only (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass spot_msgs::SpotCheckResponse
  :super ros::object
  :slots (_success _message _camera_names _camera_results _load_cell_names _load_cell_results _kinematic_joint_names _kinematic_cal_results _payload_result _leg_names _hip_range_of_motion_results _progress _last_cal_timestamp ))

(defmethod spot_msgs::SpotCheckResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    ((:camera_names __camera_names) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:camera_results __camera_results) ())
    ((:load_cell_names __load_cell_names) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:load_cell_results __load_cell_results) ())
    ((:kinematic_joint_names __kinematic_joint_names) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:kinematic_cal_results __kinematic_cal_results) ())
    ((:payload_result __payload_result) (instance spot_msgs::SpotCheckPayload :init))
    ((:leg_names __leg_names) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:hip_range_of_motion_results __hip_range_of_motion_results) ())
    ((:progress __progress) 0.0)
    ((:last_cal_timestamp __last_cal_timestamp) (instance ros::time :init))
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   (setq _camera_names __camera_names)
   (setq _camera_results __camera_results)
   (setq _load_cell_names __load_cell_names)
   (setq _load_cell_results __load_cell_results)
   (setq _kinematic_joint_names __kinematic_joint_names)
   (setq _kinematic_cal_results __kinematic_cal_results)
   (setq _payload_result __payload_result)
   (setq _leg_names __leg_names)
   (setq _hip_range_of_motion_results __hip_range_of_motion_results)
   (setq _progress (float __progress))
   (setq _last_cal_timestamp __last_cal_timestamp)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:camera_names
   (&optional __camera_names)
   (if __camera_names (setq _camera_names __camera_names)) _camera_names)
  (:camera_results
   (&rest __camera_results)
   (if (keywordp (car __camera_results))
       (send* _camera_results __camera_results)
     (progn
       (if __camera_results (setq _camera_results (car __camera_results)))
       _camera_results)))
  (:load_cell_names
   (&optional __load_cell_names)
   (if __load_cell_names (setq _load_cell_names __load_cell_names)) _load_cell_names)
  (:load_cell_results
   (&rest __load_cell_results)
   (if (keywordp (car __load_cell_results))
       (send* _load_cell_results __load_cell_results)
     (progn
       (if __load_cell_results (setq _load_cell_results (car __load_cell_results)))
       _load_cell_results)))
  (:kinematic_joint_names
   (&optional __kinematic_joint_names)
   (if __kinematic_joint_names (setq _kinematic_joint_names __kinematic_joint_names)) _kinematic_joint_names)
  (:kinematic_cal_results
   (&rest __kinematic_cal_results)
   (if (keywordp (car __kinematic_cal_results))
       (send* _kinematic_cal_results __kinematic_cal_results)
     (progn
       (if __kinematic_cal_results (setq _kinematic_cal_results (car __kinematic_cal_results)))
       _kinematic_cal_results)))
  (:payload_result
   (&rest __payload_result)
   (if (keywordp (car __payload_result))
       (send* _payload_result __payload_result)
     (progn
       (if __payload_result (setq _payload_result (car __payload_result)))
       _payload_result)))
  (:leg_names
   (&optional __leg_names)
   (if __leg_names (setq _leg_names __leg_names)) _leg_names)
  (:hip_range_of_motion_results
   (&rest __hip_range_of_motion_results)
   (if (keywordp (car __hip_range_of_motion_results))
       (send* _hip_range_of_motion_results __hip_range_of_motion_results)
     (progn
       (if __hip_range_of_motion_results (setq _hip_range_of_motion_results (car __hip_range_of_motion_results)))
       _hip_range_of_motion_results)))
  (:progress
   (&optional __progress)
   (if __progress (setq _progress __progress)) _progress)
  (:last_cal_timestamp
   (&optional __last_cal_timestamp)
   (if __last_cal_timestamp (setq _last_cal_timestamp __last_cal_timestamp)) _last_cal_timestamp)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ;; string[] _camera_names
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _camera_names)) 4
    ;; spot_msgs/SpotCheckDepth[] _camera_results
    (apply #'+ (send-all _camera_results :serialization-length)) 4
    ;; string[] _load_cell_names
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _load_cell_names)) 4
    ;; spot_msgs/SpotCheckLoadCell[] _load_cell_results
    (apply #'+ (send-all _load_cell_results :serialization-length)) 4
    ;; string[] _kinematic_joint_names
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _kinematic_joint_names)) 4
    ;; spot_msgs/SpotCheckKinematic[] _kinematic_cal_results
    (apply #'+ (send-all _kinematic_cal_results :serialization-length)) 4
    ;; spot_msgs/SpotCheckPayload _payload_result
    (send _payload_result :serialization-length)
    ;; string[] _leg_names
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _leg_names)) 4
    ;; spot_msgs/SpotCheckHipROM[] _hip_range_of_motion_results
    (apply #'+ (send-all _hip_range_of_motion_results :serialization-length)) 4
    ;; float32 _progress
    4
    ;; time _last_cal_timestamp
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;; string[] _camera_names
     (write-long (length _camera_names) s)
     (dolist (elem _camera_names)
       (write-long (length elem) s) (princ elem s)
       )
     ;; spot_msgs/SpotCheckDepth[] _camera_results
     (write-long (length _camera_results) s)
     (dolist (elem _camera_results)
       (send elem :serialize s)
       )
     ;; string[] _load_cell_names
     (write-long (length _load_cell_names) s)
     (dolist (elem _load_cell_names)
       (write-long (length elem) s) (princ elem s)
       )
     ;; spot_msgs/SpotCheckLoadCell[] _load_cell_results
     (write-long (length _load_cell_results) s)
     (dolist (elem _load_cell_results)
       (send elem :serialize s)
       )
     ;; string[] _kinematic_joint_names
     (write-long (length _kinematic_joint_names) s)
     (dolist (elem _kinematic_joint_names)
       (write-long (length elem) s) (princ elem s)
       )
     ;; spot_msgs/SpotCheckKinematic[] _kinematic_cal_results
     (write-long (length _kinematic_cal_results) s)
     (dolist (elem _kinematic_cal_results)
       (send elem :serialize s)
       )
     ;; spot_msgs/SpotCheckPayload _payload_result
       (send _payload_result :serialize s)
     ;; string[] _leg_names
     (write-long (length _leg_names) s)
     (dolist (elem _leg_names)
       (write-long (length elem) s) (princ elem s)
       )
     ;; spot_msgs/SpotCheckHipROM[] _hip_range_of_motion_results
     (write-long (length _hip_range_of_motion_results) s)
     (dolist (elem _hip_range_of_motion_results)
       (send elem :serialize s)
       )
     ;; float32 _progress
       (sys::poke _progress (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; time _last_cal_timestamp
       (write-long (send _last_cal_timestamp :sec) s) (write-long (send _last_cal_timestamp :nsec) s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string[] _camera_names
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _camera_names (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _camera_names i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; spot_msgs/SpotCheckDepth[] _camera_results
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _camera_results (let (r) (dotimes (i n) (push (instance spot_msgs::SpotCheckDepth :init) r)) r))
     (dolist (elem- _camera_results)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string[] _load_cell_names
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _load_cell_names (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _load_cell_names i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; spot_msgs/SpotCheckLoadCell[] _load_cell_results
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _load_cell_results (let (r) (dotimes (i n) (push (instance spot_msgs::SpotCheckLoadCell :init) r)) r))
     (dolist (elem- _load_cell_results)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string[] _kinematic_joint_names
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kinematic_joint_names (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _kinematic_joint_names i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; spot_msgs/SpotCheckKinematic[] _kinematic_cal_results
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kinematic_cal_results (let (r) (dotimes (i n) (push (instance spot_msgs::SpotCheckKinematic :init) r)) r))
     (dolist (elem- _kinematic_cal_results)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; spot_msgs/SpotCheckPayload _payload_result
     (send _payload_result :deserialize buf ptr-) (incf ptr- (send _payload_result :serialization-length))
   ;; string[] _leg_names
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _leg_names (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _leg_names i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; spot_msgs/SpotCheckHipROM[] _hip_range_of_motion_results
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _hip_range_of_motion_results (let (r) (dotimes (i n) (push (instance spot_msgs::SpotCheckHipROM :init) r)) r))
     (dolist (elem- _hip_range_of_motion_results)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float32 _progress
     (setq _progress (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; time _last_cal_timestamp
     (send _last_cal_timestamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _last_cal_timestamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass spot_msgs::SpotCheck
  :super ros::object
  :slots ())

(setf (get spot_msgs::SpotCheck :md5sum-) "1ec255c808f67543e9f50ba450221b4c")
(setf (get spot_msgs::SpotCheck :datatype-) "spot_msgs/SpotCheck")
(setf (get spot_msgs::SpotCheck :request) spot_msgs::SpotCheckRequest)
(setf (get spot_msgs::SpotCheck :response) spot_msgs::SpotCheckResponse)

(defmethod spot_msgs::SpotCheckRequest
  (:response () (instance spot_msgs::SpotCheckResponse :init)))

(setf (get spot_msgs::SpotCheckRequest :md5sum-) "1ec255c808f67543e9f50ba450221b4c")
(setf (get spot_msgs::SpotCheckRequest :datatype-) "spot_msgs/SpotCheckRequest")
(setf (get spot_msgs::SpotCheckRequest :definition-)
      "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/spot_check
bool start
bool blocking
bool revert_calibration
bool feedback_only
---
bool success
string message

string[] camera_names
spot_msgs/SpotCheckDepth[] camera_results

string[] load_cell_names
spot_msgs/SpotCheckLoadCell[] load_cell_results

string[] kinematic_joint_names
spot_msgs/SpotCheckKinematic[] kinematic_cal_results

spot_msgs/SpotCheckPayload payload_result

string[] leg_names
spot_msgs/SpotCheckHipROM[] hip_range_of_motion_results

float32 progress

time last_cal_timestamp

================================================================================
MSG: spot_msgs/SpotCheckDepth
uint8 STATUS_UNKNOWN = 0     # Unused enum.
uint8 STATUS_OK = 1          # No detected calibration error.
uint8 STATUS_WARNING = 2     # Possible calibration error detected.
uint8 STATUS_ERROR = 3       # Error with robot calibration.

uint8 status
float32 severity_score
================================================================================
MSG: spot_msgs/SpotCheckLoadCell
uint8 ERROR_UNKNOWN = 0              # Unused enum.
uint8 ERROR_NONE = 1                 # No hardware error detected.
uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.

# The loadcell error code
uint8 error
# The current loadcell zero as fraction of full range [0-1]
float32 zero
# The previous loadcell zero as fraction of full range [0-1]
float32 old_zero
================================================================================
MSG: spot_msgs/SpotCheckKinematic
# Errors reflect an issue with robot hardware.
uint8 ERROR_UNKNOWN = 0       # Unused enum.
uint8 ERROR_NONE = 1          # No hardware error detected.
uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.
uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.

# A flag to indicate if results has an error.
uint8 error

# The current offset [rad]
float32 offset
# The previous offset [rad]
float32 old_offset

# Joint calibration health score. range [0-1]
# 0 indicates an unhealthy kinematic joint calibration
# 1 indicates a perfect kinematic joint calibration
# Typically, values greater than 0.8 should be expected.
float32 health_score
================================================================================
MSG: spot_msgs/SpotCheckPayload
# Errors reflect an issue with payload configuration.

# Unused enum.
uint8 ERROR_UNKNOWN = 0
# No error found in the payloads.
uint8 ERROR_NONE = 1
# There is a mass discrepancy between the registered payload and what is estimated.
uint8 ERROR_MASS_DISCREPANCY = 2

# A flag to indicate if configuration has an error.
uint8 error

# Indicates how much extra payload (in kg) we think the robot has
# Positive indicates robot has more payload than it is configured.
# Negative indicates robot has less payload than it is configured.
float32 extra_payload
================================================================================
MSG: spot_msgs/SpotCheckHipROM
# Errors reflect an issue with hip range of motion
uint8 ERROR_UNKNOWN = 0
uint8 ERROR_NONE = 1
uint8 ERROR_OBSTRUCTED = 2

uint8 error

# The measured angles (radians) of the HX and HY joints where the obstruction was detected
float32[] hx
")

(setf (get spot_msgs::SpotCheckResponse :md5sum-) "1ec255c808f67543e9f50ba450221b4c")
(setf (get spot_msgs::SpotCheckResponse :datatype-) "spot_msgs/SpotCheckResponse")
(setf (get spot_msgs::SpotCheckResponse :definition-)
      "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/spot_check
bool start
bool blocking
bool revert_calibration
bool feedback_only
---
bool success
string message

string[] camera_names
spot_msgs/SpotCheckDepth[] camera_results

string[] load_cell_names
spot_msgs/SpotCheckLoadCell[] load_cell_results

string[] kinematic_joint_names
spot_msgs/SpotCheckKinematic[] kinematic_cal_results

spot_msgs/SpotCheckPayload payload_result

string[] leg_names
spot_msgs/SpotCheckHipROM[] hip_range_of_motion_results

float32 progress

time last_cal_timestamp

================================================================================
MSG: spot_msgs/SpotCheckDepth
uint8 STATUS_UNKNOWN = 0     # Unused enum.
uint8 STATUS_OK = 1          # No detected calibration error.
uint8 STATUS_WARNING = 2     # Possible calibration error detected.
uint8 STATUS_ERROR = 3       # Error with robot calibration.

uint8 status
float32 severity_score
================================================================================
MSG: spot_msgs/SpotCheckLoadCell
uint8 ERROR_UNKNOWN = 0              # Unused enum.
uint8 ERROR_NONE = 1                 # No hardware error detected.
uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.

# The loadcell error code
uint8 error
# The current loadcell zero as fraction of full range [0-1]
float32 zero
# The previous loadcell zero as fraction of full range [0-1]
float32 old_zero
================================================================================
MSG: spot_msgs/SpotCheckKinematic
# Errors reflect an issue with robot hardware.
uint8 ERROR_UNKNOWN = 0       # Unused enum.
uint8 ERROR_NONE = 1          # No hardware error detected.
uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.
uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.

# A flag to indicate if results has an error.
uint8 error

# The current offset [rad]
float32 offset
# The previous offset [rad]
float32 old_offset

# Joint calibration health score. range [0-1]
# 0 indicates an unhealthy kinematic joint calibration
# 1 indicates a perfect kinematic joint calibration
# Typically, values greater than 0.8 should be expected.
float32 health_score
================================================================================
MSG: spot_msgs/SpotCheckPayload
# Errors reflect an issue with payload configuration.

# Unused enum.
uint8 ERROR_UNKNOWN = 0
# No error found in the payloads.
uint8 ERROR_NONE = 1
# There is a mass discrepancy between the registered payload and what is estimated.
uint8 ERROR_MASS_DISCREPANCY = 2

# A flag to indicate if configuration has an error.
uint8 error

# Indicates how much extra payload (in kg) we think the robot has
# Positive indicates robot has more payload than it is configured.
# Negative indicates robot has less payload than it is configured.
float32 extra_payload
================================================================================
MSG: spot_msgs/SpotCheckHipROM
# Errors reflect an issue with hip range of motion
uint8 ERROR_UNKNOWN = 0
uint8 ERROR_NONE = 1
uint8 ERROR_OBSTRUCTED = 2

uint8 error

# The measured angles (radians) of the HX and HY joints where the obstruction was detected
float32[] hx
")



(provide :spot_msgs/SpotCheck "1ec255c808f67543e9f50ba450221b4c")


