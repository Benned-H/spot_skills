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

class SystemFault {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.name = null;
      this.duration = null;
      this.code = null;
      this.uid = null;
      this.error_message = null;
      this.attributes = null;
      this.severity = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('duration')) {
        this.duration = initObj.duration
      }
      else {
        this.duration = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('code')) {
        this.code = initObj.code
      }
      else {
        this.code = 0;
      }
      if (initObj.hasOwnProperty('uid')) {
        this.uid = initObj.uid
      }
      else {
        this.uid = 0;
      }
      if (initObj.hasOwnProperty('error_message')) {
        this.error_message = initObj.error_message
      }
      else {
        this.error_message = '';
      }
      if (initObj.hasOwnProperty('attributes')) {
        this.attributes = initObj.attributes
      }
      else {
        this.attributes = [];
      }
      if (initObj.hasOwnProperty('severity')) {
        this.severity = initObj.severity
      }
      else {
        this.severity = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SystemFault
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [duration]
    bufferOffset = _serializer.duration(obj.duration, buffer, bufferOffset);
    // Serialize message field [code]
    bufferOffset = _serializer.int32(obj.code, buffer, bufferOffset);
    // Serialize message field [uid]
    bufferOffset = _serializer.uint64(obj.uid, buffer, bufferOffset);
    // Serialize message field [error_message]
    bufferOffset = _serializer.string(obj.error_message, buffer, bufferOffset);
    // Serialize message field [attributes]
    bufferOffset = _arraySerializer.string(obj.attributes, buffer, bufferOffset, null);
    // Serialize message field [severity]
    bufferOffset = _serializer.uint8(obj.severity, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SystemFault
    let len;
    let data = new SystemFault(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [duration]
    data.duration = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [code]
    data.code = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [uid]
    data.uid = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [error_message]
    data.error_message = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [attributes]
    data.attributes = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [severity]
    data.severity = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += _getByteLength(object.name);
    length += _getByteLength(object.error_message);
    object.attributes.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 33;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/SystemFault';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd4409a7e7087c0e4485ccf8e05022a5d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new SystemFault(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.duration !== undefined) {
      resolved.duration = msg.duration;
    }
    else {
      resolved.duration = {secs: 0, nsecs: 0}
    }

    if (msg.code !== undefined) {
      resolved.code = msg.code;
    }
    else {
      resolved.code = 0
    }

    if (msg.uid !== undefined) {
      resolved.uid = msg.uid;
    }
    else {
      resolved.uid = 0
    }

    if (msg.error_message !== undefined) {
      resolved.error_message = msg.error_message;
    }
    else {
      resolved.error_message = ''
    }

    if (msg.attributes !== undefined) {
      resolved.attributes = msg.attributes;
    }
    else {
      resolved.attributes = []
    }

    if (msg.severity !== undefined) {
      resolved.severity = msg.severity;
    }
    else {
      resolved.severity = 0
    }

    return resolved;
    }
};

// Constants for message
SystemFault.Constants = {
  SEVERITY_UNKNOWN: 0,
  SEVERITY_INFO: 1,
  SEVERITY_WARN: 2,
  SEVERITY_CRITICAL: 3,
}

module.exports = SystemFault;
