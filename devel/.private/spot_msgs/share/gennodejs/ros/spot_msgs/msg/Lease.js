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

class Lease {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.resource = null;
      this.epoch = null;
      this.sequence = null;
    }
    else {
      if (initObj.hasOwnProperty('resource')) {
        this.resource = initObj.resource
      }
      else {
        this.resource = '';
      }
      if (initObj.hasOwnProperty('epoch')) {
        this.epoch = initObj.epoch
      }
      else {
        this.epoch = '';
      }
      if (initObj.hasOwnProperty('sequence')) {
        this.sequence = initObj.sequence
      }
      else {
        this.sequence = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Lease
    // Serialize message field [resource]
    bufferOffset = _serializer.string(obj.resource, buffer, bufferOffset);
    // Serialize message field [epoch]
    bufferOffset = _serializer.string(obj.epoch, buffer, bufferOffset);
    // Serialize message field [sequence]
    bufferOffset = _arraySerializer.uint32(obj.sequence, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Lease
    let len;
    let data = new Lease(null);
    // Deserialize message field [resource]
    data.resource = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [epoch]
    data.epoch = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sequence]
    data.sequence = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.resource);
    length += _getByteLength(object.epoch);
    length += 4 * object.sequence.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/Lease';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '268ed4f702e0ce57ac084653ad1ace93';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string resource
    string epoch
    uint32[] sequence
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Lease(null);
    if (msg.resource !== undefined) {
      resolved.resource = msg.resource;
    }
    else {
      resolved.resource = ''
    }

    if (msg.epoch !== undefined) {
      resolved.epoch = msg.epoch;
    }
    else {
      resolved.epoch = ''
    }

    if (msg.sequence !== undefined) {
      resolved.sequence = msg.sequence;
    }
    else {
      resolved.sequence = []
    }

    return resolved;
    }
};

module.exports = Lease;
