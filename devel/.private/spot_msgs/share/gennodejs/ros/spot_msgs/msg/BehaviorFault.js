// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class BehaviorFault {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.behavior_fault_id = null;
      this.cause = null;
      this.status = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('behavior_fault_id')) {
        this.behavior_fault_id = initObj.behavior_fault_id
      }
      else {
        this.behavior_fault_id = 0;
      }
      if (initObj.hasOwnProperty('cause')) {
        this.cause = initObj.cause
      }
      else {
        this.cause = 0;
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BehaviorFault
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [behavior_fault_id]
    bufferOffset = _serializer.uint32(obj.behavior_fault_id, buffer, bufferOffset);
    // Serialize message field [cause]
    bufferOffset = _serializer.uint8(obj.cause, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.uint8(obj.status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BehaviorFault
    let len;
    let data = new BehaviorFault(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [behavior_fault_id]
    data.behavior_fault_id = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [cause]
    data.cause = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 6;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/BehaviorFault';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '849048e719811a4f2cf68e276a235d76';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new BehaviorFault(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.behavior_fault_id !== undefined) {
      resolved.behavior_fault_id = msg.behavior_fault_id;
    }
    else {
      resolved.behavior_fault_id = 0
    }

    if (msg.cause !== undefined) {
      resolved.cause = msg.cause;
    }
    else {
      resolved.cause = 0
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    return resolved;
    }
};

// Constants for message
BehaviorFault.Constants = {
  CAUSE_UNKNOWN: 0,
  CAUSE_FALL: 1,
  CAUSE_HARDWARE: 2,
  STATUS_UNKNOWN: 0,
  STATUS_CLEARABLE: 1,
  STATUS_UNCLEARABLE: 2,
}

module.exports = BehaviorFault;
