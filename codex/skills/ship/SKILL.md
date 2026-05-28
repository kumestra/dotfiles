---
name: ship
description: Use when the user asks to ship, commit, publish, or push current git changes by staging changes, rejecting binaries, creating a Conventional Commit with a required body and Codex co-author trailer, pushing to the remote, and reporting the committed result.
---

# Ship

Ship the current git working tree as one Conventional Commit and push it to the remote.

## Workflow

1. Confirm the current directory is inside a git repository:
   ```bash
   git rev-parse --is-inside-work-tree
   ```
   If this fails, stop and tell the user the current directory is not a git repository.

2. Stage every working-tree change:
   ```bash
   git add -A
   ```

3. If nothing is staged, stop and tell the user there is nothing to commit:
   ```bash
   git diff --cached --quiet
   ```

4. Check staged files for binaries:
   ```bash
   git diff --cached --numstat
   ```
   Binary files appear as lines where both stat columns are `-`. If any are found, list those paths and stop. Do not commit or push.

5. Review the staged change before committing:
   ```bash
   git diff --cached --stat
   git diff --cached
   ```

6. Compose a Conventional Commit message. Read `references/conventional-commits.md` before choosing the final message.

   Requirements:
   - The subject must follow Conventional Commits.
   - The body is required and must explain what changed and why.
   - Include `Co-authored-by: Codex <codex@openai.com>` as the final trailer.
   - Recent commit history may be used for style reference only when the existing messages also follow Conventional Commits.

7. Commit using separate message paragraphs:
   ```bash
   git commit -m "type(scope): subject" -m "Body text." -m "Co-authored-by: Codex <codex@openai.com>"
   ```

8. Push the commit:
   - If the branch has an upstream, run `git push`.
   - If the branch has no upstream, run `git push -u origin HEAD`.
   - If network sandboxing blocks the push, request approval and retry the same push command.

9. Build the report from the committed revision, not from assumptions. Gather:
   ```bash
   git rev-parse HEAD
   git rev-parse --short HEAD
   git branch --show-current
   git show -s --format='%an|%ae|%s|%ct' HEAD
   git show -s --format='%B' HEAD
   git show --shortstat --format= HEAD
   git show --name-only --format= HEAD
   git remote get-url origin
   ```

10. Report in exactly this table format:

| Field | Value |
|---|---|
| **Commit** | short hash (full hash) |
| **Branch** | branch name |
| **When** | UTC: `Sunday, April 19, 2026 at 2:30 PM`; Beijing: `Sunday, April 19, 2026 at 10:30 PM` |
| **Author** | author name |
| **Email** | author email |
| **Message** | commit subject line only |
| **Changed** | N files; +X -Y |
| **Files** | list of changed filenames |
| **Link** | full GitHub commit URL |

Then print the full commit message as a fenced code block.

11. If the commit includes any `.md` files, print a markdown bullet list below the code block where each item is the plain URL string pointing to that file at the committed SHA on GitHub.

   Use this permalink form:
   ```text
   https://github.com/<owner>/<repo>/blob/<full-sha>/<path>
   ```

   Construct the URL from the same remote used for the commit link. Use the full commit hash, never `blob/main`. For renames, use the post-commit path from `git show --name-only`. If no `.md` files are in the commit, omit this section.

## GitHub URL Rules

Construct the GitHub commit URL from `origin`:

- `git@github.com:owner/repo.git` becomes `https://github.com/owner/repo/commit/<full-sha>`.
- `https://github.com/owner/repo.git` becomes `https://github.com/owner/repo/commit/<full-sha>`.
- `https://github.com/owner/repo` becomes `https://github.com/owner/repo/commit/<full-sha>`.

If the remote is missing or is not a GitHub remote, put `(none)` or `(unsupported remote)` in the **Link** field.
