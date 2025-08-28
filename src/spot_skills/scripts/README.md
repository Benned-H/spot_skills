# State Management and Skill Chaining

This README explains how to run `state_mgmt_skill_chain.py` from the terminal, what it does, and how to use its two main functionalities: generating skill sequence data and extracting skill transitions.

## 1. Running the Main Data Collection (`main()`)

The primary function of `state_mgmt_skill_chain.py` is to collect robot skill execution data, save images of the environment at each step, and record the sequence in a YAML file.

### How to Run
```bash
roslaunch spot_skills spot_nav_demo.launch spot_name:=[ROBOT_NAME] rtabmap_database_path:=[MAP_PATH]
```

In a seperate terminal tab, run:


```bash
cd /home/seodon/Documents/spot_skills/src/spot_skills/scripts
python3 state_mgmt_skill_chain.py
```

### What Happens

- The script will prompt you for skill success before each skill execution.
- It will navigate the robot, execute skills, and take pictures at relevant locations.
- Images are saved under `src/spot_skills/scripts/skill_chaining/skill_images/` and `init_imgs/`.
- The sequence of actions, their outcomes, and associated images are recorded in `src/spot_skills/scripts/skill_chaining/skill_sequences.yaml`.
- If interrupted, progress is saved and can be resumed later.

## 2. Extracting Skill Transitions (`get_skill_states`)

You can also use the script to extract before/after state transitions for a specific skill from the generated YAML file (assuming you had already ran main() and the YAML has already been saved to disk).

### How to Run

Comment the following line at the bottom of `state_mgmt_skill_chain.py`:

```python
main()
```

Uncomment the following lines at the bottom of `state_mgmt_skill_chain.py`:

```python
# states = get_skill_states("OpenDoor")
```

Replace `"OpenDoor"` with the skill you want to analyze.

Then run:

```bash
python3 state_mgmt_skill_chain.py
```

### What Happens

- The script will output a list of before/after state dictionaries for each occurrence of the specified skill in the YAML file.

## Output Summary

- **YAML File:** `src/spot_skills/scripts/skill_chaining/skill_sequences.yaml` (records all steps, skills, success, and image paths)
- **Images:** Saved in `skill_images/` and `init_imgs/` directories
- **Skill Transitions:** Printed to terminal when running `get_skill_states`

---

**Note:** Only one of `main()` or `get_skill_states` should be run at a time. Comment/uncomment as needed.
