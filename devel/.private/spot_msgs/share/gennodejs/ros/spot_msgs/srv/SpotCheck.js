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

let SpotCheckDepth = require('../msg/SpotCheckDepth.js');
let SpotCheckLoadCell = require('../msg/SpotCheckLoadCell.js');
let SpotCheckKinematic = require('../msg/SpotCheckKinematic.js');
let SpotCheckPayload = require('../msg/SpotCheckPayload.js');
let SpotCheckHipROM = require('../msg/SpotCheckHipROM.js');

//-----------------------------------------------------------

class SpotCheckRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.start = null;
      this.blocking = null;
      this.revert_calibration = null;
      this.feedback_only = null;
    }
    else {
      if (initObj.hasOwnProperty('start')) {
        this.start = initObj.start
      }
      else {
        this.start = false;
      }
      if (initObj.hasOwnProperty('blocking')) {
        this.blocking = initObj.blocking
      }
      else {
        this.blocking = false;
      }
      if (initObj.hasOwnProperty('revert_calibration')) {
        this.revert_calibration = initObj.revert_calibration
      }
      else {
        this.revert_calibration = false;
      }
      if (initObj.hasOwnProperty('feedback_only')) {
        this.feedback_only = initObj.feedback_only
      }
      else {
        this.feedback_only = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckRequest
    // Serialize message field [start]
    bufferOffset = _serializer.bool(obj.start, buffer, bufferOffset);
    // Serialize message field [blocking]
    bufferOffset = _serializer.bool(obj.blocking, buffer, bufferOffset);
    // Serialize message field [revert_calibration]
    bufferOffset = _serializer.bool(obj.revert_calibration, buffer, bufferOffset);
    // Serialize message field [feedback_only]
    bufferOffset = _serializer.bool(obj.feedback_only, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckRequest
    let len;
    let data = new SpotCheckRequest(null);
    // Deserialize message field [start]
    data.start = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [blocking]
    data.blocking = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [revert_calibration]
    data.revert_calibration = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [feedback_only]
    data.feedback_only = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/SpotCheckRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '21f28964d8a22171043b2be0b8230ec2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # See https://dev.bostondynamics.com/python/bosdyn-client/src/bosdyn/client/spot_check
    bool start
    bool blocking
    bool revert_calibration
    bool feedback_only
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckRequest(null);
    if (msg.start !== undefined) {
      resolved.start = msg.start;
    }
    else {
      resolved.start = false
    }

    if (msg.blocking !== undefined) {
      resolved.blocking = msg.blocking;
    }
    else {
      resolved.blocking = false
    }

    if (msg.revert_calibration !== undefined) {
      resolved.revert_calibration = msg.revert_calibration;
    }
    else {
      resolved.revert_calibration = false
    }

    if (msg.feedback_only !== undefined) {
      resolved.feedback_only = msg.feedback_only;
    }
    else {
      resolved.feedback_only = false
    }

    return resolved;
    }
};

class SpotCheckResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.message = null;
      this.camera_names = null;
      this.camera_results = null;
      this.load_cell_names = null;
      this.load_cell_results = null;
      this.kinematic_joint_names = null;
      this.kinematic_cal_results = null;
      this.payload_result = null;
      this.leg_names = null;
      this.hip_range_of_motion_results = null;
      this.progress = null;
      this.last_cal_timestamp = null;
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
      if (initObj.hasOwnProperty('camera_names')) {
        this.camera_names = initObj.camera_names
      }
      else {
        this.camera_names = [];
      }
      if (initObj.hasOwnProperty('camera_results')) {
        this.camera_results = initObj.camera_results
      }
      else {
        this.camera_results = [];
      }
      if (initObj.hasOwnProperty('load_cell_names')) {
        this.load_cell_names = initObj.load_cell_names
      }
      else {
        this.load_cell_names = [];
      }
      if (initObj.hasOwnProperty('load_cell_results')) {
        this.load_cell_results = initObj.load_cell_results
      }
      else {
        this.load_cell_results = [];
      }
      if (initObj.hasOwnProperty('kinematic_joint_names')) {
        this.kinematic_joint_names = initObj.kinematic_joint_names
      }
      else {
        this.kinematic_joint_names = [];
      }
      if (initObj.hasOwnProperty('kinematic_cal_results')) {
        this.kinematic_cal_results = initObj.kinematic_cal_results
      }
      else {
        this.kinematic_cal_results = [];
      }
      if (initObj.hasOwnProperty('payload_result')) {
        this.payload_result = initObj.payload_result
      }
      else {
        this.payload_result = new SpotCheckPayload();
      }
      if (initObj.hasOwnProperty('leg_names')) {
        this.leg_names = initObj.leg_names
      }
      else {
        this.leg_names = [];
      }
      if (initObj.hasOwnProperty('hip_range_of_motion_results')) {
        this.hip_range_of_motion_results = initObj.hip_range_of_motion_results
      }
      else {
        this.hip_range_of_motion_results = [];
      }
      if (initObj.hasOwnProperty('progress')) {
        this.progress = initObj.progress
      }
      else {
        this.progress = 0.0;
      }
      if (initObj.hasOwnProperty('last_cal_timestamp')) {
        this.last_cal_timestamp = initObj.last_cal_timestamp
      }
      else {
        this.last_cal_timestamp = {secs: 0, nsecs: 0};
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpotCheckResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    // Serialize message field [camera_names]
    bufferOffset = _arraySerializer.string(obj.camera_names, buffer, bufferOffset, null);
    // Serialize message field [camera_results]
    // Serialize the length for message field [camera_results]
    bufferOffset = _serializer.uint32(obj.camera_results.length, buffer, bufferOffset);
    obj.camera_results.forEach((val) => {
      bufferOffset = SpotCheckDepth.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [load_cell_names]
    bufferOffset = _arraySerializer.string(obj.load_cell_names, buffer, bufferOffset, null);
    // Serialize message field [load_cell_results]
    // Serialize the length for message field [load_cell_results]
    bufferOffset = _serializer.uint32(obj.load_cell_results.length, buffer, bufferOffset);
    obj.load_cell_results.forEach((val) => {
      bufferOffset = SpotCheckLoadCell.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [kinematic_joint_names]
    bufferOffset = _arraySerializer.string(obj.kinematic_joint_names, buffer, bufferOffset, null);
    // Serialize message field [kinematic_cal_results]
    // Serialize the length for message field [kinematic_cal_results]
    bufferOffset = _serializer.uint32(obj.kinematic_cal_results.length, buffer, bufferOffset);
    obj.kinematic_cal_results.forEach((val) => {
      bufferOffset = SpotCheckKinematic.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [payload_result]
    bufferOffset = SpotCheckPayload.serialize(obj.payload_result, buffer, bufferOffset);
    // Serialize message field [leg_names]
    bufferOffset = _arraySerializer.string(obj.leg_names, buffer, bufferOffset, null);
    // Serialize message field [hip_range_of_motion_results]
    // Serialize the length for message field [hip_range_of_motion_results]
    bufferOffset = _serializer.uint32(obj.hip_range_of_motion_results.length, buffer, bufferOffset);
    obj.hip_range_of_motion_results.forEach((val) => {
      bufferOffset = SpotCheckHipROM.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [progress]
    bufferOffset = _serializer.float32(obj.progress, buffer, bufferOffset);
    // Serialize message field [last_cal_timestamp]
    bufferOffset = _serializer.time(obj.last_cal_timestamp, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpotCheckResponse
    let len;
    let data = new SpotCheckResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [camera_names]
    data.camera_names = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [camera_results]
    // Deserialize array length for message field [camera_results]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.camera_results = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.camera_results[i] = SpotCheckDepth.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [load_cell_names]
    data.load_cell_names = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [load_cell_results]
    // Deserialize array length for message field [load_cell_results]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.load_cell_results = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.load_cell_results[i] = SpotCheckLoadCell.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [kinematic_joint_names]
    data.kinematic_joint_names = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [kinematic_cal_results]
    // Deserialize array length for message field [kinematic_cal_results]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.kinematic_cal_results = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.kinematic_cal_results[i] = SpotCheckKinematic.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [payload_result]
    data.payload_result = SpotCheckPayload.deserialize(buffer, bufferOffset);
    // Deserialize message field [leg_names]
    data.leg_names = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [hip_range_of_motion_results]
    // Deserialize array length for message field [hip_range_of_motion_results]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.hip_range_of_motion_results = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.hip_range_of_motion_results[i] = SpotCheckHipROM.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [progress]
    data.progress = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [last_cal_timestamp]
    data.last_cal_timestamp = _deserializer.time(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.message);
    object.camera_names.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    length += 5 * object.camera_results.length;
    object.load_cell_names.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    length += 9 * object.load_cell_results.length;
    object.kinematic_joint_names.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    length += 13 * object.kinematic_cal_results.length;
    object.leg_names.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    object.hip_range_of_motion_results.forEach((val) => {
      length += SpotCheckHipROM.getMessageSize(val);
    });
    return length + 54;
  }

  static datatype() {
    // Returns string type for a service object
    return 'spot_msgs/SpotCheckResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '57928f98c641c9bdcc0ec470d1b08af8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    string message
    
    string[] camera_names
    spot_msgs/SpotCheckDepth[] camera_results
    
    string[] load_cell_names
    spot_msgs/SpotCheckLoadCell[] load_cell_results
    
    string[] kinematic_joint_names
    spot_msgs/SpotCheckKinematic[] kinematic_cal_results
    
    spot_msgs/SpotCheckPayload payload_result
    
    string[] leg_names
    spot_msgs/SpotCheckHipROM[] hip_range_of_motion_results
    
    float32 progress
    
    time last_cal_timestamp
    
    ================================================================================
    MSG: spot_msgs/SpotCheckDepth
    uint8 STATUS_UNKNOWN = 0     # Unused enum.
    uint8 STATUS_OK = 1          # No detected calibration error.
    uint8 STATUS_WARNING = 2     # Possible calibration error detected.
    uint8 STATUS_ERROR = 3       # Error with robot calibration.
    
    uint8 status
    float32 severity_score
    ================================================================================
    MSG: spot_msgs/SpotCheckLoadCell
    uint8 ERROR_UNKNOWN = 0              # Unused enum.
    uint8 ERROR_NONE = 1                 # No hardware error detected.
    uint8 ERROR_ZERO_OUT_OF_RANGE = 2    # Load cell calibration failure.
    
    # The loadcell error code
    uint8 error
    # The current loadcell zero as fraction of full range [0-1]
    float32 zero
    # The previous loadcell zero as fraction of full range [0-1]
    float32 old_zero
    ================================================================================
    MSG: spot_msgs/SpotCheckKinematic
    # Errors reflect an issue with robot hardware.
    uint8 ERROR_UNKNOWN = 0       # Unused enum.
    uint8 ERROR_NONE = 1          # No hardware error detected.
    uint8 ERROR_CLUTCH_SLIP = 2   # Error detected in clutch performance.
    uint8 ERROR_INVALID_RANGE_OF_MOTION = 3  # Error if a joint has an incorrect range of motion.
    
    # A flag to indicate if results has an error.
    uint8 error
    
    # The current offset [rad]
    float32 offset
    # The previous offset [rad]
    float32 old_offset
    
    # Joint calibration health score. range [0-1]
    # 0 indicates an unhealthy kinematic joint calibration
    # 1 indicates a perfect kinematic joint calibration
    # Typically, values greater than 0.8 should be expected.
    float32 health_score
    ================================================================================
    MSG: spot_msgs/SpotCheckPayload
    # Errors reflect an issue with payload configuration.
    
    # Unused enum.
    uint8 ERROR_UNKNOWN = 0
    # No error found in the payloads.
    uint8 ERROR_NONE = 1
    # There is a mass discrepancy between the registered payload and what is estimated.
    uint8 ERROR_MASS_DISCREPANCY = 2
    
    # A flag to indicate if configuration has an error.
    uint8 error
    
    # Indicates how much extra payload (in kg) we think the robot has
    # Positive indicates robot has more payload than it is configured.
    # Negative indicates robot has less payload than it is configured.
    float32 extra_payload
    ================================================================================
    MSG: spot_msgs/SpotCheckHipROM
    # Errors reflect an issue with hip range of motion
    uint8 ERROR_UNKNOWN = 0
    uint8 ERROR_NONE = 1
    uint8 ERROR_OBSTRUCTED = 2
    
    uint8 error
    
    # The measured angles (radians) of the HX and HY joints where the obstruction was detected
    float32[] hx
    float32[] hy
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpotCheckResponse(null);
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

    if (msg.camera_names !== undefined) {
      resolved.camera_names = msg.camera_names;
    }
    else {
      resolved.camera_names = []
    }

    if (msg.camera_results !== undefined) {
      resolved.camera_results = new Array(msg.camera_results.length);
      for (let i = 0; i < resolved.camera_results.length; ++i) {
        resolved.camera_results[i] = SpotCheckDepth.Resolve(msg.camera_results[i]);
      }
    }
    else {
      resolved.camera_results = []
    }

    if (msg.load_cell_names !== undefined) {
      resolved.load_cell_names = msg.load_cell_names;
    }
    else {
      resolved.load_cell_names = []
    }

    if (msg.load_cell_results !== undefined) {
      resolved.load_cell_results = new Array(msg.load_cell_results.length);
      for (let i = 0; i < resolved.load_cell_results.length; ++i) {
        resolved.load_cell_results[i] = SpotCheckLoadCell.Resolve(msg.load_cell_results[i]);
      }
    }
    else {
      resolved.load_cell_results = []
    }

    if (msg.kinematic_joint_names !== undefined) {
      resolved.kinematic_joint_names = msg.kinematic_joint_names;
    }
    else {
      resolved.kinematic_joint_names = []
    }

    if (msg.kinematic_cal_results !== undefined) {
      resolved.kinematic_cal_results = new Array(msg.kinematic_cal_results.length);
      for (let i = 0; i < resolved.kinematic_cal_results.length; ++i) {
        resolved.kinematic_cal_results[i] = SpotCheckKinematic.Resolve(msg.kinematic_cal_results[i]);
      }
    }
    else {
      resolved.kinematic_cal_results = []
    }

    if (msg.payload_result !== undefined) {
      resolved.payload_result = SpotCheckPayload.Resolve(msg.payload_result)
    }
    else {
      resolved.payload_result = new SpotCheckPayload()
    }

    if (msg.leg_names !== undefined) {
      resolved.leg_names = msg.leg_names;
    }
    else {
      resolved.leg_names = []
    }

    if (msg.hip_range_of_motion_results !== undefined) {
      resolved.hip_range_of_motion_results = new Array(msg.hip_range_of_motion_results.length);
      for (let i = 0; i < resolved.hip_range_of_motion_results.length; ++i) {
        resolved.hip_range_of_motion_results[i] = SpotCheckHipROM.Resolve(msg.hip_range_of_motion_results[i]);
      }
    }
    else {
      resolved.hip_range_of_motion_results = []
    }

    if (msg.progress !== undefined) {
      resolved.progress = msg.progress;
    }
    else {
      resolved.progress = 0.0
    }

    if (msg.last_cal_timestamp !== undefined) {
      resolved.last_cal_timestamp = msg.last_cal_timestamp;
    }
    else {
      resolved.last_cal_timestamp = {secs: 0, nsecs: 0}
    }

    return resolved;
    }
};

module.exports = {
  Request: SpotCheckRequest,
  Response: SpotCheckResponse,
  md5sum() { return '1ec255c808f67543e9f50ba450221b4c'; },
  datatype() { return 'spot_msgs/SpotCheck'; }
};
