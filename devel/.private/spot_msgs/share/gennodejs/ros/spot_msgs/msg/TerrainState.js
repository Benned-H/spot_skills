// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class TerrainState {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ground_mu_est = null;
      this.frame_name = null;
      this.foot_slip_distance_rt_frame = null;
      this.foot_slip_velocity_rt_frame = null;
      this.ground_contact_normal_rt_frame = null;
      this.visual_surface_ground_penetration_mean = null;
      this.visual_surface_ground_penetration_std = null;
    }
    else {
      if (initObj.hasOwnProperty('ground_mu_est')) {
        this.ground_mu_est = initObj.ground_mu_est
      }
      else {
        this.ground_mu_est = 0.0;
      }
      if (initObj.hasOwnProperty('frame_name')) {
        this.frame_name = initObj.frame_name
      }
      else {
        this.frame_name = '';
      }
      if (initObj.hasOwnProperty('foot_slip_distance_rt_frame')) {
        this.foot_slip_distance_rt_frame = initObj.foot_slip_distance_rt_frame
      }
      else {
        this.foot_slip_distance_rt_frame = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('foot_slip_velocity_rt_frame')) {
        this.foot_slip_velocity_rt_frame = initObj.foot_slip_velocity_rt_frame
      }
      else {
        this.foot_slip_velocity_rt_frame = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('ground_contact_normal_rt_frame')) {
        this.ground_contact_normal_rt_frame = initObj.ground_contact_normal_rt_frame
      }
      else {
        this.ground_contact_normal_rt_frame = new geometry_msgs.msg.Vector3();
      }
      if (initObj.hasOwnProperty('visual_surface_ground_penetration_mean')) {
        this.visual_surface_ground_penetration_mean = initObj.visual_surface_ground_penetration_mean
      }
      else {
        this.visual_surface_ground_penetration_mean = 0.0;
      }
      if (initObj.hasOwnProperty('visual_surface_ground_penetration_std')) {
        this.visual_surface_ground_penetration_std = initObj.visual_surface_ground_penetration_std
      }
      else {
        this.visual_surface_ground_penetration_std = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TerrainState
    // Serialize message field [ground_mu_est]
    bufferOffset = _serializer.float32(obj.ground_mu_est, buffer, bufferOffset);
    // Serialize message field [frame_name]
    bufferOffset = _serializer.string(obj.frame_name, buffer, bufferOffset);
    // Serialize message field [foot_slip_distance_rt_frame]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.foot_slip_distance_rt_frame, buffer, bufferOffset);
    // Serialize message field [foot_slip_velocity_rt_frame]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.foot_slip_velocity_rt_frame, buffer, bufferOffset);
    // Serialize message field [ground_contact_normal_rt_frame]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.ground_contact_normal_rt_frame, buffer, bufferOffset);
    // Serialize message field [visual_surface_ground_penetration_mean]
    bufferOffset = _serializer.float32(obj.visual_surface_ground_penetration_mean, buffer, bufferOffset);
    // Serialize message field [visual_surface_ground_penetration_std]
    bufferOffset = _serializer.float32(obj.visual_surface_ground_penetration_std, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TerrainState
    let len;
    let data = new TerrainState(null);
    // Deserialize message field [ground_mu_est]
    data.ground_mu_est = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [frame_name]
    data.frame_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [foot_slip_distance_rt_frame]
    data.foot_slip_distance_rt_frame = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [foot_slip_velocity_rt_frame]
    data.foot_slip_velocity_rt_frame = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [ground_contact_normal_rt_frame]
    data.ground_contact_normal_rt_frame = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [visual_surface_ground_penetration_mean]
    data.visual_surface_ground_penetration_mean = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [visual_surface_ground_penetration_std]
    data.visual_surface_ground_penetration_std = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.frame_name);
    return length + 88;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/TerrainState';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8ace1ec594dcaee88134d9f49cb542d9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new TerrainState(null);
    if (msg.ground_mu_est !== undefined) {
      resolved.ground_mu_est = msg.ground_mu_est;
    }
    else {
      resolved.ground_mu_est = 0.0
    }

    if (msg.frame_name !== undefined) {
      resolved.frame_name = msg.frame_name;
    }
    else {
      resolved.frame_name = ''
    }

    if (msg.foot_slip_distance_rt_frame !== undefined) {
      resolved.foot_slip_distance_rt_frame = geometry_msgs.msg.Vector3.Resolve(msg.foot_slip_distance_rt_frame)
    }
    else {
      resolved.foot_slip_distance_rt_frame = new geometry_msgs.msg.Vector3()
    }

    if (msg.foot_slip_velocity_rt_frame !== undefined) {
      resolved.foot_slip_velocity_rt_frame = geometry_msgs.msg.Vector3.Resolve(msg.foot_slip_velocity_rt_frame)
    }
    else {
      resolved.foot_slip_velocity_rt_frame = new geometry_msgs.msg.Vector3()
    }

    if (msg.ground_contact_normal_rt_frame !== undefined) {
      resolved.ground_contact_normal_rt_frame = geometry_msgs.msg.Vector3.Resolve(msg.ground_contact_normal_rt_frame)
    }
    else {
      resolved.ground_contact_normal_rt_frame = new geometry_msgs.msg.Vector3()
    }

    if (msg.visual_surface_ground_penetration_mean !== undefined) {
      resolved.visual_surface_ground_penetration_mean = msg.visual_surface_ground_penetration_mean;
    }
    else {
      resolved.visual_surface_ground_penetration_mean = 0.0
    }

    if (msg.visual_surface_ground_penetration_std !== undefined) {
      resolved.visual_surface_ground_penetration_std = msg.visual_surface_ground_penetration_std;
    }
    else {
      resolved.visual_surface_ground_penetration_std = 0.0
    }

    return resolved;
    }
};

module.exports = TerrainState;
