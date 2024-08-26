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

class Feedback {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.standing = null;
      this.sitting = null;
      this.moving = null;
      this.serial_number = null;
      this.species = null;
      this.version = null;
      this.nickname = null;
      this.computer_serial_number = null;
    }
    else {
      if (initObj.hasOwnProperty('standing')) {
        this.standing = initObj.standing
      }
      else {
        this.standing = false;
      }
      if (initObj.hasOwnProperty('sitting')) {
        this.sitting = initObj.sitting
      }
      else {
        this.sitting = false;
      }
      if (initObj.hasOwnProperty('moving')) {
        this.moving = initObj.moving
      }
      else {
        this.moving = false;
      }
      if (initObj.hasOwnProperty('serial_number')) {
        this.serial_number = initObj.serial_number
      }
      else {
        this.serial_number = '';
      }
      if (initObj.hasOwnProperty('species')) {
        this.species = initObj.species
      }
      else {
        this.species = '';
      }
      if (initObj.hasOwnProperty('version')) {
        this.version = initObj.version
      }
      else {
        this.version = '';
      }
      if (initObj.hasOwnProperty('nickname')) {
        this.nickname = initObj.nickname
      }
      else {
        this.nickname = '';
      }
      if (initObj.hasOwnProperty('computer_serial_number')) {
        this.computer_serial_number = initObj.computer_serial_number
      }
      else {
        this.computer_serial_number = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Feedback
    // Serialize message field [standing]
    bufferOffset = _serializer.bool(obj.standing, buffer, bufferOffset);
    // Serialize message field [sitting]
    bufferOffset = _serializer.bool(obj.sitting, buffer, bufferOffset);
    // Serialize message field [moving]
    bufferOffset = _serializer.bool(obj.moving, buffer, bufferOffset);
    // Serialize message field [serial_number]
    bufferOffset = _serializer.string(obj.serial_number, buffer, bufferOffset);
    // Serialize message field [species]
    bufferOffset = _serializer.string(obj.species, buffer, bufferOffset);
    // Serialize message field [version]
    bufferOffset = _serializer.string(obj.version, buffer, bufferOffset);
    // Serialize message field [nickname]
    bufferOffset = _serializer.string(obj.nickname, buffer, bufferOffset);
    // Serialize message field [computer_serial_number]
    bufferOffset = _serializer.string(obj.computer_serial_number, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Feedback
    let len;
    let data = new Feedback(null);
    // Deserialize message field [standing]
    data.standing = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [sitting]
    data.sitting = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [moving]
    data.moving = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [serial_number]
    data.serial_number = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [species]
    data.species = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [version]
    data.version = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [nickname]
    data.nickname = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [computer_serial_number]
    data.computer_serial_number = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.serial_number);
    length += _getByteLength(object.species);
    length += _getByteLength(object.version);
    length += _getByteLength(object.nickname);
    length += _getByteLength(object.computer_serial_number);
    return length + 23;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/Feedback';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '16779e4df8e3f77c9ee8c1811559bd21';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool standing
    bool sitting
    bool moving
    
    string serial_number
    string species
    string version
    string nickname
    string computer_serial_number
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Feedback(null);
    if (msg.standing !== undefined) {
      resolved.standing = msg.standing;
    }
    else {
      resolved.standing = false
    }

    if (msg.sitting !== undefined) {
      resolved.sitting = msg.sitting;
    }
    else {
      resolved.sitting = false
    }

    if (msg.moving !== undefined) {
      resolved.moving = msg.moving;
    }
    else {
      resolved.moving = false
    }

    if (msg.serial_number !== undefined) {
      resolved.serial_number = msg.serial_number;
    }
    else {
      resolved.serial_number = ''
    }

    if (msg.species !== undefined) {
      resolved.species = msg.species;
    }
    else {
      resolved.species = ''
    }

    if (msg.version !== undefined) {
      resolved.version = msg.version;
    }
    else {
      resolved.version = ''
    }

    if (msg.nickname !== undefined) {
      resolved.nickname = msg.nickname;
    }
    else {
      resolved.nickname = ''
    }

    if (msg.computer_serial_number !== undefined) {
      resolved.computer_serial_number = msg.computer_serial_number;
    }
    else {
      resolved.computer_serial_number = ''
    }

    return resolved;
    }
};

module.exports = Feedback;
