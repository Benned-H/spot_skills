// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ImageSource {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.cols = null;
      this.rows = null;
      this.depth_scale = null;
      this.focal_length_x = null;
      this.focal_length_y = null;
      this.principal_point_x = null;
      this.principal_point_y = null;
      this.skew_x = null;
      this.skew_y = null;
      this.image_type = null;
      this.pixel_formats = null;
      this.image_formats = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('cols')) {
        this.cols = initObj.cols
      }
      else {
        this.cols = 0;
      }
      if (initObj.hasOwnProperty('rows')) {
        this.rows = initObj.rows
      }
      else {
        this.rows = 0;
      }
      if (initObj.hasOwnProperty('depth_scale')) {
        this.depth_scale = initObj.depth_scale
      }
      else {
        this.depth_scale = 0.0;
      }
      if (initObj.hasOwnProperty('focal_length_x')) {
        this.focal_length_x = initObj.focal_length_x
      }
      else {
        this.focal_length_x = 0.0;
      }
      if (initObj.hasOwnProperty('focal_length_y')) {
        this.focal_length_y = initObj.focal_length_y
      }
      else {
        this.focal_length_y = 0.0;
      }
      if (initObj.hasOwnProperty('principal_point_x')) {
        this.principal_point_x = initObj.principal_point_x
      }
      else {
        this.principal_point_x = 0.0;
      }
      if (initObj.hasOwnProperty('principal_point_y')) {
        this.principal_point_y = initObj.principal_point_y
      }
      else {
        this.principal_point_y = 0.0;
      }
      if (initObj.hasOwnProperty('skew_x')) {
        this.skew_x = initObj.skew_x
      }
      else {
        this.skew_x = 0.0;
      }
      if (initObj.hasOwnProperty('skew_y')) {
        this.skew_y = initObj.skew_y
      }
      else {
        this.skew_y = 0.0;
      }
      if (initObj.hasOwnProperty('image_type')) {
        this.image_type = initObj.image_type
      }
      else {
        this.image_type = 0;
      }
      if (initObj.hasOwnProperty('pixel_formats')) {
        this.pixel_formats = initObj.pixel_formats
      }
      else {
        this.pixel_formats = [];
      }
      if (initObj.hasOwnProperty('image_formats')) {
        this.image_formats = initObj.image_formats
      }
      else {
        this.image_formats = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImageSource
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [cols]
    bufferOffset = _serializer.int32(obj.cols, buffer, bufferOffset);
    // Serialize message field [rows]
    bufferOffset = _serializer.int32(obj.rows, buffer, bufferOffset);
    // Serialize message field [depth_scale]
    bufferOffset = _serializer.float64(obj.depth_scale, buffer, bufferOffset);
    // Serialize message field [focal_length_x]
    bufferOffset = _serializer.float64(obj.focal_length_x, buffer, bufferOffset);
    // Serialize message field [focal_length_y]
    bufferOffset = _serializer.float64(obj.focal_length_y, buffer, bufferOffset);
    // Serialize message field [principal_point_x]
    bufferOffset = _serializer.float64(obj.principal_point_x, buffer, bufferOffset);
    // Serialize message field [principal_point_y]
    bufferOffset = _serializer.float64(obj.principal_point_y, buffer, bufferOffset);
    // Serialize message field [skew_x]
    bufferOffset = _serializer.float64(obj.skew_x, buffer, bufferOffset);
    // Serialize message field [skew_y]
    bufferOffset = _serializer.float64(obj.skew_y, buffer, bufferOffset);
    // Serialize message field [image_type]
    bufferOffset = _serializer.uint8(obj.image_type, buffer, bufferOffset);
    // Serialize message field [pixel_formats]
    bufferOffset = _arraySerializer.uint8(obj.pixel_formats, buffer, bufferOffset, null);
    // Serialize message field [image_formats]
    bufferOffset = _arraySerializer.uint8(obj.image_formats, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImageSource
    let len;
    let data = new ImageSource(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [cols]
    data.cols = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [rows]
    data.rows = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [depth_scale]
    data.depth_scale = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [focal_length_x]
    data.focal_length_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [focal_length_y]
    data.focal_length_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [principal_point_x]
    data.principal_point_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [principal_point_y]
    data.principal_point_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [skew_x]
    data.skew_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [skew_y]
    data.skew_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [image_type]
    data.image_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [pixel_formats]
    data.pixel_formats = _arrayDeserializer.uint8(buffer, bufferOffset, null)
    // Deserialize message field [image_formats]
    data.image_formats = _arrayDeserializer.uint8(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    length += object.pixel_formats.length;
    length += object.image_formats.length;
    return length + 77;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/ImageSource';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '24779006d77c58e3fd81f011ebfc2932';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImageSource(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.cols !== undefined) {
      resolved.cols = msg.cols;
    }
    else {
      resolved.cols = 0
    }

    if (msg.rows !== undefined) {
      resolved.rows = msg.rows;
    }
    else {
      resolved.rows = 0
    }

    if (msg.depth_scale !== undefined) {
      resolved.depth_scale = msg.depth_scale;
    }
    else {
      resolved.depth_scale = 0.0
    }

    if (msg.focal_length_x !== undefined) {
      resolved.focal_length_x = msg.focal_length_x;
    }
    else {
      resolved.focal_length_x = 0.0
    }

    if (msg.focal_length_y !== undefined) {
      resolved.focal_length_y = msg.focal_length_y;
    }
    else {
      resolved.focal_length_y = 0.0
    }

    if (msg.principal_point_x !== undefined) {
      resolved.principal_point_x = msg.principal_point_x;
    }
    else {
      resolved.principal_point_x = 0.0
    }

    if (msg.principal_point_y !== undefined) {
      resolved.principal_point_y = msg.principal_point_y;
    }
    else {
      resolved.principal_point_y = 0.0
    }

    if (msg.skew_x !== undefined) {
      resolved.skew_x = msg.skew_x;
    }
    else {
      resolved.skew_x = 0.0
    }

    if (msg.skew_y !== undefined) {
      resolved.skew_y = msg.skew_y;
    }
    else {
      resolved.skew_y = 0.0
    }

    if (msg.image_type !== undefined) {
      resolved.image_type = msg.image_type;
    }
    else {
      resolved.image_type = 0
    }

    if (msg.pixel_formats !== undefined) {
      resolved.pixel_formats = msg.pixel_formats;
    }
    else {
      resolved.pixel_formats = []
    }

    if (msg.image_formats !== undefined) {
      resolved.image_formats = msg.image_formats;
    }
    else {
      resolved.image_formats = []
    }

    return resolved;
    }
};

// Constants for message
ImageSource.Constants = {
  IMAGE_TYPE_UNKNOWN: 0,
  IMAGE_TYPE_VISUAL: 1,
  IMAGE_TYPE_DEPTH: 2,
  PIXEL_FORMAT_UNKNOWN: 0,
  PIXEL_FORMAT_GREYSCALE_U8: 1,
  PIXEL_FORMAT_RGB_U8: 3,
  PIXEL_FORMAT_RGBA_U8: 4,
  PIXEL_FORMAT_DEPTH_U16: 5,
  PIXEL_FORMAT_GREYSCALE_U16: 6,
  FORMAT_UNKNOWN: 0,
  FORMAT_JPEG: 1,
  FORMAT_RAW: 2,
  FORMAT_RLE: 3,
}

module.exports = ImageSource;
