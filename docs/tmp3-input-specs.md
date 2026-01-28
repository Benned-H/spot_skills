# TMP3 Input Specifications

TMP3 requires four types of input files to define a TAMP problem:

## 1. High-Level PDDL Domain File

Defines abstract actions, predicates, and planning problem structure.

**Example**: [../src/TMP3/test_domains/SpotTAMP/Tasks/domain.pddl](../src/TMP3/test_domains/SpotTAMP/Tasks/domain.pddl)

```lisp
(:action erase
  :parameters (?r - robot ?board - board ?e - eraser)
  :precondition (and (holding ?r ?e) (at ?r ?board))
  :effect (and (erased ?board))
)

(:action open-door
  :parameters (?r - robot ?d - door)
  :precondition (and (gripper-empty ?r) (at ?r ?d))
  :effect (and (open ?d))
)

(:action pick-from-drawer
  :parameters (?r - robot ?obj - object ?drawer - drawer)
  :precondition (and (gripper-empty ?r) (open ?drawer)
                     (contains ?drawer ?obj))
  :effect (and (holding ?r ?obj) (not (gripper-empty ?r)))
)
```

## 2. High-Level Problem File

Specifies objects, initial state, and goal.

**Example**: [../src/TMP3/test_domains/SpotTAMP/Tasks/SciLi/problem.pddl](../src/TMP3/test_domains/SpotTAMP/Tasks/SciLi/problem.pddl)

```lisp
(:objects
  spot - robot
  eraser1 - eraser
  board1 - board
  door1 - door
  black_dresser - drawer
)

(:init
  (gripper-empty spot)
  (contains black_dresser eraser1)
  (not (open black_dresser))
)

(:goal
  (erased board1)
)
```

## 3. ActionConfig JSON File

Maps each high-level action to low-level refinement specifications including generators, predicates, and execution sequences.

**Example**: [../src/TMP3/test_domains/SpotPickAndPlace/Tasks/PickPlace/ActionConfig.json](../src/TMP3/test_domains/SpotPickAndPlace/Tasks/PickPlace/ActionConfig.json)

```json
{
  "ignore_hl_actions": ["done"],
  "non_removable_bodies": ["spot", "table"],
  "robots": {"spot": "SpotRobot"},

  "config_map": {
    "pick": {
      "HL_ARGS": ["object", "robot", "location", "trajectory"],

      "LL_ARGS": {
        "current_base_pose": ["CurrentBasePoseGenerator", "Pose3D"],
        "current_configuration": ["CurrentConfigGenerator", "Configuration"],
        "gpose": ["GraspPoseGenerator", "Pose3D"],
        "valid_base_pose": ["TargetBasePoseGenerator", "Pose3D"],
        "base_traj": ["BaseMotionPlanGenerator", "BaseTrajectory"],
        "grasp_trajectory": ["MotionPlanGenerator", "ManipTrajectory"],
        "pregrasp_pose": ["PreGraspPoseGenerator", "Pose3D"],
        "pregrasp_trajectory": ["MotionPlanGenerator", "ManipTrajectory"],
        "g_open_traj": ["GripperOpenGenerator", "GripperOpenTrajectory"],
        "g_close_traj": ["GripperCloseGenerator", "GripperCloseTrajectory"]
      },

      "precondition": [
        "IsValidGripperOpenTrajectory(robot, g_open_traj)",
        "RobotBasePose(robot, current_base_pose)",
        "RobotCurrentManipPose(robot, current_configuration)",
        "IsValidGraspPose(robot, object, gpose)",
        "IsValidTargetBasePose(robot, object, target_pose:gpose, valid_base_pose)",
        "IsValidBaseTrajectory(robot, src:current_base_pose, dest:valid_base_pose, base_traj)",
        "IsPoseValid(robot, base_pose:valid_base_pose, pose:gpose)",
        "IsValidPreGraspPose(robot, object, grasp:gpose, pregrasp_pose)",
        "IsValidMotionPlan(robot, pose_current:current_configuration, pose_end:pregrasp_pose, pregrasp_trajectory)"
      ],

      "effect": [],

      "execution_sequence": [
        "base_traj",
        "g_open_traj",
        "pregrasp_trajectory",
        "grasp_trajectory",
        "g_close_traj"
      ],

      "attach": "object"
    }
  }
}
```

### Key Elements

- **ignore_hl_actions**: Actions that need no low-level refinement
- **non_removable_bodies**: Objects not removable for collision checking
- **robots**: Map robot names to robot class names
- **config_map**: Maps each HL action to its LL refinement specification

For each action:
- **HL_ARGS**: High-level parameters from PDDL action
- **LL_ARGS**: Low-level arguments with `[GeneratorClass, Type]` pairs
- **precondition**: Ordered predicates evaluated sequentially
  - Use `alias:arg` syntax to reference previously generated values (e.g., `target_pose:gpose`)
- **effect**: Predicates to apply after execution (modifies state)
- **execution_sequence**: Order of trajectory execution on robot
- **attach**: Object to attach to gripper after execution (optional)

### Predicate Syntax

Predicates can reference arguments in two ways:
1. **Direct**: `IsValidGraspPose(robot, object, gpose)` - uses the argument name directly
2. **Aliased**: `IsValidTargetBasePose(robot, object, target_pose:gpose, valid_base_pose)` - `target_pose:gpose` means "use the value generated for `gpose` as the `target_pose` parameter"

This allows predicates and generators to reuse previously generated values.

## 4. Environment YAML File

Defines robot initial pose, object models and locations, container states.

**Example**: [../src/TMP3/test_domains/SpotTAMP/Environments/SciLi/tamp_env.yaml](../src/TMP3/test_domains/SpotTAMP/Environments/SciLi/tamp_env.yaml)

```yaml
robots:
  spot:
    base_pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]  # x, y, z, roll, pitch, yaw

objects:
  eraser1:
    collision_model:
      primitives:
        - type: box
          x: 0.05
          y: 0.12
          z: 0.03

  black_dresser:
    pose: [1.5, 0.5, 0.0, 0.0, 0.0, 0.0]
    container:
      status: closed  # or "open"
      open_model:
        meshes:
          - file: "path/to/drawer_open.stl"
            scale: [1.0, 1.0, 1.0]
      closed_model:
        meshes:
          - file: "path/to/drawer_closed.stl"
            scale: [1.0, 1.0, 1.0]
      contains:
        eraser1:
          pose_when_open: [0.1, 0.0, 0.2, 0.0, 0.0, 0.0]
          pose_when_closed: [0.1, 0.0, 0.2, 0.0, 0.0, 0.0]

waypoints:
  open_drawer:
    x_y_yaw: [1.0, 0.5, 0.0]
    frame: black_dresser

default_frame: map
```

### YAML Structure

**robots**: Dictionary of robot names to initial configurations
- `base_pose`: [x, y, z, roll, pitch, yaw] in default_frame

**objects**: Dictionary of object names to object definitions
- `pose`: [x, y, z, roll, pitch, yaw] in default_frame
- `collision_model`: Collision geometry
  - `primitives`: List of primitive shapes (box, sphere, cylinder)
  - `meshes`: List of mesh files with scale
- `container`: For objects that contain other objects (drawers, cabinets)
  - `status`: "open" or "closed"
  - `open_model`: Geometry when container is open
  - `closed_model`: Geometry when container is closed
  - `contains`: Dictionary of contained objects with poses

**waypoints**: Named navigation waypoints (optional)
- `x_y_yaw`: [x, y, yaw] position
- `frame`: Reference frame (object name or default_frame)

**default_frame**: Global coordinate frame name (usually "map")
