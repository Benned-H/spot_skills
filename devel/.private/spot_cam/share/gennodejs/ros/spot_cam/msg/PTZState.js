// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PTZDescription = require('./PTZDescription.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class PTZState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.ptz = null;
      this.pan = null;
      this.tilt = null;
      this.zoom = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('ptz')) {
        this.ptz = initObj.ptz
      }
      else {
        this.ptz = new PTZDescription();
      }
      if (initObj.hasOwnProperty('pan')) {
        this.pan = initObj.pan
      }
      else {
        this.pan = 0.0;
      }
      if (initObj.hasOwnProperty('tilt')) {
        this.tilt = initObj.tilt
      }
      else {
        this.tilt = 0.0;
      }
      if (initObj.hasOwnProperty('zoom')) {
        this.zoom = initObj.zoom
      }
      else {
        this.zoom = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PTZState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [ptz]
    bufferOffset = PTZDescription.serialize(obj.ptz, buffer, bufferOffset);
    // Serialize message field [pan]
    bufferOffset = _serializer.float32(obj.pan, buffer, bufferOffset);
    // Serialize message field [tilt]
    bufferOffset = _serializer.float32(obj.tilt, buffer, bufferOffset);
    // Serialize message field [zoom]
    bufferOffset = _serializer.float32(obj.zoom, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PTZState
    let len;
    let data = new PTZState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [ptz]
    data.ptz = PTZDescription.deserialize(buffer, bufferOffset);
    // Deserialize message field [pan]
    data.pan = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt]
    data.tilt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [zoom]
    data.zoom = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += PTZDescription.getMessageSize(object.ptz);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/PTZState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6780ed299706699768ff791d8291261f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,
    # The meaning of the pan/tilt/zoom values changes.
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity
    std_msgs/Header header
    # Description of the ptz
    spot_cam/PTZDescription ptz
    # degrees or degrees per second
    float32 pan
    # degrees or degrees per second
    float32 tilt
    # zoom level or zoom level per second
    float32 zoom
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
    MSG: spot_cam/PTZDescription
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
    # Name of this ptz (can be virtual)
    string name
    # Limits in degrees on the pan axis
    spot_cam/PTZLimits pan_limit
    # Limits in degrees on the pan axis
    spot_cam/PTZLimits tilt_limit
    # Limits in degrees on the pan axis
    spot_cam/PTZLimits zoom_limit
    ================================================================================
    MSG: spot_cam/PTZLimits
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits
    # If both max and min are zero, this means the limit is unset. The documentation states that if a limit
    # is unset, then all positions are valid.
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
    # Minimum value for the axis
    float32 min
    # Maximum value for the axis
    float32 max
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PTZState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.ptz !== undefined) {
      resolved.ptz = PTZDescription.Resolve(msg.ptz)
    }
    else {
      resolved.ptz = new PTZDescription()
    }

    if (msg.pan !== undefined) {
      resolved.pan = msg.pan;
    }
    else {
      resolved.pan = 0.0
    }

    if (msg.tilt !== undefined) {
      resolved.tilt = msg.tilt;
    }
    else {
      resolved.tilt = 0.0
    }

    if (msg.zoom !== undefined) {
      resolved.zoom = msg.zoom;
    }
    else {
      resolved.zoom = 0.0
    }

    return resolved;
    }
};

module.exports = PTZState;
