---
name: ship
description: Stage working directory changes, check for binaries, then commit and push
disable-model-invocation: true
---

# Ship

1. Stage all changes in the working directory.
2. Check staged files for binaries. If any are found, list them and stop — do not commit or push.
3. Review the staged diff and commit using Conventional Commits format.
4. Push to remote, then give the user a report about this commit.
