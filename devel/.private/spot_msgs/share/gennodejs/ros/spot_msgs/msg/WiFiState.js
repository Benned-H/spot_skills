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

class WiFiState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.current_mode = null;
      this.essid = null;
    }
    else {
      if (initObj.hasOwnProperty('current_mode')) {
        this.current_mode = initObj.current_mode
      }
      else {
        this.current_mode = 0;
      }
      if (initObj.hasOwnProperty('essid')) {
        this.essid = initObj.essid
      }
      else {
        this.essid = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WiFiState
    // Serialize message field [current_mode]
    bufferOffset = _serializer.uint8(obj.current_mode, buffer, bufferOffset);
    // Serialize message field [essid]
    bufferOffset = _serializer.string(obj.essid, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WiFiState
    let len;
    let data = new WiFiState(null);
    // Deserialize message field [current_mode]
    data.current_mode = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [essid]
    data.essid = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.essid);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/WiFiState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ba66be2de3368e3a5a22e1ccf928954a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Mode
    uint8 MODE_UNKNOWN = 0
    uint8 MODE_ACCESS_POINT = 1
    uint8 MODE_CLIENT = 2
    
    uint8 current_mode
    string essid
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WiFiState(null);
    if (msg.current_mode !== undefined) {
      resolved.current_mode = msg.current_mode;
    }
    else {
      resolved.current_mode = 0
    }

    if (msg.essid !== undefined) {
      resolved.essid = msg.essid;
    }
    else {
      resolved.essid = ''
    }

    return resolved;
    }
};

// Constants for message
WiFiState.Constants = {
  MODE_UNKNOWN: 0,
  MODE_ACCESS_POINT: 1,
  MODE_CLIENT: 2,
}

module.exports = WiFiState;
