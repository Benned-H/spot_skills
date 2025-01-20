# How to Contribute to `spot_skills`

## Version 2: Simplified Workflow with Proposed Changes

This version simplifies and automates the workflow with the goal of reducing friction and improving efficiency.

### 1. Set up the Development Environment

- **Clone the repository and submodules**:

  ```bash
  git clone --recurse-submodules <repository-url>
  cd <repository-directory>
  ```

- **Build the Docker environment**:

  ```bash
  docker-compose up --build
  ```

- **Automate Environment Activation**:
  Use a script (e.g., `./dev_setup.sh`) that automatically enters the Docker container:

  ```bash
  ./dev_setup.sh
  ```

  The script would contain:

  ```bash
  #!/bin/bash
  docker exec -it <container-name> bash
  ```

### 2. Create a Feature Branch and Draft PR Early

- **Sync with \*\***`main`\*\*:

  ```bash
  git checkout main
  git pull origin main
  ```

- **Create a new feature branch** and push immediately:

  ```bash
  git checkout -b feature/<branch-name>
  git push origin feature/<branch-name>
  ```

- **Open a Draft Pull Request** on GitHub early and focus on the "Done When" logic.

### 3. Frequent Atomic Commits with Pre-Push Hook

- **Automate frequent pushes** by configuring a Git **pre-push hook** that stages and commits changes automatically when pushing:
  ```bash
  # Add the following script to .git/hooks/pre-push
  git add .
  git commit -m "Auto-commit: Changes made to <file>"
  ```

### 4. Testing and Automation

- **Run tests via script**:
  Create a `run_tests.sh` script that automates testing inside the Docker container:
  ```bash
  ./run_tests.sh
  ```
  The script would contain:
  ```bash
  #!/bin/bash
  docker exec <container-name> pytest --cov=<path>
  ```

### 5. CI Testing with GitHub Actions

- Set up **GitHub Actions** to automatically run tests and linting when a PR is opened or updated. This ensures that the tests are always run consistently across developers.

### 6. Iterate on the Draft PR and Use Self-Review

- Continue to push frequent commits and update the Draft PR iteratively.
- Use GitHub's self-review feature to track progress.

### 7. Mark PR as Ready for Review

- Once the feature is complete, mark the PR as **"Ready for Review."**
  - Ensure the "Done When" statement is still accurate.

### 8. Code Review Process and Automatic Squashing

- Enable **squash and merge** in GitHub to combine all atomic commits into one, resulting in a cleaner history on `main`.

### 9. Cleanup

- After the feature is merged, a post-merge hook script could automatically delete the local and remote feature branch.
  ```bash
  # Example post-merge hook script
  git branch -d feature/<branch-name>
  git push origin --delete feature/<branch-name>
  ```

### 10. Final Considerations

- This workflow emphasizes automation at every step, including environment setup, testing, and branch management, to streamline contributions.
