// Filter out points below the feet of the Spot robot
// This filter uses the TF library to get the position of the feet
// and filters out points below the feet
// This is needed because spot does not publish lidar based on the body,
//   but instead based on the lidar frame (based on the world frame)
// Could be made more general by making some parameters configurable.
// WYC 02/22/2024

#include "spot_rtabmap/pointcloud_foot_filter.h"
#include <geometry_msgs/TransformStamped.h>
#include <pluginlib/class_list_macros.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>

namespace spot_rtabmap
{

    PointCloudFootFilter::PointCloudFootFilter()
        : nh_(), tfBuffer_(), tfListener_(tfBuffer_) {}

    PointCloudFootFilter::~PointCloudFootFilter() {}

    bool PointCloudFootFilter::configure()
    {
        return true;
    }

    double PointCloudFootFilter::getMinZ()
    {
        const std::vector<std::string> frames = {
            "front_left_foot",
            "front_right_foot",
            "rear_left_foot",
            "rear_right_foot"};

        double min_z = std::numeric_limits<double>::max();

        for (const auto &frame : frames)
        {
            try
            {
                geometry_msgs::TransformStamped transform = tfBuffer_.lookupTransform("sensor_origin_velodyne-point-cloud", frame, ros::Time(0), ros::Duration(1.0));
                double z = transform.transform.translation.z;
                if (z < min_z)
                    min_z = z;
            }
            catch (tf2::TransformException &ex)
            {
                ROS_WARN("TF transform failed: %s", ex.what());
                return 0;
            }
        }

        return min_z;
    }

    bool PointCloudFootFilter::update(const sensor_msgs::PointCloud2 &input, sensor_msgs::PointCloud2 &output)
    {
        // Process incoming TF messages
        ros::spinOnce();

        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>());
        pcl::fromROSMsg(input, *cloud);

        double min_z = getMinZ();

        pcl::PassThrough<pcl::PointXYZ> pass;
        pass.setInputCloud(cloud);
        pass.setFilterFieldName("z");
        pass.setFilterLimits(min_z, min_z + 2);
        pcl::PointCloud<pcl::PointXYZ>::Ptr filtered_cloud(new pcl::PointCloud<pcl::PointXYZ>());
        pass.filter(*filtered_cloud);

        pcl::toROSMsg(*filtered_cloud, output);
        output.header = input.header;

        return true;
    }
}

// Register the filter plugin
PLUGINLIB_EXPORT_CLASS(spot_rtabmap::PointCloudFootFilter, filters::FilterBase<sensor_msgs::PointCloud2>);
