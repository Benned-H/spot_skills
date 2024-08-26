// Auto-generated. Do not edit!

// (in-package spot_cam.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetIRColormapRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.colormap = null;
      this.min = null;
      this.max = null;
      this.auto_scale = null;
    }
    else {
      if (initObj.hasOwnProperty('colormap')) {
        this.colormap = initObj.colormap
      }
      else {
        this.colormap = 0;
      }
      if (initObj.hasOwnProperty('min')) {
        this.min = initObj.min
      }
      else {
        this.min = 0.0;
      }
      if (initObj.hasOwnProperty('max')) {
        this.max = initObj.max
      }
      else {
        this.max = 0.0;
      }
      if (initObj.hasOwnProperty('auto_scale')) {
        this.auto_scale = initObj.auto_scale
      }
      else {
        this.auto_scale = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetIRColormapRequest
    // Serialize message field [colormap]
    bufferOffset = _serializer.uint8(obj.colormap, buffer, bufferOffset);
    // Serialize message field [min]
    bufferOffset = _serializer.float32(obj.min, buffer, bufferOffset);
    // Serialize message field [max]
    bufferOffset = _serializer.float32(obj.max, buffer, bufferOffset);
    // Serialize message field [auto_scale]
    bufferOffset = _serializer.bool(obj.auto_scale, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetIRColormapRequest
    let len;
    let data = new SetIRColormapRequest(null);
    // Deserialize message field [colormap]
    data.colormap = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [min]
    data.min = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [max]
    data.max = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [auto_scale]
    data.auto_scale = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 10;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_cam/SetIRColormapRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '69f70a473af7d968f923ffcb40d332eb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # See https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference#ircolormap for definition
    uint8 COLORMAP_UNKNOWN=0
    # The greyscale colormap maps the minimum value (defined below) to black and the maximum value (defined below) to white
    uint8 COLORMAP_GREYSCALE=1
    # The jet colormap uses blues for values closer to the minimum, and red values for values closer to the maximum.
    uint8 COLORMAP_JET=2
    # The inferno colormap maps the minimum value to black and the maximum value to light yellow RGB(252, 252, 164).
    # It is also easier to view by those with color blindness
    uint8 COLORMAP_INFERNO=3
    # The turbo colormap uses blues for values closer to the minumum, red values for values closer to the maximum,
    # and addresses some short comings of the jet color map such as false detail, banding and color blindness
    uint8 COLORMAP_TURBO=4
    
    # The colormap to use for the IR display
    uint8 colormap
    # Minimum value for the color mapping in degrees celsius
    float32 min
    # Maximum value for the color mapping in degrees celsius
    float32 max
    # If true, automatically derive min and max from the image data. Min and max values are ignored
    bool auto_scale
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetIRColormapRequest(null);
    if (msg.colormap !== undefined) {
      resolved.colormap = msg.colormap;
    }
    else {
      resolved.colormap = 0
    }

    if (msg.min !== undefined) {
      resolved.min = msg.min;
    }
    else {
      resolved.min = 0.0
    }

    if (msg.max !== undefined) {
      resolved.max = msg.max;
    }
    else {
      resolved.max = 0.0
    }

    if (msg.auto_scale !== undefined) {
      resolved.auto_scale = msg.auto_scale;
    }
    else {
      resolved.auto_scale = false
    }

    return resolved;
    }
};

// Constants for message
SetIRColormapRequest.Constants = {
  COLORMAP_UNKNOWN: 0,
  COLORMAP_GREYSCALE: 1,
  COLORMAP_JET: 2,
  COLORMAP_INFERNO: 3,
  COLORMAP_TURBO: 4,
}

class SetIRColormapResponse {
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
    // Serializes a message object of type SetIRColormapResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetIRColormapResponse
    let len;
    let data = new SetIRColormapResponse(null);
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
    return 'spot_cam/SetIRColormapResponse';
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
    const resolved = new SetIRColormapResponse(null);
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
  Request: SetIRColormapRequest,
  Response: SetIRColormapResponse,
  md5sum() { return 'e8a4267610857cdc61a42ef5adcd242f'; },
  datatype() { return 'spot_cam/SetIRColormap'; }
};
