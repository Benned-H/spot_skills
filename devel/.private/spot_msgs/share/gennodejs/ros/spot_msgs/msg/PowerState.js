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

class PowerState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.motor_power_state = null;
      this.shore_power_state = null;
      this.locomotion_charge_percentage = null;
      this.locomotion_estimated_runtime = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('motor_power_state')) {
        this.motor_power_state = initObj.motor_power_state
      }
      else {
        this.motor_power_state = 0;
      }
      if (initObj.hasOwnProperty('shore_power_state')) {
        this.shore_power_state = initObj.shore_power_state
      }
      else {
        this.shore_power_state = 0;
      }
      if (initObj.hasOwnProperty('locomotion_charge_percentage')) {
        this.locomotion_charge_percentage = initObj.locomotion_charge_percentage
      }
      else {
        this.locomotion_charge_percentage = 0.0;
      }
      if (initObj.hasOwnProperty('locomotion_estimated_runtime')) {
        this.locomotion_estimated_runtime = initObj.locomotion_estimated_runtime
      }
      else {
        this.locomotion_estimated_runtime = {secs: 0, nsecs: 0};
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PowerState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [motor_power_state]
    bufferOffset = _serializer.uint8(obj.motor_power_state, buffer, bufferOffset);
    // Serialize message field [shore_power_state]
    bufferOffset = _serializer.uint8(obj.shore_power_state, buffer, bufferOffset);
    // Serialize message field [locomotion_charge_percentage]
    bufferOffset = _serializer.float64(obj.locomotion_charge_percentage, buffer, bufferOffset);
    // Serialize message field [locomotion_estimated_runtime]
    bufferOffset = _serializer.duration(obj.locomotion_estimated_runtime, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PowerState
    let len;
    let data = new PowerState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [motor_power_state]
    data.motor_power_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [shore_power_state]
    data.shore_power_state = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [locomotion_charge_percentage]
    data.locomotion_charge_percentage = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [locomotion_estimated_runtime]
    data.locomotion_estimated_runtime = _deserializer.duration(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 18;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/PowerState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1248df72d2f23288441e3a23d09bd4f0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # MotorPowerState
    uint8 STATE_UNKNOWN = 0
    uint8 STATE_OFF = 1
    uint8 STATE_ON = 2
    uint8 STATE_POWERING_ON = 3
    uint8 STATE_POWERING_OFF = 4
    uint8 STATE_ERROR = 5
    
    # ShorePowerState
    uint8 STATE_UNKNOWN_SHORE_POWER = 0
    uint8 STATE_ON_SHORE_POWER = 1
    uint8 STATE_OFF_SHORE_POWER = 2
    
    Header header
    uint8 motor_power_state
    uint8 shore_power_state
    float64 locomotion_charge_percentage
    duration locomotion_estimated_runtime
    
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
    const resolved = new PowerState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.motor_power_state !== undefined) {
      resolved.motor_power_state = msg.motor_power_state;
    }
    else {
      resolved.motor_power_state = 0
    }

    if (msg.shore_power_state !== undefined) {
      resolved.shore_power_state = msg.shore_power_state;
    }
    else {
      resolved.shore_power_state = 0
    }

    if (msg.locomotion_charge_percentage !== undefined) {
      resolved.locomotion_charge_percentage = msg.locomotion_charge_percentage;
    }
    else {
      resolved.locomotion_charge_percentage = 0.0
    }

    if (msg.locomotion_estimated_runtime !== undefined) {
      resolved.locomotion_estimated_runtime = msg.locomotion_estimated_runtime;
    }
    else {
      resolved.locomotion_estimated_runtime = {secs: 0, nsecs: 0}
    }

    return resolved;
    }
};

// Constants for message
PowerState.Constants = {
  STATE_UNKNOWN: 0,
  STATE_OFF: 1,
  STATE_ON: 2,
  STATE_POWERING_ON: 3,
  STATE_POWERING_OFF: 4,
  STATE_ERROR: 5,
  STATE_UNKNOWN_SHORE_POWER: 0,
  STATE_ON_SHORE_POWER: 1,
  STATE_OFF_SHORE_POWER: 2,
}

module.exports = PowerState;
