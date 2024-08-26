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

class PosedStandRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.body_height = null;
      this.body_yaw = null;
      this.body_pitch = null;
      this.body_roll = null;
    }
    else {
      if (initObj.hasOwnProperty('body_height')) {
        this.body_height = initObj.body_height
      }
      else {
        this.body_height = 0.0;
      }
      if (initObj.hasOwnProperty('body_yaw')) {
        this.body_yaw = initObj.body_yaw
      }
      else {
        this.body_yaw = 0.0;
      }
      if (initObj.hasOwnProperty('body_pitch')) {
        this.body_pitch = initObj.body_pitch
      }
      else {
        this.body_pitch = 0.0;
      }
      if (initObj.hasOwnProperty('body_roll')) {
        this.body_roll = initObj.body_roll
      }
      else {
        this.body_roll = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PosedStandRequest
    // Serialize message field [body_height]
    bufferOffset = _serializer.float32(obj.body_height, buffer, bufferOffset);
    // Serialize message field [body_yaw]
    bufferOffset = _serializer.float32(obj.body_yaw, buffer, bufferOffset);
    // Serialize message field [body_pitch]
    bufferOffset = _serializer.float32(obj.body_pitch, buffer, bufferOffset);
    // Serialize message field [body_roll]
    bufferOffset = _serializer.float32(obj.body_roll, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PosedStandRequest
    let len;
    let data = new PosedStandRequest(null);
    // Deserialize message field [body_height]
    data.body_height = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [body_yaw]
    data.body_yaw = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [body_pitch]
    data.body_pitch = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [body_roll]
    data.body_roll = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/PosedStandRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5d0c3f2418cea7d59ebb460053334aa6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/robot_command.html?highlight=feedback#bosdyn.client.robot_command.RobotCommandBuilder.stand_command
    
    # Offset of the body from the default stand height, in metres
    float32 body_height
    
    # RPY of the body relative to the robot's default stand pose
    float32 body_yaw
    float32 body_pitch
    float32 body_roll
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PosedStandRequest(null);
    if (msg.body_height !== undefined) {
      resolved.body_height = msg.body_height;
    }
    else {
      resolved.body_height = 0.0
    }

    if (msg.body_yaw !== undefined) {
      resolved.body_yaw = msg.body_yaw;
    }
    else {
      resolved.body_yaw = 0.0
    }

    if (msg.body_pitch !== undefined) {
      resolved.body_pitch = msg.body_pitch;
    }
    else {
      resolved.body_pitch = 0.0
    }

    if (msg.body_roll !== undefined) {
      resolved.body_roll = msg.body_roll;
    }
    else {
      resolved.body_roll = 0.0
    }

    return resolved;
    }
};

class PosedStandResponse {
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
    // Serializes a message object of type PosedStandResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PosedStandResponse
    let len;
    let data = new PosedStandResponse(null);
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
    return 'spot_msgs/PosedStandResponse';
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
    const resolved = new PosedStandResponse(null);
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
  Request: PosedStandRequest,
  Response: PosedStandResponse,
  md5sum() { return '832f607027428cf7110c7d6907d1c083'; },
  datatype() { return 'spot_msgs/PosedStand'; }
};
