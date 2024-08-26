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

class TerrainParams {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ground_mu_hint = null;
      this.grated_surfaces_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('ground_mu_hint')) {
        this.ground_mu_hint = initObj.ground_mu_hint
      }
      else {
        this.ground_mu_hint = 0.0;
      }
      if (initObj.hasOwnProperty('grated_surfaces_mode')) {
        this.grated_surfaces_mode = initObj.grated_surfaces_mode
      }
      else {
        this.grated_surfaces_mode = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TerrainParams
    // Serialize message field [ground_mu_hint]
    bufferOffset = _serializer.float32(obj.ground_mu_hint, buffer, bufferOffset);
    // Serialize message field [grated_surfaces_mode]
    bufferOffset = _serializer.uint8(obj.grated_surfaces_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TerrainParams
    let len;
    let data = new TerrainParams(null);
    // Deserialize message field [ground_mu_hint]
    data.ground_mu_hint = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [grated_surfaces_mode]
    data.grated_surfaces_mode = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/TerrainParams';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '58fe7415b44378cf75e03c9f80729c0f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams
    uint8 GRATED_SURFACES_MODE_UNKNOWN=0
    uint8 GRATED_SURFACES_MODE_OFF=1
    uint8 GRATED_SURFACES_MODE_ON=2
    uint8 GRATED_SURFACES_MODE_AUTO=3
    
    float32 ground_mu_hint
    uint8 grated_surfaces_mode
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TerrainParams(null);
    if (msg.ground_mu_hint !== undefined) {
      resolved.ground_mu_hint = msg.ground_mu_hint;
    }
    else {
      resolved.ground_mu_hint = 0.0
    }

    if (msg.grated_surfaces_mode !== undefined) {
      resolved.grated_surfaces_mode = msg.grated_surfaces_mode;
    }
    else {
      resolved.grated_surfaces_mode = 0
    }

    return resolved;
    }
};

// Constants for message
TerrainParams.Constants = {
  GRATED_SURFACES_MODE_UNKNOWN: 0,
  GRATED_SURFACES_MODE_OFF: 1,
  GRATED_SURFACES_MODE_ON: 2,
  GRATED_SURFACES_MODE_AUTO: 3,
}

module.exports = TerrainParams;
