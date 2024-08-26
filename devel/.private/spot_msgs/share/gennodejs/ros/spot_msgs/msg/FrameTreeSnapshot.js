// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ParentEdge = require('./ParentEdge.js');

//-----------------------------------------------------------

class FrameTreeSnapshot {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.child_edges = null;
      this.parent_edges = null;
    }
    else {
      if (initObj.hasOwnProperty('child_edges')) {
        this.child_edges = initObj.child_edges
      }
      else {
        this.child_edges = [];
      }
      if (initObj.hasOwnProperty('parent_edges')) {
        this.parent_edges = initObj.parent_edges
      }
      else {
        this.parent_edges = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FrameTreeSnapshot
    // Serialize message field [child_edges]
    bufferOffset = _arraySerializer.string(obj.child_edges, buffer, bufferOffset, null);
    // Serialize message field [parent_edges]
    // Serialize the length for message field [parent_edges]
    bufferOffset = _serializer.uint32(obj.parent_edges.length, buffer, bufferOffset);
    obj.parent_edges.forEach((val) => {
      bufferOffset = ParentEdge.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FrameTreeSnapshot
    let len;
    let data = new FrameTreeSnapshot(null);
    // Deserialize message field [child_edges]
    data.child_edges = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [parent_edges]
    // Deserialize array length for message field [parent_edges]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.parent_edges = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.parent_edges[i] = ParentEdge.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.child_edges.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    object.parent_edges.forEach((val) => {
      length += ParentEdge.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/FrameTreeSnapshot';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '211a7cb63ae362a8f92513c0e74a29a9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] child_edges
    ParentEdge[] parent_edges
    ================================================================================
    MSG: spot_msgs/ParentEdge
    string parent_frame_name
    geometry_msgs/Pose parent_tform_child
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FrameTreeSnapshot(null);
    if (msg.child_edges !== undefined) {
      resolved.child_edges = msg.child_edges;
    }
    else {
      resolved.child_edges = []
    }

    if (msg.parent_edges !== undefined) {
      resolved.parent_edges = new Array(msg.parent_edges.length);
      for (let i = 0; i < resolved.parent_edges.length; ++i) {
        resolved.parent_edges[i] = ParentEdge.Resolve(msg.parent_edges[i]);
      }
    }
    else {
      resolved.parent_edges = []
    }

    return resolved;
    }
};

module.exports = FrameTreeSnapshot;
