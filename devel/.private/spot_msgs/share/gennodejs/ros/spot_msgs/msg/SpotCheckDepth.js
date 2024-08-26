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

class SpotCheckDepth {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.status = null;
      this.severity_score = null;
    }
    else {
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('severity_score')) {
        this.severity_score = initObj.severity_score
      }
      else {
        this.severity_score = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckDepth
    // Serialize message field [status]
    bufferOffset = _serializer.uint8(obj.status, buffer, bufferOffset);
    // Serialize message field [severity_score]
    bufferOffset = _serializer.float32(obj.severity_score, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckDepth
    let len;
    let data = new SpotCheckDepth(null);
    // Deserialize message field [status]
    data.status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [severity_score]
    data.severity_score = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SpotCheckDepth';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1df6ba22c62edcdd0f95e8c8502952ed';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 STATUS_UNKNOWN = 0     # Unused enum.
    uint8 STATUS_OK = 1          # No detected calibration error.
    uint8 STATUS_WARNING = 2     # Possible calibration error detected.
    uint8 STATUS_ERROR = 3       # Error with robot calibration.
    
    uint8 status
    float32 severity_score
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckDepth(null);
    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.severity_score !== undefined) {
      resolved.severity_score = msg.severity_score;
    }
    else {
      resolved.severity_score = 0.0
    }

    return resolved;
    }
};

// Constants for message
SpotCheckDepth.Constants = {
  STATUS_UNKNOWN: 0,
  STATUS_OK: 1,
  STATUS_WARNING: 2,
  STATUS_ERROR: 3,
}

module.exports = SpotCheckDepth;
