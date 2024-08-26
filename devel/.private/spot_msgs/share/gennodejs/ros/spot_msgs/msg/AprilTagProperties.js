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

class AprilTagProperties {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.tag_id = null;
      this.x = null;
      this.y = null;
      this.frame_name_fiducial = null;
      this.fiducial_pose_status = null;
      this.frame_name_fiducial_filtered = null;
      this.fiducial_filtered_pose_status = null;
      this.frame_name_camera = null;
      this.detection_covariance = null;
      this.detection_covariance_reference_frame = null;
    }
    else {
      if (initObj.hasOwnProperty('tag_id')) {
        this.tag_id = initObj.tag_id
      }
      else {
        this.tag_id = 0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0.0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0.0;
      }
      if (initObj.hasOwnProperty('frame_name_fiducial')) {
        this.frame_name_fiducial = initObj.frame_name_fiducial
      }
      else {
        this.frame_name_fiducial = '';
      }
      if (initObj.hasOwnProperty('fiducial_pose_status')) {
        this.fiducial_pose_status = initObj.fiducial_pose_status
      }
      else {
        this.fiducial_pose_status = 0;
      }
      if (initObj.hasOwnProperty('frame_name_fiducial_filtered')) {
        this.frame_name_fiducial_filtered = initObj.frame_name_fiducial_filtered
      }
      else {
        this.frame_name_fiducial_filtered = '';
      }
      if (initObj.hasOwnProperty('fiducial_filtered_pose_status')) {
        this.fiducial_filtered_pose_status = initObj.fiducial_filtered_pose_status
      }
      else {
        this.fiducial_filtered_pose_status = 0;
      }
      if (initObj.hasOwnProperty('frame_name_camera')) {
        this.frame_name_camera = initObj.frame_name_camera
      }
      else {
        this.frame_name_camera = '';
      }
      if (initObj.hasOwnProperty('detection_covariance')) {
        this.detection_covariance = initObj.detection_covariance
      }
      else {
        this.detection_covariance = new geometry_msgs.msg.PoseWithCovariance();
      }
      if (initObj.hasOwnProperty('detection_covariance_reference_frame')) {
        this.detection_covariance_reference_frame = initObj.detection_covariance_reference_frame
      }
      else {
        this.detection_covariance_reference_frame = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AprilTagProperties
    // Serialize message field [tag_id]
    bufferOffset = _serializer.int32(obj.tag_id, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float64(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float64(obj.y, buffer, bufferOffset);
    // Serialize message field [frame_name_fiducial]
    bufferOffset = _serializer.string(obj.frame_name_fiducial, buffer, bufferOffset);
    // Serialize message field [fiducial_pose_status]
    bufferOffset = _serializer.uint8(obj.fiducial_pose_status, buffer, bufferOffset);
    // Serialize message field [frame_name_fiducial_filtered]
    bufferOffset = _serializer.string(obj.frame_name_fiducial_filtered, buffer, bufferOffset);
    // Serialize message field [fiducial_filtered_pose_status]
    bufferOffset = _serializer.uint8(obj.fiducial_filtered_pose_status, buffer, bufferOffset);
    // Serialize message field [frame_name_camera]
    bufferOffset = _serializer.string(obj.frame_name_camera, buffer, bufferOffset);
    // Serialize message field [detection_covariance]
    bufferOffset = geometry_msgs.msg.PoseWithCovariance.serialize(obj.detection_covariance, buffer, bufferOffset);
    // Serialize message field [detection_covariance_reference_frame]
    bufferOffset = _serializer.string(obj.detection_covariance_reference_frame, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AprilTagProperties
    let len;
    let data = new AprilTagProperties(null);
    // Deserialize message field [tag_id]
    data.tag_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [frame_name_fiducial]
    data.frame_name_fiducial = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [fiducial_pose_status]
    data.fiducial_pose_status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [frame_name_fiducial_filtered]
    data.frame_name_fiducial_filtered = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [fiducial_filtered_pose_status]
    data.fiducial_filtered_pose_status = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [frame_name_camera]
    data.frame_name_camera = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [detection_covariance]
    data.detection_covariance = geometry_msgs.msg.PoseWithCovariance.deserialize(buffer, bufferOffset);
    // Deserialize message field [detection_covariance_reference_frame]
    data.detection_covariance_reference_frame = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.frame_name_fiducial);
    length += _getByteLength(object.frame_name_fiducial_filtered);
    length += _getByteLength(object.frame_name_camera);
    length += _getByteLength(object.detection_covariance_reference_frame);
    return length + 382;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/AprilTagProperties';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '035439ca15acb004b11a25a16f3fd1de';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Status
    uint8 STATUS_UNKNOWN = 0
    uint8 STATUS_OK = 1
    uint8 STATUS_AMBIGUOUS = 2
    uint8 STATUS_HIGH_ERROR = 3
    
    int32 tag_id
    float64 x
    float64 y
    
    string frame_name_fiducial
    uint8 fiducial_pose_status
    
    string frame_name_fiducial_filtered
    uint8 fiducial_filtered_pose_status
    
    string frame_name_camera
    
    geometry_msgs/PoseWithCovariance detection_covariance
    string detection_covariance_reference_frame
    ================================================================================
    MSG: geometry_msgs/PoseWithCovariance
    # This represents a pose in free space with uncertainty.
    
    Pose pose
    
    # Row-major representation of the 6x6 covariance matrix
    # The orientation parameters use a fixed-axis representation.
    # In order, the parameters are:
    # (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
    float64[36] covariance
    
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
    const resolved = new AprilTagProperties(null);
    if (msg.tag_id !== undefined) {
      resolved.tag_id = msg.tag_id;
    }
    else {
      resolved.tag_id = 0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0.0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0.0
    }

    if (msg.frame_name_fiducial !== undefined) {
      resolved.frame_name_fiducial = msg.frame_name_fiducial;
    }
    else {
      resolved.frame_name_fiducial = ''
    }

    if (msg.fiducial_pose_status !== undefined) {
      resolved.fiducial_pose_status = msg.fiducial_pose_status;
    }
    else {
      resolved.fiducial_pose_status = 0
    }

    if (msg.frame_name_fiducial_filtered !== undefined) {
      resolved.frame_name_fiducial_filtered = msg.frame_name_fiducial_filtered;
    }
    else {
      resolved.frame_name_fiducial_filtered = ''
    }

    if (msg.fiducial_filtered_pose_status !== undefined) {
      resolved.fiducial_filtered_pose_status = msg.fiducial_filtered_pose_status;
    }
    else {
      resolved.fiducial_filtered_pose_status = 0
    }

    if (msg.frame_name_camera !== undefined) {
      resolved.frame_name_camera = msg.frame_name_camera;
    }
    else {
      resolved.frame_name_camera = ''
    }

    if (msg.detection_covariance !== undefined) {
      resolved.detection_covariance = geometry_msgs.msg.PoseWithCovariance.Resolve(msg.detection_covariance)
    }
    else {
      resolved.detection_covariance = new geometry_msgs.msg.PoseWithCovariance()
    }

    if (msg.detection_covariance_reference_frame !== undefined) {
      resolved.detection_covariance_reference_frame = msg.detection_covariance_reference_frame;
    }
    else {
      resolved.detection_covariance_reference_frame = ''
    }

    return resolved;
    }
};

// Constants for message
AprilTagProperties.Constants = {
  STATUS_UNKNOWN: 0,
  STATUS_OK: 1,
  STATUS_AMBIGUOUS: 2,
  STATUS_HIGH_ERROR: 3,
}

module.exports = AprilTagProperties;
