// Auto-generated. Do not edit!

// (in-package spot_cam.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PTZState = require('../msg/PTZState.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetPTZStateRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.command = null;
    }
    else {
      if (initObj.hasOwnProperty('command')) {
        this.command = initObj.command
      }
      else {
        this.command = new PTZState();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetPTZStateRequest
    // Serialize message field [command]
    bufferOffset = PTZState.serialize(obj.command, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetPTZStateRequest
    let len;
    let data = new SetPTZStateRequest(null);
    // Deserialize message field [command]
    data.command = PTZState.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += PTZState.getMessageSize(object.command);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_cam/SetPTZStateRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e08053b336ca453cbb59f5d2035c7110';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # This message can be used to send either position or velocity commands
    # The description of the ptz does not need to be complete - only the name is used
    spot_cam/PTZState command
    
    ================================================================================
    MSG: spot_cam/PTZState
    # This message covers two different types which have the exact same field names, to reduce duplication. Depending on the topic,
    # The meaning of the pan/tilt/zoom values changes.
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzposition
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzvelocity
    std_msgs/Header header
    # Description of the ptz
    spot_cam/PTZDescription ptz
    # degrees or degrees per second
    float32 pan
    # degrees or degrees per second
    float32 tilt
    # zoom level or zoom level per second
    float32 zoom
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
    MSG: spot_cam/PTZDescription
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
    # Name of this ptz (can be virtual)
    string name
    # Limits in degrees on the pan axis
    spot_cam/PTZLimits pan_limit
    # Limits in degrees on the pan axis
    spot_cam/PTZLimits tilt_limit
    # Limits in degrees on the pan axis
    spot_cam/PTZLimits zoom_limit
    ================================================================================
    MSG: spot_cam/PTZLimits
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription-limits
    # If both max and min are zero, this means the limit is unset. The documentation states that if a limit
    # is unset, then all positions are valid.
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ptzdescription
    # Minimum value for the axis
    float32 min
    # Maximum value for the axis
    float32 max
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetPTZStateRequest(null);
    if (msg.command !== undefined) {
      resolved.command = PTZState.Resolve(msg.command)
    }
    else {
      resolved.command = new PTZState()
    }

    return resolved;
    }
};

class SetPTZStateResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.message = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetPTZStateResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetPTZStateResponse
    let len;
    let data = new SetPTZStateResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.message);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_cam/SetPTZStateResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '937c9679a518e3a18d831e57125ea522';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    string message
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetPTZStateResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: SetPTZStateRequest,
  Response: SetPTZStateResponse,
  md5sum() { return '2dd984827d05222cd185e849e7da947f'; },
  datatype() { return 'spot_cam/SetPTZState'; }
};
