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

let DockState = require('../msg/DockState.js');

//-----------------------------------------------------------

class GetDockStateRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDockStateRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDockStateRequest
    let len;
    let data = new GetDockStateRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/GetDockStateRequest';
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
    const resolved = new GetDockStateRequest(null);
    return resolved;
    }
};

class GetDockStateResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.dock_state = null;
    }
    else {
      if (initObj.hasOwnProperty('dock_state')) {
        this.dock_state = initObj.dock_state
      }
      else {
        this.dock_state = new DockState();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDockStateResponse
    // Serialize message field [dock_state]
    bufferOffset = DockState.serialize(obj.dock_state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDockStateResponse
    let len;
    let data = new GetDockStateResponse(null);
    // Deserialize message field [dock_state]
    data.dock_state = DockState.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 7;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/GetDockStateResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '01a4a21c7545e2e6d9b2173fc84d1af7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    DockState dock_state
    
    ================================================================================
    MSG: spot_msgs/DockState
    # Status
    uint8 DOCK_STATUS_UNKNOWN = 0
    uint8 DOCK_STATUS_DOCKED = 1
    uint8 DOCK_STATUS_DOCKING = 2
    uint8 DOCK_STATUS_UNDOCKED = 3
    uint8 DOCK_STATUS_UNDOCKING = 4
    
    # DockType
    uint8 DOCK_TYPE_UNKNOWN = 0
    uint8 DOCK_TYPE_CONTACT_PROTOTYPE = 2
    uint8 DOCK_TYPE_SPOT_DOCK = 3
    
    # LinkStatus
    uint8 LINK_STATUS_UNKNOWN = 0
    uint8 LINK_STATUS_CONNECTED = 1
    uint8 LINK_STATUS_ERROR = 2
    uint8 LINK_STATUS_DETECTING = 3
    
    uint8 status
    uint8 dock_type
    uint32 dock_id
    uint8 power_status
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDockStateResponse(null);
    if (msg.dock_state !== undefined) {
      resolved.dock_state = DockState.Resolve(msg.dock_state)
    }
    else {
      resolved.dock_state = new DockState()
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDockStateRequest,
  Response: GetDockStateResponse,
  md5sum() { return '01a4a21c7545e2e6d9b2173fc84d1af7'; },
  datatype() { return 'spot_msgs/GetDockState'; }
};
