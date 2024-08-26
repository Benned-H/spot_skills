// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Degradation = require('./Degradation.js');
let spot_msgs = _finder('spot_msgs');

//-----------------------------------------------------------

class BITStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.events = null;
      this.degradations = null;
    }
    else {
      if (initObj.hasOwnProperty('events')) {
        this.events = initObj.events
      }
      else {
        this.events = [];
      }
      if (initObj.hasOwnProperty('degradations')) {
        this.degradations = initObj.degradations
      }
      else {
        this.degradations = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BITStatus
    // Serialize message field [events]
    // Serialize the length for message field [events]
    bufferOffset = _serializer.uint32(obj.events.length, buffer, bufferOffset);
    obj.events.forEach((val) => {
      bufferOffset = spot_msgs.msg.SystemFault.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [degradations]
    // Serialize the length for message field [degradations]
    bufferOffset = _serializer.uint32(obj.degradations.length, buffer, bufferOffset);
    obj.degradations.forEach((val) => {
      bufferOffset = Degradation.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BITStatus
    let len;
    let data = new BITStatus(null);
    // Deserialize message field [events]
    // Deserialize array length for message field [events]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.events = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.events[i] = spot_msgs.msg.SystemFault.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [degradations]
    // Deserialize array length for message field [degradations]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.degradations = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.degradations[i] = Degradation.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.events.forEach((val) => {
      length += spot_msgs.msg.SystemFault.getMessageSize(val);
    });
    object.degradations.forEach((val) => {
      length += Degradation.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/BITStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bbef0264c8e68f60c3f5c0359d3c130d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse
    spot_msgs/SystemFault[] events
    spot_cam/Degradation[] degradations
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
    
    ================================================================================
    MSG: spot_cam/Degradation
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#getbitstatusresponse-degradation
    # Different degradation types
    uint8 TYPE_STORAGE=0
    uint8 TYPE_PTZ=1
    uint8 TYPE_LED=2
    
    # The system affected by the degradation
    uint8 type
    # What degradation is being experienced
    string description
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BITStatus(null);
    if (msg.events !== undefined) {
      resolved.events = new Array(msg.events.length);
      for (let i = 0; i < resolved.events.length; ++i) {
        resolved.events[i] = spot_msgs.msg.SystemFault.Resolve(msg.events[i]);
      }
    }
    else {
      resolved.events = []
    }

    if (msg.degradations !== undefined) {
      resolved.degradations = new Array(msg.degradations.length);
      for (let i = 0; i < resolved.degradations.length; ++i) {
        resolved.degradations[i] = Degradation.Resolve(msg.degradations[i]);
      }
    }
    else {
      resolved.degradations = []
    }

    return resolved;
    }
};

module.exports = BITStatus;
