// Auto-generated. Do not edit!

// (in-package spot_cam.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class StreamParams {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.target_bitrate = null;
      this.refresh_interval = null;
      this.idr_interval = null;
      this.awb = null;
    }
    else {
      if (initObj.hasOwnProperty('target_bitrate')) {
        this.target_bitrate = initObj.target_bitrate
      }
      else {
        this.target_bitrate = 0;
      }
      if (initObj.hasOwnProperty('refresh_interval')) {
        this.refresh_interval = initObj.refresh_interval
      }
      else {
        this.refresh_interval = 0;
      }
      if (initObj.hasOwnProperty('idr_interval')) {
        this.idr_interval = initObj.idr_interval
      }
      else {
        this.idr_interval = 0;
      }
      if (initObj.hasOwnProperty('awb')) {
        this.awb = initObj.awb
      }
      else {
        this.awb = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type StreamParams
    // Serialize message field [target_bitrate]
    bufferOffset = _serializer.int64(obj.target_bitrate, buffer, bufferOffset);
    // Serialize message field [refresh_interval]
    bufferOffset = _serializer.int64(obj.refresh_interval, buffer, bufferOffset);
    // Serialize message field [idr_interval]
    bufferOffset = _serializer.int64(obj.idr_interval, buffer, bufferOffset);
    // Serialize message field [awb]
    bufferOffset = _serializer.int8(obj.awb, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type StreamParams
    let len;
    let data = new StreamParams(null);
    // Deserialize message field [target_bitrate]
    data.target_bitrate = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [refresh_interval]
    data.refresh_interval = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [idr_interval]
    data.idr_interval = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [awb]
    data.awb = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 25;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/StreamParams';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7fa7ed9c6dbde8368621018918a2a544';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new StreamParams(null);
    if (msg.target_bitrate !== undefined) {
      resolved.target_bitrate = msg.target_bitrate;
    }
    else {
      resolved.target_bitrate = 0
    }

    if (msg.refresh_interval !== undefined) {
      resolved.refresh_interval = msg.refresh_interval;
    }
    else {
      resolved.refresh_interval = 0
    }

    if (msg.idr_interval !== undefined) {
      resolved.idr_interval = msg.idr_interval;
    }
    else {
      resolved.idr_interval = 0
    }

    if (msg.awb !== undefined) {
      resolved.awb = msg.awb;
    }
    else {
      resolved.awb = 0
    }

    return resolved;
    }
};

// Constants for message
StreamParams.Constants = {
  OFF: -1,
  UNSET: 0,
  AUTO: 1,
  INCANDESCENT: 2,
  FLUORESCENT: 3,
  WARM_FLUORESCENT: 4,
  DAYLIGHT: 5,
  CLOUDY: 6,
  TWILIGHT: 7,
  SHADE: 8,
  DARK: 9,
}

module.exports = StreamParams;
