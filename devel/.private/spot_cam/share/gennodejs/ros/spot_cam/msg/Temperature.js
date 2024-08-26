// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Temperature {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.channel_name = null;
      this.temperature = null;
    }
    else {
      if (initObj.hasOwnProperty('channel_name')) {
        this.channel_name = initObj.channel_name
      }
      else {
        this.channel_name = '';
      }
      if (initObj.hasOwnProperty('temperature')) {
        this.temperature = initObj.temperature
      }
      else {
        this.temperature = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Temperature
    // Serialize message field [channel_name]
    bufferOffset = _serializer.string(obj.channel_name, buffer, bufferOffset);
    // Serialize message field [temperature]
    bufferOffset = _serializer.float32(obj.temperature, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Temperature
    let len;
    let data = new Temperature(null);
    // Deserialize message field [channel_name]
    data.channel_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [temperature]
    data.temperature = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.channel_name);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/Temperature';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '086009cefe0e896fc6b042a5e575d367';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string channel_name
    float32 temperature
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Temperature(null);
    if (msg.channel_name !== undefined) {
      resolved.channel_name = msg.channel_name;
    }
    else {
      resolved.channel_name = ''
    }

    if (msg.temperature !== undefined) {
      resolved.temperature = msg.temperature;
    }
    else {
      resolved.temperature = 0.0
    }

    return resolved;
    }
};

module.exports = Temperature;
