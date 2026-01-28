# Development Guide

Guide for developers working on the spot_skills codebase.

## Setup

### Clone Repository

```bash
git clone --recursive <repository_url>
cd spot_skills
```

### Update Submodules

```bash
# Initial clone
git submodule update --init --recursive

# Update to latest
git submodule update --remote --recursive

# Or use helper script
./docker/git_pull_all.sh
```

## Building

### Build ROS Workspace

```bash
# Inside Docker container
cd /docker/spot_skills

# Clean build
catkin clean
catkin build

# Build specific package
catkin build spot_skills

# Build with verbose output
catkin build --verbose

# Source workspace
source devel/setup.bash
```

### Build Python Packages

```bash
# Create virtual environment
uv venv --system-site-packages --python 3.8
source .venv/bin/activate

# Install in editable mode
uv pip install -e .

# Install with extras
uv pip install -e ".[vision]"
```

## Testing

### Python Unit Tests

```bash
# Run all tests
pytest src/spot_skills/tests/

# Run specific test file
pytest src/spot_skills/tests/test_time_stamp.py

# Run with coverage
pytest --cov=spot_skills_py src/spot_skills/tests/

# Run with verbose output
pytest -v src/spot_skills/tests/
```

### ROS Tests

```bash
# Build and run tests
catkin build --catkin-make-args run_tests

# View test results
catkin_test_results

# Run specific package tests
catkin run_tests spot_skills
```

### Integration Tests

```bash
# Launch test environment
roslaunch spot_skills test_environment.launch

# Run integration test
rostest spot_skills integration_test.test
```

## Code Quality

### Type Checking

```bash
# Run mypy
mypy src/spot_skills/src/spot_skills_py

# Check specific file
mypy src/spot_skills/src/spot_skills_py/spot/spot_manager.py

# With strict mode
mypy --strict src/spot_skills/src/spot_skills_py
```

### Linting

```bash
# Run ruff
ruff check src/spot_skills/src/spot_skills_py

# Auto-fix issues
ruff check --fix src/spot_skills/src/spot_skills_py

# Format code
ruff format src/spot_skills/src/spot_skills_py
```

### Pre-commit Hooks

```bash
# Install pre-commit
pip install pre-commit

# Install hooks
pre-commit install

# Run manually
pre-commit run --all-files
```

## Code Organization

### Package Structure

```
src/spot_skills/
├── src/spot_skills_py/        # Python library
│   ├── spot/                  # Robot control modules
│   │   ├── __init__.py
│   │   ├── spot_manager.py    # One module per file
│   │   └── ...
│   ├── planners/              # Planning utilities
│   ├── samplers/              # Sampling utilities
│   └── __init__.py
├── scripts/                   # Executable scripts
│   ├── spot_wrapper_node.py  # ROS nodes
│   └── ...
├── launch/                    # Launch files
├── config/                    # Configuration
├── tests/                     # Unit tests
└── package.xml                # ROS package metadata
```

### Coding Standards

**Python**:
- Follow PEP 8 style guide
- Use type hints for all functions
- Docstrings in Google style
- Maximum line length: 100 characters

**Example**:
```python
from typing import Optional
import rospy

def navigate_to_pose(
    pose: PoseStamped,
    timeout: Optional[float] = None
) -> bool:
    """Navigate robot to target pose.

    Args:
        pose: Target pose in map frame
        timeout: Maximum time to wait (seconds), None for no timeout

    Returns:
        True if navigation succeeded, False otherwise

    Raises:
        NavigationError: If navigation fails critically
    """
    # Implementation
    pass
```

**ROS Conventions**:
- Use standard message types when possible
- Namespace services under `/spot/`
- Use snake_case for topic/service names
- Use PascalCase for message/service types

## Adding New Features

### Adding a New Skill

1. **Create skill module** in `src/spot_skills_py/spot/`:
   ```python
   # spot_new_skill.py
   class SpotNewSkill:
       def __init__(self, robot):
           self.robot = robot

       def execute(self, params):
           # Implementation
           pass
   ```

2. **Add service definition** in `srv/`:
   ```
   # NewSkill.srv
   float64 param1
   string param2
   ---
   bool success
   string message
   ```

3. **Register in spot_ros_wrapper.py**:
   ```python
   from spot_skills_py.spot.spot_new_skill import SpotNewSkill

   class SpotROSWrapper:
       def __init__(self):
           self.new_skill = SpotNewSkill(self.robot)
           self.new_skill_srv = rospy.Service(
               '/spot/new_skill',
               NewSkill,
               self.handle_new_skill
           )

       def handle_new_skill(self, req):
           result = self.new_skill.execute(req)
           return NewSkillResponse(success=result)
   ```

4. **Add configuration** (if needed) in `config/`:
   ```yaml
   # new_skill_config.yaml
   param1_default: 1.0
   param2_options: ["option1", "option2"]
   ```

5. **Create demo launch file** in `launch/demos/`:
   ```xml
   <launch>
     <arg name="spot_name" />
     <include file="$(find spot_skills)/launch/bringup_spot_driver.launch">
       <arg name="spot_name" value="$(arg spot_name)" />
     </include>
     <node pkg="spot_skills" type="new_skill_demo.py" name="new_skill_demo" />
   </launch>
   ```

6. **Write tests**:
   ```python
   # tests/test_new_skill.py
   import unittest
   from spot_skills_py.spot.spot_new_skill import SpotNewSkill

   class TestNewSkill(unittest.TestCase):
       def test_execute(self):
           skill = SpotNewSkill(mock_robot)
           result = skill.execute(params)
           self.assertTrue(result)
   ```

7. **Document**:
   - Add to [spot-skills-reference.md](spot-skills-reference.md)
   - Add demo to [demos-and-examples.md](demos-and-examples.md)
   - Update main README if major feature

### Adding a TMP3 Domain

See [tmp3-patterns.md](tmp3-patterns.md) for detailed guide on creating custom domains with generators, predicates, and executors.

## Debugging

### ROS Debugging

**Check node status**:
```bash
rosnode list
rosnode info /spot_wrapper
```

**Check topic info**:
```bash
rostopic list
rostopic info /joint_states
rostopic echo /joint_states
```

**Check service availability**:
```bash
rosservice list
rosservice info /spot/navigate_to_pose
```

**View TF tree**:
```bash
rosrun tf view_frames
evince frames.pdf
```

**Monitor transforms**:
```bash
rosrun tf tf_echo map base_link
```

### Python Debugging

**Using pdb**:
```python
import pdb

def my_function():
    x = 1
    pdb.set_trace()  # Breakpoint
    y = x + 1
    return y
```

**Using ipdb** (enhanced pdb):
```python
import ipdb

def my_function():
    ipdb.set_trace()
    # Rest of code
```

**Remote debugging** (attach to running ROS node):
```python
import debugpy

debugpy.listen(5678)
print("Waiting for debugger attach")
debugpy.wait_for_client()
```

Then attach from VS Code with launch configuration:
```json
{
    "type": "python",
    "request": "attach",
    "connect": {
        "host": "localhost",
        "port": 5678
    }
}
```

### Logging

**Python logging**:
```python
import rospy

rospy.logdebug("Debug message")
rospy.loginfo("Info message")
rospy.logwarn("Warning message")
rospy.logerr("Error message")
rospy.logfatal("Fatal message")
```

**Set log level**:
```bash
# In launch file
<node pkg="spot_skills" type="node.py" name="node" output="screen">
  <env name="ROSCONSOLE_CONFIG_FILE" value="$(find spot_skills)/config/rosconsole.conf"/>
</node>

# Command line
rosservice call /node/set_logger_level "logger: 'rosout' level: 'debug'"
```

## Contributing

### Workflow

1. **Create feature branch**:
   ```bash
   git checkout -b feature/new-skill
   ```

2. **Make changes and commit**:
   ```bash
   git add src/spot_skills/src/spot_skills_py/spot/new_skill.py
   git commit -m "Add new skill for object manipulation"
   ```

3. **Push to remote**:
   ```bash
   git push origin feature/new-skill
   ```

4. **Create pull request** on GitHub

### Commit Message Guidelines

Format:
```
<type>: <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Build/tooling changes

Example:
```
feat: Add door opening skill

Implement autonomous door opening with force control and
vision-based handle detection. Supports both pull and push
doors with configurable hinge location.

Closes #123
```

### Pull Request Guidelines

- Write clear description of changes
- Reference related issues
- Include tests for new features
- Update documentation
- Ensure CI passes
- Request review from maintainers

## Docker Development

### Build Docker Image

```bash
docker build -t spot-tamp:latest .
```

### Run with Code Mounted

```bash
docker run -it --rm \
  -v $(pwd):/docker/spot_skills \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  --network host \
  spot-tamp:latest \
  bash
```

### Docker Compose Development

```yaml
# compose.dev.yaml
services:
  spot-tamp-dev:
    build: .
    volumes:
      - .:/docker/spot_skills
      - /tmp/.X11-unix:/tmp/.X11-unix
    environment:
      - DISPLAY
    network_mode: host
    privileged: true
    command: bash
```

```bash
docker compose -f compose.dev.yaml up
```

## Performance Profiling

### Python Profiling

```bash
# Profile script
python -m cProfile -o profile.stats script.py

# View results
python -m pstats profile.stats
>>> sort time
>>> stats 10
```

### ROS Performance

```bash
# Monitor node CPU/memory
rosrun rqt_top rqt_top

# Profile node
rosrun roslaunch_profiler roslaunch_profiler node_name
```

## Documentation

### Building Documentation

```bash
# If using Sphinx
cd docs
make html
firefox _build/html/index.html
```

### Documenting Code

- Add docstrings to all public functions/classes
- Use type hints
- Include usage examples in docstrings
- Keep README and docs/ in sync

See [CONTRIBUTING.md](../CONTRIBUTING.md) for more details.
