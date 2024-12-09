import heapq
import math


def quaternion_to_yaw(qx, qy, qz, qw):
    """Convert a quaternion to a yaw angle."""
    siny_cosp = 2 * (qw * qz + qx * qy)
    cosy_cosp = 1 - 2 * (qy**2 + qz**2)
    return math.atan2(siny_cosp, cosy_cosp)


def a_star_with_orientation(start, goal, grid_map, resolution, orientations):
    """A* algorithm that considers orientation.

    Args:
        start: (x, y, yaw) in world coordinates.
        goal: (x, y, yaw) in world coordinates.
        grid_map: 2D grid map (0 = free, 1 = obstacle).
        resolution: Map resolution in meters/pixel.
        orientations: List of discrete allowed orientations (e.g., [0, pi/2, pi, -pi/2]).

    Returns:
        Path: List of (x, y, yaw) states.

    """

    def heuristic(state, goal):
        x1, y1, _ = state
        x2, y2, _ = goal
        return math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2)

    def is_valid(state):
        x, y, _ = state
        grid_x = int(x / resolution)
        grid_y = int(y / resolution)
        return (
            0 <= grid_x < len(grid_map[0])
            and 0 <= grid_y < len(grid_map)
            and grid_map[grid_y][grid_x] == 0
        )

    # Priority queue for A*
    open_list = []
    heapq.heappush(open_list, (0, start))
    came_from = {}
    g_score = {start: 0}

    while open_list:
        _, current = heapq.heappop(open_list)

        # Check if goal reached (position + orientation match)
        if heuristic(current, goal) < resolution and abs(
            current[2] - goal[2]
        ) < math.radians(10):
            path = []
            while current in came_from:
                path.append(current)
                current = came_from[current]
            return path[::-1]

        x, y, theta = current
        for d_theta in orientations:
            # Compute next state
            next_theta = theta + d_theta
            next_x = x + resolution * math.cos(next_theta)
            next_y = y + resolution * math.sin(next_theta)
            next_state = (next_x, next_y, next_theta)

            if not is_valid(next_state):
                continue

            # Update cost and priority
            tentative_g_score = g_score[current] + resolution
            if next_state not in g_score or tentative_g_score < g_score[next_state]:
                g_score[next_state] = tentative_g_score
                f_score = tentative_g_score + heuristic(next_state, goal)
                heapq.heappush(open_list, (f_score, next_state))
                came_from[next_state] = current

    return None  # No path found
