// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TerrainState = require('./TerrainState.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class FootState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.foot_position_rt_body = null;
      this.contact = null;
      this.terrain = null;
    }
    else {
      if (initObj.hasOwnProperty('foot_position_rt_body')) {
        this.foot_position_rt_body = initObj.foot_position_rt_body
      }
      else {
        this.foot_position_rt_body = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('contact')) {
        this.contact = initObj.contact
      }
      else {
        this.contact = 0;
      }
      if (initObj.hasOwnProperty('terrain')) {
        this.terrain = initObj.terrain
      }
      else {
        this.terrain = new TerrainState();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FootState
    // Serialize message field [foot_position_rt_body]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.foot_position_rt_body, buffer, bufferOffset);
    // Serialize message field [contact]
    bufferOffset = _serializer.uint8(obj.contact, buffer, bufferOffset);
    // Serialize message field [terrain]
    bufferOffset = TerrainState.serialize(obj.terrain, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FootState
    let len;
    let data = new FootState(null);
    // Deserialize message field [foot_position_rt_body]
    data.foot_position_rt_body = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [contact]
    data.contact = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [terrain]
    data.terrain = TerrainState.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += TerrainState.getMessageSize(object.terrain);
    return length + 25;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/FootState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b315748465703ff0724bcad0b58e8e71';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Contact
    uint8 CONTACT_UNKNOWN = 0
    uint8 CONTACT_MADE = 1
    uint8 CONTACT_LOST = 2
    
    geometry_msgs/Point foot_position_rt_body
    uint8 contact
    spot_msgs/TerrainState terrain
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: spot_msgs/TerrainState
    # See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=foot_state#footstate-terrainstate
    
    float32 ground_mu_est
    string frame_name
    geometry_msgs/Vector3 foot_slip_distance_rt_frame
    geometry_msgs/Vector3 foot_slip_velocity_rt_frame
    geometry_msgs/Vector3 ground_contact_normal_rt_frame
    float32 visual_surface_ground_penetration_mean
    float32 visual_surface_ground_penetration_std
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FootState(null);
    if (msg.foot_position_rt_body !== undefined) {
      resolved.foot_position_rt_body = geometry_msgs.msg.Point.Resolve(msg.foot_position_rt_body)
    }
    else {
      resolved.foot_position_rt_body = new geometry_msgs.msg.Point()
    }

    if (msg.contact !== undefined) {
      resolved.contact = msg.contact;
    }
    else {
      resolved.contact = 0
    }

    if (msg.terrain !== undefined) {
      resolved.terrain = TerrainState.Resolve(msg.terrain)
    }
    else {
      resolved.terrain = new TerrainState()
    }

    return resolved;
    }
};

// Constants for message
FootState.Constants = {
  CONTACT_UNKNOWN: 0,
  CONTACT_MADE: 1,
  CONTACT_LOST: 2,
}

module.exports = FootState;
