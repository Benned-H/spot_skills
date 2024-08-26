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

class SpotCheckPayload {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.error = null;
      this.extra_payload = null;
    }
    else {
      if (initObj.hasOwnProperty('error')) {
        this.error = initObj.error
      }
      else {
        this.error = 0;
      }
      if (initObj.hasOwnProperty('extra_payload')) {
        this.extra_payload = initObj.extra_payload
      }
      else {
        this.extra_payload = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckPayload
    // Serialize message field [error]
    bufferOffset = _serializer.uint8(obj.error, buffer, bufferOffset);
    // Serialize message field [extra_payload]
    bufferOffset = _serializer.float32(obj.extra_payload, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckPayload
    let len;
    let data = new SpotCheckPayload(null);
    // Deserialize message field [error]
    data.error = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [extra_payload]
    data.extra_payload = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SpotCheckPayload';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8a5462c1672d0b3443d0f93dc832b167';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Errors reflect an issue with payload configuration.
    
    # Unused enum.
    uint8 ERROR_UNKNOWN = 0
    # No error found in the payloads.
    uint8 ERROR_NONE = 1
    # There is a mass discrepancy between the registered payload and what is estimated.
    uint8 ERROR_MASS_DISCREPANCY = 2
    
    # A flag to indicate if configuration has an error.
    uint8 error
    
    # Indicates how much extra payload (in kg) we think the robot has
    # Positive indicates robot has more payload than it is configured.
    # Negative indicates robot has less payload than it is configured.
    float32 extra_payload
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckPayload(null);
    if (msg.error !== undefined) {
      resolved.error = msg.error;
    }
    else {
      resolved.error = 0
    }

    if (msg.extra_payload !== undefined) {
      resolved.extra_payload = msg.extra_payload;
    }
    else {
      resolved.extra_payload = 0.0
    }

    return resolved;
    }
};

// Constants for message
SpotCheckPayload.Constants = {
  ERROR_UNKNOWN: 0,
  ERROR_NONE: 1,
  ERROR_MASS_DISCREPANCY: 2,
}

module.exports = SpotCheckPayload;
