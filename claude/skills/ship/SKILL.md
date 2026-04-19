---
name: ship
description: Stage working directory changes, check for binaries, then commit and push
disable-model-invocation: true
---

# Ship

1. Stage all changes in the working directory.
2. If nothing is staged, stop and tell the user there is nothing to commit.
3. Check staged files for binaries using `git diff --cached --numstat`. Binary files appear as lines where both stat columns are `-` instead of numbers. If any are found, list them and stop — do not commit or push.
4. Review the staged diff using `git diff --cached`, then commit using Conventional Commits format (see `conventional-commits.md`). The body is required — always include it. Always add yourself as co-author. You may view recent commit history for style reference, but only treat messages as worth referencing if they follow the Conventional Commits format defined in this skill — ignore any that do not.
5. Push to remote, then give the user a report in this table format:

| Field | Value |
|---|---|
| **Commit** | short hash (full hash) |
| **Branch** | branch name |
| **When** | UTC: `Sunday, April 19, 2026 at 2:30 PM` · Beijing: `Sunday, April 19, 2026 at 10:30 PM` |
| **Author** | author name |
| **Email** | author email |
| **Message** | commit subject line only |
| **Changed** | N files · +X −Y |
| **Files** | list of changed filenames |
| **Link** | full GitHub commit URL (construct from remote URL) |

Then print the full commit message (subject, body, footers) as a code block below the table.
