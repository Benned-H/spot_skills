// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Temperature = require('./Temperature.js');

//-----------------------------------------------------------

class TemperatureArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.temperatures = null;
    }
    else {
      if (initObj.hasOwnProperty('temperatures')) {
        this.temperatures = initObj.temperatures
      }
      else {
        this.temperatures = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TemperatureArray
    // Serialize message field [temperatures]
    // Serialize the length for message field [temperatures]
    bufferOffset = _serializer.uint32(obj.temperatures.length, buffer, bufferOffset);
    obj.temperatures.forEach((val) => {
      bufferOffset = Temperature.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TemperatureArray
    let len;
    let data = new TemperatureArray(null);
    // Deserialize message field [temperatures]
    // Deserialize array length for message field [temperatures]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.temperatures = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.temperatures[i] = Temperature.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.temperatures.forEach((val) => {
      length += Temperature.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/TemperatureArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '73e05ea32a31a886a7c7b59b78f7eb0b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    spot_cam/Temperature[] temperatures
    ================================================================================
    MSG: spot_cam/Temperature
    string channel_name
    float32 temperature
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TemperatureArray(null);
    if (msg.temperatures !== undefined) {
      resolved.temperatures = new Array(msg.temperatures.length);
      for (let i = 0; i < resolved.temperatures.length; ++i) {
        resolved.temperatures[i] = Temperature.Resolve(msg.temperatures[i]);
      }
    }
    else {
      resolved.temperatures = []
    }

    return resolved;
    }
};

module.exports = TemperatureArray;
