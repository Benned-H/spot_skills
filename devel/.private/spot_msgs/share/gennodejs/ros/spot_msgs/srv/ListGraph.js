// Auto-generated. Do not edit!

// (in-package spot_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ListGraphRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ListGraphRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ListGraphRequest
    let len;
    let data = new ListGraphRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/ListGraphRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ListGraphRequest(null);
    return resolved;
    }
};

class ListGraphResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.waypoint_ids = null;
    }
    else {
      if (initObj.hasOwnProperty('waypoint_ids')) {
        this.waypoint_ids = initObj.waypoint_ids
      }
      else {
        this.waypoint_ids = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ListGraphResponse
    // Serialize message field [waypoint_ids]
    bufferOffset = _arraySerializer.string(obj.waypoint_ids, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ListGraphResponse
    let len;
    let data = new ListGraphResponse(null);
    // Deserialize message field [waypoint_ids]
    data.waypoint_ids = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.waypoint_ids.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/ListGraphResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '118b8bcfd9aa792758857e91da4c7a89';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] waypoint_ids
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ListGraphResponse(null);
    if (msg.waypoint_ids !== undefined) {
      resolved.waypoint_ids = msg.waypoint_ids;
    }
    else {
      resolved.waypoint_ids = []
    }

    return resolved;
    }
};

module.exports = {
  Request: ListGraphRequest,
  Response: ListGraphResponse,
  md5sum() { return '118b8bcfd9aa792758857e91da4c7a89'; },
  datatype() { return 'spot_msgs/ListGraph'; }
};
