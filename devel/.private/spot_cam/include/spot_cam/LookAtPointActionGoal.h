// Generated by gencpp from file spot_cam/LookAtPointActionGoal.msg
// DO NOT EDIT!


#ifndef SPOT_CAM_MESSAGE_LOOKATPOINTACTIONGOAL_H
#define SPOT_CAM_MESSAGE_LOOKATPOINTACTIONGOAL_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>
#include <actionlib_msgs/GoalID.h>
#include <spot_cam/LookAtPointGoal.h>

namespace spot_cam
{
template <class ContainerAllocator>
struct LookAtPointActionGoal_
{
  typedef LookAtPointActionGoal_<ContainerAllocator> Type;

  LookAtPointActionGoal_()
    : header()
    , goal_id()
    , goal()  {
    }
  LookAtPointActionGoal_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , goal_id(_alloc)
    , goal(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef  ::actionlib_msgs::GoalID_<ContainerAllocator>  _goal_id_type;
  _goal_id_type goal_id;

   typedef  ::spot_cam::LookAtPointGoal_<ContainerAllocator>  _goal_type;
  _goal_type goal;





  typedef boost::shared_ptr< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> const> ConstPtr;

}; // struct LookAtPointActionGoal_

typedef ::spot_cam::LookAtPointActionGoal_<std::allocator<void> > LookAtPointActionGoal;

typedef boost::shared_ptr< ::spot_cam::LookAtPointActionGoal > LookAtPointActionGoalPtr;
typedef boost::shared_ptr< ::spot_cam::LookAtPointActionGoal const> LookAtPointActionGoalConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator1> & lhs, const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator2> & rhs)
{
  return lhs.header == rhs.header &&
    lhs.goal_id == rhs.goal_id &&
    lhs.goal == rhs.goal;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator1> & lhs, const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace spot_cam

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c7c4d5a5b66b744935117d8331c580ba";
  }

  static const char* value(const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc7c4d5a5b66b7449ULL;
  static const uint64_t static_value2 = 0x35117d8331c580baULL;
};

template<class ContainerAllocator>
struct DataType< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "spot_cam/LookAtPointActionGoal";
  }

  static const char* value(const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n"
"\n"
"Header header\n"
"actionlib_msgs/GoalID goal_id\n"
"LookAtPointGoal goal\n"
"\n"
"================================================================================\n"
"MSG: std_msgs/Header\n"
"# Standard metadata for higher-level stamped data types.\n"
"# This is generally used to communicate timestamped data \n"
"# in a particular coordinate frame.\n"
"# \n"
"# sequence ID: consecutively increasing ID \n"
"uint32 seq\n"
"#Two-integer timestamp that is expressed as:\n"
"# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n"
"# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n"
"# time-handling sugar is provided by the client library\n"
"time stamp\n"
"#Frame this data is associated with\n"
"string frame_id\n"
"\n"
"================================================================================\n"
"MSG: actionlib_msgs/GoalID\n"
"# The stamp should store the time at which this goal was requested.\n"
"# It is used by an action server when it tries to preempt all\n"
"# goals that were requested before a certain time\n"
"time stamp\n"
"\n"
"# The id provides a way to associate feedback and\n"
"# result message with specific goal requests. The id\n"
"# specified must be unique.\n"
"string id\n"
"\n"
"\n"
"================================================================================\n"
"MSG: spot_cam/LookAtPointGoal\n"
"# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n"
"# Point the spot cam PTZ at a specific point in space\n"
"# The target at which the PTZ should be pointed\n"
"geometry_msgs/PointStamped target\n"
"# Approximate width that the PTZ image should show. This is prioritised over the zoom level - if both are nonzero,\n"
"# this will be used\n"
"float32 image_width\n"
"# Optical zoom level between 1 and 30 to use\n"
"float32 zoom_level\n"
"# If true, the camera will track this point as the robot moves\n"
"bool track\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/PointStamped\n"
"# This represents a Point with reference coordinate frame and timestamp\n"
"Header header\n"
"Point point\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Point\n"
"# This contains the position of a point in free space\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
;
  }

  static const char* value(const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.goal_id);
      stream.next(m.goal);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct LookAtPointActionGoal_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::spot_cam::LookAtPointActionGoal_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::spot_cam::LookAtPointActionGoal_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "goal_id: ";
    s << std::endl;
    Printer< ::actionlib_msgs::GoalID_<ContainerAllocator> >::stream(s, indent + "  ", v.goal_id);
    s << indent << "goal: ";
    s << std::endl;
    Printer< ::spot_cam::LookAtPointGoal_<ContainerAllocator> >::stream(s, indent + "  ", v.goal);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SPOT_CAM_MESSAGE_LOOKATPOINTACTIONGOAL_H
