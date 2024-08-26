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

class ArmJointMovementRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joint_target = null;
    }
    else {
      if (initObj.hasOwnProperty('joint_target')) {
        this.joint_target = initObj.joint_target
      }
      else {
        this.joint_target = new Array(6).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ArmJointMovementRequest
    // Check that the constant length array field [joint_target] has the right length
    if (obj.joint_target.length !== 6) {
      throw new Error('Unable to serialize array field joint_target - length must be 6')
    }
    // Serialize message field [joint_target]
    bufferOffset = _arraySerializer.float64(obj.joint_target, buffer, bufferOffset, 6);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ArmJointMovementRequest
    let len;
    let data = new ArmJointMovementRequest(null);
    // Deserialize message field [joint_target]
    data.joint_target = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/ArmJointMovementRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e1bfc757eb861f0f76e03b9c8e73a193';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[6] joint_target
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ArmJointMovementRequest(null);
    if (msg.joint_target !== undefined) {
      resolved.joint_target = msg.joint_target;
    }
    else {
      resolved.joint_target = new Array(6).fill(0)
    }

    return resolved;
    }
};

class ArmJointMovementResponse {
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
    // Serializes a message object of type ArmJointMovementResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ArmJointMovementResponse
    let len;
    let data = new ArmJointMovementResponse(null);
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
    return 'spot_msgs/ArmJointMovementResponse';
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
    const resolved = new ArmJointMovementResponse(null);
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
  Request: ArmJointMovementRequest,
  Response: ArmJointMovementResponse,
  md5sum() { return 'd47819994e77542a6388625321902fe1'; },
  datatype() { return 'spot_msgs/ArmJointMovement'; }
};
