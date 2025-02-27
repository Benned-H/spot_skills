#ifndef POINTCLOUD_FOOT_FILTER_H
#define POINTCLOUD_FOOT_FILTER_H

#include <filters/filter_base.hpp>
#include <sensor_msgs/PointCloud2.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_ros/buffer.h>
#include <ros/ros.h>
#include <pcl/filters/passthrough.h>
#include <pcl_conversions/pcl_conversions.h>

namespace spot_rtabmap
{
    class PointCloudFootFilter : public filters::FilterBase<sensor_msgs::PointCloud2>
    {
    public:
        PointCloudFootFilter();
        ~PointCloudFootFilter() override;

        bool configure() override;
        bool update(const sensor_msgs::PointCloud2 &input, sensor_msgs::PointCloud2 &output) override;

    private:
        ros::NodeHandle nh_; // Add a NodeHandle for ROS
        tf2_ros::Buffer tfBuffer_;
        tf2_ros::TransformListener tfListener_;

        double getMinZ();
    };
}

#endif // POINTCLOUD_FOOT_FILTER_H
