---
name: git-branch-status
description: Use when the user asks for git branch status, branch health, current branch details, upstream comparison, default-branch comparison, working tree state, stashes, remotes, or a compact overview of local and remote branches.
---

# Git Branch Status

Show useful information about the current git branch, working tree, and how the branch relates to its upstream and the default branch.

## Workflow

1. Confirm the current directory is inside a git repository:
   ```bash
   git rev-parse --is-inside-work-tree
   ```
   If this fails, stop and tell the user the current directory is not a git repository.

2. Gather branch and repository information. Treat each field as optional. If a command fails or returns nothing, show `(none)` for that field rather than failing the whole report.

   - Branch name:
     ```bash
     git branch --show-current
     ```
     If empty because HEAD is detached, show `(detached) <short-sha>`.

   - Upstream tracking branch:
     ```bash
     git rev-parse --abbrev-ref --symbolic-full-name @{upstream}
     ```

   - Ahead/behind vs upstream:
     ```bash
     git rev-list --left-right --count @{upstream}...HEAD
     ```
     Format as `X ahead, Y behind` or `up to date`. If there is no upstream, show `(no upstream)`.

   - Default branch:
     ```bash
     git symbolic-ref refs/remotes/origin/HEAD
     ```
     Strip `refs/remotes/origin/`. If missing, fall back to `main`, then `master`, when those refs exist.

   - Ahead/behind vs default branch:
     ```bash
     git rev-list --left-right --count <default>...HEAD
     ```

   - Last commit:
     ```bash
     git log -1 --format='%h%x09%s%x09%an%x09%ar'
     ```

   - Working tree:
     ```bash
     git status --porcelain=v1
     ```
     Count staged entries from the index column, unstaged entries from the worktree column, and untracked entries from `??`. Show `clean` when all counts are zero; otherwise show `N staged, M unstaged, K untracked`.

   - Stashes:
     ```bash
     git stash list
     ```
     Count lines.

   - Remote URL:
     ```bash
     git remote get-url origin
     ```

   - Repo root:
     ```bash
     git rev-parse --show-toplevel
     ```

3. Present the gathered data as this table:

| Field | Value |
|---|---|
| **Branch** | name or `(detached) <sha>` |
| **Upstream** | tracking branch or `(none)` |
| **vs Upstream** | `X ahead, Y behind` / `up to date` / `(no upstream)` |
| **Default Branch** | resolved default |
| **vs Default** | `X ahead, Y behind` |
| **Last Commit** | `<short-hash> - <subject> - <author> - <relative time>` |
| **Working Tree** | `clean` or counts |
| **Stashes** | count |
| **Remote** | origin URL or `(none)` |
| **Repo Root** | absolute path |

4. Then output a second table with exactly three columns: **Local**, **Remote**, and **vs Upstream**. Each row pairs a local branch with its tracking remote, so corresponding branches sit on the same row.

   Collect local branches:
   ```bash
   git for-each-ref --sort=-committerdate --format='%(HEAD)|%(refname:short)|%(upstream:short)|%(upstream:track)' refs/heads
   ```

   Collect remote branches and skip symbolic refs like `origin/HEAD`:
   ```bash
   git for-each-ref --sort=-committerdate --format='%(refname:short)|%(symref)' refs/remotes
   ```

   Rendering rules:
   - Prefix the checked-out local branch with `* `.
   - Empty upstream tracking text means `up to date`.
   - `[ahead N]` means `N ahead`.
   - `[behind N]` means `N behind`.
   - `[ahead N, behind M]` means `N ahead, M behind`.
   - `[gone]` means `gone`.
   - A local branch with no upstream gets `(none)` and `(no upstream)`.
   - Drop local branches whose short names start with `archive-`.
   - Drop remote branches whose branch segment after the remote name starts with `archive-`.
   - Still show an archived upstream if it is referenced by a non-archived local branch.
   - After all local branch rows, add remote branches that did not appear as an upstream of any local branch with `(none)` in the Local column and `-` in the vs Upstream column.
   - Cap the table at 20 rows. If more rows exist, add a final row that says how many were omitted.

| Local | Remote | vs Upstream |
|---|---|---|
| `* main` | `origin/main` | up to date |
| `feature-x` | `origin/feature-x` | 2 ahead, 1 behind |
| `local-only` | `(none)` | (no upstream) |
| `stale` | `origin/stale` | gone |
| `(none)` | `origin/abandoned` | - |

Output only the two tables. Do not add extra sections, lists, or commentary.
