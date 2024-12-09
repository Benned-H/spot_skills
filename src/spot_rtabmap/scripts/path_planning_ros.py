#!/usr/bin/env python3

import heapq
import math

import matplotlib.pyplot as plt
import numpy as np
import rospy
from geometry_msgs.msg import PoseStamped
from nav_msgs.msg import OccupancyGrid


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

    smoothed_path.append((*path[-1], yaw_1))
    return smoothed_path


def map_callback(msg):
    """Handle incoming map data."""
    global grid_map, resolution, origin
    grid_map = np.array(msg.data).reshape(msg.info.height, msg.info.width)
    grid_map = (grid_map > 50).astype(int)  # Convert to binary (0: free, 1: occupied)
    resolution = msg.info.resolution
    origin = (msg.info.origin.position.x, msg.info.origin.position.y)


def init_callback(msg):
    """Handle incoming initial pose."""
    global start
    start = (msg.pose.position.x, msg.pose.position.y)
    start = (50, 50)


def goal_callback(msg):
    """Handle incoming goal pose."""
    global goal
    goal = (msg.pose.position.x, msg.pose.position.y)


def main():
    rospy.init_node("path_planner", anonymous=True)

    # Subscribe to map, init, and goal topics
    rospy.Subscriber("/map", OccupancyGrid, map_callback)
    rospy.Subscriber("/init", PoseStamped, init_callback)
    rospy.Subscriber("/goal", PoseStamped, goal_callback)
    goal = (3, 3)
    start = (4, 4)

    # Wait for data
    rospy.sleep(1)
    np.save("map.npy", grid_map)
    if grid_map is None or start is None or goal is None:
        print(grid_map, start, goal)
        rospy.loginfo("Waiting for map, init, and goal data...")
        return

    # Parameters
    yaw_0 = 0  # Initial orientation
    yaw_1 = math.radians(90)  # Final orientation
    robot_radius = 0.1  # Robot radius in meters
    jump_distance = 1.5  # Max jump distance in meters

    # Convert start and goal to grid-relative positions
    start_rel = (start[0] - origin[0], start[1] - origin[1])
    goal_rel = (goal[0] - origin[0], goal[1] - origin[1])

    # Perform path planning
    path = a_star_with_robot_barrier(
        start_rel,
        goal_rel,
        grid_map,
        resolution,
        jump_distance,
        robot_radius,
    )
    print(path)
    if path:
        smoothed_path = smooth_path(path, yaw_0, yaw_1)

        # Visualization
        plt.figure(figsize=(10, 10))
        plt.imshow(
            grid_map,
            cmap="gray",
            origin="lower",
            extent=[
                0,
                grid_map.shape[1] * resolution,
                0,
                grid_map.shape[0] * resolution,
            ],
        )

        # Plot raw and smoothed paths
        raw_x, raw_y = zip(
            *[
                (x * resolution + origin[0], y * resolution + origin[1])
                for x, y in path
            ],
        )
        smooth_x, smooth_y = zip(
            *[
                (x * resolution + origin[0], y * resolution + origin[1])
                for x, y, _ in smoothed_path
            ],
        )
        plt.plot(raw_x, raw_y, "b-o", label="Raw Path")
        plt.plot(smooth_x, smooth_y, "r-x", label="Smoothed Path")

        # Add orientations
        for x, y, theta in smoothed_path:
            dx, dy = math.cos(theta) * 0.3, math.sin(theta) * 0.3
            plt.arrow(
                x * resolution + origin[0],
                y * resolution + origin[1],
                dx,
                dy,
                color="green",
                head_width=0.1,
            )

        plt.scatter(start[0], start[1], color="green", label="Start")
        plt.scatter(goal[0], goal[1], color="blue", label="Goal")

        plt.legend()
        plt.title("Path Planning with ROS Map")
        plt.grid(True)
        plt.show()
    else:
        rospy.loginfo("No path found!")


if __name__ == "__main__":
    grid_map = None
    start = None
    goal = None
    resolution = None
    origin = None
    main()
