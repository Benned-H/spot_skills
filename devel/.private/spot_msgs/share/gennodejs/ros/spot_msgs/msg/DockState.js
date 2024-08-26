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

class DockState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.status = null;
      this.dock_type = null;
      this.dock_id = null;
      this.power_status = null;
    }
    else {
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('dock_type')) {
        this.dock_type = initObj.dock_type
      }
      else {
        this.dock_type = 0;
      }
      if (initObj.hasOwnProperty('dock_id')) {
        this.dock_id = initObj.dock_id
      }
      else {
        this.dock_id = 0;
      }
      if (initObj.hasOwnProperty('power_status')) {
        this.power_status = initObj.power_status
      }
      else {
        this.power_status = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DockState
    // Serialize message field [status]
    bufferOffset = _serializer.uint8(obj.status, buffer, bufferOffset);
    // Serialize message field [dock_type]
    bufferOffset = _serializer.uint8(obj.dock_type, buffer, bufferOffset);
    // Serialize message field [dock_id]
    bufferOffset = _serializer.uint32(obj.dock_id, buffer, bufferOffset);
    // Serialize message field [power_status]
    bufferOffset = _serializer.uint8(obj.power_status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DockState
    let len;
    let data = new DockState(null);
    // Deserialize message field [status]
    data.status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [dock_type]
    data.dock_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [dock_id]
    data.dock_id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [power_status]
    data.power_status = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 7;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/DockState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a5cf6a3afaa5e6b3ccda4170a976059d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new DockState(null);
    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.dock_type !== undefined) {
      resolved.dock_type = msg.dock_type;
    }
    else {
      resolved.dock_type = 0
    }

    if (msg.dock_id !== undefined) {
      resolved.dock_id = msg.dock_id;
    }
    else {
      resolved.dock_id = 0
    }

    if (msg.power_status !== undefined) {
      resolved.power_status = msg.power_status;
    }
    else {
      resolved.power_status = 0
    }

    return resolved;
    }
};

// Constants for message
DockState.Constants = {
  DOCK_STATUS_UNKNOWN: 0,
  DOCK_STATUS_DOCKED: 1,
  DOCK_STATUS_DOCKING: 2,
  DOCK_STATUS_UNDOCKED: 3,
  DOCK_STATUS_UNDOCKING: 4,
  DOCK_TYPE_UNKNOWN: 0,
  DOCK_TYPE_CONTACT_PROTOTYPE: 2,
  DOCK_TYPE_SPOT_DOCK: 3,
  LINK_STATUS_UNKNOWN: 0,
  LINK_STATUS_CONNECTED: 1,
  LINK_STATUS_ERROR: 2,
  LINK_STATUS_DETECTING: 3,
}

module.exports = DockState;
