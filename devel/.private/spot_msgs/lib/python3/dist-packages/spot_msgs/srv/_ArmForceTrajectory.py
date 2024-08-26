# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from spot_msgs/ArmForceTrajectoryRequest.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class ArmForceTrajectoryRequest(genpy.Message):
  _md5sum = "df1770a07fa213279ddffa14a7667266"
  _type = "spot_msgs/ArmForceTrajectoryRequest"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """float64 duration
string frame
float64[3] forces_pt0 # fx fy fz
float64[3] torques_pt0 # tx ty yz
float64[3] forces_pt1 # fx fy fz
float64[3] torques_pt1 # tx ty yz
"""
  __slots__ = ['duration','frame','forces_pt0','torques_pt0','forces_pt1','torques_pt1']
  _slot_types = ['float64','string','float64[3]','float64[3]','float64[3]','float64[3]']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       duration,frame,forces_pt0,torques_pt0,forces_pt1,torques_pt1

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(ArmForceTrajectoryRequest, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.duration is None:
        self.duration = 0.
      if self.frame is None:
        self.frame = ''
      if self.forces_pt0 is None:
        self.forces_pt0 = [0.] * 3
      if self.torques_pt0 is None:
        self.torques_pt0 = [0.] * 3
      if self.forces_pt1 is None:
        self.forces_pt1 = [0.] * 3
      if self.torques_pt1 is None:
        self.torques_pt1 = [0.] * 3
    else:
      self.duration = 0.
      self.frame = ''
      self.forces_pt0 = [0.] * 3
      self.torques_pt0 = [0.] * 3
      self.forces_pt1 = [0.] * 3
      self.torques_pt1 = [0.] * 3

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self.duration
      buff.write(_get_struct_d().pack(_x))
      _x = self.frame
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      buff.write(_get_struct_3d().pack(*self.forces_pt0))
      buff.write(_get_struct_3d().pack(*self.torques_pt0))
      buff.write(_get_struct_3d().pack(*self.forces_pt1))
      buff.write(_get_struct_3d().pack(*self.torques_pt1))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 8
      (self.duration,) = _get_struct_d().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.frame = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.frame = str[start:end]
      start = end
      end += 24
      self.forces_pt0 = _get_struct_3d().unpack(str[start:end])
      start = end
      end += 24
      self.torques_pt0 = _get_struct_3d().unpack(str[start:end])
      start = end
      end += 24
      self.forces_pt1 = _get_struct_3d().unpack(str[start:end])
      start = end
      end += 24
      self.torques_pt1 = _get_struct_3d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self.duration
      buff.write(_get_struct_d().pack(_x))
      _x = self.frame
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      buff.write(self.forces_pt0.tostring())
      buff.write(self.torques_pt0.tostring())
      buff.write(self.forces_pt1.tostring())
      buff.write(self.torques_pt1.tostring())
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 8
      (self.duration,) = _get_struct_d().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.frame = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.frame = str[start:end]
      start = end
      end += 24
      self.forces_pt0 = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=3)
      start = end
      end += 24
      self.torques_pt0 = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=3)
      start = end
      end += 24
      self.forces_pt1 = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=3)
      start = end
      end += 24
      self.torques_pt1 = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=3)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_3d = None
def _get_struct_3d():
    global _struct_3d
    if _struct_3d is None:
        _struct_3d = struct.Struct("<3d")
    return _struct_3d
_struct_d = None
def _get_struct_d():
    global _struct_d
    if _struct_d is None:
        _struct_d = struct.Struct("<d")
    return _struct_d
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from spot_msgs/ArmForceTrajectoryResponse.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class ArmForceTrajectoryResponse(genpy.Message):
  _md5sum = "937c9679a518e3a18d831e57125ea522"
  _type = "spot_msgs/ArmForceTrajectoryResponse"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """bool success
string message

"""
  __slots__ = ['success','message']
  _slot_types = ['bool','string']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       success,message

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(ArmForceTrajectoryResponse, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.success is None:
        self.success = False
      if self.message is None:
        self.message = ''
    else:
      self.success = False
      self.message = ''

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self.success
      buff.write(_get_struct_B().pack(_x))
      _x = self.message
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 1
      (self.success,) = _get_struct_B().unpack(str[start:end])
      self.success = bool(self.success)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.message = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.message = str[start:end]
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self.success
      buff.write(_get_struct_B().pack(_x))
      _x = self.message
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 1
      (self.success,) = _get_struct_B().unpack(str[start:end])
      self.success = bool(self.success)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.message = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.message = str[start:end]
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_B = None
def _get_struct_B():
    global _struct_B
    if _struct_B is None:
        _struct_B = struct.Struct("<B")
    return _struct_B
class ArmForceTrajectory(object):
  _type          = 'spot_msgs/ArmForceTrajectory'
  _md5sum = '5ec2796f0480118f129c21c2f87b4cf7'
  _request_class  = ArmForceTrajectoryRequest
  _response_class = ArmForceTrajectoryResponse
