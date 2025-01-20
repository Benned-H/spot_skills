# How to Contribute to `spot_skills`

## Typical Workflow

This section outlines the workflow generally followed by developers contributing to `spot_skills` and related codebases.

### 1. Set up the Development Environment

- **Clone the repository and submodules using SSH**:

  ```bash
  git clone --recurse-submodules git@github.com:Benned-H/spot_skills.git
  cd spot_skills
  ```

- **Build the Docker environment**:

  ```bash
  docker-compose up --build
  ```

  TODO: Create automated script to build/pull the correct image (GPU?) based on CLI commands

- **Activate the development environment**:

  ```bash
  docker exec -it <container-name> bash
  ```

  TODO: Create automated script to automatically enter the correct service

### 2. Create a Feature Branch

- **Sync with \*\***`main`\*\*:

  ```bash
  git checkout main
  git pull origin main
  ```

- **Create a new feature branch**:

  ```bash
  git checkout -b feature/<branch-name>
  ```

### 3. Push Early and Create a Draft Pull Request

- **Stage and commit initial changes** (even if minimal or experimental):

  ```bash
  git add <changed-files>
  git commit -m "Initial commit for <branch-name>"
  ```

- **Push to the remote**:

  ```bash
  git push origin feature/<branch-name>
  ```

- **Open a Draft Pull Request**:

  - Create a PR on GitHub right away and mark it as a "Draft."
  - Add a minimal description and focus on a **"Done When"** logic: A simple sentence explaining what outcome the reviewer should expect when the PR is considered "done."
  - Example:
    > "Done When: Spot robot can successfully execute the new pick-and-place skill without error in the simulated environment."

### 4. Make Frequent Atomic Commits

- **Implement and commit code iteratively**:

  - Keep commits atomic and frequent. Each commit should reflect one logical change or update:
    ```bash
    git add <specific-files>
    git commit -m "Add X feature for task Y"
    ```

- **Push frequently** to keep the remote branch up-to-date:

  ```bash
  git push origin feature/<branch-name>
  ```

- Use the Draft PR for **self-review** and iteration.

### 5. Test the Changes

- **Run tests locally** if they are available. If not, testing tools are optional for future use.
  ```bash
  # Run any available tests inside the container
  pytest --cov=<path>  # Optional, if tests exist
  ```

### 6. Iterate on the Draft PR

- Use GitHub’s **Review Tools** to leave comments and iterate on the code while the PR is in draft mode.
- Continue making changes in the feature branch, pushing frequently.
  ```bash
  git push origin feature/<branch-name>
  ```

### 7. Mark PR as Ready for Review

- Once the feature is complete, mark the Draft PR as **"Ready for Review."**
  - Ensure the "Done When" statement is still accurate.
  - Example:
    > "Done When: Spot can execute the grasp skill reliably on a detected object."

### 8. Code Review Process

- The project lead will review the PR and provide feedback.

- **Respond to feedback** with additional commits, and update the PR as needed.

- **Push revisions**:

  ```bash
  git push origin feature/<branch-name>
  ```

### 9. Merging to Main

Once approved:

- The project lead merges the feature branch into `main`, typically with **rebase and merge** to maintain clean history.
- **Update submodules** if necessary:
  ```bash
  git submodule update --remote
  ```

### 10. Cleanup

- **Delete the feature branch** locally and remotely once merged:
  ```bash
  git branch -d feature/<branch-name>
  git push origin --delete feature/<branch-name>
  ```
