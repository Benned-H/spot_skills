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

class LeaseOwner {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.client_name = null;
      this.user_name = null;
    }
    else {
      if (initObj.hasOwnProperty('client_name')) {
        this.client_name = initObj.client_name
      }
      else {
        this.client_name = '';
      }
      if (initObj.hasOwnProperty('user_name')) {
        this.user_name = initObj.user_name
      }
      else {
        this.user_name = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LeaseOwner
    // Serialize message field [client_name]
    bufferOffset = _serializer.string(obj.client_name, buffer, bufferOffset);
    // Serialize message field [user_name]
    bufferOffset = _serializer.string(obj.user_name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LeaseOwner
    let len;
    let data = new LeaseOwner(null);
    // Deserialize message field [client_name]
    data.client_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [user_name]
    data.user_name = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.client_name);
    length += _getByteLength(object.user_name);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/LeaseOwner';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5cea27b2d1a89312b1101c1d985fe078';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string client_name
    string user_name
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LeaseOwner(null);
    if (msg.client_name !== undefined) {
      resolved.client_name = msg.client_name;
    }
    else {
      resolved.client_name = ''
    }

    if (msg.user_name !== undefined) {
      resolved.user_name = msg.user_name;
    }
    else {
      resolved.user_name = ''
    }

    return resolved;
    }
};

module.exports = LeaseOwner;
