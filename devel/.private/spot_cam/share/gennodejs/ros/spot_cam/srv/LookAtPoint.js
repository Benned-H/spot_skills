// Auto-generated. Do not edit!

// (in-package spot_cam.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class LookAtPointRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.target = null;
      this.image_width = null;
      this.zoom_level = null;
      this.track = null;
    }
    else {
      if (initObj.hasOwnProperty('target')) {
        this.target = initObj.target
      }
      else {
        this.target = new geometry_msgs.msg.PointStamped();
      }
      if (initObj.hasOwnProperty('image_width')) {
        this.image_width = initObj.image_width
      }
      else {
        this.image_width = 0.0;
      }
      if (initObj.hasOwnProperty('zoom_level')) {
        this.zoom_level = initObj.zoom_level
      }
      else {
        this.zoom_level = 0.0;
      }
      if (initObj.hasOwnProperty('track')) {
        this.track = initObj.track
      }
      else {
        this.track = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LookAtPointRequest
    // Serialize message field [target]
    bufferOffset = geometry_msgs.msg.PointStamped.serialize(obj.target, buffer, bufferOffset);
    // Serialize message field [image_width]
    bufferOffset = _serializer.float32(obj.image_width, buffer, bufferOffset);
    // Serialize message field [zoom_level]
    bufferOffset = _serializer.float32(obj.zoom_level, buffer, bufferOffset);
    // Serialize message field [track]
    bufferOffset = _serializer.bool(obj.track, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LookAtPointRequest
    let len;
    let data = new LookAtPointRequest(null);
    // Deserialize message field [target]
    data.target = geometry_msgs.msg.PointStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_width]
    data.image_width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [zoom_level]
    data.zoom_level = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [track]
    data.track = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PointStamped.getMessageSize(object.target);
    return length + 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_cam/LookAtPointRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '216e8536a7d77a61af59b6f7aa3d17c4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Point the spot cam PTZ at a specific point in space
    # The target at which the PTZ should be pointed
    geometry_msgs/PointStamped target
    # Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,
    # this will be used
    float32 image_width
    # Optical zoom level between 1 and 30 to use
    float32 zoom_level
    # If true, the camera will track this point as the robot moves
    bool track
    
    ================================================================================
    MSG: geometry_msgs/PointStamped
    # This represents a Point with reference coordinate frame and timestamp
    Header header
    Point point
    
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
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
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
    const resolved = new LookAtPointRequest(null);
    if (msg.target !== undefined) {
      resolved.target = geometry_msgs.msg.PointStamped.Resolve(msg.target)
    }
    else {
      resolved.target = new geometry_msgs.msg.PointStamped()
    }

    if (msg.image_width !== undefined) {
      resolved.image_width = msg.image_width;
    }
    else {
      resolved.image_width = 0.0
    }

    if (msg.zoom_level !== undefined) {
      resolved.zoom_level = msg.zoom_level;
    }
    else {
      resolved.zoom_level = 0.0
    }

    if (msg.track !== undefined) {
      resolved.track = msg.track;
    }
    else {
      resolved.track = false
    }

    return resolved;
    }
};

class LookAtPointResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.message = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LookAtPointResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LookAtPointResponse
    let len;
    let data = new LookAtPointResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.message);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_cam/LookAtPointResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '937c9679a518e3a18d831e57125ea522';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    string message
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LookAtPointResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: LookAtPointRequest,
  Response: LookAtPointResponse,
  md5sum() { return '0dc127af1bc4082ad4ce1ba11dbd2e9b'; },
  datatype() { return 'spot_cam/LookAtPoint'; }
};
