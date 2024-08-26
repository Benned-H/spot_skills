// Auto-generated. Do not edit!

// (in-package spot_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TerrainParams = require('../msg/TerrainParams.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetTerrainParamsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.terrain_params = null;
    }
    else {
      if (initObj.hasOwnProperty('terrain_params')) {
        this.terrain_params = initObj.terrain_params
      }
      else {
        this.terrain_params = new TerrainParams();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetTerrainParamsRequest
    // Serialize message field [terrain_params]
    bufferOffset = TerrainParams.serialize(obj.terrain_params, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetTerrainParamsRequest
    let len;
    let data = new SetTerrainParamsRequest(null);
    // Deserialize message field [terrain_params]
    data.terrain_params = TerrainParams.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/SetTerrainParamsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4536ebedae12528eeea4125da8612197';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    spot_msgs/TerrainParams terrain_params
    
    ================================================================================
    MSG: spot_msgs/TerrainParams
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
    const resolved = new SetTerrainParamsRequest(null);
    if (msg.terrain_params !== undefined) {
      resolved.terrain_params = TerrainParams.Resolve(msg.terrain_params)
    }
    else {
      resolved.terrain_params = new TerrainParams()
    }

    return resolved;
    }
};

class SetTerrainParamsResponse {
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
    // Serializes a message object of type SetTerrainParamsResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetTerrainParamsResponse
    let len;
    let data = new SetTerrainParamsResponse(null);
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
    return 'spot_msgs/SetTerrainParamsResponse';
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
    const resolved = new SetTerrainParamsResponse(null);
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
  Request: SetTerrainParamsRequest,
  Response: SetTerrainParamsResponse,
  md5sum() { return '7ab3f769faaa7a5562cf1f71a78cd453'; },
  datatype() { return 'spot_msgs/SetTerrainParams'; }
};
