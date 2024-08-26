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

class PowerStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ptz = null;
      this.aux1 = null;
      this.aux2 = null;
      this.external_mic = null;
    }
    else {
      if (initObj.hasOwnProperty('ptz')) {
        this.ptz = initObj.ptz
      }
      else {
        this.ptz = 0;
      }
      if (initObj.hasOwnProperty('aux1')) {
        this.aux1 = initObj.aux1
      }
      else {
        this.aux1 = 0;
      }
      if (initObj.hasOwnProperty('aux2')) {
        this.aux2 = initObj.aux2
      }
      else {
        this.aux2 = 0;
      }
      if (initObj.hasOwnProperty('external_mic')) {
        this.external_mic = initObj.external_mic
      }
      else {
        this.external_mic = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PowerStatus
    // Serialize message field [ptz]
    bufferOffset = _serializer.uint8(obj.ptz, buffer, bufferOffset);
    // Serialize message field [aux1]
    bufferOffset = _serializer.uint8(obj.aux1, buffer, bufferOffset);
    // Serialize message field [aux2]
    bufferOffset = _serializer.uint8(obj.aux2, buffer, bufferOffset);
    // Serialize message field [external_mic]
    bufferOffset = _serializer.uint8(obj.external_mic, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PowerStatus
    let len;
    let data = new PowerStatus(null);
    // Deserialize message field [ptz]
    data.ptz = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [aux1]
    data.aux1 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [aux2]
    data.aux2 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [external_mic]
    data.external_mic = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_cam/PowerStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'cff241b1526dd8ec49e990b4e13bfa92';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Use when requesting a change to the power state. Indicates that no action should be taken on that device. This is
    # necessary because the BD API uses a bool to set the power state, where false is off. It would be impossible to know from
    # a bool in a request to change power state whether the user wanted to turn the device off or leave it as it was.
    uint8 NO_ACTION=0
    # Indicates that the power is on, or requests the power to be turned on
    uint8 POWER_ON=1
    # Indicates that the power is off, or requests the power to be turned off
    uint8 POWER_OFF=2
    
    uint8 ptz
    uint8 aux1
    uint8 aux2
    uint8 external_mic
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PowerStatus(null);
    if (msg.ptz !== undefined) {
      resolved.ptz = msg.ptz;
    }
    else {
      resolved.ptz = 0
    }

    if (msg.aux1 !== undefined) {
      resolved.aux1 = msg.aux1;
    }
    else {
      resolved.aux1 = 0
    }

    if (msg.aux2 !== undefined) {
      resolved.aux2 = msg.aux2;
    }
    else {
      resolved.aux2 = 0
    }

    if (msg.external_mic !== undefined) {
      resolved.external_mic = msg.external_mic;
    }
    else {
      resolved.external_mic = 0
    }

    return resolved;
    }
};

// Constants for message
PowerStatus.Constants = {
  NO_ACTION: 0,
  POWER_ON: 1,
  POWER_OFF: 2,
}

module.exports = PowerStatus;
