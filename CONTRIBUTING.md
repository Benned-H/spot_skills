# How to Contribute to `spot_skills`

## Typical Workflow

This section outlines the typical workflow for contributing to `spot_skills` and related codebases, involving these high-level steps:

1. Set up the environment.
2. Create a feature branch.
3. Push early and open a pull request (PR).
4. Make iterative, atomic commits.
5. Review and merge the PR.

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

Whenever you begin a new task for the project, create a branch on GitHub to track the effort. In principle, each branch should introduce a single, well-defined feature to the codebase. In this so-called [feature branch](https://martinfowler.com/bliki/FeatureBranch.html) style of development, changes are only integrated into the `main` branch once they're complete. This keeps the `main` branch stable, providing a foundation enabling the simultaneous development of independent features in separate feature branches.

- **Sync with `main`**:

  ```bash
  git checkout main
  git pull origin main
  git submodule update --init --recursive
  ```

- **Create a new feature branch**:

  ```bash
  git checkout -b <branch-name>
  ```

  Name the branch descriptively (e.g. `edit-urdf`).

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

- **Open a Draft Pull Request (PR)**:

  - Create a PR on GitHub right away. If you've just pushed to your branch, the "Pull requests" tab should provide a pop-up button to create a PR for your branch.
  - Set the base branch to `main` and the `compare` branch to your new `<branch-name>`.
  - In the description, describe the purpose of the branch in a sentence or two. What is this branch supposed to do?
  - End the description with a **Done When** sentence: _What outcome will have been accomplished when this PR can be considered "done"?_ For example:

    > **Done When**: MoveIt controls Spot's gripper to open and close throughout the MoveIt-Spot demo.

  - After you've created the task's PR(s), **add the relevant links to the Slack task** in the "Pull Request(s)" column.

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

- You can use GitHub’s review tools to leave comments, track TODOs, and iterate on the code while the PR is in development.
- Continue making changes in the feature branch, pushing frequently.

  ```bash
  git push origin <branch-name>
  ```

### 6. Mark PR as Ready for Review

- Once the branch is ready, request a review on the _Reviewers_ section of the PR.
  - Ensure that the **Done When** statement is still accurate.
- Ping the relevant person on Slack, reminding them that the branch is ready for review.

### 7. Code Review Process

- The reviewer will read the current changes in the PR's _Files changed_ tab, leaving comments on any issues that need to be addressed before the branch can be merged. You can respond to these comments within the PR on GitHub.
- If feedback is given, address it in subsequent commits (`git add <files>` and `git commit -m "..."`), push them (`git push <branch-name>`), and continue resolving until all review comments are closed.
- The reviewer will read the new changes, may leave additional feedback, and otherwise will resolve their comments once they've been addressed.

### 8. Merging to Main

- Once all review comments have been resolved, Benned will merge your PR into `main`. This automatically deletes the branch name remotely, which you can retrieve locally by running:

  ```bash
  git fetch -p
  ```

### 9. Conclusion

- In the Slack task list, update your task as "Done" and double-check that its title reflects what has been accomplished.
- Finally, communicate with the team to identify what should be done next.
