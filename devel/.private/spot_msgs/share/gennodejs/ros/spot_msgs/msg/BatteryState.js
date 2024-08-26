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

class BatteryState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.identifier = null;
      this.charge_percentage = null;
      this.estimated_runtime = null;
      this.current = null;
      this.voltage = null;
      this.temperatures = null;
      this.status = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('identifier')) {
        this.identifier = initObj.identifier
      }
      else {
        this.identifier = '';
      }
      if (initObj.hasOwnProperty('charge_percentage')) {
        this.charge_percentage = initObj.charge_percentage
      }
      else {
        this.charge_percentage = 0.0;
      }
      if (initObj.hasOwnProperty('estimated_runtime')) {
        this.estimated_runtime = initObj.estimated_runtime
      }
      else {
        this.estimated_runtime = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('current')) {
        this.current = initObj.current
      }
      else {
        this.current = 0.0;
      }
      if (initObj.hasOwnProperty('voltage')) {
        this.voltage = initObj.voltage
      }
      else {
        this.voltage = 0.0;
      }
      if (initObj.hasOwnProperty('temperatures')) {
        this.temperatures = initObj.temperatures
      }
      else {
        this.temperatures = [];
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
    // Serializes a message object of type BatteryState
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [identifier]
    bufferOffset = _serializer.string(obj.identifier, buffer, bufferOffset);
    // Serialize message field [charge_percentage]
    bufferOffset = _serializer.float64(obj.charge_percentage, buffer, bufferOffset);
    // Serialize message field [estimated_runtime]
    bufferOffset = _serializer.duration(obj.estimated_runtime, buffer, bufferOffset);
    // Serialize message field [current]
    bufferOffset = _serializer.float64(obj.current, buffer, bufferOffset);
    // Serialize message field [voltage]
    bufferOffset = _serializer.float64(obj.voltage, buffer, bufferOffset);
    // Serialize message field [temperatures]
    bufferOffset = _arraySerializer.float64(obj.temperatures, buffer, bufferOffset, null);
    // Serialize message field [status]
    bufferOffset = _serializer.uint8(obj.status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BatteryState
    let len;
    let data = new BatteryState(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [identifier]
    data.identifier = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [charge_percentage]
    data.charge_percentage = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [estimated_runtime]
    data.estimated_runtime = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [current]
    data.current = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [voltage]
    data.voltage = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [temperatures]
    data.temperatures = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [status]
    data.status = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.identifier);
    length += 8 * object.temperatures.length;
    return length + 41;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/BatteryState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd4f77065e2805bf6a288541cb5a848ce';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new BatteryState(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.identifier !== undefined) {
      resolved.identifier = msg.identifier;
    }
    else {
      resolved.identifier = ''
    }

    if (msg.charge_percentage !== undefined) {
      resolved.charge_percentage = msg.charge_percentage;
    }
    else {
      resolved.charge_percentage = 0.0
    }

    if (msg.estimated_runtime !== undefined) {
      resolved.estimated_runtime = msg.estimated_runtime;
    }
    else {
      resolved.estimated_runtime = {secs: 0, nsecs: 0}
    }

    if (msg.current !== undefined) {
      resolved.current = msg.current;
    }
    else {
      resolved.current = 0.0
    }

    if (msg.voltage !== undefined) {
      resolved.voltage = msg.voltage;
    }
    else {
      resolved.voltage = 0.0
    }

    if (msg.temperatures !== undefined) {
      resolved.temperatures = msg.temperatures;
    }
    else {
      resolved.temperatures = []
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
BatteryState.Constants = {
  STATUS_UNKNOWN: 0,
  STATUS_MISSING: 1,
  STATUS_CHARGING: 2,
  STATUS_DISCHARGING: 3,
  STATUS_BOOTING: 4,
}

module.exports = BatteryState;
