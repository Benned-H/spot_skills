// Generated by gencpp from file spot_cam/SetFloat.msg
// DO NOT EDIT!


#ifndef SPOT_CAM_MESSAGE_SETFLOAT_H
#define SPOT_CAM_MESSAGE_SETFLOAT_H

#include <ros/service_traits.h>


#include <spot_cam/SetFloatRequest.h>
#include <spot_cam/SetFloatResponse.h>


namespace spot_cam
{

struct SetFloat
{

typedef SetFloatRequest Request;
typedef SetFloatResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct SetFloat
} // namespace spot_cam


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::spot_cam::SetFloat > {
  static const char* value()
  {
    return "345a3274594e7cc629d8cd38d3b1fe73";
  }

  static const char* value(const ::spot_cam::SetFloat&) { return value(); }
};

template<>
struct DataType< ::spot_cam::SetFloat > {
  static const char* value()
  {
    return "spot_cam/SetFloat";
  }

  static const char* value(const ::spot_cam::SetFloat&) { return value(); }
};


// service_traits::MD5Sum< ::spot_cam::SetFloatRequest> should match
// service_traits::MD5Sum< ::spot_cam::SetFloat >
template<>
struct MD5Sum< ::spot_cam::SetFloatRequest>
{
  static const char* value()
  {
    return MD5Sum< ::spot_cam::SetFloat >::value();
  }
  static const char* value(const ::spot_cam::SetFloatRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::spot_cam::SetFloatRequest> should match
// service_traits::DataType< ::spot_cam::SetFloat >
template<>
struct DataType< ::spot_cam::SetFloatRequest>
{
  static const char* value()
  {
    return DataType< ::spot_cam::SetFloat >::value();
  }
  static const char* value(const ::spot_cam::SetFloatRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::spot_cam::SetFloatResponse> should match
// service_traits::MD5Sum< ::spot_cam::SetFloat >
template<>
struct MD5Sum< ::spot_cam::SetFloatResponse>
{
  static const char* value()
  {
    return MD5Sum< ::spot_cam::SetFloat >::value();
  }
  static const char* value(const ::spot_cam::SetFloatResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::spot_cam::SetFloatResponse> should match
// service_traits::DataType< ::spot_cam::SetFloat >
template<>
struct DataType< ::spot_cam::SetFloatResponse>
{
  static const char* value()
  {
    return DataType< ::spot_cam::SetFloat >::value();
  }
  static const char* value(const ::spot_cam::SetFloatResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SPOT_CAM_MESSAGE_SETFLOAT_H
