// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ObstacleParams {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.disable_vision_foot_obstacle_avoidance = null;
      this.disable_vision_foot_constraint_avoidance = null;
      this.disable_vision_body_obstacle_avoidance = null;
      this.obstacle_avoidance_padding = null;
      this.disable_vision_foot_obstacle_body_assist = null;
      this.disable_vision_negative_obstacles = null;
    }
    else {
      if (initObj.hasOwnProperty('disable_vision_foot_obstacle_avoidance')) {
        this.disable_vision_foot_obstacle_avoidance = initObj.disable_vision_foot_obstacle_avoidance
      }
      else {
        this.disable_vision_foot_obstacle_avoidance = false;
      }
      if (initObj.hasOwnProperty('disable_vision_foot_constraint_avoidance')) {
        this.disable_vision_foot_constraint_avoidance = initObj.disable_vision_foot_constraint_avoidance
      }
      else {
        this.disable_vision_foot_constraint_avoidance = false;
      }
      if (initObj.hasOwnProperty('disable_vision_body_obstacle_avoidance')) {
        this.disable_vision_body_obstacle_avoidance = initObj.disable_vision_body_obstacle_avoidance
      }
      else {
        this.disable_vision_body_obstacle_avoidance = false;
      }
      if (initObj.hasOwnProperty('obstacle_avoidance_padding')) {
        this.obstacle_avoidance_padding = initObj.obstacle_avoidance_padding
      }
      else {
        this.obstacle_avoidance_padding = 0.0;
      }
      if (initObj.hasOwnProperty('disable_vision_foot_obstacle_body_assist')) {
        this.disable_vision_foot_obstacle_body_assist = initObj.disable_vision_foot_obstacle_body_assist
      }
      else {
        this.disable_vision_foot_obstacle_body_assist = false;
      }
      if (initObj.hasOwnProperty('disable_vision_negative_obstacles')) {
        this.disable_vision_negative_obstacles = initObj.disable_vision_negative_obstacles
      }
      else {
        this.disable_vision_negative_obstacles = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ObstacleParams
    // Serialize message field [disable_vision_foot_obstacle_avoidance]
    bufferOffset = _serializer.bool(obj.disable_vision_foot_obstacle_avoidance, buffer, bufferOffset);
    // Serialize message field [disable_vision_foot_constraint_avoidance]
    bufferOffset = _serializer.bool(obj.disable_vision_foot_constraint_avoidance, buffer, bufferOffset);
    // Serialize message field [disable_vision_body_obstacle_avoidance]
    bufferOffset = _serializer.bool(obj.disable_vision_body_obstacle_avoidance, buffer, bufferOffset);
    // Serialize message field [obstacle_avoidance_padding]
    bufferOffset = _serializer.float32(obj.obstacle_avoidance_padding, buffer, bufferOffset);
    // Serialize message field [disable_vision_foot_obstacle_body_assist]
    bufferOffset = _serializer.bool(obj.disable_vision_foot_obstacle_body_assist, buffer, bufferOffset);
    // Serialize message field [disable_vision_negative_obstacles]
    bufferOffset = _serializer.bool(obj.disable_vision_negative_obstacles, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ObstacleParams
    let len;
    let data = new ObstacleParams(null);
    // Deserialize message field [disable_vision_foot_obstacle_avoidance]
    data.disable_vision_foot_obstacle_avoidance = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [disable_vision_foot_constraint_avoidance]
    data.disable_vision_foot_constraint_avoidance = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [disable_vision_body_obstacle_avoidance]
    data.disable_vision_body_obstacle_avoidance = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [obstacle_avoidance_padding]
    data.obstacle_avoidance_padding = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [disable_vision_foot_obstacle_body_assist]
    data.disable_vision_foot_obstacle_body_assist = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [disable_vision_negative_obstacles]
    data.disable_vision_negative_obstacles = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/ObstacleParams';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9b3390759d58138d9a7a53bad6b0edad';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new ObstacleParams(null);
    if (msg.disable_vision_foot_obstacle_avoidance !== undefined) {
      resolved.disable_vision_foot_obstacle_avoidance = msg.disable_vision_foot_obstacle_avoidance;
    }
    else {
      resolved.disable_vision_foot_obstacle_avoidance = false
    }

    if (msg.disable_vision_foot_constraint_avoidance !== undefined) {
      resolved.disable_vision_foot_constraint_avoidance = msg.disable_vision_foot_constraint_avoidance;
    }
    else {
      resolved.disable_vision_foot_constraint_avoidance = false
    }

    if (msg.disable_vision_body_obstacle_avoidance !== undefined) {
      resolved.disable_vision_body_obstacle_avoidance = msg.disable_vision_body_obstacle_avoidance;
    }
    else {
      resolved.disable_vision_body_obstacle_avoidance = false
    }

    if (msg.obstacle_avoidance_padding !== undefined) {
      resolved.obstacle_avoidance_padding = msg.obstacle_avoidance_padding;
    }
    else {
      resolved.obstacle_avoidance_padding = 0.0
    }

    if (msg.disable_vision_foot_obstacle_body_assist !== undefined) {
      resolved.disable_vision_foot_obstacle_body_assist = msg.disable_vision_foot_obstacle_body_assist;
    }
    else {
      resolved.disable_vision_foot_obstacle_body_assist = false
    }

    if (msg.disable_vision_negative_obstacles !== undefined) {
      resolved.disable_vision_negative_obstacles = msg.disable_vision_negative_obstacles;
    }
    else {
      resolved.disable_vision_negative_obstacles = false
    }

    return resolved;
    }
};

module.exports = ObstacleParams;
