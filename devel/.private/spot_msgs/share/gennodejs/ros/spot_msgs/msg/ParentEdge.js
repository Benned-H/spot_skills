// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class ParentEdge {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.parent_frame_name = null;
      this.parent_tform_child = null;
    }
    else {
      if (initObj.hasOwnProperty('parent_frame_name')) {
        this.parent_frame_name = initObj.parent_frame_name
      }
      else {
        this.parent_frame_name = '';
      }
      if (initObj.hasOwnProperty('parent_tform_child')) {
        this.parent_tform_child = initObj.parent_tform_child
      }
      else {
        this.parent_tform_child = new geometry_msgs.msg.Pose();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParentEdge
    // Serialize message field [parent_frame_name]
    bufferOffset = _serializer.string(obj.parent_frame_name, buffer, bufferOffset);
    // Serialize message field [parent_tform_child]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.parent_tform_child, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParentEdge
    let len;
    let data = new ParentEdge(null);
    // Deserialize message field [parent_frame_name]
    data.parent_frame_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [parent_tform_child]
    data.parent_tform_child = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.parent_frame_name);
    return length + 60;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/ParentEdge';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '14b32cd1337d19fdeb4701a1cb7d7dd2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new ParentEdge(null);
    if (msg.parent_frame_name !== undefined) {
      resolved.parent_frame_name = msg.parent_frame_name;
    }
    else {
      resolved.parent_frame_name = ''
    }

    if (msg.parent_tform_child !== undefined) {
      resolved.parent_tform_child = geometry_msgs.msg.Pose.Resolve(msg.parent_tform_child)
    }
    else {
      resolved.parent_tform_child = new geometry_msgs.msg.Pose()
    }

    return resolved;
    }
};

module.exports = ParentEdge;
