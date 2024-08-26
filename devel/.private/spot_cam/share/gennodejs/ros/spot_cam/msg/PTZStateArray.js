// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PTZState = require('./PTZState.js');

//-----------------------------------------------------------

class PTZStateArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ptzs = null;
    }
    else {
      if (initObj.hasOwnProperty('ptzs')) {
        this.ptzs = initObj.ptzs
      }
      else {
        this.ptzs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PTZStateArray
    // Serialize message field [ptzs]
    // Serialize the length for message field [ptzs]
    bufferOffset = _serializer.uint32(obj.ptzs.length, buffer, bufferOffset);
    obj.ptzs.forEach((val) => {
      bufferOffset = PTZState.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PTZStateArray
    let len;
    let data = new PTZStateArray(null);
    // Deserialize message field [ptzs]
    // Deserialize array length for message field [ptzs]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.ptzs = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.ptzs[i] = PTZState.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.ptzs.forEach((val) => {
      length += PTZState.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/PTZStateArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c71a65fc59258e7303baf75176b74b2b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    spot_cam/PTZState[] ptzs
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
    const resolved = new PTZStateArray(null);
    if (msg.ptzs !== undefined) {
      resolved.ptzs = new Array(msg.ptzs.length);
      for (let i = 0; i < resolved.ptzs.length; ++i) {
        resolved.ptzs[i] = PTZState.Resolve(msg.ptzs[i]);
      }
    }
    else {
      resolved.ptzs = []
    }

    return resolved;
    }
};

module.exports = PTZStateArray;
