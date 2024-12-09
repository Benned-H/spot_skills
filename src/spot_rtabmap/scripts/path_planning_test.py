import math

import matplotlib.pyplot as plt
import numpy as np
from path_planning import a_star_with_orientation

# Example grid map (20x20, 0 = free, 1 = obstacle)
grid_map = np.zeros((10, 10))
grid_map[5, 4:5] = 1  # Add an obstacle

# Parameters
start = (0, 0, 0)  # (x, y, yaw) in meters and radians
goal = (9, 9, math.radians(90))  # (x, y, yaw) in meters and radians
resolution = 0.5  # 0.5 meters per cell
orientations = [
    0,
    math.pi / 2,
    -math.pi / 2,
    math.pi,
]  # Allowed rotations (90-degree steps)
robot_radius = 0.5  # Robot radius in meters

# Run the planner
path = a_star_with_orientation(
    start,
    goal,
    grid_map,
    resolution,
    orientations,
    # robot_radius,
)

if path:
    for state in path:
        print(
            f"Position: ({state[0]:.2f}, {state[1]:.2f}), Orientation: {math.degrees(state[2]):.1f}°",
        )

    # Visualization
    plt.figure(figsize=(10, 10))
    plt.imshow(
        grid_map,
        cmap="gray",
        origin="lower",
        extent=[0, grid_map.shape[1] * resolution, 0, grid_map.shape[0] * resolution],
    )

    # Plot the trajectory
    path_x = [state[0] for state in path]
    path_y = [state[1] for state in path]
    plt.plot(path_x, path_y, marker="o", color="red", label="Planned Path")

    # Plot start and goal
    plt.scatter(start[0], start[1], color="green", label="Start")
    plt.scatter(goal[0], goal[1], color="blue", label="Goal")

    # Add legend and labels
    plt.legend()
    plt.xlabel("X (meters)")
    plt.ylabel("Y (meters)")
    plt.title("Path Planning with Barrier")
    plt.grid(True)
    plt.show()

else:
    print("No path found!")
