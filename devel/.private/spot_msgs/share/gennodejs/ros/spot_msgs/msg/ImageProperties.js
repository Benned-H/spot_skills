// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ImageSource = require('./ImageSource.js');
let ImageCapture = require('./ImageCapture.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class ImageProperties {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.camera_source = null;
      this.image_data_coordinates = null;
      this.image_data_keypoint_type = null;
      this.keypoint_coordinate_x = null;
      this.keypoint_coordinate_y = null;
      this.binary_descriptor = null;
      this.keypoint_score = null;
      this.keypoint_size = null;
      this.keypoint_angle = null;
      this.image_source = null;
      this.image_capture = null;
      this.frame_name_image_coordinates = null;
    }
    else {
      if (initObj.hasOwnProperty('camera_source')) {
        this.camera_source = initObj.camera_source
      }
      else {
        this.camera_source = '';
      }
      if (initObj.hasOwnProperty('image_data_coordinates')) {
        this.image_data_coordinates = initObj.image_data_coordinates
      }
      else {
        this.image_data_coordinates = new geometry_msgs.msg.Polygon();
      }
      if (initObj.hasOwnProperty('image_data_keypoint_type')) {
        this.image_data_keypoint_type = initObj.image_data_keypoint_type
      }
      else {
        this.image_data_keypoint_type = 0;
      }
      if (initObj.hasOwnProperty('keypoint_coordinate_x')) {
        this.keypoint_coordinate_x = initObj.keypoint_coordinate_x
      }
      else {
        this.keypoint_coordinate_x = [];
      }
      if (initObj.hasOwnProperty('keypoint_coordinate_y')) {
        this.keypoint_coordinate_y = initObj.keypoint_coordinate_y
      }
      else {
        this.keypoint_coordinate_y = [];
      }
      if (initObj.hasOwnProperty('binary_descriptor')) {
        this.binary_descriptor = initObj.binary_descriptor
      }
      else {
        this.binary_descriptor = [];
      }
      if (initObj.hasOwnProperty('keypoint_score')) {
        this.keypoint_score = initObj.keypoint_score
      }
      else {
        this.keypoint_score = [];
      }
      if (initObj.hasOwnProperty('keypoint_size')) {
        this.keypoint_size = initObj.keypoint_size
      }
      else {
        this.keypoint_size = [];
      }
      if (initObj.hasOwnProperty('keypoint_angle')) {
        this.keypoint_angle = initObj.keypoint_angle
      }
      else {
        this.keypoint_angle = [];
      }
      if (initObj.hasOwnProperty('image_source')) {
        this.image_source = initObj.image_source
      }
      else {
        this.image_source = new ImageSource();
      }
      if (initObj.hasOwnProperty('image_capture')) {
        this.image_capture = initObj.image_capture
      }
      else {
        this.image_capture = new ImageCapture();
      }
      if (initObj.hasOwnProperty('frame_name_image_coordinates')) {
        this.frame_name_image_coordinates = initObj.frame_name_image_coordinates
      }
      else {
        this.frame_name_image_coordinates = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImageProperties
    // Serialize message field [camera_source]
    bufferOffset = _serializer.string(obj.camera_source, buffer, bufferOffset);
    // Serialize message field [image_data_coordinates]
    bufferOffset = geometry_msgs.msg.Polygon.serialize(obj.image_data_coordinates, buffer, bufferOffset);
    // Serialize message field [image_data_keypoint_type]
    bufferOffset = _serializer.uint8(obj.image_data_keypoint_type, buffer, bufferOffset);
    // Serialize message field [keypoint_coordinate_x]
    bufferOffset = _arraySerializer.int32(obj.keypoint_coordinate_x, buffer, bufferOffset, null);
    // Serialize message field [keypoint_coordinate_y]
    bufferOffset = _arraySerializer.int32(obj.keypoint_coordinate_y, buffer, bufferOffset, null);
    // Serialize message field [binary_descriptor]
    bufferOffset = _arraySerializer.string(obj.binary_descriptor, buffer, bufferOffset, null);
    // Serialize message field [keypoint_score]
    bufferOffset = _arraySerializer.float64(obj.keypoint_score, buffer, bufferOffset, null);
    // Serialize message field [keypoint_size]
    bufferOffset = _arraySerializer.float64(obj.keypoint_size, buffer, bufferOffset, null);
    // Serialize message field [keypoint_angle]
    bufferOffset = _arraySerializer.float64(obj.keypoint_angle, buffer, bufferOffset, null);
    // Serialize message field [image_source]
    bufferOffset = ImageSource.serialize(obj.image_source, buffer, bufferOffset);
    // Serialize message field [image_capture]
    bufferOffset = ImageCapture.serialize(obj.image_capture, buffer, bufferOffset);
    // Serialize message field [frame_name_image_coordinates]
    bufferOffset = _serializer.string(obj.frame_name_image_coordinates, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImageProperties
    let len;
    let data = new ImageProperties(null);
    // Deserialize message field [camera_source]
    data.camera_source = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [image_data_coordinates]
    data.image_data_coordinates = geometry_msgs.msg.Polygon.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_data_keypoint_type]
    data.image_data_keypoint_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [keypoint_coordinate_x]
    data.keypoint_coordinate_x = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [keypoint_coordinate_y]
    data.keypoint_coordinate_y = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [binary_descriptor]
    data.binary_descriptor = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [keypoint_score]
    data.keypoint_score = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [keypoint_size]
    data.keypoint_size = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [keypoint_angle]
    data.keypoint_angle = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [image_source]
    data.image_source = ImageSource.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_capture]
    data.image_capture = ImageCapture.deserialize(buffer, bufferOffset);
    // Deserialize message field [frame_name_image_coordinates]
    data.frame_name_image_coordinates = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.camera_source);
    length += geometry_msgs.msg.Polygon.getMessageSize(object.image_data_coordinates);
    length += 4 * object.keypoint_coordinate_x.length;
    length += 4 * object.keypoint_coordinate_y.length;
    object.binary_descriptor.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    length += 8 * object.keypoint_score.length;
    length += 8 * object.keypoint_size.length;
    length += 8 * object.keypoint_angle.length;
    length += ImageSource.getMessageSize(object.image_source);
    length += ImageCapture.getMessageSize(object.image_capture);
    length += _getByteLength(object.frame_name_image_coordinates);
    return length + 33;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/ImageProperties';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '94ff5688662ac7e33ef10bbd7d52e755';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImageProperties(null);
    if (msg.camera_source !== undefined) {
      resolved.camera_source = msg.camera_source;
    }
    else {
      resolved.camera_source = ''
    }

    if (msg.image_data_coordinates !== undefined) {
      resolved.image_data_coordinates = geometry_msgs.msg.Polygon.Resolve(msg.image_data_coordinates)
    }
    else {
      resolved.image_data_coordinates = new geometry_msgs.msg.Polygon()
    }

    if (msg.image_data_keypoint_type !== undefined) {
      resolved.image_data_keypoint_type = msg.image_data_keypoint_type;
    }
    else {
      resolved.image_data_keypoint_type = 0
    }

    if (msg.keypoint_coordinate_x !== undefined) {
      resolved.keypoint_coordinate_x = msg.keypoint_coordinate_x;
    }
    else {
      resolved.keypoint_coordinate_x = []
    }

    if (msg.keypoint_coordinate_y !== undefined) {
      resolved.keypoint_coordinate_y = msg.keypoint_coordinate_y;
    }
    else {
      resolved.keypoint_coordinate_y = []
    }

    if (msg.binary_descriptor !== undefined) {
      resolved.binary_descriptor = msg.binary_descriptor;
    }
    else {
      resolved.binary_descriptor = []
    }

    if (msg.keypoint_score !== undefined) {
      resolved.keypoint_score = msg.keypoint_score;
    }
    else {
      resolved.keypoint_score = []
    }

    if (msg.keypoint_size !== undefined) {
      resolved.keypoint_size = msg.keypoint_size;
    }
    else {
      resolved.keypoint_size = []
    }

    if (msg.keypoint_angle !== undefined) {
      resolved.keypoint_angle = msg.keypoint_angle;
    }
    else {
      resolved.keypoint_angle = []
    }

    if (msg.image_source !== undefined) {
      resolved.image_source = ImageSource.Resolve(msg.image_source)
    }
    else {
      resolved.image_source = new ImageSource()
    }

    if (msg.image_capture !== undefined) {
      resolved.image_capture = ImageCapture.Resolve(msg.image_capture)
    }
    else {
      resolved.image_capture = new ImageCapture()
    }

    if (msg.frame_name_image_coordinates !== undefined) {
      resolved.frame_name_image_coordinates = msg.frame_name_image_coordinates;
    }
    else {
      resolved.frame_name_image_coordinates = ''
    }

    return resolved;
    }
};

// Constants for message
ImageProperties.Constants = {
  KEYPOINT_UNKNOWN: 0,
  KEYPOINT_SIMPLE: 1,
  KEYPOINT_ORB: 2,
}

module.exports = ImageProperties;
