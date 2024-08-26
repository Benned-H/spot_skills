// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ObstacleParams = require('./ObstacleParams.js');
let TerrainParams = require('./TerrainParams.js');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class MobilityParams {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.body_control = null;
      this.locomotion_hint = null;
      this.swing_height = null;
      this.stair_hint = null;
      this.velocity_limit = null;
      this.obstacle_params = null;
      this.terrain_params = null;
    }
    else {
      if (initObj.hasOwnProperty('body_control')) {
        this.body_control = initObj.body_control
      }
      else {
        this.body_control = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('locomotion_hint')) {
        this.locomotion_hint = initObj.locomotion_hint
      }
      else {
        this.locomotion_hint = 0;
      }
      if (initObj.hasOwnProperty('swing_height')) {
        this.swing_height = initObj.swing_height
      }
      else {
        this.swing_height = 0;
      }
      if (initObj.hasOwnProperty('stair_hint')) {
        this.stair_hint = initObj.stair_hint
      }
      else {
        this.stair_hint = false;
      }
      if (initObj.hasOwnProperty('velocity_limit')) {
        this.velocity_limit = initObj.velocity_limit
      }
      else {
        this.velocity_limit = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('obstacle_params')) {
        this.obstacle_params = initObj.obstacle_params
      }
      else {
        this.obstacle_params = new ObstacleParams();
      }
      if (initObj.hasOwnProperty('terrain_params')) {
        this.terrain_params = initObj.terrain_params
      }
      else {
        this.terrain_params = new TerrainParams();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MobilityParams
    // Serialize message field [body_control]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.body_control, buffer, bufferOffset);
    // Serialize message field [locomotion_hint]
    bufferOffset = _serializer.uint32(obj.locomotion_hint, buffer, bufferOffset);
    // Serialize message field [swing_height]
    bufferOffset = _serializer.uint8(obj.swing_height, buffer, bufferOffset);
    // Serialize message field [stair_hint]
    bufferOffset = _serializer.bool(obj.stair_hint, buffer, bufferOffset);
    // Serialize message field [velocity_limit]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.velocity_limit, buffer, bufferOffset);
    // Serialize message field [obstacle_params]
    bufferOffset = ObstacleParams.serialize(obj.obstacle_params, buffer, bufferOffset);
    // Serialize message field [terrain_params]
    bufferOffset = TerrainParams.serialize(obj.terrain_params, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MobilityParams
    let len;
    let data = new MobilityParams(null);
    // Deserialize message field [body_control]
    data.body_control = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [locomotion_hint]
    data.locomotion_hint = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [swing_height]
    data.swing_height = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [stair_hint]
    data.stair_hint = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [velocity_limit]
    data.velocity_limit = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [obstacle_params]
    data.obstacle_params = ObstacleParams.deserialize(buffer, bufferOffset);
    // Deserialize message field [terrain_params]
    data.terrain_params = TerrainParams.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 124;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/MobilityParams';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'cd45019f5c330befb9646917a064a94d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Pose body_control
    uint32 locomotion_hint
    uint8 swing_height
    bool stair_hint
    geometry_msgs/Twist velocity_limit
    spot_msgs/ObstacleParams obstacle_params
    spot_msgs/TerrainParams terrain_params
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
    
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    ================================================================================
    MSG: spot_msgs/ObstacleParams
    # see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#obstacleparams
    bool disable_vision_foot_obstacle_avoidance
    bool disable_vision_foot_constraint_avoidance
    bool disable_vision_body_obstacle_avoidance
    float32 obstacle_avoidance_padding
    bool disable_vision_foot_obstacle_body_assist
    bool disable_vision_negative_obstacles
    ================================================================================
    MSG: spot_msgs/TerrainParams
    # see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams
    uint8 GRATED_SURFACES_MODE_UNKNOWN=0
    uint8 GRATED_SURFACES_MODE_OFF=1
    uint8 GRATED_SURFACES_MODE_ON=2
    uint8 GRATED_SURFACES_MODE_AUTO=3
    
    float32 ground_mu_hint
    uint8 grated_surfaces_mode
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MobilityParams(null);
    if (msg.body_control !== undefined) {
      resolved.body_control = geometry_msgs.msg.Pose.Resolve(msg.body_control)
    }
    else {
      resolved.body_control = new geometry_msgs.msg.Pose()
    }

    if (msg.locomotion_hint !== undefined) {
      resolved.locomotion_hint = msg.locomotion_hint;
    }
    else {
      resolved.locomotion_hint = 0
    }

    if (msg.swing_height !== undefined) {
      resolved.swing_height = msg.swing_height;
    }
    else {
      resolved.swing_height = 0
    }

    if (msg.stair_hint !== undefined) {
      resolved.stair_hint = msg.stair_hint;
    }
    else {
      resolved.stair_hint = false
    }

    if (msg.velocity_limit !== undefined) {
      resolved.velocity_limit = geometry_msgs.msg.Twist.Resolve(msg.velocity_limit)
    }
    else {
      resolved.velocity_limit = new geometry_msgs.msg.Twist()
    }

    if (msg.obstacle_params !== undefined) {
      resolved.obstacle_params = ObstacleParams.Resolve(msg.obstacle_params)
    }
    else {
      resolved.obstacle_params = new ObstacleParams()
    }

    if (msg.terrain_params !== undefined) {
      resolved.terrain_params = TerrainParams.Resolve(msg.terrain_params)
    }
    else {
      resolved.terrain_params = new TerrainParams()
    }

    return resolved;
    }
};

module.exports = MobilityParams;
