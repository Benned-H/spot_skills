#!/usr/bin/env python3

import matplotlib.pyplot as plt
import numpy as np
import rospy
from matplotlib.animation import FuncAnimation
from matplotlib.colors import ListedColormap
from nav_msgs.msg import OccupancyGrid


class MapVisualizer:
    def __init__(self):
        # Initialize the ROS node
        rospy.init_node("map_visualizer", anonymous=True)

        # Subscriber to the /map topic
        self.map_subscriber = rospy.Subscriber("/map", OccupancyGrid, self.map_callback)

        # Matplotlib figure and axis
        self.fig, self.ax = plt.subplots()
        self.map_data = None

        # Define a custom colormap for -1, 0, and 100
        # Colors: Deep Blue for -1, White for 0, Black for 100
        self.cmap = ListedColormap(
            ["white", "red", "black"],
        )  # Hex code for deep blue

    def map_callback(self, msg):
        # Extract map metadata
        width = msg.info.width
        height = msg.info.height

        # Convert the 1D data array to a 2D numpy array
        grid = np.array(msg.data, dtype=np.int8).reshape((height, width))

        # Store the map data for visualization
        self.map_data = grid

    def update_plot(self, frame):
        if self.map_data is None:
            return

        self.ax.clear()
        self.ax.set_title("Occupancy Grid Map")
        self.ax.set_xlabel("X (cells)")
        self.ax.set_ylabel("Y (cells)")

        # Visualize the grid using the custom colormap
        im = self.ax.imshow(
            self.map_data,
            cmap=self.cmap,  # Use custom colormap
            origin="lower",  # Ensure the map is oriented correctly
            interpolation="nearest",  # Avoid blurring
            vmin=-1,  # Normalize: Min value (-1)
            vmax=100,  # Normalize: Max value (100)
        )

        # Add a color bar with appropriate labels
        # cbar = self.fig.colorbar(im, ax=self.ax, ticks=[-1, 0, 100])
        # cbar.ax.set_yticklabels(["Unknown (-1)", "Free (0)", "Occupied (100)"])

    def run(self):
        # Use FuncAnimation to update the plot in the main thread
        ani = FuncAnimation(
            self.fig,
            self.update_plot,
            interval=500,
        )  # Update every 500 ms

        # Show the plot
        plt.show()


if __name__ == "__main__":
    try:
        visualizer = MapVisualizer()
        visualizer.run()
    except rospy.ROSInterruptException:
        pass
