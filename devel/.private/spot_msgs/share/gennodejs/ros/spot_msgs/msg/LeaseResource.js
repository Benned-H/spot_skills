// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Lease = require('./Lease.js');
let LeaseOwner = require('./LeaseOwner.js');

//-----------------------------------------------------------

class LeaseResource {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.resource = null;
      this.lease = null;
      this.lease_owner = null;
    }
    else {
      if (initObj.hasOwnProperty('resource')) {
        this.resource = initObj.resource
      }
      else {
        this.resource = '';
      }
      if (initObj.hasOwnProperty('lease')) {
        this.lease = initObj.lease
      }
      else {
        this.lease = new Lease();
      }
      if (initObj.hasOwnProperty('lease_owner')) {
        this.lease_owner = initObj.lease_owner
      }
      else {
        this.lease_owner = new LeaseOwner();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LeaseResource
    // Serialize message field [resource]
    bufferOffset = _serializer.string(obj.resource, buffer, bufferOffset);
    // Serialize message field [lease]
    bufferOffset = Lease.serialize(obj.lease, buffer, bufferOffset);
    // Serialize message field [lease_owner]
    bufferOffset = LeaseOwner.serialize(obj.lease_owner, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LeaseResource
    let len;
    let data = new LeaseResource(null);
    // Deserialize message field [resource]
    data.resource = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [lease]
    data.lease = Lease.deserialize(buffer, bufferOffset);
    // Deserialize message field [lease_owner]
    data.lease_owner = LeaseOwner.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.resource);
    length += Lease.getMessageSize(object.lease);
    length += LeaseOwner.getMessageSize(object.lease_owner);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/LeaseResource';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e2b2b151bf21111e26403b0a4feba023';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new LeaseResource(null);
    if (msg.resource !== undefined) {
      resolved.resource = msg.resource;
    }
    else {
      resolved.resource = ''
    }

    if (msg.lease !== undefined) {
      resolved.lease = Lease.Resolve(msg.lease)
    }
    else {
      resolved.lease = new Lease()
    }

    if (msg.lease_owner !== undefined) {
      resolved.lease_owner = LeaseOwner.Resolve(msg.lease_owner)
    }
    else {
      resolved.lease_owner = new LeaseOwner()
    }

    return resolved;
    }
};

module.exports = LeaseResource;
