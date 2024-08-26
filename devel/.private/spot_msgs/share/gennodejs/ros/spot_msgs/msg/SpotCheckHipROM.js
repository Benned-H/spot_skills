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

class SpotCheckHipROM {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.error = null;
      this.hx = null;
      this.hy = null;
    }
    else {
      if (initObj.hasOwnProperty('error')) {
        this.error = initObj.error
      }
      else {
        this.error = 0;
      }
      if (initObj.hasOwnProperty('hx')) {
        this.hx = initObj.hx
      }
      else {
        this.hx = [];
      }
      if (initObj.hasOwnProperty('hy')) {
        this.hy = initObj.hy
      }
      else {
        this.hy = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckHipROM
    // Serialize message field [error]
    bufferOffset = _serializer.uint8(obj.error, buffer, bufferOffset);
    // Serialize message field [hx]
    bufferOffset = _arraySerializer.float32(obj.hx, buffer, bufferOffset, null);
    // Serialize message field [hy]
    bufferOffset = _arraySerializer.float32(obj.hy, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckHipROM
    let len;
    let data = new SpotCheckHipROM(null);
    // Deserialize message field [error]
    data.error = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [hx]
    data.hx = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [hy]
    data.hy = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.hx.length;
    length += 4 * object.hy.length;
    return length + 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SpotCheckHipROM';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2bffa893cfa8c1ee57352f3ccf3348bc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Errors reflect an issue with hip range of motion
    uint8 ERROR_UNKNOWN = 0
    uint8 ERROR_NONE = 1
    uint8 ERROR_OBSTRUCTED = 2
    
    uint8 error
    
    # The measured angles (radians) of the HX and HY joints where the obstruction was detected
    float32[] hx
    float32[] hy
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckHipROM(null);
    if (msg.error !== undefined) {
      resolved.error = msg.error;
    }
    else {
      resolved.error = 0
    }

    if (msg.hx !== undefined) {
      resolved.hx = msg.hx;
    }
    else {
      resolved.hx = []
    }

    if (msg.hy !== undefined) {
      resolved.hy = msg.hy;
    }
    else {
      resolved.hy = []
    }

    return resolved;
    }
};

// Constants for message
SpotCheckHipROM.Constants = {
  ERROR_UNKNOWN: 0,
  ERROR_NONE: 1,
  ERROR_OBSTRUCTED: 2,
}

module.exports = SpotCheckHipROM;
