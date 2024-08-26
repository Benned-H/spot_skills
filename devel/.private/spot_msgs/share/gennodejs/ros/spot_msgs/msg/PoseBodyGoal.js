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

class PoseBodyGoal {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.body_pose = null;
      this.roll = null;
      this.pitch = null;
      this.yaw = null;
      this.body_height = null;
    }
    else {
      if (initObj.hasOwnProperty('body_pose')) {
        this.body_pose = initObj.body_pose
      }
      else {
        this.body_pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('roll')) {
        this.roll = initObj.roll
      }
      else {
        this.roll = 0;
      }
      if (initObj.hasOwnProperty('pitch')) {
        this.pitch = initObj.pitch
      }
      else {
        this.pitch = 0;
      }
      if (initObj.hasOwnProperty('yaw')) {
        this.yaw = initObj.yaw
      }
      else {
        this.yaw = 0;
      }
      if (initObj.hasOwnProperty('body_height')) {
        this.body_height = initObj.body_height
      }
      else {
        this.body_height = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PoseBodyGoal
    // Serialize message field [body_pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.body_pose, buffer, bufferOffset);
    // Serialize message field [roll]
    bufferOffset = _serializer.int8(obj.roll, buffer, bufferOffset);
    // Serialize message field [pitch]
    bufferOffset = _serializer.int8(obj.pitch, buffer, bufferOffset);
    // Serialize message field [yaw]
    bufferOffset = _serializer.int8(obj.yaw, buffer, bufferOffset);
    // Serialize message field [body_height]
    bufferOffset = _serializer.float32(obj.body_height, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PoseBodyGoal
    let len;
    let data = new PoseBodyGoal(null);
    // Deserialize message field [body_pose]
    data.body_pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [roll]
    data.roll = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [pitch]
    data.pitch = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [yaw]
    data.yaw = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [body_height]
    data.body_height = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 63;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/PoseBodyGoal';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2aaa468be31e97608ddb9e68aa66e756';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
    # The pose the body should be moved to. Only the orientation and the z component (body height) of position is considered.
    # If this is unset, the rpy/body height values will be used instead.
    geometry_msgs/Pose body_pose
    
    # Alternative specification of the body pose with rpy (in degrees). These values are ignored if the body_pose is set
    int8 roll
    int8 pitch
    int8 yaw
    float32 body_height
    
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
    const resolved = new PoseBodyGoal(null);
    if (msg.body_pose !== undefined) {
      resolved.body_pose = geometry_msgs.msg.Pose.Resolve(msg.body_pose)
    }
    else {
      resolved.body_pose = new geometry_msgs.msg.Pose()
    }

    if (msg.roll !== undefined) {
      resolved.roll = msg.roll;
    }
    else {
      resolved.roll = 0
    }

    if (msg.pitch !== undefined) {
      resolved.pitch = msg.pitch;
    }
    else {
      resolved.pitch = 0
    }

    if (msg.yaw !== undefined) {
      resolved.yaw = msg.yaw;
    }
    else {
      resolved.yaw = 0
    }

    if (msg.body_height !== undefined) {
      resolved.body_height = msg.body_height;
    }
    else {
      resolved.body_height = 0.0
    }

    return resolved;
    }
};

module.exports = PoseBodyGoal;
