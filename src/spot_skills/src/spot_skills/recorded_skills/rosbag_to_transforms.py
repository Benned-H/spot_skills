import matplotlib.pyplot as plt
import numpy as np
import rospy
import tf2_geometry_msgs
import tf2_ros
from geometry_msgs.msg import TransformStamped
from mpl_toolkits.mplot3d import Axes3D


class TFTransformListener:
    def __init__(self, target_frame, source_frame):
        self.target_frame = target_frame
        self.source_frame = source_frame
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)
        self.initial_transform = None
        self.previous_translation = None
        self.transforms = []  # Store all transforms

        # Setup for visualization
        self.fig = plt.figure()
        self.ax = self.fig.add_subplot(111, projection="3d")
        self.ax.set_xlabel("X")
        self.ax.set_ylabel("Y")
        self.ax.set_zlabel("Z")
        plt.ion()
        plt.show()

    def get_transform(self):
        try:
            # Look up the transform from source_frame to target_frame
            transform: TransformStamped = self.tf_buffer.lookup_transform(
                self.target_frame,
                self.source_frame,
                rospy.Time(0),
                rospy.Duration(1.0),
            )
            return transform
        except tf2_ros.LookupException as e:
            rospy.logwarn(f"LookupException: {e}")
        except tf2_ros.ConnectivityException as e:
            rospy.logwarn(f"ConnectivityException: {e}")
        except tf2_ros.ExtrapolationException as e:
            rospy.logwarn(f"ExtrapolationException: {e}")
        return None

    def transform_to_matrix(self, transform):
        translation = transform.transform.translation
        rotation = transform.transform.rotation

        # Convert quaternion to rotation matrix
        q = np.array([rotation.x, rotation.y, rotation.z, rotation.w])
        rotation_matrix = self.quaternion_to_matrix(q)

        # Create transformation matrix
        transformation_matrix = np.eye(4)
        transformation_matrix[:3, :3] = rotation_matrix
        transformation_matrix[:3, 3] = [translation.x, translation.y, translation.z]

        return transformation_matrix

    def quaternion_to_matrix(self, q):
        x, y, z, w = q
        return np.array(
            [
                [1 - 2 * (y**2 + z**2), 2 * (x * y - z * w), 2 * (x * z + y * w)],
                [2 * (x * y + z * w), 1 - 2 * (x**2 + z**2), 2 * (y * z - x * w)],
                [2 * (x * z - y * w), 2 * (y * z + x * w), 1 - 2 * (x**2 + y**2)],
            ],
        )

    def calculate_relative_transform(self, initial_transform, current_transform):
        # Calculate the relative transform from the initial state to the current state
        if not initial_transform or not current_transform:
            return

        initial_matrix = self.transform_to_matrix(initial_transform)
        current_matrix = self.transform_to_matrix(current_transform)

        # Compute relative transformation matrix
        relative_matrix = np.linalg.inv(initial_matrix) @ current_matrix

        # Extract translation component
        rel_translation = relative_matrix[:3, 3]

        # rospy.loginfo(
        #     f"Relative Transform from Initial State:\n"
        #     f"Translation: x={rel_translation[0]}, y={rel_translation[1]}, z={rel_translation[2]}",
        # )

        # Store the transform
        self.transforms.append(relative_matrix)

        # Update visualization
        self.visualize_transform(rel_translation, relative_matrix[:3, :3])

    def visualize_transform(self, translation, rotation_matrix):
        x, y, z = translation

        # Plot point
        self.ax.scatter(x, y, z, marker="o")

        # Connect to previous point with a line
        if self.previous_translation is not None:
            px, py, pz = self.previous_translation
            self.ax.plot([px, x], [py, y], [pz, z], "r-")

        # Visualize rotation axis
        origin = np.array([x, y, z])
        scale = 0.1  # Reduce axis size by 10 times
        axis_x = origin + scale * rotation_matrix[:, 0]  # X-axis
        axis_y = origin + scale * rotation_matrix[:, 1]  # Y-axis
        axis_z = origin + scale * rotation_matrix[:, 2]  # Z-axis

        self.ax.plot(
            [origin[0], axis_x[0]],
            [origin[1], axis_x[1]],
            [origin[2], axis_x[2]],
            "b-",
            label="X-axis",
        )
        self.ax.plot(
            [origin[0], axis_y[0]],
            [origin[1], axis_y[1]],
            [origin[2], axis_y[2]],
            "g-",
            label="Y-axis",
        )
        self.ax.plot(
            [origin[0], axis_z[0]],
            [origin[1], axis_z[1]],
            [origin[2], axis_z[2]],
            "k-",
            label="Z-axis",
        )

        self.previous_translation = (x, y, z)
        plt.draw()
        plt.pause(0.001)

    def log_transform(self, transform):
        rospy.loginfo(
            f"Transform from {self.source_frame} to {self.target_frame}:\n"
            f"Translation: x={transform.transform.translation.x}, "
            f"y={transform.transform.translation.y}, "
            f"z={transform.transform.translation.z}\n"
            f"Rotation: x={transform.transform.rotation.x}, "
            f"y={transform.transform.rotation.y}, "
            f"z={transform.transform.rotation.z}, "
            f"w={transform.transform.rotation.w}",
        )

    def save_transforms(self):
        np.save("transforms.npy", np.array(self.transforms))
        rospy.loginfo("Transforms saved to transforms.npy")


def main():
    rospy.init_node("tf_transform_listener", anonymous=True)

    # Define the source and target frames
    source_frame = "arm_link_wr1"
    target_frame = "body"

    listener = TFTransformListener(target_frame, source_frame)

    rate = rospy.Rate(10)  # 10 Hz
    try:
        while not rospy.is_shutdown():
            current_transform = listener.get_transform()
            if current_transform:
                if listener.initial_transform is None:
                    listener.initial_transform = current_transform
                    rospy.loginfo("Initial state captured.")
                # listener.log_transform(current_transform)
                listener.calculate_relative_transform(
                    listener.initial_transform,
                    current_transform,
                )
            rate.sleep()
    except rospy.ROSInterruptException:
        pass
    finally:
        listener.save_transforms()


if __name__ == "__main__":
    try:
        main()
    except rospy.ROSInterruptException:
        pass
