---
name: ship
description: Stage working directory changes, check for binaries, then commit and push
disable-model-invocation: true
---

# Ship

Stage all changes, verify no binary files are included, then commit and push.

## Steps

### 1. Stage

Run `git add -A` to stage all changes in the working directory.

### 2. Check for binary files

Run `git diff --cached --numstat` and inspect the output. Binary files appear as lines starting with `-\t-\t` (two dashes instead of numbers).

If any binary files are found:
- List each binary file by name
- Tell the user: "Staged changes include binary files — stopping. Please unstage them with `git restore --staged <file>` before shipping."
- Stop. Do not proceed.

### 3. Commit

Review `git diff --cached` and compose an appropriate commit message.

### 4. Push

Run `git push`.

Report the commit hash and pushed branch to the user.
