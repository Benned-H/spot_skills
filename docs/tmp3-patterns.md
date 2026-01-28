# TMP3 Core Patterns

TMP3 uses three extensible patterns for domain-specific customization:

## Generator Pattern

**Base Class**: [../src/TMP3/src/tmp3/DataStructures/Generator.py](../src/TMP3/src/tmp3/DataStructures/Generator.py)

Generators produce low-level argument values on-demand during refinement.

### Interface

```python
class Generator:
    def __init__(self, ll_state: ROSLowLevelState,
                 known_argument_values: dict):
        """
        ll_state: Current environment state
        known_argument_values: Previously generated values for this action
        """
        pass

    def get_next(self, flag: dict) -> Any:
        """
        flag["flag"]: True = error-free mode, False = error mode
        Returns: Next generated value, or None when exhausted
        """
        pass

    def reset(self):
        """Reset generator to initial state"""
        pass
```

### Example: GraspPoseGenerator

Location: [../src/TMP3/test_domains/SpotTAMP/Generators/](../src/TMP3/test_domains/SpotTAMP/Generators/)

```python
class GraspPoseGenerator(Generator):
    def __init__(self, ll_state, known_argument_values):
        super().__init__(ll_state, known_argument_values)
        self.object_name = known_argument_values["object"]
        self.samples = []
        self.index = 0

    def get_next(self, flag):
        if flag["flag"]:  # error-free mode
            # Sample collision-free grasp poses
            while self.index < MAX_SAMPLES:
                pose = self.sample_grasp_pose()
                if self.is_collision_free(pose):
                    self.index += 1
                    return pose
        else:  # error mode - relax constraints
            # Also return collision-ignoring poses
            if self.index < MAX_SAMPLES:
                pose = self.sample_grasp_pose()
                self.index += 1
                return pose
        return None  # exhausted
```

### Built-in Generators (from SpotTAMP)

- **CurrentBasePoseGenerator** - Returns robot's current base pose
- **CurrentConfigGenerator** - Returns current arm configuration
- **TargetBasePoseGenerator** - Samples valid base poses to approach objects
- **GraspPoseGenerator** - Samples grasp poses around objects
- **NavigationPlanGenerator** - Plans base navigation trajectories
- **MotionPlanGenerator** - Plans arm motion via MoveIt
- **EraseTrajectoryGenerator** - Generates force-controlled erase motions
- **OpenDrawerTrajectoryGenerator** - Plans drawer opening trajectories
- **PoseEstimationEEPoseGenerator** - Uses perception to estimate object poses
- **GripperOpenGenerator** / **GripperCloseGenerator** - Gripper commands

### Implementation Guidelines

1. **Location**: Place in `test_domains/<DomainName>/Generators/<GeneratorClassName>.py`
2. **Naming**: Must match the class name in ActionConfig `LL_ARGS`
3. **Access to state**: Use `ll_state` to query current robot/object poses
4. **Use known values**: Access previously generated arguments via `known_argument_values`
5. **Visualization**: Optionally publish samples to RViz for debugging
6. **Error modes**: Support both error-free and error modes for robustness

## Predicate Pattern

**Base Class**: [../src/TMP3/src/tmp3/DataStructures/Predicate.py](../src/TMP3/src/tmp3/DataStructures/Predicate.py)

Predicates validate generated argument values.

### Interface

```python
class Predicate:
    def __call__(self, low_level_state: ROSLowLevelState,
                 arg_map: dict) -> tuple[bool, str]:
        """
        low_level_state: Current environment state
        arg_map: Dictionary of argument names to values

        Returns: (is_valid: bool, explanation: str)
        """
        pass
```

### Two Usage Modes

#### 1. Generator-based (Implicit Validation)

The generator only produces valid values, so the predicate always returns `True`.

```python
class IsValidGripperOpenTrajectory(Predicate):
    def __call__(self, low_level_state, arg_map):
        # Generator always produces valid gripper commands
        return True, "Valid gripper trajectory"
```

#### 2. Explicit Validation

The predicate performs complex checks (collision detection, reachability, etc.).

```python
class IsPoseValid(Predicate):
    def __call__(self, low_level_state, arg_map):
        robot = arg_map["robot"]
        base_pose = arg_map["base_pose"]
        pose = arg_map["pose"]

        # Update planning scene with robot at candidate pose
        low_level_state.simulator.set_robot_pose(robot, base_pose, pose)

        # Check for collisions
        if low_level_state.simulator.is_collision():
            return False, "Robot configuration in collision"

        return True, "Pose is collision-free"
```

### Common Predicates

- **IsValidGraspPose** - Validates grasp geometry
- **IsValidMotionPlan** - Checks motion plan feasibility
- **IsPoseValid** - Collision checking for configurations
- **RobotBasePose** - Returns current base pose (informational)
- **NotObstructs** - Checks trajectory doesn't collide
- **IsValidTargetBasePose** - Validates base position for manipulation

### Implementation Guidelines

1. **Location**: Place in `test_domains/<DomainName>/Predicates/<PredicateName>.py`
2. **Naming**: Must match predicate name in ActionConfig `precondition` list
3. **Arguments**: Access via `arg_map` using argument names from precondition
4. **Return**: Always return `(bool, str)` tuple
5. **Side effects**: Avoid modifying state; only validate
6. **Performance**: Keep checks fast; they're called many times during refinement

## Executor Pattern

**Base Class**: [../src/TMP3/src/tmp3/DataStructures/ArgExecutor.py](../src/TMP3/src/tmp3/DataStructures/ArgExecutor.py)

Executors apply and execute trajectories on the robot.

### Interface

```python
class ArgExecutor:
    def __init__(self, argument_name: str):
        self.argument_name = argument_name

    def apply(self, ll_state: ROSLowLevelState, value: Any,
              other_generated_values: dict):
        """
        Simulate/apply without real execution (updates state internally)
        Used during planning to update simulator state
        """
        pass

    def execute(self, ll_state: ROSLowLevelState, value: Any,
                other_generated_values: dict):
        """
        Execute on actual robot (calls ROS services/actions)
        Used during real-world execution
        """
        pass
```

### Example: ManipTrajectory

Location: [../src/TMP3/test_domains/SpotTAMP/Executors/](../src/TMP3/test_domains/SpotTAMP/Executors/)

```python
class ManipTrajectory(ArgExecutor):
    def __init__(self, argument_name):
        super().__init__(argument_name)

    def apply(self, ll_state, value, other_generated_values):
        """Simulate trajectory execution"""
        # value is a MotionPlanningQuery from generator
        robot = other_generated_values["robot"]
        end_config = value.end_configuration

        # Update robot configuration in simulator
        ll_state.simulator.set_robot_config(robot, end_config)

    def execute(self, ll_state, value, other_generated_values):
        """Execute on real robot"""
        # Compute motion plan via MoveIt
        plan = ll_state.simulator.compute_motion_plan(value)

        # Execute via ROS action server
        client = actionlib.SimpleActionClient(
            'arm_controller/follow_joint_trajectory',
            FollowJointTrajectoryAction
        )
        goal = FollowJointTrajectoryGoal()
        goal.trajectory = plan
        client.send_goal_and_wait(goal)

        # Update state after execution
        self.apply(ll_state, value, other_generated_values)
```

### Built-in Executors (from SpotTAMP)

- **NavigationTrajectory** - Executes base navigation
- **ManipTrajectory** - Executes arm motion plans
- **EraseTrajectory** - Force-controlled erasing execution
- **GripperOpenTrajectory** / **GripperCloseTrajectory** - Gripper control
- **OpenDoorTrajectory** - Door opening skill
- **OpenDrawerTrajectory** - Drawer opening skill
- **StowCommand** - Stow arm to safe configuration
- **PoseEstimationCommand** - Trigger pose estimation service

### Implementation Guidelines

1. **Location**: Place in `test_domains/<DomainName>/Executors/<ExecutorClassName>.py`
2. **Naming**: Must match the type name in ActionConfig `LL_ARGS`
3. **apply() vs execute()**:
   - `apply()`: Used during planning; updates simulator state only
   - `execute()`: Used during real execution; calls ROS services/actions
4. **State updates**: Always update `ll_state` to reflect execution results
5. **Error handling**: Handle execution failures gracefully
6. **Idempotency**: `apply()` should be safe to call multiple times

## Pattern Integration in ActionConfig

Example showing how all three patterns work together:

```json
{
  "config_map": {
    "pick": {
      "LL_ARGS": {
        "gpose": ["GraspPoseGenerator", "Pose3D"],
        "grasp_trajectory": ["MotionPlanGenerator", "ManipTrajectory"]
      },

      "precondition": [
        "IsValidGraspPose(robot, object, gpose)",
        "IsValidMotionPlan(robot, pose_current:current_config, pose_end:gpose, grasp_trajectory)"
      ],

      "execution_sequence": [
        "grasp_trajectory"
      ]
    }
  }
}
```

**Workflow**:
1. **GraspPoseGenerator** samples grasp poses → generates `gpose`
2. **IsValidGraspPose** predicate validates `gpose`
3. **MotionPlanGenerator** plans motion to `gpose` → generates `grasp_trajectory`
4. **IsValidMotionPlan** predicate validates `grasp_trajectory`
5. **ManipTrajectory** executor applies/executes `grasp_trajectory`

The `execution_sequence` determines which arguments are actually executed on the robot.
