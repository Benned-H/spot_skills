;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::TerrainParams)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'TerrainParams (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::TERRAINPARAMS")
  (make-package "SPOT_MSGS::TERRAINPARAMS"))

(in-package "ROS")
;;//! \htmlinclude TerrainParams.msg.html


(intern "*GRATED_SURFACES_MODE_UNKNOWN*" (find-package "SPOT_MSGS::TERRAINPARAMS"))
(shadow '*GRATED_SURFACES_MODE_UNKNOWN* (find-package "SPOT_MSGS::TERRAINPARAMS"))
(defconstant spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_UNKNOWN* 0)
(intern "*GRATED_SURFACES_MODE_OFF*" (find-package "SPOT_MSGS::TERRAINPARAMS"))
(shadow '*GRATED_SURFACES_MODE_OFF* (find-package "SPOT_MSGS::TERRAINPARAMS"))
(defconstant spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_OFF* 1)
(intern "*GRATED_SURFACES_MODE_ON*" (find-package "SPOT_MSGS::TERRAINPARAMS"))
(shadow '*GRATED_SURFACES_MODE_ON* (find-package "SPOT_MSGS::TERRAINPARAMS"))
(defconstant spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_ON* 2)
(intern "*GRATED_SURFACES_MODE_AUTO*" (find-package "SPOT_MSGS::TERRAINPARAMS"))
(shadow '*GRATED_SURFACES_MODE_AUTO* (find-package "SPOT_MSGS::TERRAINPARAMS"))
(defconstant spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_AUTO* 3)

(defun spot_msgs::TerrainParams-to-symbol (const)
  (cond
        ((= const 0) 'spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_UNKNOWN*)
        ((= const 1) 'spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_OFF*)
        ((= const 2) 'spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_ON*)
        ((= const 3) 'spot_msgs::TerrainParams::*GRATED_SURFACES_MODE_AUTO*)
        (t nil)))

(defclass spot_msgs::TerrainParams
  :super ros::object
  :slots (_ground_mu_hint _grated_surfaces_mode ))

(defmethod spot_msgs::TerrainParams
  (:init
   (&key
    ((:ground_mu_hint __ground_mu_hint) 0.0)
    ((:grated_surfaces_mode __grated_surfaces_mode) 0)
    )
   (send-super :init)
   (setq _ground_mu_hint (float __ground_mu_hint))
   (setq _grated_surfaces_mode (round __grated_surfaces_mode))
   self)
  (:ground_mu_hint
   (&optional __ground_mu_hint)
   (if __ground_mu_hint (setq _ground_mu_hint __ground_mu_hint)) _ground_mu_hint)
  (:grated_surfaces_mode
   (&optional __grated_surfaces_mode)
   (if __grated_surfaces_mode (setq _grated_surfaces_mode __grated_surfaces_mode)) _grated_surfaces_mode)
  (:serialization-length
   ()
   (+
    ;; float32 _ground_mu_hint
    4
    ;; uint8 _grated_surfaces_mode
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _ground_mu_hint
       (sys::poke _ground_mu_hint (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _grated_surfaces_mode
       (write-byte _grated_surfaces_mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _ground_mu_hint
     (setq _ground_mu_hint (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _grated_surfaces_mode
     (setq _grated_surfaces_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get spot_msgs::TerrainParams :md5sum-) "58fe7415b44378cf75e03c9f80729c0f")
(setf (get spot_msgs::TerrainParams :datatype-) "spot_msgs/TerrainParams")
(setf (get spot_msgs::TerrainParams :definition-)
      "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams
uint8 GRATED_SURFACES_MODE_UNKNOWN=0
uint8 GRATED_SURFACES_MODE_OFF=1
uint8 GRATED_SURFACES_MODE_ON=2
uint8 GRATED_SURFACES_MODE_AUTO=3

float32 ground_mu_hint
uint8 grated_surfaces_mode
")



(provide :spot_msgs/TerrainParams "58fe7415b44378cf75e03c9f80729c0f")


