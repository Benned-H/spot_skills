// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let WorldObject = require('./WorldObject.js');

//-----------------------------------------------------------

class WorldObjectArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.world_objects = null;
    }
    else {
      if (initObj.hasOwnProperty('world_objects')) {
        this.world_objects = initObj.world_objects
      }
      else {
        this.world_objects = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WorldObjectArray
    // Serialize message field [world_objects]
    // Serialize the length for message field [world_objects]
    bufferOffset = _serializer.uint32(obj.world_objects.length, buffer, bufferOffset);
    obj.world_objects.forEach((val) => {
      bufferOffset = WorldObject.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WorldObjectArray
    let len;
    let data = new WorldObjectArray(null);
    // Deserialize message field [world_objects]
    // Deserialize array length for message field [world_objects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.world_objects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.world_objects[i] = WorldObject.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.world_objects.forEach((val) => {
      length += WorldObject.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/WorldObjectArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd864d05495a41dfc3c5ac3126d50b37f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # World objects list
    WorldObject[] world_objects
    ================================================================================
    MSG: spot_msgs/WorldObject
    int32 id
    string name
    time acquisition_time
    
    ### Frame tree
    FrameTreeSnapshot frame_tree_snapshot
    
    ### AprilTag properties
    AprilTagProperties apriltag_properties
    
    ### Image properties
    ImageProperties image_properties
    
    ### Dock properties
    # Dock type enum
    uint8 DOCK_TYPE_UNKNOWN=0
    uint8 DOCK_TYPE_CONTACT_PROTOTYPE=2
    uint8 DOCK_TYPE_SPOT_DOCK=3
    
    int32 dock_id
    uint8 dock_type
    
    string frame_name_dock
    bool dock_unavailable
    bool from_prior_detection
    
    ### Ray properties
    string ray_frame
    geometry_msgs/Vector3 ray_origin
    geometry_msgs/Vector3 ray_direction
    
    ### Bounding box properties
    string bounding_box_frame
    geometry_msgs/Vector3 bounding_box_size_ewrt_frame
    
    ================================================================================
    MSG: spot_msgs/FrameTreeSnapshot
    string[] child_edges
    ParentEdge[] parent_edges
    ================================================================================
    MSG: spot_msgs/ParentEdge
    string parent_frame_name
    geometry_msgs/Pose parent_tform_child
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    ================================================================================
    MSG: spot_msgs/AprilTagProperties
    # Status
    uint8 STATUS_UNKNOWN = 0
    uint8 STATUS_OK = 1
    uint8 STATUS_AMBIGUOUS = 2
    uint8 STATUS_HIGH_ERROR = 3
    
    int32 tag_id
    float64 x
    float64 y
    
    string frame_name_fiducial
    uint8 fiducial_pose_status
    
    string frame_name_fiducial_filtered
    uint8 fiducial_filtered_pose_status
    
    string frame_name_camera
    
    geometry_msgs/PoseWithCovariance detection_covariance
    string detection_covariance_reference_frame
    ================================================================================
    MSG: geometry_msgs/PoseWithCovariance
    # This represents a pose in free space with uncertainty.
    
    Pose pose
    
    # Row-major representation of the 6x6 covariance matrix
    # The orientation parameters use a fixed-axis representation.
    # In order, the parameters are:
    # (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
    float64[36] covariance
    
    ================================================================================
    MSG: spot_msgs/ImageProperties
    string camera_source
    
    # Polygon coordinates
    geometry_msgs/Polygon image_data_coordinates
    
    # Keypoint coordinates
    uint8 KEYPOINT_UNKNOWN=0
    uint8 KEYPOINT_SIMPLE=1
    uint8 KEYPOINT_ORB=2
    
    uint8 image_data_keypoint_type
    int32[] keypoint_coordinate_x
    int32[] keypoint_coordinate_y
    string[] binary_descriptor
    float64[] keypoint_score
    float64[] keypoint_size
    float64[] keypoint_angle
    
    ImageSource image_source
    ImageCapture image_capture
    
    string frame_name_image_coordinates
    ================================================================================
    MSG: geometry_msgs/Polygon
    #A specification of a polygon where the first and last points are assumed to be connected
    Point32[] points
    
    ================================================================================
    MSG: geometry_msgs/Point32
    # This contains the position of a point in free space(with 32 bits of precision).
    # It is recommeded to use Point wherever possible instead of Point32.  
    # 
    # This recommendation is to promote interoperability.  
    #
    # This message is designed to take up less space when sending
    # lots of points at once, as in the case of a PointCloud.  
    
    float32 x
    float32 y
    float32 z
    ================================================================================
    MSG: spot_msgs/ImageSource
    # Image type enums
    uint8 IMAGE_TYPE_UNKNOWN = 0
    uint8 IMAGE_TYPE_VISUAL = 1
    uint8 IMAGE_TYPE_DEPTH = 2
    
    # Pixel format enums
    uint8 PIXEL_FORMAT_UNKNOWN = 0
    uint8 PIXEL_FORMAT_GREYSCALE_U8 = 1
    uint8 PIXEL_FORMAT_RGB_U8 = 3
    uint8 PIXEL_FORMAT_RGBA_U8 = 4
    uint8 PIXEL_FORMAT_DEPTH_U16 = 5
    uint8 PIXEL_FORMAT_GREYSCALE_U16 = 6
    
    # Image format enums
    uint8 FORMAT_UNKNOWN = 0
    uint8 FORMAT_JPEG = 1
    uint8 FORMAT_RAW = 2
    uint8 FORMAT_RLE = 3
    
    string name
    int32 cols
    int32 rows
    float64 depth_scale
    
    # Camera pinhole model parameters
    float64 focal_length_x
    float64 focal_length_y
    float64 principal_point_x
    float64 principal_point_y
    float64 skew_x
    float64 skew_y
    
    uint8 image_type
    uint8[] pixel_formats
    uint8[] image_formats
    
    ================================================================================
    MSG: spot_msgs/ImageCapture
    time acquisition_time
    
    FrameTreeSnapshot transforms_snapshot
    string frame_name_image_sensor
    
    sensor_msgs/Image image
    
    duration capture_exposure_duration
    float64 capture_sensor_gain
    
    ================================================================================
    MSG: sensor_msgs/Image
    # This message contains an uncompressed image
    # (0, 0) is at top-left corner of image
    #
    
    Header header        # Header timestamp should be acquisition time of image
                         # Header frame_id should be optical frame of camera
                         # origin of frame should be optical center of camera
                         # +x should point to the right in the image
                         # +y should point down in the image
                         # +z should point into to plane of the image
                         # If the frame_id here and the frame_id of the CameraInfo
                         # message associated with the image conflict
                         # the behavior is undefined
    
    uint32 height         # image height, that is, number of rows
    uint32 width          # image width, that is, number of columns
    
    # The legal values for encoding are in file src/image_encodings.cpp
    # If you want to standardize a new string format, join
    # ros-users@lists.sourceforge.net and send an email proposing a new encoding.
    
    string encoding       # Encoding of pixels -- channel meaning, ordering, size
                          # taken from the list of strings in include/sensor_msgs/image_encodings.h
    
    uint8 is_bigendian    # is this data bigendian?
    uint32 step           # Full row length in bytes
    uint8[] data          # actual matrix data, size is (step * rows)
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WorldObjectArray(null);
    if (msg.world_objects !== undefined) {
      resolved.world_objects = new Array(msg.world_objects.length);
      for (let i = 0; i < resolved.world_objects.length; ++i) {
        resolved.world_objects[i] = WorldObject.Resolve(msg.world_objects[i]);
      }
    }
    else {
      resolved.world_objects = []
    }

    return resolved;
    }
};

module.exports = WorldObjectArray;
