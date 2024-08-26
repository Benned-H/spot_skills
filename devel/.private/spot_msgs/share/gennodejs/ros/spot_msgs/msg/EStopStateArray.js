// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let EStopState = require('./EStopState.js');

//-----------------------------------------------------------

class EStopStateArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.estop_states = null;
    }
    else {
      if (initObj.hasOwnProperty('estop_states')) {
        this.estop_states = initObj.estop_states
      }
      else {
        this.estop_states = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EStopStateArray
    // Serialize message field [estop_states]
    // Serialize the length for message field [estop_states]
    bufferOffset = _serializer.uint32(obj.estop_states.length, buffer, bufferOffset);
    obj.estop_states.forEach((val) => {
      bufferOffset = EStopState.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EStopStateArray
    let len;
    let data = new EStopStateArray(null);
    // Deserialize message field [estop_states]
    // Deserialize array length for message field [estop_states]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.estop_states = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.estop_states[i] = EStopState.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.estop_states.forEach((val) => {
      length += EStopState.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/EStopStateArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9a14a6b761f26c00c5613f0dc614f084';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    EStopState[] estop_states
    
    ================================================================================
    MSG: spot_msgs/EStopState
    # Type
    uint8 TYPE_UNKNOWN = 0
    uint8 TYPE_HARDWARE = 1
    uint8 TYPE_SOFTWARE = 2
    
    # State
    uint8 STATE_UNKNOWN = 0
    uint8 STATE_ESTOPPED = 1
    uint8 STATE_NOT_ESTOPPED = 2
    
    Header header
    string name
    uint8 type
    uint8 state
    string state_description
    
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
    const resolved = new EStopStateArray(null);
    if (msg.estop_states !== undefined) {
      resolved.estop_states = new Array(msg.estop_states.length);
      for (let i = 0; i < resolved.estop_states.length; ++i) {
        resolved.estop_states[i] = EStopState.Resolve(msg.estop_states[i]);
      }
    }
    else {
      resolved.estop_states = []
    }

    return resolved;
    }
};

module.exports = EStopStateArray;
