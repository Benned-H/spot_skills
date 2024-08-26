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

//-----------------------------------------------------------

class PTZDescriptionArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ptzs = null;
    }
    else {
      if (initObj.hasOwnProperty('ptzs')) {
        this.ptzs = initObj.ptzs
      }
      else {
        this.ptzs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PTZDescriptionArray
    // Serialize message field [ptzs]
    // Serialize the length for message field [ptzs]
    bufferOffset = _serializer.uint32(obj.ptzs.length, buffer, bufferOffset);
    obj.ptzs.forEach((val) => {
      bufferOffset = PTZDescription.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PTZDescriptionArray
    let len;
    let data = new PTZDescriptionArray(null);
    // Deserialize message field [ptzs]
    // Deserialize array length for message field [ptzs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.ptzs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.ptzs[i] = PTZDescription.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.ptzs.forEach((val) => {
      length += PTZDescription.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/PTZDescriptionArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bb84fb6777d2423bbf5218a0dc2508f6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    spot_cam/PTZDescription[] ptzs
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
    const resolved = new PTZDescriptionArray(null);
    if (msg.ptzs !== undefined) {
      resolved.ptzs = new Array(msg.ptzs.length);
      for (let i = 0; i < resolved.ptzs.length; ++i) {
        resolved.ptzs[i] = PTZDescription.Resolve(msg.ptzs[i]);
      }
    }
    else {
      resolved.ptzs = []
    }

    return resolved;
    }
};

module.exports = PTZDescriptionArray;
