// Auto-generated. Do not edit!

// (in-package spot_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ObstacleParams = require('../msg/ObstacleParams.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetObstacleParamsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.obstacle_params = null;
    }
    else {
      if (initObj.hasOwnProperty('obstacle_params')) {
        this.obstacle_params = initObj.obstacle_params
      }
      else {
        this.obstacle_params = new ObstacleParams();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetObstacleParamsRequest
    // Serialize message field [obstacle_params]
    bufferOffset = ObstacleParams.serialize(obj.obstacle_params, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetObstacleParamsRequest
    let len;
    let data = new SetObstacleParamsRequest(null);
    // Deserialize message field [obstacle_params]
    data.obstacle_params = ObstacleParams.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/SetObstacleParamsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '40db8075f91685db646bf10f6ec7202f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    spot_msgs/ObstacleParams obstacle_params
    
    ================================================================================
    MSG: spot_msgs/ObstacleParams
    # see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams
    bool disable_vision_foot_obstacle_avoidance
    bool disable_vision_foot_constraint_avoidance
    bool disable_vision_body_obstacle_avoidance
    float32 obstacle_avoidance_padding
    bool disable_vision_foot_obstacle_body_assist
    bool disable_vision_negative_obstacles
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetObstacleParamsRequest(null);
    if (msg.obstacle_params !== undefined) {
      resolved.obstacle_params = ObstacleParams.Resolve(msg.obstacle_params)
    }
    else {
      resolved.obstacle_params = new ObstacleParams()
    }

    return resolved;
    }
};

class SetObstacleParamsResponse {
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
    // Serializes a message object of type SetObstacleParamsResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetObstacleParamsResponse
    let len;
    let data = new SetObstacleParamsResponse(null);
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
    return 'spot_msgs/SetObstacleParamsResponse';
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
    const resolved = new SetObstacleParamsResponse(null);
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
  Request: SetObstacleParamsRequest,
  Response: SetObstacleParamsResponse,
  md5sum() { return '8ca30ec022a12ccabed5c0af340a4796'; },
  datatype() { return 'spot_msgs/SetObstacleParams'; }
};
