// Auto-generated. Do not edit!

// (in-package spot_cam.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let StreamParams = require('../msg/StreamParams.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetStreamParamsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.params = null;
    }
    else {
      if (initObj.hasOwnProperty('params')) {
        this.params = initObj.params
      }
      else {
        this.params = new StreamParams();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetStreamParamsRequest
    // Serialize message field [params]
    bufferOffset = StreamParams.serialize(obj.params, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetStreamParamsRequest
    let len;
    let data = new SetStreamParamsRequest(null);
    // Deserialize message field [params]
    data.params = StreamParams.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 25;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_cam/SetStreamParamsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ddc9d6ae532786ed5f1bc25d48bc1c7a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    spot_cam/StreamParams params
    
    ================================================================================
    MSG: spot_cam/StreamParams
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#streamparams
    # White balance modes
    int8 OFF=-1
    # This is not provided, but we add it to be able to distinguish when setting the white balance
    int8 UNSET=0
    int8 AUTO=1
    int8 INCANDESCENT=2
    int8 FLUORESCENT=3
    int8 WARM_FLUORESCENT=4
    int8 DAYLIGHT=5
    int8 CLOUDY=6
    int8 TWILIGHT=7
    int8 SHADE=8
    int8 DARK=9
    
    # Compression level target in bits per second
    int64 target_bitrate
    # How often should the entire feed be refreshed (in frames)
    int64 refresh_interval
    # How often should an IDR message be sent (in frames)
    int64 idr_interval
    # Automatic white balance
    int8 awb
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetStreamParamsRequest(null);
    if (msg.params !== undefined) {
      resolved.params = StreamParams.Resolve(msg.params)
    }
    else {
      resolved.params = new StreamParams()
    }

    return resolved;
    }
};

class SetStreamParamsResponse {
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
    // Serializes a message object of type SetStreamParamsResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetStreamParamsResponse
    let len;
    let data = new SetStreamParamsResponse(null);
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
    return 'spot_cam/SetStreamParamsResponse';
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
    const resolved = new SetStreamParamsResponse(null);
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
  Request: SetStreamParamsRequest,
  Response: SetStreamParamsResponse,
  md5sum() { return 'bde49dd2a9f9234c2f23c257153388e8'; },
  datatype() { return 'spot_cam/SetStreamParams'; }
};
