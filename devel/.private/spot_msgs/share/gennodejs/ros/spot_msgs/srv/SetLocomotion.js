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

class SetLocomotionRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.locomotion_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('locomotion_mode')) {
        this.locomotion_mode = initObj.locomotion_mode
      }
      else {
        this.locomotion_mode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetLocomotionRequest
    // Serialize message field [locomotion_mode]
    bufferOffset = _serializer.uint32(obj.locomotion_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetLocomotionRequest
    let len;
    let data = new SetLocomotionRequest(null);
    // Deserialize message field [locomotion_mode]
    data.locomotion_mode = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/SetLocomotionRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '68dc925cf63dfcd4a62a5dc5dbd3efec';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=mobilityparams#locomotionhint for details
    uint8 HINT_UNKNOWN=0
    uint8 HINT_AUTO=1
    uint8 HINT_TROT=2
    uint8 HINT_SPEED_SELECT_TROT=3
    uint8 HINT_CRAWL=4
    uint8 HINT_AMBLE=5
    uint8 HINT_SPEED_SELECT_AMBLE=6
    uint8 HINT_JOG=7
    uint8 HINT_HOP=8
    uint8 HINT_SPEED_SELECT_CRAWL=10
    
    uint32 locomotion_mode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetLocomotionRequest(null);
    if (msg.locomotion_mode !== undefined) {
      resolved.locomotion_mode = msg.locomotion_mode;
    }
    else {
      resolved.locomotion_mode = 0
    }

    return resolved;
    }
};

// Constants for message
SetLocomotionRequest.Constants = {
  HINT_UNKNOWN: 0,
  HINT_AUTO: 1,
  HINT_TROT: 2,
  HINT_SPEED_SELECT_TROT: 3,
  HINT_CRAWL: 4,
  HINT_AMBLE: 5,
  HINT_SPEED_SELECT_AMBLE: 6,
  HINT_JOG: 7,
  HINT_HOP: 8,
  HINT_SPEED_SELECT_CRAWL: 10,
}

class SetLocomotionResponse {
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
    // Serializes a message object of type SetLocomotionResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetLocomotionResponse
    let len;
    let data = new SetLocomotionResponse(null);
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
    return 'spot_msgs/SetLocomotionResponse';
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
    const resolved = new SetLocomotionResponse(null);
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
  Request: SetLocomotionRequest,
  Response: SetLocomotionResponse,
  md5sum() { return 'e8dfb4cee89cb4df2de99142d065f95d'; },
  datatype() { return 'spot_msgs/SetLocomotion'; }
};
