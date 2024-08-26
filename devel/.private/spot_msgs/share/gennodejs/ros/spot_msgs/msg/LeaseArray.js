// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LeaseResource = require('./LeaseResource.js');

//-----------------------------------------------------------

class LeaseArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.resources = null;
    }
    else {
      if (initObj.hasOwnProperty('resources')) {
        this.resources = initObj.resources
      }
      else {
        this.resources = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LeaseArray
    // Serialize message field [resources]
    // Serialize the length for message field [resources]
    bufferOffset = _serializer.uint32(obj.resources.length, buffer, bufferOffset);
    obj.resources.forEach((val) => {
      bufferOffset = LeaseResource.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LeaseArray
    let len;
    let data = new LeaseArray(null);
    // Deserialize message field [resources]
    // Deserialize array length for message field [resources]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.resources = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.resources[i] = LeaseResource.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.resources.forEach((val) => {
      length += LeaseResource.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/LeaseArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1e9c3bf77fbef8b5aa6a3bea6c733c8a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    LeaseResource[] resources
    
    ================================================================================
    MSG: spot_msgs/LeaseResource
    string resource
    Lease lease
    LeaseOwner lease_owner
    
    ================================================================================
    MSG: spot_msgs/Lease
    string resource
    string epoch
    uint32[] sequence
    
    ================================================================================
    MSG: spot_msgs/LeaseOwner
    string client_name
    string user_name
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LeaseArray(null);
    if (msg.resources !== undefined) {
      resolved.resources = new Array(msg.resources.length);
      for (let i = 0; i < resolved.resources.length; ++i) {
        resolved.resources[i] = LeaseResource.Resolve(msg.resources[i]);
      }
    }
    else {
      resolved.resources = []
    }

    return resolved;
    }
};

module.exports = LeaseArray;
