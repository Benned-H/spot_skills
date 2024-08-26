// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SystemFault = require('./SystemFault.js');

//-----------------------------------------------------------

class SystemFaultState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.faults = null;
      this.historical_faults = null;
    }
    else {
      if (initObj.hasOwnProperty('faults')) {
        this.faults = initObj.faults
      }
      else {
        this.faults = [];
      }
      if (initObj.hasOwnProperty('historical_faults')) {
        this.historical_faults = initObj.historical_faults
      }
      else {
        this.historical_faults = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SystemFaultState
    // Serialize message field [faults]
    // Serialize the length for message field [faults]
    bufferOffset = _serializer.uint32(obj.faults.length, buffer, bufferOffset);
    obj.faults.forEach((val) => {
      bufferOffset = SystemFault.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [historical_faults]
    // Serialize the length for message field [historical_faults]
    bufferOffset = _serializer.uint32(obj.historical_faults.length, buffer, bufferOffset);
    obj.historical_faults.forEach((val) => {
      bufferOffset = SystemFault.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SystemFaultState
    let len;
    let data = new SystemFaultState(null);
    // Deserialize message field [faults]
    // Deserialize array length for message field [faults]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.faults = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.faults[i] = SystemFault.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [historical_faults]
    // Deserialize array length for message field [historical_faults]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.historical_faults = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.historical_faults[i] = SystemFault.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.faults.forEach((val) => {
      length += SystemFault.getMessageSize(val);
    });
    object.historical_faults.forEach((val) => {
      length += SystemFault.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SystemFaultState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3847105c5e3204fe63ad7caa31a33575';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    SystemFault[] faults
    SystemFault[] historical_faults
    
    ================================================================================
    MSG: spot_msgs/SystemFault
    # Severity
    uint8 SEVERITY_UNKNOWN = 0
    uint8 SEVERITY_INFO = 1
    uint8 SEVERITY_WARN = 2
    uint8 SEVERITY_CRITICAL = 3
    
    Header header
    string name
    duration duration
    int32 code
    uint64 uid
    string error_message
    string[] attributes
    uint8 severity
    
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
    const resolved = new SystemFaultState(null);
    if (msg.faults !== undefined) {
      resolved.faults = new Array(msg.faults.length);
      for (let i = 0; i < resolved.faults.length; ++i) {
        resolved.faults[i] = SystemFault.Resolve(msg.faults[i]);
      }
    }
    else {
      resolved.faults = []
    }

    if (msg.historical_faults !== undefined) {
      resolved.historical_faults = new Array(msg.historical_faults.length);
      for (let i = 0; i < resolved.historical_faults.length; ++i) {
        resolved.historical_faults[i] = SystemFault.Resolve(msg.historical_faults[i]);
      }
    }
    else {
      resolved.historical_faults = []
    }

    return resolved;
    }
};

module.exports = SystemFaultState;
