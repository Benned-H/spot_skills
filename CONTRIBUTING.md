# How to Contribute to `spot_skills`

## Typical Workflow

This section outlines a general workflow for contributing to `spot_skills` and related codebases.

### 1. Set Up the Local Development Environment

- **Clone the repository and submodules using SSH**:

  ```bash
  git clone --recurse-submodules git@github.com:Benned-H/spot_skills.git
  cd spot_skills
  ```

- **Activate the Docker environment (builds or pulls the necessary image)**:

  ```bash
  bash docker/launch.sh
  ```

  You can use this script whenever you want to enter the Docker container.

### 2. Create a Feature Branch

When you begin a "new task," create a branch on GitHub to track the effort. We're following a [feature branch](https://martinfowler.com/bliki/FeatureBranch.html) style of development where changes are only integrated into the `main` branch once they're working.

- **Sync with `main`**:

  ```bash
  git checkout main
  git pull origin main
  ```

- **Create a new feature branch**:

  ```bash
  git checkout -b <branch-name>
  ```

  Name the branch something short and relevant to its purpose (e.g. `edit-urdf`). There's not much point in prefixing `feature/` to the branch name, but you can if you want.

### 3. Push Early and Create a Draft Pull Request

- **Stage and commit initial changes** (even if minimal or experimental):

  ```bash
  git add <changed-files>
  git commit -m "<commit message>"
  ```

  Once your branch has some local changes, commit and push them to GitHub.

- **Push to the remote**:

  ```bash
  git push --set-upstream origin <branch-name>
  ```

- **Open a Draft Pull Request**:

  - Create a PR on GitHub right away. If you've just pushed to your branch, the "Pull requests" tab should provide a pop-up button to create a PR for your branch.
  - Set the base branch to `main` and the `compare` branch to your new `<branch-name>`.
  - Add a minimal description to the PR. Focus on a **Done When** sentence: What outcome should a reviewer expect when this PR is considered "done"?
  - Example:
    > "**Done When**: MoveIt can control Spot's gripper while executing the MoveIt-Spot demo."

### 4. Make Frequent Atomic Commits

- **Implement and commit code iteratively**:

  - Keep commits [atomic](https://www.aleksandrhovhannisyan.com/blog/atomic-git-commits/) and frequent. Each commit should reflect one logical change or update:
    ```bash
    git add <specific-files>
    git commit -m "Add feature X for task Y"
    ```

- **Push frequently** to keep the remote branch up-to-date:

  ```bash
  git push origin <branch-name>
  ```

### 5. Iterate on the Draft PR

- Use GitHub’s review tools to leave comments, track TODOs, and iterate on the code while the PR is in draft mode.
- Continue making changes in the feature branch, pushing frequently.

  ```bash
  git push origin <branch-name>
  ```

### 6. Mark PR as Ready for Review

- Once the feature is complete, mark the Draft PR as **"Ready for Review."**
  - Ensure the "Done When" statement is still accurate.
  - Example:
    > "Done When: Spot can execute the grasp skill reliably on a detected object."

### 7. Code Review Process

TODO: Continue reviewing from here.

- The project lead will review the PR and provide feedback.

- **Respond to feedback** with additional commits, and update the PR as needed.

- **Push revisions**:

  ```bash
  git push origin feature/<branch-name>
  ```

### 8. Merging to Main

Once approved:

- The project lead merges the feature branch into `main`, typically with **rebase and merge** to maintain clean history.
- **Update submodules** if necessary:
  ```bash
  git submodule update --remote
  ```

### 9. Cleanup

- **Delete the feature branch** locally and remotely once merged:
  ```bash
  git branch -d feature/<branch-name>
  git push origin --delete feature/<branch-name>
  ```
