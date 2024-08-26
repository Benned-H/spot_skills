; Auto-generated. Do not edit!


(cl:in-package spot_msgs-srv)


;//! \htmlinclude SpotCheck-request.msg.html

(cl:defclass <SpotCheck-request> (roslisp-msg-protocol:ros-message)
  ((start
    :reader start
    :initarg :start
    :type cl:boolean
    :initform cl:nil)
   (blocking
    :reader blocking
    :initarg :blocking
    :type cl:boolean
    :initform cl:nil)
   (revert_calibration
    :reader revert_calibration
    :initarg :revert_calibration
    :type cl:boolean
    :initform cl:nil)
   (feedback_only
    :reader feedback_only
    :initarg :feedback_only
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SpotCheck-request (<SpotCheck-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheck-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheck-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SpotCheck-request> is deprecated: use spot_msgs-srv:SpotCheck-request instead.")))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <SpotCheck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:start-val is deprecated.  Use spot_msgs-srv:start instead.")
  (start m))

(cl:ensure-generic-function 'blocking-val :lambda-list '(m))
(cl:defmethod blocking-val ((m <SpotCheck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:blocking-val is deprecated.  Use spot_msgs-srv:blocking instead.")
  (blocking m))

(cl:ensure-generic-function 'revert_calibration-val :lambda-list '(m))
(cl:defmethod revert_calibration-val ((m <SpotCheck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:revert_calibration-val is deprecated.  Use spot_msgs-srv:revert_calibration instead.")
  (revert_calibration m))

(cl:ensure-generic-function 'feedback_only-val :lambda-list '(m))
(cl:defmethod feedback_only-val ((m <SpotCheck-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:feedback_only-val is deprecated.  Use spot_msgs-srv:feedback_only instead.")
  (feedback_only m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheck-request>) ostream)
  "Serializes a message object of type '<SpotCheck-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'start) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'blocking) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'revert_calibration) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'feedback_only) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheck-request>) istream)
  "Deserializes a message object of type '<SpotCheck-request>"
    (cl:setf (cl:slot-value msg 'start) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'blocking) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'revert_calibration) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'feedback_only) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheck-request>)))
  "Returns string type for a service object of type '<SpotCheck-request>"
  "spot_msgs/SpotCheckRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheck-request)))
  "Returns string type for a service object of type 'SpotCheck-request"
  "spot_msgs/SpotCheckRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheck-request>)))
  "Returns md5sum for a message object of type '<SpotCheck-request>"
  "1ec255c808f67543e9f50ba450221b4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheck-request)))
  "Returns md5sum for a message object of type 'SpotCheck-request"
  "1ec255c808f67543e9f50ba450221b4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheck-request>)))
  "Returns full string definition for message of type '<SpotCheck-request>"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/spot_check~%bool start~%bool blocking~%bool revert_calibration~%bool feedback_only~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheck-request)))
  "Returns full string definition for message of type 'SpotCheck-request"
  (cl:format cl:nil "# See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/spot_check~%bool start~%bool blocking~%bool revert_calibration~%bool feedback_only~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheck-request>))
  (cl:+ 0
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheck-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheck-request
    (cl:cons ':start (start msg))
    (cl:cons ':blocking (blocking msg))
    (cl:cons ':revert_calibration (revert_calibration msg))
    (cl:cons ':feedback_only (feedback_only msg))
))
;//! \htmlinclude SpotCheck-response.msg.html

(cl:defclass <SpotCheck-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform "")
   (camera_names
    :reader camera_names
    :initarg :camera_names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (camera_results
    :reader camera_results
    :initarg :camera_results
    :type (cl:vector spot_msgs-msg:SpotCheckDepth)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SpotCheckDepth :initial-element (cl:make-instance 'spot_msgs-msg:SpotCheckDepth)))
   (load_cell_names
    :reader load_cell_names
    :initarg :load_cell_names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (load_cell_results
    :reader load_cell_results
    :initarg :load_cell_results
    :type (cl:vector spot_msgs-msg:SpotCheckLoadCell)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SpotCheckLoadCell :initial-element (cl:make-instance 'spot_msgs-msg:SpotCheckLoadCell)))
   (kinematic_joint_names
    :reader kinematic_joint_names
    :initarg :kinematic_joint_names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (kinematic_cal_results
    :reader kinematic_cal_results
    :initarg :kinematic_cal_results
    :type (cl:vector spot_msgs-msg:SpotCheckKinematic)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SpotCheckKinematic :initial-element (cl:make-instance 'spot_msgs-msg:SpotCheckKinematic)))
   (payload_result
    :reader payload_result
    :initarg :payload_result
    :type spot_msgs-msg:SpotCheckPayload
    :initform (cl:make-instance 'spot_msgs-msg:SpotCheckPayload))
   (leg_names
    :reader leg_names
    :initarg :leg_names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (hip_range_of_motion_results
    :reader hip_range_of_motion_results
    :initarg :hip_range_of_motion_results
    :type (cl:vector spot_msgs-msg:SpotCheckHipROM)
   :initform (cl:make-array 0 :element-type 'spot_msgs-msg:SpotCheckHipROM :initial-element (cl:make-instance 'spot_msgs-msg:SpotCheckHipROM)))
   (progress
    :reader progress
    :initarg :progress
    :type cl:float
    :initform 0.0)
   (last_cal_timestamp
    :reader last_cal_timestamp
    :initarg :last_cal_timestamp
    :type cl:real
    :initform 0))
)

(cl:defclass SpotCheck-response (<SpotCheck-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SpotCheck-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SpotCheck-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name spot_msgs-srv:<SpotCheck-response> is deprecated: use spot_msgs-srv:SpotCheck-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:success-val is deprecated.  Use spot_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:message-val is deprecated.  Use spot_msgs-srv:message instead.")
  (message m))

(cl:ensure-generic-function 'camera_names-val :lambda-list '(m))
(cl:defmethod camera_names-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:camera_names-val is deprecated.  Use spot_msgs-srv:camera_names instead.")
  (camera_names m))

(cl:ensure-generic-function 'camera_results-val :lambda-list '(m))
(cl:defmethod camera_results-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:camera_results-val is deprecated.  Use spot_msgs-srv:camera_results instead.")
  (camera_results m))

(cl:ensure-generic-function 'load_cell_names-val :lambda-list '(m))
(cl:defmethod load_cell_names-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:load_cell_names-val is deprecated.  Use spot_msgs-srv:load_cell_names instead.")
  (load_cell_names m))

(cl:ensure-generic-function 'load_cell_results-val :lambda-list '(m))
(cl:defmethod load_cell_results-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:load_cell_results-val is deprecated.  Use spot_msgs-srv:load_cell_results instead.")
  (load_cell_results m))

(cl:ensure-generic-function 'kinematic_joint_names-val :lambda-list '(m))
(cl:defmethod kinematic_joint_names-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:kinematic_joint_names-val is deprecated.  Use spot_msgs-srv:kinematic_joint_names instead.")
  (kinematic_joint_names m))

(cl:ensure-generic-function 'kinematic_cal_results-val :lambda-list '(m))
(cl:defmethod kinematic_cal_results-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:kinematic_cal_results-val is deprecated.  Use spot_msgs-srv:kinematic_cal_results instead.")
  (kinematic_cal_results m))

(cl:ensure-generic-function 'payload_result-val :lambda-list '(m))
(cl:defmethod payload_result-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:payload_result-val is deprecated.  Use spot_msgs-srv:payload_result instead.")
  (payload_result m))

(cl:ensure-generic-function 'leg_names-val :lambda-list '(m))
(cl:defmethod leg_names-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:leg_names-val is deprecated.  Use spot_msgs-srv:leg_names instead.")
  (leg_names m))

(cl:ensure-generic-function 'hip_range_of_motion_results-val :lambda-list '(m))
(cl:defmethod hip_range_of_motion_results-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:hip_range_of_motion_results-val is deprecated.  Use spot_msgs-srv:hip_range_of_motion_results instead.")
  (hip_range_of_motion_results m))

(cl:ensure-generic-function 'progress-val :lambda-list '(m))
(cl:defmethod progress-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:progress-val is deprecated.  Use spot_msgs-srv:progress instead.")
  (progress m))

(cl:ensure-generic-function 'last_cal_timestamp-val :lambda-list '(m))
(cl:defmethod last_cal_timestamp-val ((m <SpotCheck-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader spot_msgs-srv:last_cal_timestamp-val is deprecated.  Use spot_msgs-srv:last_cal_timestamp instead.")
  (last_cal_timestamp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SpotCheck-response>) ostream)
  "Serializes a message object of type '<SpotCheck-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'camera_names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'camera_names))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'camera_results))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'camera_results))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'load_cell_names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'load_cell_names))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'load_cell_results))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'load_cell_results))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'kinematic_joint_names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'kinematic_joint_names))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'kinematic_cal_results))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'kinematic_cal_results))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'payload_result) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'leg_names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'leg_names))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'hip_range_of_motion_results))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'hip_range_of_motion_results))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'progress))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'last_cal_timestamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'last_cal_timestamp) (cl:floor (cl:slot-value msg 'last_cal_timestamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SpotCheck-response>) istream)
  "Deserializes a message object of type '<SpotCheck-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'camera_names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'camera_names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'camera_results) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'camera_results)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SpotCheckDepth))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'load_cell_names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'load_cell_names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'load_cell_results) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'load_cell_results)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SpotCheckLoadCell))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'kinematic_joint_names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'kinematic_joint_names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'kinematic_cal_results) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'kinematic_cal_results)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SpotCheckKinematic))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'payload_result) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'leg_names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'leg_names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'hip_range_of_motion_results) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'hip_range_of_motion_results)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'spot_msgs-msg:SpotCheckHipROM))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'progress) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'last_cal_timestamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SpotCheck-response>)))
  "Returns string type for a service object of type '<SpotCheck-response>"
  "spot_msgs/SpotCheckResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheck-response)))
  "Returns string type for a service object of type 'SpotCheck-response"
  "spot_msgs/SpotCheckResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SpotCheck-response>)))
  "Returns md5sum for a message object of type '<SpotCheck-response>"
  "1ec255c808f67543e9f50ba450221b4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SpotCheck-response)))
  "Returns md5sum for a message object of type 'SpotCheck-response"
  "1ec255c808f67543e9f50ba450221b4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SpotCheck-response>)))
  "Returns full string definition for message of type '<SpotCheck-response>"
  (cl:format cl:nil "bool success~%string message~%~%string[] camera_names~%spot_msgs/SpotCheckDepth[] camera_results~%~%string[] load_cell_names~%spot_msgs/SpotCheckLoadCell[] load_cell_results~%~%string[] kinematic_joint_names~%spot_msgs/SpotCheckKinematic[] kinematic_cal_results~%~%spot_msgs/SpotCheckPayload payload_result~%~%string[] leg_names~%spot_msgs/SpotCheckHipROM[] hip_range_of_motion_results~%~%float32 progress~%~%time last_cal_timestamp~%~%================================================================================~%MSG: spot_msgs/SpotCheckDepth~%uint8 STATUS_UNKNOWN = 0     # Unused enum.~%uint8 STATUS_OK = 1          # No detected calibration error.~%uint8 STATUS_WARNING = 2     # Possible calibration error detected.~%uint8 STATUS_ERROR = 3       # Error with robot calibration.~%~%uint8 status~%float32 severity_score~%================================================================================~%MSG: spot_msgs/SpotCheckLoadCell~%uint8 ERROR_UNKNOWN = 0              # Unused enum.~%uint8 ERROR_NONE = 1                 # No hardware error detected.~%uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.~%~%# The loadcell error code~%uint8 error~%# The current loadcell zero as fraction of full range [0-1]~%float32 zero~%# The previous loadcell zero as fraction of full range [0-1]~%float32 old_zero~%================================================================================~%MSG: spot_msgs/SpotCheckKinematic~%# Errors reflect an issue with robot hardware.~%uint8 ERROR_UNKNOWN = 0       # Unused enum.~%uint8 ERROR_NONE = 1          # No hardware error detected.~%uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.~%uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.~%~%# A flag to indicate if results has an error.~%uint8 error~%~%# The current offset [rad]~%float32 offset~%# The previous offset [rad]~%float32 old_offset~%~%# Joint calibration health score. range [0-1]~%# 0 indicates an unhealthy kinematic joint calibration~%# 1 indicates a perfect kinematic joint calibration~%# Typically, values greater than 0.8 should be expected.~%float32 health_score~%================================================================================~%MSG: spot_msgs/SpotCheckPayload~%# Errors reflect an issue with payload configuration.~%~%# Unused enum.~%uint8 ERROR_UNKNOWN = 0~%# No error found in the payloads.~%uint8 ERROR_NONE = 1~%# There is a mass discrepancy between the registered payload and what is estimated.~%uint8 ERROR_MASS_DISCREPANCY = 2~%~%# A flag to indicate if configuration has an error.~%uint8 error~%~%# Indicates how much extra payload (in kg) we think the robot has~%# Positive indicates robot has more payload than it is configured.~%# Negative indicates robot has less payload than it is configured.~%float32 extra_payload~%================================================================================~%MSG: spot_msgs/SpotCheckHipROM~%# Errors reflect an issue with hip range of motion~%uint8 ERROR_UNKNOWN = 0~%uint8 ERROR_NONE = 1~%uint8 ERROR_OBSTRUCTED = 2~%~%uint8 error~%~%# The measured angles (radians) of the HX and HY joints where the obstruction was detected~%float32[] hx~%float32[] hy~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SpotCheck-response)))
  "Returns full string definition for message of type 'SpotCheck-response"
  (cl:format cl:nil "bool success~%string message~%~%string[] camera_names~%spot_msgs/SpotCheckDepth[] camera_results~%~%string[] load_cell_names~%spot_msgs/SpotCheckLoadCell[] load_cell_results~%~%string[] kinematic_joint_names~%spot_msgs/SpotCheckKinematic[] kinematic_cal_results~%~%spot_msgs/SpotCheckPayload payload_result~%~%string[] leg_names~%spot_msgs/SpotCheckHipROM[] hip_range_of_motion_results~%~%float32 progress~%~%time last_cal_timestamp~%~%================================================================================~%MSG: spot_msgs/SpotCheckDepth~%uint8 STATUS_UNKNOWN = 0     # Unused enum.~%uint8 STATUS_OK = 1          # No detected calibration error.~%uint8 STATUS_WARNING = 2     # Possible calibration error detected.~%uint8 STATUS_ERROR = 3       # Error with robot calibration.~%~%uint8 status~%float32 severity_score~%================================================================================~%MSG: spot_msgs/SpotCheckLoadCell~%uint8 ERROR_UNKNOWN = 0              # Unused enum.~%uint8 ERROR_NONE = 1                 # No hardware error detected.~%uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.~%~%# The loadcell error code~%uint8 error~%# The current loadcell zero as fraction of full range [0-1]~%float32 zero~%# The previous loadcell zero as fraction of full range [0-1]~%float32 old_zero~%================================================================================~%MSG: spot_msgs/SpotCheckKinematic~%# Errors reflect an issue with robot hardware.~%uint8 ERROR_UNKNOWN = 0       # Unused enum.~%uint8 ERROR_NONE = 1          # No hardware error detected.~%uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.~%uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.~%~%# A flag to indicate if results has an error.~%uint8 error~%~%# The current offset [rad]~%float32 offset~%# The previous offset [rad]~%float32 old_offset~%~%# Joint calibration health score. range [0-1]~%# 0 indicates an unhealthy kinematic joint calibration~%# 1 indicates a perfect kinematic joint calibration~%# Typically, values greater than 0.8 should be expected.~%float32 health_score~%================================================================================~%MSG: spot_msgs/SpotCheckPayload~%# Errors reflect an issue with payload configuration.~%~%# Unused enum.~%uint8 ERROR_UNKNOWN = 0~%# No error found in the payloads.~%uint8 ERROR_NONE = 1~%# There is a mass discrepancy between the registered payload and what is estimated.~%uint8 ERROR_MASS_DISCREPANCY = 2~%~%# A flag to indicate if configuration has an error.~%uint8 error~%~%# Indicates how much extra payload (in kg) we think the robot has~%# Positive indicates robot has more payload than it is configured.~%# Negative indicates robot has less payload than it is configured.~%float32 extra_payload~%================================================================================~%MSG: spot_msgs/SpotCheckHipROM~%# Errors reflect an issue with hip range of motion~%uint8 ERROR_UNKNOWN = 0~%uint8 ERROR_NONE = 1~%uint8 ERROR_OBSTRUCTED = 2~%~%uint8 error~%~%# The measured angles (radians) of the HX and HY joints where the obstruction was detected~%float32[] hx~%float32[] hy~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SpotCheck-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'camera_names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'camera_results) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'load_cell_names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'load_cell_results) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'kinematic_joint_names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'kinematic_cal_results) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'payload_result))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'leg_names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'hip_range_of_motion_results) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SpotCheck-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SpotCheck-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
    (cl:cons ':camera_names (camera_names msg))
    (cl:cons ':camera_results (camera_results msg))
    (cl:cons ':load_cell_names (load_cell_names msg))
    (cl:cons ':load_cell_results (load_cell_results msg))
    (cl:cons ':kinematic_joint_names (kinematic_joint_names msg))
    (cl:cons ':kinematic_cal_results (kinematic_cal_results msg))
    (cl:cons ':payload_result (payload_result msg))
    (cl:cons ':leg_names (leg_names msg))
    (cl:cons ':hip_range_of_motion_results (hip_range_of_motion_results msg))
    (cl:cons ':progress (progress msg))
    (cl:cons ':last_cal_timestamp (last_cal_timestamp msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SpotCheck)))
  'SpotCheck-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SpotCheck)))
  'SpotCheck-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SpotCheck)))
  "Returns string type for a service object of type '<SpotCheck>"
  "spot_msgs/SpotCheck")