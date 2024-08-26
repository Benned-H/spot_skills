// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let FrameTreeSnapshot = require('./FrameTreeSnapshot.js');
let AprilTagProperties = require('./AprilTagProperties.js');
let ImageProperties = require('./ImageProperties.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class WorldObject {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.name = null;
      this.acquisition_time = null;
      this.frame_tree_snapshot = null;
      this.apriltag_properties = null;
      this.image_properties = null;
      this.dock_id = null;
      this.dock_type = null;
      this.frame_name_dock = null;
      this.dock_unavailable = null;
      this.from_prior_detection = null;
      this.ray_frame = null;
      this.ray_origin = null;
      this.ray_direction = null;
      this.bounding_box_frame = null;
      this.bounding_box_size_ewrt_frame = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('acquisition_time')) {
        this.acquisition_time = initObj.acquisition_time
      }
      else {
        this.acquisition_time = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('frame_tree_snapshot')) {
        this.frame_tree_snapshot = initObj.frame_tree_snapshot
      }
      else {
        this.frame_tree_snapshot = new FrameTreeSnapshot();
      }
      if (initObj.hasOwnProperty('apriltag_properties')) {
        this.apriltag_properties = initObj.apriltag_properties
      }
      else {
        this.apriltag_properties = new AprilTagProperties();
      }
      if (initObj.hasOwnProperty('image_properties')) {
        this.image_properties = initObj.image_properties
      }
      else {
        this.image_properties = new ImageProperties();
      }
      if (initObj.hasOwnProperty('dock_id')) {
        this.dock_id = initObj.dock_id
      }
      else {
        this.dock_id = 0;
      }
      if (initObj.hasOwnProperty('dock_type')) {
        this.dock_type = initObj.dock_type
      }
      else {
        this.dock_type = 0;
      }
      if (initObj.hasOwnProperty('frame_name_dock')) {
        this.frame_name_dock = initObj.frame_name_dock
      }
      else {
        this.frame_name_dock = '';
      }
      if (initObj.hasOwnProperty('dock_unavailable')) {
        this.dock_unavailable = initObj.dock_unavailable
      }
      else {
        this.dock_unavailable = false;
      }
      if (initObj.hasOwnProperty('from_prior_detection')) {
        this.from_prior_detection = initObj.from_prior_detection
      }
      else {
        this.from_prior_detection = false;
      }
      if (initObj.hasOwnProperty('ray_frame')) {
        this.ray_frame = initObj.ray_frame
      }
      else {
        this.ray_frame = '';
      }
      if (initObj.hasOwnProperty('ray_origin')) {
        this.ray_origin = initObj.ray_origin
      }
      else {
        this.ray_origin = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('ray_direction')) {
        this.ray_direction = initObj.ray_direction
      }
      else {
        this.ray_direction = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('bounding_box_frame')) {
        this.bounding_box_frame = initObj.bounding_box_frame
      }
      else {
        this.bounding_box_frame = '';
      }
      if (initObj.hasOwnProperty('bounding_box_size_ewrt_frame')) {
        this.bounding_box_size_ewrt_frame = initObj.bounding_box_size_ewrt_frame
      }
      else {
        this.bounding_box_size_ewrt_frame = new geometry_msgs.msg.Vector3();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WorldObject
    // Serialize message field [id]
    bufferOffset = _serializer.int32(obj.id, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [acquisition_time]
    bufferOffset = _serializer.time(obj.acquisition_time, buffer, bufferOffset);
    // Serialize message field [frame_tree_snapshot]
    bufferOffset = FrameTreeSnapshot.serialize(obj.frame_tree_snapshot, buffer, bufferOffset);
    // Serialize message field [apriltag_properties]
    bufferOffset = AprilTagProperties.serialize(obj.apriltag_properties, buffer, bufferOffset);
    // Serialize message field [image_properties]
    bufferOffset = ImageProperties.serialize(obj.image_properties, buffer, bufferOffset);
    // Serialize message field [dock_id]
    bufferOffset = _serializer.int32(obj.dock_id, buffer, bufferOffset);
    // Serialize message field [dock_type]
    bufferOffset = _serializer.uint8(obj.dock_type, buffer, bufferOffset);
    // Serialize message field [frame_name_dock]
    bufferOffset = _serializer.string(obj.frame_name_dock, buffer, bufferOffset);
    // Serialize message field [dock_unavailable]
    bufferOffset = _serializer.bool(obj.dock_unavailable, buffer, bufferOffset);
    // Serialize message field [from_prior_detection]
    bufferOffset = _serializer.bool(obj.from_prior_detection, buffer, bufferOffset);
    // Serialize message field [ray_frame]
    bufferOffset = _serializer.string(obj.ray_frame, buffer, bufferOffset);
    // Serialize message field [ray_origin]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.ray_origin, buffer, bufferOffset);
    // Serialize message field [ray_direction]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.ray_direction, buffer, bufferOffset);
    // Serialize message field [bounding_box_frame]
    bufferOffset = _serializer.string(obj.bounding_box_frame, buffer, bufferOffset);
    // Serialize message field [bounding_box_size_ewrt_frame]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.bounding_box_size_ewrt_frame, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WorldObject
    let len;
    let data = new WorldObject(null);
    // Deserialize message field [id]
    data.id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [acquisition_time]
    data.acquisition_time = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [frame_tree_snapshot]
    data.frame_tree_snapshot = FrameTreeSnapshot.deserialize(buffer, bufferOffset);
    // Deserialize message field [apriltag_properties]
    data.apriltag_properties = AprilTagProperties.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_properties]
    data.image_properties = ImageProperties.deserialize(buffer, bufferOffset);
    // Deserialize message field [dock_id]
    data.dock_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [dock_type]
    data.dock_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [frame_name_dock]
    data.frame_name_dock = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [dock_unavailable]
    data.dock_unavailable = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [from_prior_detection]
    data.from_prior_detection = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ray_frame]
    data.ray_frame = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [ray_origin]
    data.ray_origin = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [ray_direction]
    data.ray_direction = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [bounding_box_frame]
    data.bounding_box_frame = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [bounding_box_size_ewrt_frame]
    data.bounding_box_size_ewrt_frame = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    length += FrameTreeSnapshot.getMessageSize(object.frame_tree_snapshot);
    length += AprilTagProperties.getMessageSize(object.apriltag_properties);
    length += ImageProperties.getMessageSize(object.image_properties);
    length += _getByteLength(object.frame_name_dock);
    length += _getByteLength(object.ray_frame);
    length += _getByteLength(object.bounding_box_frame);
    return length + 107;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/WorldObject';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6886a66dad17ad58030255815149c776';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new WorldObject(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.acquisition_time !== undefined) {
      resolved.acquisition_time = msg.acquisition_time;
    }
    else {
      resolved.acquisition_time = {secs: 0, nsecs: 0}
    }

    if (msg.frame_tree_snapshot !== undefined) {
      resolved.frame_tree_snapshot = FrameTreeSnapshot.Resolve(msg.frame_tree_snapshot)
    }
    else {
      resolved.frame_tree_snapshot = new FrameTreeSnapshot()
    }

    if (msg.apriltag_properties !== undefined) {
      resolved.apriltag_properties = AprilTagProperties.Resolve(msg.apriltag_properties)
    }
    else {
      resolved.apriltag_properties = new AprilTagProperties()
    }

    if (msg.image_properties !== undefined) {
      resolved.image_properties = ImageProperties.Resolve(msg.image_properties)
    }
    else {
      resolved.image_properties = new ImageProperties()
    }

    if (msg.dock_id !== undefined) {
      resolved.dock_id = msg.dock_id;
    }
    else {
      resolved.dock_id = 0
    }

    if (msg.dock_type !== undefined) {
      resolved.dock_type = msg.dock_type;
    }
    else {
      resolved.dock_type = 0
    }

    if (msg.frame_name_dock !== undefined) {
      resolved.frame_name_dock = msg.frame_name_dock;
    }
    else {
      resolved.frame_name_dock = ''
    }

    if (msg.dock_unavailable !== undefined) {
      resolved.dock_unavailable = msg.dock_unavailable;
    }
    else {
      resolved.dock_unavailable = false
    }

    if (msg.from_prior_detection !== undefined) {
      resolved.from_prior_detection = msg.from_prior_detection;
    }
    else {
      resolved.from_prior_detection = false
    }

    if (msg.ray_frame !== undefined) {
      resolved.ray_frame = msg.ray_frame;
    }
    else {
      resolved.ray_frame = ''
    }

    if (msg.ray_origin !== undefined) {
      resolved.ray_origin = geometry_msgs.msg.Vector3.Resolve(msg.ray_origin)
    }
    else {
      resolved.ray_origin = new geometry_msgs.msg.Vector3()
    }

    if (msg.ray_direction !== undefined) {
      resolved.ray_direction = geometry_msgs.msg.Vector3.Resolve(msg.ray_direction)
    }
    else {
      resolved.ray_direction = new geometry_msgs.msg.Vector3()
    }

    if (msg.bounding_box_frame !== undefined) {
      resolved.bounding_box_frame = msg.bounding_box_frame;
    }
    else {
      resolved.bounding_box_frame = ''
    }

    if (msg.bounding_box_size_ewrt_frame !== undefined) {
      resolved.bounding_box_size_ewrt_frame = geometry_msgs.msg.Vector3.Resolve(msg.bounding_box_size_ewrt_frame)
    }
    else {
      resolved.bounding_box_size_ewrt_frame = new geometry_msgs.msg.Vector3()
    }

    return resolved;
    }
};

// Constants for message
WorldObject.Constants = {
  DOCK_TYPE_UNKNOWN: 0,
  DOCK_TYPE_CONTACT_PROTOTYPE: 2,
  DOCK_TYPE_SPOT_DOCK: 3,
}

module.exports = WorldObject;
