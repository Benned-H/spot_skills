// Generated by gencpp from file spot_msgs/GripperAngleMoveRequest.msg
// DO NOT EDIT!


#ifndef SPOT_MSGS_MESSAGE_GRIPPERANGLEMOVEREQUEST_H
#define SPOT_MSGS_MESSAGE_GRIPPERANGLEMOVEREQUEST_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace spot_msgs
{
template <class ContainerAllocator>
struct GripperAngleMoveRequest_
{
  typedef GripperAngleMoveRequest_<ContainerAllocator> Type;

  GripperAngleMoveRequest_()
    : gripper_angle(0.0)  {
    }
  GripperAngleMoveRequest_(const ContainerAllocator& _alloc)
    : gripper_angle(0.0)  {
  (void)_alloc;
    }



   typedef double _gripper_angle_type;
  _gripper_angle_type gripper_angle;





  typedef boost::shared_ptr< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> const> ConstPtr;

}; // struct GripperAngleMoveRequest_

typedef ::spot_msgs::GripperAngleMoveRequest_<std::allocator<void> > GripperAngleMoveRequest;

typedef boost::shared_ptr< ::spot_msgs::GripperAngleMoveRequest > GripperAngleMoveRequestPtr;
typedef boost::shared_ptr< ::spot_msgs::GripperAngleMoveRequest const> GripperAngleMoveRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator1> & lhs, const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator2> & rhs)
{
  return lhs.gripper_angle == rhs.gripper_angle;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator1> & lhs, const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace spot_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "59da75002a58e255f8fcf865093b61cd";
  }

  static const char* value(const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x59da75002a58e255ULL;
  static const uint64_t static_value2 = 0xf8fcf865093b61cdULL;
};

template<class ContainerAllocator>
struct DataType< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "spot_msgs/GripperAngleMoveRequest";
  }

  static const char* value(const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 gripper_angle\n"
;
  }

  static const char* value(const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.gripper_angle);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct GripperAngleMoveRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::spot_msgs::GripperAngleMoveRequest_<ContainerAllocator>& v)
  {
    s << indent << "gripper_angle: ";
    Printer<double>::stream(s, indent + "  ", v.gripper_angle);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SPOT_MSGS_MESSAGE_GRIPPERANGLEMOVEREQUEST_H
