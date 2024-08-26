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

class NavigateInitRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.upload_path = null;
      this.initial_localization_fiducial = null;
      this.initial_localization_waypoint = null;
    }
    else {
      if (initObj.hasOwnProperty('upload_path')) {
        this.upload_path = initObj.upload_path
      }
      else {
        this.upload_path = '';
      }
      if (initObj.hasOwnProperty('initial_localization_fiducial')) {
        this.initial_localization_fiducial = initObj.initial_localization_fiducial
      }
      else {
        this.initial_localization_fiducial = false;
      }
      if (initObj.hasOwnProperty('initial_localization_waypoint')) {
        this.initial_localization_waypoint = initObj.initial_localization_waypoint
      }
      else {
        this.initial_localization_waypoint = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavigateInitRequest
    // Serialize message field [upload_path]
    bufferOffset = _serializer.string(obj.upload_path, buffer, bufferOffset);
    // Serialize message field [initial_localization_fiducial]
    bufferOffset = _serializer.bool(obj.initial_localization_fiducial, buffer, bufferOffset);
    // Serialize message field [initial_localization_waypoint]
    bufferOffset = _serializer.string(obj.initial_localization_waypoint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavigateInitRequest
    let len;
    let data = new NavigateInitRequest(null);
    // Deserialize message field [upload_path]
    data.upload_path = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [initial_localization_fiducial]
    data.initial_localization_fiducial = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [initial_localization_waypoint]
    data.initial_localization_waypoint = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.upload_path);
    length += _getByteLength(object.initial_localization_waypoint);
    return length + 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/NavigateInitRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c82ac133d5526c46e6a57b9de8e38740';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string upload_path # Absolute path to map_directory, which is downloaded from tablet controller
    bool initial_localization_fiducial   # Tells the initializer whether to use fiducials
    string initial_localization_waypoint # Waypoint id to trigger localization 
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NavigateInitRequest(null);
    if (msg.upload_path !== undefined) {
      resolved.upload_path = msg.upload_path;
    }
    else {
      resolved.upload_path = ''
    }

    if (msg.initial_localization_fiducial !== undefined) {
      resolved.initial_localization_fiducial = msg.initial_localization_fiducial;
    }
    else {
      resolved.initial_localization_fiducial = false
    }

    if (msg.initial_localization_waypoint !== undefined) {
      resolved.initial_localization_waypoint = msg.initial_localization_waypoint;
    }
    else {
      resolved.initial_localization_waypoint = ''
    }

    return resolved;
    }
};

class NavigateInitResponse {
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
    // Serializes a message object of type NavigateInitResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavigateInitResponse
    let len;
    let data = new NavigateInitResponse(null);
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
    return 'spot_msgs/NavigateInitResponse';
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
    const resolved = new NavigateInitResponse(null);
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
  Request: NavigateInitRequest,
  Response: NavigateInitResponse,
  md5sum() { return 'c444c9070e6d223b1750275fad5b1484'; },
  datatype() { return 'spot_msgs/NavigateInit'; }
};
