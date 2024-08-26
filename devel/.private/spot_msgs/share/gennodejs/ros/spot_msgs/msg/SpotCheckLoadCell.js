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

class SpotCheckLoadCell {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.error = null;
      this.zero = null;
      this.old_zero = null;
    }
    else {
      if (initObj.hasOwnProperty('error')) {
        this.error = initObj.error
      }
      else {
        this.error = 0;
      }
      if (initObj.hasOwnProperty('zero')) {
        this.zero = initObj.zero
      }
      else {
        this.zero = 0.0;
      }
      if (initObj.hasOwnProperty('old_zero')) {
        this.old_zero = initObj.old_zero
      }
      else {
        this.old_zero = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckLoadCell
    // Serialize message field [error]
    bufferOffset = _serializer.uint8(obj.error, buffer, bufferOffset);
    // Serialize message field [zero]
    bufferOffset = _serializer.float32(obj.zero, buffer, bufferOffset);
    // Serialize message field [old_zero]
    bufferOffset = _serializer.float32(obj.old_zero, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckLoadCell
    let len;
    let data = new SpotCheckLoadCell(null);
    // Deserialize message field [error]
    data.error = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [zero]
    data.zero = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [old_zero]
    data.old_zero = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SpotCheckLoadCell';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bfb62ba66777d3800f98e3fc7140667a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 ERROR_UNKNOWN = 0              # Unused enum.
    uint8 ERROR_NONE = 1                 # No hardware error detected.
    uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.
    
    # The loadcell error code
    uint8 error
    # The current loadcell zero as fraction of full range [0-1]
    float32 zero
    # The previous loadcell zero as fraction of full range [0-1]
    float32 old_zero
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckLoadCell(null);
    if (msg.error !== undefined) {
      resolved.error = msg.error;
    }
    else {
      resolved.error = 0
    }

    if (msg.zero !== undefined) {
      resolved.zero = msg.zero;
    }
    else {
      resolved.zero = 0.0
    }

    if (msg.old_zero !== undefined) {
      resolved.old_zero = msg.old_zero;
    }
    else {
      resolved.old_zero = 0.0
    }

    return resolved;
    }
};

// Constants for message
SpotCheckLoadCell.Constants = {
  ERROR_UNKNOWN: 0,
  ERROR_NONE: 1,
  ERROR_ZERO_OUT_OF_RANGE: 2,
}

module.exports = SpotCheckLoadCell;
