# TMP3 Task and Motion Planner - Complete Guide

TMP3 (Task and Motion Policies) implements planning for stochastic environments by combining high-level task planning with low-level motion planning through abstraction refinement.

## Overview

**Based on**: ["Task and Motion Policies for Stochastic Environments"](https://aair-lab.github.io/atam/atam_full_version.pdf)

**Key Concept**: Instead of generating a single sequential plan, TMP3 produces a *policy* - a tree-structured mapping from states to actions that handles multiple contingencies and stochastic outcomes. This enables robust execution in uncertain environments where actions may have probabilistic effects.

## Architecture

```
┌──────────────────────────────────────────────────────┐
│ High-Level PDDL Planning (FF/LAO*)                   │
│ - Task planner generates abstract action sequences   │
└────────────────┬─────────────────────────────────────┘
                 ↓
┌──────────────────────────────────────────────────────┐
│ Plan Refinement Graph (PRRefinement)                 │
│ - Iteratively refines HL actions to LL trajectories  │
│ - Backtracking on failures, alternative sampling     │
└────────────────┬─────────────────────────────────────┘
                 ↓
┌──────────────────────────────────────────────────────┐
│ Low-Level Motion Planning (MoveIt/Generators)        │
│ - Generate concrete trajectories satisfying          │
│   geometric constraints and collision-free motion    │
└────────────────┬─────────────────────────────────────┘
                 ↓
┌──────────────────────────────────────────────────────┐
│ Refined Policy Tree (RefinedPolicy)                  │
│ - Executable policy with branching for stochasticity │
└──────────────────────────────────────────────────────┘
```

## Directory Structure

```
src/TMP3/
├── src/tmp3/                          # Core library (92 Python files)
│   ├── Action/                        # High-level action definitions
│   ├── Config/                        # Configuration system
│   ├── DataStructures/                # Graph structures, generators, predicates
│   ├── Environments/                  # Environment state and planning scene
│   ├── Functions/                     # Function and predicate base classes
│   ├── IKSolvers/                     # Inverse kinematics interfaces
│   ├── MotionPlanners/                # Motion planning integration
│   ├── Parser/                        # PDDL and ActionConfig parsers
│   ├── Planner/                       # Task planners (FF, LAO*)
│   ├── PRGraphRefinementAlgorithms/   # Main refinement algorithm
│   ├── Robots/                        # Robot models (SpotRobot, etc.)
│   ├── Simulators/                    # RViz simulator and executors
│   ├── States/                        # State representations
│   ├── Utils/                         # Utility functions
│   └── Wrappers/                      # Action/problem specifications
├── test_domains/                      # Domain implementations (164 Python files)
│   ├── SpotTAMP/                      # Main Spot TAMP domain
│   │   ├── Tasks/                     # PDDL domains and problems
│   │   ├── Environments/              # Environment YAML files
│   │   ├── Generators/                # Low-level argument generators
│   │   ├── Executors/                 # Trajectory executors
│   │   └── Predicates/                # Custom predicates
│   ├── SpotPickAndPlace/              # Pick-and-place domain
│   ├── DelicateCan/                   # Stochastic manipulation
│   └── DelicateCanDeterministic/      # Deterministic variant
├── planners/                          # External planner binaries
│   ├── FF-v2.3modified/               # Fast Forward PDDL planner
│   └── mdp-lib/                       # MDP solver (LAO*)
├── scripts/                           # Execution scripts
│   ├── TMP.py                         # Main TAMP execution
│   └── tamp_executor.py               # Policy execution on robot
├── launch/                            # ROS launch files
└── TMP.py                             # Entry point
```

## Input Specifications

TMP3 requires four types of input files to define a TAMP problem. See [tmp3-input-specs.md](tmp3-input-specs.md) for complete details and examples:

1. **High-Level PDDL Domain File** - Abstract actions and predicates
2. **High-Level Problem File** - Objects, initial state, and goal
3. **ActionConfig JSON File** - Maps abstract actions to concrete generators/executors
4. **Environment YAML File** - Robot poses, object models, container states

## Core Patterns

TMP3 uses three extensible patterns for domain-specific customization. See [tmp3-patterns.md](tmp3-patterns.md) for implementation details:

### Generator Pattern
Produces low-level argument values on-demand during refinement.

**Examples**: `GraspPoseGenerator`, `NavigationPlanGenerator`, `MotionPlanGenerator`

### Predicate Pattern
Validates generated argument values.

**Examples**: `IsPoseValid`, `IsValidMotionPlan`, `IsValidGraspPose`

### Executor Pattern
Applies and executes trajectories on the robot.

**Examples**: `ManipTrajectory`, `NavigationTrajectory`, `GripperOpenTrajectory`

## Test Domains

### SpotTAMP Domain
**Path**: [../src/TMP3/test_domains/SpotTAMP/](../src/TMP3/test_domains/SpotTAMP/)

Main domain for real-world Spot TAMP tasks.

**Skills**:
- `erase` - Force-controlled whiteboard erasing
- `open-door` - Door opening manipulation
- `open-drawer` - Drawer opening (pulling motion)
- `pick-from-drawer` - Object picking from containers

**Example Tasks**:
- **SciLi**: Pick eraser from drawer, navigate to board, erase
- **RSS Demo**: Complex multi-step manipulation sequence
- **ICRA Video**: Demonstration tasks for video

### SpotPickAndPlace Domain
**Path**: [../src/TMP3/test_domains/SpotPickAndPlace/](../src/TMP3/test_domains/SpotPickAndPlace/)

Simplified pick-and-place tasks for testing.

**Actions**: `pick`, `place`, `navigate`

### DelicateCan Domains
**Stochastic** [../src/TMP3/test_domains/DelicateCan/](../src/TMP3/test_domains/DelicateCan/)
- Models fragile object manipulation
- Probabilistic action outcomes (may drop object)

**Deterministic** [../src/TMP3/test_domains/DelicateCanDeterministic/](../src/TMP3/test_domains/DelicateCanDeterministic/)
- Same domain without stochasticity for comparison

## Core Algorithm: Plan Refinement Graph

**Implementation**: [../src/TMP3/src/tmp3/PRGraphRefinementAlgorithms/PRRefinement.py](../src/TMP3/src/tmp3/PRGraphRefinementAlgorithms/PRRefinement.py)

The main algorithm iteratively refines high-level actions to low-level trajectories through a search process:

```
Algorithm: Plan Refinement
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Input: PDDL domain, problem, ActionConfig, initial state
Output: RefinedPolicy (executable policy tree)

1. Initialize PlanRefinementGraph with root PR node
2. While not done:
   a. Select next PR node to refine (using PR_STRATEGY)
   b. If HL plan needed:
      - Call task planner (FF/LAO*) to get HL action sequence
   c. Extract leaf sequences (paths from root to leaves in HL plan)
   d. For each leaf sequence:
      i. Try to refine all HL actions:
         - For each LL argument in ActionConfig:
           * Call Generator.get_next() to sample values
           * Evaluate predicates in order
           * If predicate fails:
             - Try next generator sample
             - If generator exhausted → refinement fails
      ii. If refinement succeeds:
          - Apply effects to state
          - Create LowLevelPlan with execution_sequence
      iii. If refinement fails:
           - Create new PR nodes for:
             * Backtracking to previous action
             * Updating model (if stochastic)
   e. Combine refined sequences into RefinedPolicy tree
3. Return RefinedPolicy
```

**Key Features**:
- **Ordered predicate evaluation**: Predicates in ActionConfig are evaluated sequentially
- **Alias mechanism**: Use `target:gpose` syntax to reference previously generated values
- **Backtracking**: On failure, algorithm backtracks and tries alternative generator samples
- **Stochastic branching**: Policy trees have multiple branches for different action outcomes
- **Error modes**: Generators can produce relaxed solutions when error-free mode exhausted

## Running TMP3

### Via ROS Launch (Recommended)

**Planning**:
```bash
# Set ROS parameters and run planner
roslaunch tmp3 load_tamp_params.launch \
  domain_dir:=/docker/spot_skills/src/TMP3/test_domains/SpotTAMP \
  problem_name:=SciLi

roslaunch tmp3 3_plan_in_sim.launch
```

**Execution on Robot**:
```bash
# Execute refined policy tree on real Spot
roslaunch tmp3 execute_on_robot.launch
```

### Via Python Script

**Main Entry Point**: [../src/TMP3/TMP.py](../src/TMP3/TMP.py)

```bash
cd /docker/spot_skills/src/TMP3

# Set ROS parameters:
rosparam set DOMAIN_DIR "/docker/spot_skills/src/TMP3/test_domains/SpotTAMP"
rosparam set PROBLEM_NAME "SciLi"
rosparam set PROJ_DIR "/docker/spot_skills/src/TMP3"

# Run TMP3
python TMP.py
```

The planner will:
1. Load PDDL domain and problem from `DOMAIN_DIR/Tasks/`
2. Load ActionConfig from `DOMAIN_DIR/Tasks/PROBLEM_NAME/ActionConfig.json`
3. Load environment from `DOMAIN_DIR/Environments/PROBLEM_NAME/tamp_env.yaml`
4. Run refinement algorithm
5. Save refined policy to `refined_tree.pkl`

**Execution**: [../src/TMP3/scripts/tamp_executor.py](../src/TMP3/scripts/tamp_executor.py)
```bash
# Execute saved policy on robot
python scripts/tamp_executor.py
```

## Workflow Summary

```
┌─────────────────────────────────────────────────────────────┐
│ 1. PROBLEM DEFINITION                                       │
│    - Write PDDL domain (abstract actions)                   │
│    - Write PDDL problem (objects, init, goal)               │
│    - Write ActionConfig JSON (HL→LL mapping)                │
│    - Write environment YAML (object poses, models)          │
│    - Implement custom Generators/Executors/Predicates       │
└────────────────────┬────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. PLANNING (TMP.py)                                        │
│    - Load all specifications                                │
│    - Initialize ROSLowLevelState with RVizSimulator         │
│    - Call FF/LAO* planner → get HL plan                     │
│    - Run PRRefinement algorithm:                            │
│      * For each HL action, sample LL arguments via          │
│        generators until predicates satisfied                │
│      * Build LowLevelPlans with execution sequences         │
│      * Handle failures by backtracking/alternative sampling │
│    - Output: refined_tree.pkl (RefinedPolicy)               │
└────────────────────┬────────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. EXECUTION (tamp_executor.py)                             │
│    - Load refined_tree.pkl                                  │
│    - Walk policy tree from root:                            │
│      * Execute trajectories in execution_sequence           │
│      * Call executor.execute() for each argument            │
│      * Handle branching for stochastic outcomes             │
│    - Monitor execution, proceed to children based on state  │
└─────────────────────────────────────────────────────────────┘
```

## Key Files Reference

| File | Purpose |
|------|---------|
| [TMP.py](../src/TMP3/TMP.py) | Main entry point |
| [Config.py](../src/TMP3/src/tmp3/Config/Config.py) | Global configuration |
| [DomainConfig.py](../src/TMP3/src/tmp3/Config/DomainConfig.py) | Domain-specific config from ROS params |
| [PRRefinement.py](../src/TMP3/src/tmp3/PRGraphRefinementAlgorithms/PRRefinement.py) | Main refinement algorithm |
| [ROSLowLevelState.py](../src/TMP3/src/tmp3/States/ROSLowLevelState.py) | Low-level state management |
| [RVizSimulator.py](../src/TMP3/src/tmp3/Simulators/RVizSimulator.py) | Simulation and motion planning |
| [ActionConfigParserV2.py](../src/TMP3/src/tmp3/Parser/ActionConfigParserV2.py) | ActionConfig JSON parser |
| [EnvironmentState.py](../src/TMP3/src/tmp3/Environments/EnvironmentState.py) | Environment and planning scene |
| [tamp_executor.py](../src/TMP3/scripts/tamp_executor.py) | Policy execution on robot |

## Recent Updates

**Latest Work** (Jan 2026):
- Debugging SciLi erase board TAMP sequence
- Added `PoseEstimationEEPoseGenerator` for perception-based grasping
- Updated SpotTAMP generators and executors for current spot_skills codebase
- Custom `IsPoseValid` predicate for SpotTAMP collision checking
- RSS demo domain (pick from drawer + erase sequence)
- ICRA video demonstration support
- Gripper half-opening for gentle grasping integration
