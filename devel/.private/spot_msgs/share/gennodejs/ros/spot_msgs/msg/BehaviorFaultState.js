// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let BehaviorFault = require('./BehaviorFault.js');

//-----------------------------------------------------------

class BehaviorFaultState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.faults = null;
    }
    else {
      if (initObj.hasOwnProperty('faults')) {
        this.faults = initObj.faults
      }
      else {
        this.faults = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BehaviorFaultState
    // Serialize message field [faults]
    // Serialize the length for message field [faults]
    bufferOffset = _serializer.uint32(obj.faults.length, buffer, bufferOffset);
    obj.faults.forEach((val) => {
      bufferOffset = BehaviorFault.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BehaviorFaultState
    let len;
    let data = new BehaviorFaultState(null);
    // Deserialize message field [faults]
    // Deserialize array length for message field [faults]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.faults = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.faults[i] = BehaviorFault.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.faults.forEach((val) => {
      length += BehaviorFault.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/BehaviorFaultState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '59543c1c1ad10a39140a97dcfc78f876';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    BehaviorFault[] faults
    
    ================================================================================
    MSG: spot_msgs/BehaviorFault
    # Cause
    uint8 CAUSE_UNKNOWN = 0
    uint8 CAUSE_FALL = 1
    uint8 CAUSE_HARDWARE = 2
    
    # Status
    uint8 STATUS_UNKNOWN = 0
    uint8 STATUS_CLEARABLE = 1
    uint8 STATUS_UNCLEARABLE = 2
    
    Header header
    uint32 behavior_fault_id
    uint8 cause
    uint8 status
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BehaviorFaultState(null);
    if (msg.faults !== undefined) {
      resolved.faults = new Array(msg.faults.length);
      for (let i = 0; i < resolved.faults.length; ++i) {
        resolved.faults[i] = BehaviorFault.Resolve(msg.faults[i]);
      }
    }
    else {
      resolved.faults = []
    }

    return resolved;
    }
};

module.exports = BehaviorFaultState;
