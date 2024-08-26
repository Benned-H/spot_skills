;; Auto-generated. Do not edit!


(when (boundp 'spot_msgs::DownloadGraph)
  (if (not (find-package "SPOT_MSGS"))
    (make-package "SPOT_MSGS"))
  (shadow 'DownloadGraph (find-package "SPOT_MSGS")))
(unless (find-package "SPOT_MSGS::DOWNLOADGRAPH")
  (make-package "SPOT_MSGS::DOWNLOADGRAPH"))
(unless (find-package "SPOT_MSGS::DOWNLOADGRAPHREQUEST")
  (make-package "SPOT_MSGS::DOWNLOADGRAPHREQUEST"))
(unless (find-package "SPOT_MSGS::DOWNLOADGRAPHRESPONSE")
  (make-package "SPOT_MSGS::DOWNLOADGRAPHRESPONSE"))

(in-package "ROS")





(defclass spot_msgs::DownloadGraphRequest
  :super ros::object
  :slots (_download_filepath ))

(defmethod spot_msgs::DownloadGraphRequest
  (:init
   (&key
    ((:download_filepath __download_filepath) "")
    )
   (send-super :init)
   (setq _download_filepath (string __download_filepath))
   self)
  (:download_filepath
   (&optional __download_filepath)
   (if __download_filepath (setq _download_filepath __download_filepath)) _download_filepath)
  (:serialization-length
   ()
   (+
    ;; string _download_filepath
    4 (length _download_filepath)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _download_filepath
       (write-long (length _download_filepath) s) (princ _download_filepath s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _download_filepath
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _download_filepath (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass spot_msgs::DownloadGraphResponse
  :super ros::object
  :slots (_waypoint_ids ))

(defmethod spot_msgs::DownloadGraphResponse
  (:init
   (&key
    ((:waypoint_ids __waypoint_ids) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _waypoint_ids __waypoint_ids)
   self)
  (:waypoint_ids
   (&optional __waypoint_ids)
   (if __waypoint_ids (setq _waypoint_ids __waypoint_ids)) _waypoint_ids)
  (:serialization-length
   ()
   (+
    ;; string[] _waypoint_ids
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _waypoint_ids)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _waypoint_ids
     (write-long (length _waypoint_ids) s)
     (dolist (elem _waypoint_ids)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _waypoint_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoint_ids (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _waypoint_ids i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass spot_msgs::DownloadGraph
  :super ros::object
  :slots ())

(setf (get spot_msgs::DownloadGraph :md5sum-) "a39595a31eb3fe78c31f978ce5465539")
(setf (get spot_msgs::DownloadGraph :datatype-) "spot_msgs/DownloadGraph")
(setf (get spot_msgs::DownloadGraph :request) spot_msgs::DownloadGraphRequest)
(setf (get spot_msgs::DownloadGraph :response) spot_msgs::DownloadGraphResponse)

(defmethod spot_msgs::DownloadGraphRequest
  (:response () (instance spot_msgs::DownloadGraphResponse :init)))

(setf (get spot_msgs::DownloadGraphRequest :md5sum-) "a39595a31eb3fe78c31f978ce5465539")
(setf (get spot_msgs::DownloadGraphRequest :datatype-) "spot_msgs/DownloadGraphRequest")
(setf (get spot_msgs::DownloadGraphRequest :definition-)
      "string download_filepath
---
string[] waypoint_ids

")

(setf (get spot_msgs::DownloadGraphResponse :md5sum-) "a39595a31eb3fe78c31f978ce5465539")
(setf (get spot_msgs::DownloadGraphResponse :datatype-) "spot_msgs/DownloadGraphResponse")
(setf (get spot_msgs::DownloadGraphResponse :definition-)
      "string download_filepath
---
string[] waypoint_ids

")



(provide :spot_msgs/DownloadGraph "a39595a31eb3fe78c31f978ce5465539")


