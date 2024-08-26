// Auto-generated. Do not edit!

// (in-package spot_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class GraphCloseLoopsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.close_fiducial_loops = null;
      this.close_odometry_loops = null;
    }
    else {
      if (initObj.hasOwnProperty('close_fiducial_loops')) {
        this.close_fiducial_loops = initObj.close_fiducial_loops
      }
      else {
        this.close_fiducial_loops = false;
      }
      if (initObj.hasOwnProperty('close_odometry_loops')) {
        this.close_odometry_loops = initObj.close_odometry_loops
      }
      else {
        this.close_odometry_loops = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GraphCloseLoopsRequest
    // Serialize message field [close_fiducial_loops]
    bufferOffset = _serializer.bool(obj.close_fiducial_loops, buffer, bufferOffset);
    // Serialize message field [close_odometry_loops]
    bufferOffset = _serializer.bool(obj.close_odometry_loops, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GraphCloseLoopsRequest
    let len;
    let data = new GraphCloseLoopsRequest(null);
    // Deserialize message field [close_fiducial_loops]
    data.close_fiducial_loops = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [close_odometry_loops]
    data.close_odometry_loops = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 2;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/GraphCloseLoopsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ab6c21cb08fec8bf664f4006fddb401b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool close_fiducial_loops
    bool close_odometry_loops
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GraphCloseLoopsRequest(null);
    if (msg.close_fiducial_loops !== undefined) {
      resolved.close_fiducial_loops = msg.close_fiducial_loops;
    }
    else {
      resolved.close_fiducial_loops = false
    }

    if (msg.close_odometry_loops !== undefined) {
      resolved.close_odometry_loops = msg.close_odometry_loops;
    }
    else {
      resolved.close_odometry_loops = false
    }

    return resolved;
    }
};

class GraphCloseLoopsResponse {
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
    // Serializes a message object of type GraphCloseLoopsResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GraphCloseLoopsResponse
    let len;
    let data = new GraphCloseLoopsResponse(null);
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
    return 'spot_msgs/GraphCloseLoopsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '937c9679a518e3a18d831e57125ea522';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success   # indicate successful run of triggered service
    string message # informational, e.g. for error messages
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GraphCloseLoopsResponse(null);
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
  Request: GraphCloseLoopsRequest,
  Response: GraphCloseLoopsResponse,
  md5sum() { return 'dcd1b935b0d8f62ecaa9864406b50eae'; },
  datatype() { return 'spot_msgs/GraphCloseLoops'; }
};
