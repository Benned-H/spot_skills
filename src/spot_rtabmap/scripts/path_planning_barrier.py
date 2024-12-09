import heapq
import math

import matplotlib.pyplot as plt
import numpy as np


def heuristic(node, goal):
    """Euclidean distance heuristic."""
    return math.sqrt((node[0] - goal[0]) ** 2 + (node[1] - goal[1]) ** 2)


def is_valid_with_barrier(node, grid_map, resolution, robot_radius):
    """Check if a robot with a circular barrier around it is in a valid position."""
    x, y = node
    grid_x = int(x / resolution)
    grid_y = int(y / resolution)
    if not (0 <= grid_x < grid_map.shape[1] and 0 <= grid_y < grid_map.shape[0]):
        return False  # Out of bounds

    # Check surrounding cells within the robot's radius
    radius_in_cells = int(math.ceil(robot_radius / resolution))
    for dy in range(-radius_in_cells, radius_in_cells + 1):
        for dx in range(-radius_in_cells, radius_in_cells + 1):
            nx, ny = grid_x + dx, grid_y + dy
            if 0 <= nx < grid_map.shape[1] and 0 <= ny < grid_map.shape[0]:
                if math.sqrt(dx**2 + dy**2) * resolution <= robot_radius / resolution:
                    if grid_map[ny, nx] == 100:  # Obstacle
                        return False
    return True


def a_star_with_robot_barrier(
    start,
    goal,
    grid_map,
    resolution,
    jump_distance,
    robot_radius,
):
    """A* algorithm ensuring a robot with a barrier avoids obstacles."""
    open_list = []
    heapq.heappush(open_list, (0, start))
    came_from = {}
    g_score = {start: 0}

    while open_list:
        _, current = heapq.heappop(open_list)

        if heuristic(current, goal) < resolution:
            path = []
            while current in came_from:
                path.append(current)
                current = came_from[current]
            return path[::-1]

        x, y = current
        # Allow jumps within the given jump distance
        for dx in np.linspace(
            -jump_distance,
            jump_distance,
            int(2 * jump_distance / resolution) + 1,
        ):
            for dy in np.linspace(
                -jump_distance,
                jump_distance,
                int(2 * jump_distance / resolution) + 1,
            ):
                if dx == 0 and dy == 0:
                    continue
                neighbor = (x + dx, y + dy)
                if not is_valid_with_barrier(
                    neighbor,
                    grid_map,
                    resolution,
                    robot_radius,
                ):
                    continue

                tentative_g_score = g_score[current] + heuristic(current, neighbor)
                if neighbor not in g_score or tentative_g_score < g_score[neighbor]:
                    g_score[neighbor] = tentative_g_score
                    f_score = tentative_g_score + heuristic(neighbor, goal)
                    heapq.heappush(open_list, (f_score, neighbor))
                    came_from[neighbor] = current

    return None  # No path found


def smooth_path(path, yaw_0, yaw_1):
    """Smooth the trajectory with interpolated orientations."""
    smoothed_path = []
    total_distance = sum(
        math.sqrt(
            (path[i + 1][0] - path[i][0]) ** 2 + (path[i + 1][1] - path[i][1]) ** 2,
        )
        for i in range(len(path) - 1)
    )

    distance_covered = 0
    for i in range(len(path) - 1):
        x0, y0 = path[i]
        x1, y1 = path[i + 1]
        dx, dy = x1 - x0, y1 - y0
        distance = math.sqrt(dx**2 + dy**2)
        orientation = yaw_0 + (yaw_1 - yaw_0) * (distance_covered / total_distance)
        smoothed_path.append((x0, y0, orientation))
        distance_covered += distance

    # Add the last point with the final orientation
    smoothed_path.append((*path[-1], yaw_1))
    return smoothed_path


# Example usage
grid_map = np.zeros((20, 20))
grid_map[10, 5:15] = 1  # Add an obstacle

grid_map = np.load("map.npy")

start = (0.0, 0.0)  # Start position in meters
goal = (9.5, 9.5)  # Goal position in meters
start = (3.0, 3.0)
goal = (4.0, 4.0)
yaw_0 = 0  # Initial orientation (radians)
yaw_1 = math.radians(90)  # Final orientation (radians)
resolution = 0.5  # Grid cell size in meters
robot_radius = 1.0  # Robot radius in meters
jump_distance = 1.5  # Maximum jump distance in meters

# Run A* path planner with robot barrier
path = a_star_with_robot_barrier(
    start,
    goal,
    grid_map,
    resolution,
    jump_distance,
    robot_radius,
)

if path:
    smoothed_path = smooth_path(path, yaw_0, yaw_1)
    print("Smoothed Path:", smoothed_path)

    # Visualization
    plt.figure(figsize=(10, 10))
    plt.imshow(
        grid_map,
        cmap="gray",
        origin="lower",
        extent=[0, grid_map.shape[1] * resolution, 0, grid_map.shape[0] * resolution],
    )

    # Plot the raw path
    path_x = [pos[0] for pos in path]
    path_y = [pos[1] for pos in path]
    plt.plot(path_x, path_y, marker="o", color="blue", label="Raw Path")

    # Plot the smoothed path
    smoothed_x = [pos[0] for pos in smoothed_path]
    smoothed_y = [pos[1] for pos in smoothed_path]
    plt.plot(smoothed_x, smoothed_y, marker="x", color="red", label="Smoothed Path")

    # Plot orientations along the smoothed path
    for x, y, theta in smoothed_path:
        dx = math.cos(theta) * 0.3
        dy = math.sin(theta) * 0.3
        plt.arrow(x, y, dx, dy, color="green", head_width=0.1)

    # Plot robot's barrier along the path
    for x, y in path:
        circle = plt.Circle((x, y), robot_radius, color="orange", fill=False)
        plt.gca().add_artist(circle)

    # Plot start and goal
    plt.scatter(start[0], start[1], color="green", label="Start")
    plt.scatter(goal[0], goal[1], color="blue", label="Goal")

    # Add legend and labels
    plt.legend()
    plt.xlabel("X (meters)")
    plt.ylabel("Y (meters)")
    plt.title("2D Path Planning with Robot Barrier")
    plt.grid(True)
else:
    print("No path found!")

plt.show()
