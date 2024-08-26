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

class ArmForceTrajectoryRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.duration = null;
      this.frame = null;
      this.forces_pt0 = null;
      this.torques_pt0 = null;
      this.forces_pt1 = null;
      this.torques_pt1 = null;
    }
    else {
      if (initObj.hasOwnProperty('duration')) {
        this.duration = initObj.duration
      }
      else {
        this.duration = 0.0;
      }
      if (initObj.hasOwnProperty('frame')) {
        this.frame = initObj.frame
      }
      else {
        this.frame = '';
      }
      if (initObj.hasOwnProperty('forces_pt0')) {
        this.forces_pt0 = initObj.forces_pt0
      }
      else {
        this.forces_pt0 = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('torques_pt0')) {
        this.torques_pt0 = initObj.torques_pt0
      }
      else {
        this.torques_pt0 = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('forces_pt1')) {
        this.forces_pt1 = initObj.forces_pt1
      }
      else {
        this.forces_pt1 = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('torques_pt1')) {
        this.torques_pt1 = initObj.torques_pt1
      }
      else {
        this.torques_pt1 = new Array(3).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ArmForceTrajectoryRequest
    // Serialize message field [duration]
    bufferOffset = _serializer.float64(obj.duration, buffer, bufferOffset);
    // Serialize message field [frame]
    bufferOffset = _serializer.string(obj.frame, buffer, bufferOffset);
    // Check that the constant length array field [forces_pt0] has the right length
    if (obj.forces_pt0.length !== 3) {
      throw new Error('Unable to serialize array field forces_pt0 - length must be 3')
    }
    // Serialize message field [forces_pt0]
    bufferOffset = _arraySerializer.float64(obj.forces_pt0, buffer, bufferOffset, 3);
    // Check that the constant length array field [torques_pt0] has the right length
    if (obj.torques_pt0.length !== 3) {
      throw new Error('Unable to serialize array field torques_pt0 - length must be 3')
    }
    // Serialize message field [torques_pt0]
    bufferOffset = _arraySerializer.float64(obj.torques_pt0, buffer, bufferOffset, 3);
    // Check that the constant length array field [forces_pt1] has the right length
    if (obj.forces_pt1.length !== 3) {
      throw new Error('Unable to serialize array field forces_pt1 - length must be 3')
    }
    // Serialize message field [forces_pt1]
    bufferOffset = _arraySerializer.float64(obj.forces_pt1, buffer, bufferOffset, 3);
    // Check that the constant length array field [torques_pt1] has the right length
    if (obj.torques_pt1.length !== 3) {
      throw new Error('Unable to serialize array field torques_pt1 - length must be 3')
    }
    // Serialize message field [torques_pt1]
    bufferOffset = _arraySerializer.float64(obj.torques_pt1, buffer, bufferOffset, 3);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ArmForceTrajectoryRequest
    let len;
    let data = new ArmForceTrajectoryRequest(null);
    // Deserialize message field [duration]
    data.duration = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [frame]
    data.frame = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [forces_pt0]
    data.forces_pt0 = _arrayDeserializer.float64(buffer, bufferOffset, 3)
    // Deserialize message field [torques_pt0]
    data.torques_pt0 = _arrayDeserializer.float64(buffer, bufferOffset, 3)
    // Deserialize message field [forces_pt1]
    data.forces_pt1 = _arrayDeserializer.float64(buffer, bufferOffset, 3)
    // Deserialize message field [torques_pt1]
    data.torques_pt1 = _arrayDeserializer.float64(buffer, bufferOffset, 3)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.frame);
    return length + 108;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/ArmForceTrajectoryRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'df1770a07fa213279ddffa14a7667266';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 duration
    string frame
    float64[3] forces_pt0 # fx fy fz
    float64[3] torques_pt0 # tx ty yz
    float64[3] forces_pt1 # fx fy fz
    float64[3] torques_pt1 # tx ty yz
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ArmForceTrajectoryRequest(null);
    if (msg.duration !== undefined) {
      resolved.duration = msg.duration;
    }
    else {
      resolved.duration = 0.0
    }

    if (msg.frame !== undefined) {
      resolved.frame = msg.frame;
    }
    else {
      resolved.frame = ''
    }

    if (msg.forces_pt0 !== undefined) {
      resolved.forces_pt0 = msg.forces_pt0;
    }
    else {
      resolved.forces_pt0 = new Array(3).fill(0)
    }

    if (msg.torques_pt0 !== undefined) {
      resolved.torques_pt0 = msg.torques_pt0;
    }
    else {
      resolved.torques_pt0 = new Array(3).fill(0)
    }

    if (msg.forces_pt1 !== undefined) {
      resolved.forces_pt1 = msg.forces_pt1;
    }
    else {
      resolved.forces_pt1 = new Array(3).fill(0)
    }

    if (msg.torques_pt1 !== undefined) {
      resolved.torques_pt1 = msg.torques_pt1;
    }
    else {
      resolved.torques_pt1 = new Array(3).fill(0)
    }

    return resolved;
    }
};

class ArmForceTrajectoryResponse {
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
    // Serializes a message object of type ArmForceTrajectoryResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ArmForceTrajectoryResponse
    let len;
    let data = new ArmForceTrajectoryResponse(null);
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
    return 'spot_msgs/ArmForceTrajectoryResponse';
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
    const resolved = new ArmForceTrajectoryResponse(null);
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
  Request: ArmForceTrajectoryRequest,
  Response: ArmForceTrajectoryResponse,
  md5sum() { return '5ec2796f0480118f129c21c2f87b4cf7'; },
  datatype() { return 'spot_msgs/ArmForceTrajectory'; }
};
