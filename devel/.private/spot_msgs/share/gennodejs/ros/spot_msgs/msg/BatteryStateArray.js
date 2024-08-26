// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let BatteryState = require('./BatteryState.js');

//-----------------------------------------------------------

class BatteryStateArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.battery_states = null;
    }
    else {
      if (initObj.hasOwnProperty('battery_states')) {
        this.battery_states = initObj.battery_states
      }
      else {
        this.battery_states = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BatteryStateArray
    // Serialize message field [battery_states]
    // Serialize the length for message field [battery_states]
    bufferOffset = _serializer.uint32(obj.battery_states.length, buffer, bufferOffset);
    obj.battery_states.forEach((val) => {
      bufferOffset = BatteryState.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BatteryStateArray
    let len;
    let data = new BatteryStateArray(null);
    // Deserialize message field [battery_states]
    // Deserialize array length for message field [battery_states]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.battery_states = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.battery_states[i] = BatteryState.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.battery_states.forEach((val) => {
      length += BatteryState.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/BatteryStateArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5be00bcb9a392f14ba6707e020a94106';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    BatteryState[] battery_states
    
    ================================================================================
    MSG: spot_msgs/BatteryState
    # Status
    uint8 STATUS_UNKNOWN = 0
    uint8 STATUS_MISSING = 1
    uint8 STATUS_CHARGING = 2
    uint8 STATUS_DISCHARGING = 3
    uint8 STATUS_BOOTING = 4
    
    Header header
    string identifier
    float64 charge_percentage
    duration estimated_runtime
    float64 current
    float64 voltage
    float64[] temperatures
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
    const resolved = new BatteryStateArray(null);
    if (msg.battery_states !== undefined) {
      resolved.battery_states = new Array(msg.battery_states.length);
      for (let i = 0; i < resolved.battery_states.length; ++i) {
        resolved.battery_states[i] = BatteryState.Resolve(msg.battery_states[i]);
      }
    }
    else {
      resolved.battery_states = []
    }

    return resolved;
    }
};

module.exports = BatteryStateArray;
