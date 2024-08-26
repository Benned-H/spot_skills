// Generated by gencpp from file spot_msgs/ClearBehaviorFaultRequest.msg
// DO NOT EDIT!


#ifndef SPOT_MSGS_MESSAGE_CLEARBEHAVIORFAULTREQUEST_H
#define SPOT_MSGS_MESSAGE_CLEARBEHAVIORFAULTREQUEST_H


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
struct ClearBehaviorFaultRequest_
{
  typedef ClearBehaviorFaultRequest_<ContainerAllocator> Type;

  ClearBehaviorFaultRequest_()
    : id(0)  {
    }
  ClearBehaviorFaultRequest_(const ContainerAllocator& _alloc)
    : id(0)  {
  (void)_alloc;
    }



   typedef uint32_t _id_type;
  _id_type id;





  typedef boost::shared_ptr< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> const> ConstPtr;

}; // struct ClearBehaviorFaultRequest_

typedef ::spot_msgs::ClearBehaviorFaultRequest_<std::allocator<void> > ClearBehaviorFaultRequest;

typedef boost::shared_ptr< ::spot_msgs::ClearBehaviorFaultRequest > ClearBehaviorFaultRequestPtr;
typedef boost::shared_ptr< ::spot_msgs::ClearBehaviorFaultRequest const> ClearBehaviorFaultRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator1> & lhs, const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator2> & rhs)
{
  return lhs.id == rhs.id;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator1> & lhs, const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace spot_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "309d4b30834b338cced19e5622a97a03";
  }

  static const char* value(const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x309d4b30834b338cULL;
  static const uint64_t static_value2 = 0xced19e5622a97a03ULL;
};

template<class ContainerAllocator>
struct DataType< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "spot_msgs/ClearBehaviorFaultRequest";
  }

  static const char* value(const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uint32 id\n"
;
  }

  static const char* value(const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.id);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ClearBehaviorFaultRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::spot_msgs::ClearBehaviorFaultRequest_<ContainerAllocator>& v)
  {
    s << indent << "id: ";
    Printer<uint32_t>::stream(s, indent + "  ", v.id);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SPOT_MSGS_MESSAGE_CLEARBEHAVIORFAULTREQUEST_H
