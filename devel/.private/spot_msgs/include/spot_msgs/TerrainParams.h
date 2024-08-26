// Generated by gencpp from file spot_msgs/TerrainParams.msg
// DO NOT EDIT!


#ifndef SPOT_MSGS_MESSAGE_TERRAINPARAMS_H
#define SPOT_MSGS_MESSAGE_TERRAINPARAMS_H


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
struct TerrainParams_
{
  typedef TerrainParams_<ContainerAllocator> Type;

  TerrainParams_()
    : ground_mu_hint(0.0)
    , grated_surfaces_mode(0)  {
    }
  TerrainParams_(const ContainerAllocator& _alloc)
    : ground_mu_hint(0.0)
    , grated_surfaces_mode(0)  {
  (void)_alloc;
    }



   typedef float _ground_mu_hint_type;
  _ground_mu_hint_type ground_mu_hint;

   typedef uint8_t _grated_surfaces_mode_type;
  _grated_surfaces_mode_type grated_surfaces_mode;



// reducing the odds to have name collisions with Windows.h 
#if defined(_WIN32) && defined(GRATED_SURFACES_MODE_UNKNOWN)
  #undef GRATED_SURFACES_MODE_UNKNOWN
#endif
#if defined(_WIN32) && defined(GRATED_SURFACES_MODE_OFF)
  #undef GRATED_SURFACES_MODE_OFF
#endif
#if defined(_WIN32) && defined(GRATED_SURFACES_MODE_ON)
  #undef GRATED_SURFACES_MODE_ON
#endif
#if defined(_WIN32) && defined(GRATED_SURFACES_MODE_AUTO)
  #undef GRATED_SURFACES_MODE_AUTO
#endif

  enum {
    GRATED_SURFACES_MODE_UNKNOWN = 0u,
    GRATED_SURFACES_MODE_OFF = 1u,
    GRATED_SURFACES_MODE_ON = 2u,
    GRATED_SURFACES_MODE_AUTO = 3u,
  };


  typedef boost::shared_ptr< ::spot_msgs::TerrainParams_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::spot_msgs::TerrainParams_<ContainerAllocator> const> ConstPtr;

}; // struct TerrainParams_

typedef ::spot_msgs::TerrainParams_<std::allocator<void> > TerrainParams;

typedef boost::shared_ptr< ::spot_msgs::TerrainParams > TerrainParamsPtr;
typedef boost::shared_ptr< ::spot_msgs::TerrainParams const> TerrainParamsConstPtr;

// constants requiring out of line definition

   

   

   

   



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::spot_msgs::TerrainParams_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::spot_msgs::TerrainParams_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::spot_msgs::TerrainParams_<ContainerAllocator1> & lhs, const ::spot_msgs::TerrainParams_<ContainerAllocator2> & rhs)
{
  return lhs.ground_mu_hint == rhs.ground_mu_hint &&
    lhs.grated_surfaces_mode == rhs.grated_surfaces_mode;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::spot_msgs::TerrainParams_<ContainerAllocator1> & lhs, const ::spot_msgs::TerrainParams_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace spot_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::TerrainParams_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::TerrainParams_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::TerrainParams_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::TerrainParams_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::TerrainParams_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::TerrainParams_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::spot_msgs::TerrainParams_<ContainerAllocator> >
{
  static const char* value()
  {
    return "58fe7415b44378cf75e03c9f80729c0f";
  }

  static const char* value(const ::spot_msgs::TerrainParams_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x58fe7415b44378cfULL;
  static const uint64_t static_value2 = 0x75e03c9f80729c0fULL;
};

template<class ContainerAllocator>
struct DataType< ::spot_msgs::TerrainParams_<ContainerAllocator> >
{
  static const char* value()
  {
    return "spot_msgs/TerrainParams";
  }

  static const char* value(const ::spot_msgs::TerrainParams_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::spot_msgs::TerrainParams_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# see https://dev.bostondynamics.com/protos/bosdyn/api/proto_reference.html?highlight=power_state#terrainparams\n"
"uint8 GRATED_SURFACES_MODE_UNKNOWN=0\n"
"uint8 GRATED_SURFACES_MODE_OFF=1\n"
"uint8 GRATED_SURFACES_MODE_ON=2\n"
"uint8 GRATED_SURFACES_MODE_AUTO=3\n"
"\n"
"float32 ground_mu_hint\n"
"uint8 grated_surfaces_mode\n"
;
  }

  static const char* value(const ::spot_msgs::TerrainParams_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::spot_msgs::TerrainParams_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.ground_mu_hint);
      stream.next(m.grated_surfaces_mode);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct TerrainParams_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::spot_msgs::TerrainParams_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::spot_msgs::TerrainParams_<ContainerAllocator>& v)
  {
    s << indent << "ground_mu_hint: ";
    Printer<float>::stream(s, indent + "  ", v.ground_mu_hint);
    s << indent << "grated_surfaces_mode: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.grated_surfaces_mode);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SPOT_MSGS_MESSAGE_TERRAINPARAMS_H
