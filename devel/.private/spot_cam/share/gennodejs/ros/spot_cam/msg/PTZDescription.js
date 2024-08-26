// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PTZLimits = require('./PTZLimits.js');

//-----------------------------------------------------------

class PTZDescription {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.pan_limit = null;
      this.tilt_limit = null;
      this.zoom_limit = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('pan_limit')) {
        this.pan_limit = initObj.pan_limit
      }
      else {
        this.pan_limit = new PTZLimits();
      }
      if (initObj.hasOwnProperty('tilt_limit')) {
        this.tilt_limit = initObj.tilt_limit
      }
      else {
        this.tilt_limit = new PTZLimits();
      }
      if (initObj.hasOwnProperty('zoom_limit')) {
        this.zoom_limit = initObj.zoom_limit
      }
      else {
        this.zoom_limit = new PTZLimits();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PTZDescription
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [pan_limit]
    bufferOffset = PTZLimits.serialize(obj.pan_limit, buffer, bufferOffset);
    // Serialize message field [tilt_limit]
    bufferOffset = PTZLimits.serialize(obj.tilt_limit, buffer, bufferOffset);
    // Serialize message field [zoom_limit]
    bufferOffset = PTZLimits.serialize(obj.zoom_limit, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PTZDescription
    let len;
    let data = new PTZDescription(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [pan_limit]
    data.pan_limit = PTZLimits.deserialize(buffer, bufferOffset);
    // Deserialize message field [tilt_limit]
    data.tilt_limit = PTZLimits.deserialize(buffer, bufferOffset);
    // Deserialize message field [zoom_limit]
    data.zoom_limit = PTZLimits.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/PTZDescription';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e115be93750ee1ae6231f38b8b89491a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new PTZDescription(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.pan_limit !== undefined) {
      resolved.pan_limit = PTZLimits.Resolve(msg.pan_limit)
    }
    else {
      resolved.pan_limit = new PTZLimits()
    }

    if (msg.tilt_limit !== undefined) {
      resolved.tilt_limit = PTZLimits.Resolve(msg.tilt_limit)
    }
    else {
      resolved.tilt_limit = new PTZLimits()
    }

    if (msg.zoom_limit !== undefined) {
      resolved.zoom_limit = PTZLimits.Resolve(msg.zoom_limit)
    }
    else {
      resolved.zoom_limit = new PTZLimits()
    }

    return resolved;
    }
};

module.exports = PTZDescription;
