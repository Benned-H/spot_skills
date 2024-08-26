// Generated by gencpp from file spot_cam/SetPTZState.msg
// DO NOT EDIT!


#ifndef SPOT_CAM_MESSAGE_SETPTZSTATE_H
#define SPOT_CAM_MESSAGE_SETPTZSTATE_H

#include <ros/service_traits.h>


#include <spot_cam/SetPTZStateRequest.h>
#include <spot_cam/SetPTZStateResponse.h>


namespace spot_cam
{

struct SetPTZState
{

typedef SetPTZStateRequest Request;
typedef SetPTZStateResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct SetPTZState
} // namespace spot_cam


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::spot_cam::SetPTZState > {
  static const char* value()
  {
    return "2dd984827d05222cd185e849e7da947f";
  }

  static const char* value(const ::spot_cam::SetPTZState&) { return value(); }
};

template<>
struct DataType< ::spot_cam::SetPTZState > {
  static const char* value()
  {
    return "spot_cam/SetPTZState";
  }

  static const char* value(const ::spot_cam::SetPTZState&) { return value(); }
};


// service_traits::MD5Sum< ::spot_cam::SetPTZStateRequest> should match
// service_traits::MD5Sum< ::spot_cam::SetPTZState >
template<>
struct MD5Sum< ::spot_cam::SetPTZStateRequest>
{
  static const char* value()
  {
    return MD5Sum< ::spot_cam::SetPTZState >::value();
  }
  static const char* value(const ::spot_cam::SetPTZStateRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::spot_cam::SetPTZStateRequest> should match
// service_traits::DataType< ::spot_cam::SetPTZState >
template<>
struct DataType< ::spot_cam::SetPTZStateRequest>
{
  static const char* value()
  {
    return DataType< ::spot_cam::SetPTZState >::value();
  }
  static const char* value(const ::spot_cam::SetPTZStateRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::spot_cam::SetPTZStateResponse> should match
// service_traits::MD5Sum< ::spot_cam::SetPTZState >
template<>
struct MD5Sum< ::spot_cam::SetPTZStateResponse>
{
  static const char* value()
  {
    return MD5Sum< ::spot_cam::SetPTZState >::value();
  }
  static const char* value(const ::spot_cam::SetPTZStateResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::spot_cam::SetPTZStateResponse> should match
// service_traits::DataType< ::spot_cam::SetPTZState >
template<>
struct DataType< ::spot_cam::SetPTZStateResponse>
{
  static const char* value()
  {
    return DataType< ::spot_cam::SetPTZState >::value();
  }
  static const char* value(const ::spot_cam::SetPTZStateResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SPOT_CAM_MESSAGE_SETPTZSTATE_H
