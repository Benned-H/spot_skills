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

class ConstrainedArmJointMovementRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joint_target = null;
      this.max_execution_time = null;
      this.max_velocity = null;
      this.max_acceleration = null;
    }
    else {
      if (initObj.hasOwnProperty('joint_target')) {
        this.joint_target = initObj.joint_target
      }
      else {
        this.joint_target = [];
      }
      if (initObj.hasOwnProperty('max_execution_time')) {
        this.max_execution_time = initObj.max_execution_time
      }
      else {
        this.max_execution_time = 0.0;
      }
      if (initObj.hasOwnProperty('max_velocity')) {
        this.max_velocity = initObj.max_velocity
      }
      else {
        this.max_velocity = 0.0;
      }
      if (initObj.hasOwnProperty('max_acceleration')) {
        this.max_acceleration = initObj.max_acceleration
      }
      else {
        this.max_acceleration = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ConstrainedArmJointMovementRequest
    // Serialize message field [joint_target]
    bufferOffset = _arraySerializer.float64(obj.joint_target, buffer, bufferOffset, null);
    // Serialize message field [max_execution_time]
    bufferOffset = _serializer.float64(obj.max_execution_time, buffer, bufferOffset);
    // Serialize message field [max_velocity]
    bufferOffset = _serializer.float64(obj.max_velocity, buffer, bufferOffset);
    // Serialize message field [max_acceleration]
    bufferOffset = _serializer.float64(obj.max_acceleration, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ConstrainedArmJointMovementRequest
    let len;
    let data = new ConstrainedArmJointMovementRequest(null);
    // Deserialize message field [joint_target]
    data.joint_target = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [max_execution_time]
    data.max_execution_time = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [max_velocity]
    data.max_velocity = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [max_acceleration]
    data.max_acceleration = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.joint_target.length;
    return length + 28;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/ConstrainedArmJointMovementRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a082e7ef50d130896e56c126137b38d3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[] joint_target
    float64 max_execution_time
    float64 max_velocity
    float64 max_acceleration
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ConstrainedArmJointMovementRequest(null);
    if (msg.joint_target !== undefined) {
      resolved.joint_target = msg.joint_target;
    }
    else {
      resolved.joint_target = []
    }

    if (msg.max_execution_time !== undefined) {
      resolved.max_execution_time = msg.max_execution_time;
    }
    else {
      resolved.max_execution_time = 0.0
    }

    if (msg.max_velocity !== undefined) {
      resolved.max_velocity = msg.max_velocity;
    }
    else {
      resolved.max_velocity = 0.0
    }

    if (msg.max_acceleration !== undefined) {
      resolved.max_acceleration = msg.max_acceleration;
    }
    else {
      resolved.max_acceleration = 0.0
    }

    return resolved;
    }
};

class ConstrainedArmJointMovementResponse {
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
    // Serializes a message object of type ConstrainedArmJointMovementResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ConstrainedArmJointMovementResponse
    let len;
    let data = new ConstrainedArmJointMovementResponse(null);
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
    return 'spot_msgs/ConstrainedArmJointMovementResponse';
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
    const resolved = new ConstrainedArmJointMovementResponse(null);
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
  Request: ConstrainedArmJointMovementRequest,
  Response: ConstrainedArmJointMovementResponse,
  md5sum() { return '9e4ce278a819d084143e339b61079523'; },
  datatype() { return 'spot_msgs/ConstrainedArmJointMovement'; }
};
