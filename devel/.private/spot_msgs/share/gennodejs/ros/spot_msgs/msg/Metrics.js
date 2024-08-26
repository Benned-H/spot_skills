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

class Metrics {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.distance = null;
      this.gait_cycles = null;
      this.time_moving = null;
      this.electric_power = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
      if (initObj.hasOwnProperty('gait_cycles')) {
        this.gait_cycles = initObj.gait_cycles
      }
      else {
        this.gait_cycles = 0;
      }
      if (initObj.hasOwnProperty('time_moving')) {
        this.time_moving = initObj.time_moving
      }
      else {
        this.time_moving = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('electric_power')) {
        this.electric_power = initObj.electric_power
      }
      else {
        this.electric_power = {secs: 0, nsecs: 0};
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Metrics
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.float32(obj.distance, buffer, bufferOffset);
    // Serialize message field [gait_cycles]
    bufferOffset = _serializer.int32(obj.gait_cycles, buffer, bufferOffset);
    // Serialize message field [time_moving]
    bufferOffset = _serializer.duration(obj.time_moving, buffer, bufferOffset);
    // Serialize message field [electric_power]
    bufferOffset = _serializer.duration(obj.electric_power, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Metrics
    let len;
    let data = new Metrics(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [gait_cycles]
    data.gait_cycles = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [time_moving]
    data.time_moving = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [electric_power]
    data.electric_power = _deserializer.duration(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/Metrics';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '493e599307ab2a6dbe49405e7b5a9b6d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    float32 distance
    int32 gait_cycles
    duration time_moving
    duration electric_power
    
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
    const resolved = new Metrics(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    if (msg.gait_cycles !== undefined) {
      resolved.gait_cycles = msg.gait_cycles;
    }
    else {
      resolved.gait_cycles = 0
    }

    if (msg.time_moving !== undefined) {
      resolved.time_moving = msg.time_moving;
    }
    else {
      resolved.time_moving = {secs: 0, nsecs: 0}
    }

    if (msg.electric_power !== undefined) {
      resolved.electric_power = msg.electric_power;
    }
    else {
      resolved.electric_power = {secs: 0, nsecs: 0}
    }

    return resolved;
    }
};

module.exports = Metrics;
