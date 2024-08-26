// Auto-generated. Do not edit!

// (in-package spot_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let FrameTreeSnapshot = require('./FrameTreeSnapshot.js');
let sensor_msgs = _finder('sensor_msgs');

//-----------------------------------------------------------

class ImageCapture {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.acquisition_time = null;
      this.transforms_snapshot = null;
      this.frame_name_image_sensor = null;
      this.image = null;
      this.capture_exposure_duration = null;
      this.capture_sensor_gain = null;
    }
    else {
      if (initObj.hasOwnProperty('acquisition_time')) {
        this.acquisition_time = initObj.acquisition_time
      }
      else {
        this.acquisition_time = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('transforms_snapshot')) {
        this.transforms_snapshot = initObj.transforms_snapshot
      }
      else {
        this.transforms_snapshot = new FrameTreeSnapshot();
      }
      if (initObj.hasOwnProperty('frame_name_image_sensor')) {
        this.frame_name_image_sensor = initObj.frame_name_image_sensor
      }
      else {
        this.frame_name_image_sensor = '';
      }
      if (initObj.hasOwnProperty('image')) {
        this.image = initObj.image
      }
      else {
        this.image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('capture_exposure_duration')) {
        this.capture_exposure_duration = initObj.capture_exposure_duration
      }
      else {
        this.capture_exposure_duration = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('capture_sensor_gain')) {
        this.capture_sensor_gain = initObj.capture_sensor_gain
      }
      else {
        this.capture_sensor_gain = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImageCapture
    // Serialize message field [acquisition_time]
    bufferOffset = _serializer.time(obj.acquisition_time, buffer, bufferOffset);
    // Serialize message field [transforms_snapshot]
    bufferOffset = FrameTreeSnapshot.serialize(obj.transforms_snapshot, buffer, bufferOffset);
    // Serialize message field [frame_name_image_sensor]
    bufferOffset = _serializer.string(obj.frame_name_image_sensor, buffer, bufferOffset);
    // Serialize message field [image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.image, buffer, bufferOffset);
    // Serialize message field [capture_exposure_duration]
    bufferOffset = _serializer.duration(obj.capture_exposure_duration, buffer, bufferOffset);
    // Serialize message field [capture_sensor_gain]
    bufferOffset = _serializer.float64(obj.capture_sensor_gain, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImageCapture
    let len;
    let data = new ImageCapture(null);
    // Deserialize message field [acquisition_time]
    data.acquisition_time = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [transforms_snapshot]
    data.transforms_snapshot = FrameTreeSnapshot.deserialize(buffer, bufferOffset);
    // Deserialize message field [frame_name_image_sensor]
    data.frame_name_image_sensor = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [image]
    data.image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [capture_exposure_duration]
    data.capture_exposure_duration = _deserializer.duration(buffer, bufferOffset);
    // Deserialize message field [capture_sensor_gain]
    data.capture_sensor_gain = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += FrameTreeSnapshot.getMessageSize(object.transforms_snapshot);
    length += _getByteLength(object.frame_name_image_sensor);
    length += sensor_msgs.msg.Image.getMessageSize(object.image);
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'spot_msgs/ImageCapture';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3f615a6b98619410c2ebd532b7113b6e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    time acquisition_time
    
    FrameTreeSnapshot transforms_snapshot
    string frame_name_image_sensor
    
    sensor_msgs/Image image
    
    duration capture_exposure_duration
    float64 capture_sensor_gain
    
    ================================================================================
    MSG: spot_msgs/FrameTreeSnapshot
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
    
    ================================================================================
    MSG: sensor_msgs/Image
    # This message contains an uncompressed image
    # (0, 0) is at top-left corner of image
    #
    
    Header header        # Header timestamp should be acquisition time of image
                         # Header frame_id should be optical frame of camera
                         # origin of frame should be optical center of camera
                         # +x should point to the right in the image
                         # +y should point down in the image
                         # +z should point into to plane of the image
                         # If the frame_id here and the frame_id of the CameraInfo
                         # message associated with the image conflict
                         # the behavior is undefined
    
    uint32 height         # image height, that is, number of rows
    uint32 width          # image width, that is, number of columns
    
    # The legal values for encoding are in file src/image_encodings.cpp
    # If you want to standardize a new string format, join
    # ros-users@lists.sourceforge.net and send an email proposing a new encoding.
    
    string encoding       # Encoding of pixels -- channel meaning, ordering, size
                          # taken from the list of strings in include/sensor_msgs/image_encodings.h
    
    uint8 is_bigendian    # is this data bigendian?
    uint32 step           # Full row length in bytes
    uint8[] data          # actual matrix data, size is (step * rows)
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImageCapture(null);
    if (msg.acquisition_time !== undefined) {
      resolved.acquisition_time = msg.acquisition_time;
    }
    else {
      resolved.acquisition_time = {secs: 0, nsecs: 0}
    }

    if (msg.transforms_snapshot !== undefined) {
      resolved.transforms_snapshot = FrameTreeSnapshot.Resolve(msg.transforms_snapshot)
    }
    else {
      resolved.transforms_snapshot = new FrameTreeSnapshot()
    }

    if (msg.frame_name_image_sensor !== undefined) {
      resolved.frame_name_image_sensor = msg.frame_name_image_sensor;
    }
    else {
      resolved.frame_name_image_sensor = ''
    }

    if (msg.image !== undefined) {
      resolved.image = sensor_msgs.msg.Image.Resolve(msg.image)
    }
    else {
      resolved.image = new sensor_msgs.msg.Image()
    }

    if (msg.capture_exposure_duration !== undefined) {
      resolved.capture_exposure_duration = msg.capture_exposure_duration;
    }
    else {
      resolved.capture_exposure_duration = {secs: 0, nsecs: 0}
    }

    if (msg.capture_sensor_gain !== undefined) {
      resolved.capture_sensor_gain = msg.capture_sensor_gain;
    }
    else {
      resolved.capture_sensor_gain = 0.0
    }

    return resolved;
    }
};

module.exports = ImageCapture;
