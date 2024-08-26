
(cl:in-package :asdf)

(defsystem "spot_cam-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :spot_cam-msg
)
  :components ((:file "_package")
    (:file "LoadSound" :depends-on ("_package_LoadSound"))
    (:file "_package_LoadSound" :depends-on ("_package"))
    (:file "LookAtPoint" :depends-on ("_package_LookAtPoint"))
    (:file "_package_LookAtPoint" :depends-on ("_package"))
    (:file "PlaySound" :depends-on ("_package_PlaySound"))
    (:file "_package_PlaySound" :depends-on ("_package"))
    (:file "SetBool" :depends-on ("_package_SetBool"))
    (:file "_package_SetBool" :depends-on ("_package"))
    (:file "SetFloat" :depends-on ("_package_SetFloat"))
    (:file "_package_SetFloat" :depends-on ("_package"))
    (:file "SetIRColormap" :depends-on ("_package_SetIRColormap"))
    (:file "_package_SetIRColormap" :depends-on ("_package"))
    (:file "SetIRMeterOverlay" :depends-on ("_package_SetIRMeterOverlay"))
    (:file "_package_SetIRMeterOverlay" :depends-on ("_package"))
    (:file "SetPTZState" :depends-on ("_package_SetPTZState"))
    (:file "_package_SetPTZState" :depends-on ("_package"))
    (:file "SetStreamParams" :depends-on ("_package_SetStreamParams"))
    (:file "_package_SetStreamParams" :depends-on ("_package"))
    (:file "SetString" :depends-on ("_package_SetString"))
    (:file "_package_SetString" :depends-on ("_package"))
  ))