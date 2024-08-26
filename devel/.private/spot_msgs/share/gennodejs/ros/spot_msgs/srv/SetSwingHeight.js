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

class SetSwingHeightRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.swing_height = null;
    }
    else {
      if (initObj.hasOwnProperty('swing_height')) {
        this.swing_height = initObj.swing_height
      }
      else {
        this.swing_height = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetSwingHeightRequest
    // Serialize message field [swing_height]
    bufferOffset = _serializer.uint8(obj.swing_height, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetSwingHeightRequest
    let len;
    let data = new SetSwingHeightRequest(null);
    // Deserialize message field [swing_height]
    data.swing_height = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/SetSwingHeightRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c9888bf054dacbd6d927d090d75df80e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#swingheight
    uint8 SWING_HEIGHT_UNKNOWN=0
    uint8 SWING_HEIGHT_LOW=1
    uint8 SWING_HEIGHT_MEDIUM=2
    uint8 SWING_HEIGHT_HIGH=3
    
    uint8 swing_height
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetSwingHeightRequest(null);
    if (msg.swing_height !== undefined) {
      resolved.swing_height = msg.swing_height;
    }
    else {
      resolved.swing_height = 0
    }

    return resolved;
    }
};

// Constants for message
SetSwingHeightRequest.Constants = {
  SWING_HEIGHT_UNKNOWN: 0,
  SWING_HEIGHT_LOW: 1,
  SWING_HEIGHT_MEDIUM: 2,
  SWING_HEIGHT_HIGH: 3,
}

class SetSwingHeightResponse {
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
    // Serializes a message object of type SetSwingHeightResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetSwingHeightResponse
    let len;
    let data = new SetSwingHeightResponse(null);
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
    return 'spot_msgs/SetSwingHeightResponse';
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
    const resolved = new SetSwingHeightResponse(null);
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
  Request: SetSwingHeightRequest,
  Response: SetSwingHeightResponse,
  md5sum() { return '27a6a29042cae7012a31b7fb7aa42680'; },
  datatype() { return 'spot_msgs/SetSwingHeight'; }
};
