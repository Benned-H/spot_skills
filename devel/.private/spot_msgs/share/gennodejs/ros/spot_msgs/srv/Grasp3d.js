// Auto-generated. Do not edit!

// (in-package spot_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class Grasp3dRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.frame_name = null;
      this.object_rt_frame = null;
    }
    else {
      if (initObj.hasOwnProperty('frame_name')) {
        this.frame_name = initObj.frame_name
      }
      else {
        this.frame_name = '';
      }
      if (initObj.hasOwnProperty('object_rt_frame')) {
        this.object_rt_frame = initObj.object_rt_frame
      }
      else {
        this.object_rt_frame = new Array(3).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Grasp3dRequest
    // Serialize message field [frame_name]
    bufferOffset = _serializer.string(obj.frame_name, buffer, bufferOffset);
    // Check that the constant length array field [object_rt_frame] has the right length
    if (obj.object_rt_frame.length !== 3) {
      throw new Error('Unable to serialize array field object_rt_frame - length must be 3')
    }
    // Serialize message field [object_rt_frame]
    bufferOffset = _arraySerializer.float64(obj.object_rt_frame, buffer, bufferOffset, 3);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Grasp3dRequest
    let len;
    let data = new Grasp3dRequest(null);
    // Deserialize message field [frame_name]
    data.frame_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [object_rt_frame]
    data.object_rt_frame = _arrayDeserializer.float64(buffer, bufferOffset, 3)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.frame_name);
    return length + 28;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/Grasp3dRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '137192c88d2c462af8e3f3418526b82a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#pickobject
    string frame_name # name of the tf frame
    float64[3] object_rt_frame # x,y,z of the object in the frame named above
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Grasp3dRequest(null);
    if (msg.frame_name !== undefined) {
      resolved.frame_name = msg.frame_name;
    }
    else {
      resolved.frame_name = ''
    }

    if (msg.object_rt_frame !== undefined) {
      resolved.object_rt_frame = msg.object_rt_frame;
    }
    else {
      resolved.object_rt_frame = new Array(3).fill(0)
    }

    return resolved;
    }
};

class Grasp3dResponse {
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
    // Serializes a message object of type Grasp3dResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Grasp3dResponse
    let len;
    let data = new Grasp3dResponse(null);
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
    return 'spot_msgs/Grasp3dResponse';
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
    const resolved = new Grasp3dResponse(null);
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
  Request: Grasp3dRequest,
  Response: Grasp3dResponse,
  md5sum() { return '7cdad498436e31571e25a54239d53a58'; },
  datatype() { return 'spot_msgs/Grasp3d'; }
};
