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

class SpotCheckKinematic {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.error = null;
      this.offset = null;
      this.old_offset = null;
      this.health_score = null;
    }
    else {
      if (initObj.hasOwnProperty('error')) {
        this.error = initObj.error
      }
      else {
        this.error = 0;
      }
      if (initObj.hasOwnProperty('offset')) {
        this.offset = initObj.offset
      }
      else {
        this.offset = 0.0;
      }
      if (initObj.hasOwnProperty('old_offset')) {
        this.old_offset = initObj.old_offset
      }
      else {
        this.old_offset = 0.0;
      }
      if (initObj.hasOwnProperty('health_score')) {
        this.health_score = initObj.health_score
      }
      else {
        this.health_score = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckKinematic
    // Serialize message field [error]
    bufferOffset = _serializer.uint8(obj.error, buffer, bufferOffset);
    // Serialize message field [offset]
    bufferOffset = _serializer.float32(obj.offset, buffer, bufferOffset);
    // Serialize message field [old_offset]
    bufferOffset = _serializer.float32(obj.old_offset, buffer, bufferOffset);
    // Serialize message field [health_score]
    bufferOffset = _serializer.float32(obj.health_score, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckKinematic
    let len;
    let data = new SpotCheckKinematic(null);
    // Deserialize message field [error]
    data.error = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [offset]
    data.offset = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [old_offset]
    data.old_offset = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [health_score]
    data.health_score = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SpotCheckKinematic';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fe33606761c255ffb331f260e7ee4d23';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Errors reflect an issue with robot hardware.
    uint8 ERROR_UNKNOWN = 0       # Unused enum.
    uint8 ERROR_NONE = 1          # No hardware error detected.
    uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.
    uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.
    
    # A flag to indicate if results has an error.
    uint8 error
    
    # The current offset [rad]
    float32 offset
    # The previous offset [rad]
    float32 old_offset
    
    # Joint calibration health score. range [0-1]
    # 0 indicates an unhealthy kinematic joint calibration
    # 1 indicates a perfect kinematic joint calibration
    # Typically, values greater than 0.8 should be expected.
    float32 health_score
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckKinematic(null);
    if (msg.error !== undefined) {
      resolved.error = msg.error;
    }
    else {
      resolved.error = 0
    }

    if (msg.offset !== undefined) {
      resolved.offset = msg.offset;
    }
    else {
      resolved.offset = 0.0
    }

    if (msg.old_offset !== undefined) {
      resolved.old_offset = msg.old_offset;
    }
    else {
      resolved.old_offset = 0.0
    }

    if (msg.health_score !== undefined) {
      resolved.health_score = msg.health_score;
    }
    else {
      resolved.health_score = 0.0
    }

    return resolved;
    }
};

// Constants for message
SpotCheckKinematic.Constants = {
  ERROR_UNKNOWN: 0,
  ERROR_NONE: 1,
  ERROR_CLUTCH_SLIP: 2,
  ERROR_INVALID_RANGE_OF_MOTION: 3,
}

module.exports = SpotCheckKinematic;
