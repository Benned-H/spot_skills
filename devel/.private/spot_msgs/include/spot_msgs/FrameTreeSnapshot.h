// Generated by gencpp from file spot_msgs/FrameTreeSnapshot.msg
// DO NOT EDIT!


#ifndef SPOT_MSGS_MESSAGE_FRAMETREESNAPSHOT_H
#define SPOT_MSGS_MESSAGE_FRAMETREESNAPSHOT_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <spot_msgs/ParentEdge.h>

namespace spot_msgs
{
template <class ContainerAllocator>
struct FrameTreeSnapshot_
{
  typedef FrameTreeSnapshot_<ContainerAllocator> Type;

  FrameTreeSnapshot_()
    : child_edges()
    , parent_edges()  {
    }
  FrameTreeSnapshot_(const ContainerAllocator& _alloc)
    : child_edges(_alloc)
    , parent_edges(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>> _child_edges_type;
  _child_edges_type child_edges;

   typedef std::vector< ::spot_msgs::ParentEdge_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::spot_msgs::ParentEdge_<ContainerAllocator> >> _parent_edges_type;
  _parent_edges_type parent_edges;





  typedef boost::shared_ptr< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> const> ConstPtr;

}; // struct FrameTreeSnapshot_

typedef ::spot_msgs::FrameTreeSnapshot_<std::allocator<void> > FrameTreeSnapshot;

typedef boost::shared_ptr< ::spot_msgs::FrameTreeSnapshot > FrameTreeSnapshotPtr;
typedef boost::shared_ptr< ::spot_msgs::FrameTreeSnapshot const> FrameTreeSnapshotConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator1> & lhs, const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator2> & rhs)
{
  return lhs.child_edges == rhs.child_edges &&
    lhs.parent_edges == rhs.parent_edges;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator1> & lhs, const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace spot_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
{
  static const char* value()
  {
    return "211a7cb63ae362a8f92513c0e74a29a9";
  }

  static const char* value(const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x211a7cb63ae362a8ULL;
  static const uint64_t static_value2 = 0xf92513c0e74a29a9ULL;
};

template<class ContainerAllocator>
struct DataType< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
{
  static const char* value()
  {
    return "spot_msgs/FrameTreeSnapshot";
  }

  static const char* value(const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string[] child_edges\n"
"ParentEdge[] parent_edges\n"
"================================================================================\n"
"MSG: spot_msgs/ParentEdge\n"
"string parent_frame_name\n"
"geometry_msgs/Pose parent_tform_child\n"
"================================================================================\n"
"MSG: geometry_msgs/Pose\n"
"# A representation of pose in free space, composed of position and orientation. \n"
"Point position\n"
"Quaternion orientation\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Point\n"
"# This contains the position of a point in free space\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Quaternion\n"
"# This represents an orientation in free space in quaternion form.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"float64 w\n"
;
  }

  static const char* value(const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.child_edges);
      stream.next(m.parent_edges);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct FrameTreeSnapshot_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::spot_msgs::FrameTreeSnapshot_<ContainerAllocator>& v)
  {
    s << indent << "child_edges[]" << std::endl;
    for (size_t i = 0; i < v.child_edges.size(); ++i)
    {
      s << indent << "  child_edges[" << i << "]: ";
      Printer<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>::stream(s, indent + "  ", v.child_edges[i]);
    }
    s << indent << "parent_edges[]" << std::endl;
    for (size_t i = 0; i < v.parent_edges.size(); ++i)
    {
      s << indent << "  parent_edges[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::spot_msgs::ParentEdge_<ContainerAllocator> >::stream(s, indent + "    ", v.parent_edges[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // SPOT_MSGS_MESSAGE_FRAMETREESNAPSHOT_H
