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

class DownloadGraphRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.download_filepath = null;
    }
    else {
      if (initObj.hasOwnProperty('download_filepath')) {
        this.download_filepath = initObj.download_filepath
      }
      else {
        this.download_filepath = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DownloadGraphRequest
    // Serialize message field [download_filepath]
    bufferOffset = _serializer.string(obj.download_filepath, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DownloadGraphRequest
    let len;
    let data = new DownloadGraphRequest(null);
    // Deserialize message field [download_filepath]
    data.download_filepath = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.download_filepath);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/DownloadGraphRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f171b9220180198cc327ec65dad2dce8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string download_filepath
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DownloadGraphRequest(null);
    if (msg.download_filepath !== undefined) {
      resolved.download_filepath = msg.download_filepath;
    }
    else {
      resolved.download_filepath = ''
    }

    return resolved;
    }
};

class DownloadGraphResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.waypoint_ids = null;
    }
    else {
      if (initObj.hasOwnProperty('waypoint_ids')) {
        this.waypoint_ids = initObj.waypoint_ids
      }
      else {
        this.waypoint_ids = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DownloadGraphResponse
    // Serialize message field [waypoint_ids]
    bufferOffset = _arraySerializer.string(obj.waypoint_ids, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DownloadGraphResponse
    let len;
    let data = new DownloadGraphResponse(null);
    // Deserialize message field [waypoint_ids]
    data.waypoint_ids = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.waypoint_ids.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/DownloadGraphResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '118b8bcfd9aa792758857e91da4c7a89';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] waypoint_ids
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DownloadGraphResponse(null);
    if (msg.waypoint_ids !== undefined) {
      resolved.waypoint_ids = msg.waypoint_ids;
    }
    else {
      resolved.waypoint_ids = []
    }

    return resolved;
    }
};

module.exports = {
  Request: DownloadGraphRequest,
  Response: DownloadGraphResponse,
  md5sum() { return 'a39595a31eb3fe78c31f978ce5465539'; },
  datatype() { return 'spot_msgs/DownloadGraph'; }
};
