---
name: branch-status
description: Show comprehensive status of the current git branch
disable-model-invocation: true
---

# Branch Status

Show as much useful information as possible about the current branch, working tree, and how it relates to its upstream and the default branch.

## Instructions

1. If not in a git repository (`git rev-parse --is-inside-work-tree` fails), stop and tell the user.
2. Gather information. Treat each as optional — if a command fails or returns nothing, show `(none)` for that field rather than erroring out.
   - **Branch name:** `git branch --show-current` (may be empty if HEAD is detached — show `(detached) <short-sha>` in that case).
   - **Upstream tracking branch:** `git rev-parse --abbrev-ref --symbolic-full-name @{upstream}`.
   - **Ahead/behind vs upstream:** `git rev-list --left-right --count @{upstream}...HEAD` → format as `X ahead, Y behind` or `up to date`.
   - **Default branch:** resolve via `git symbolic-ref refs/remotes/origin/HEAD` (strip `refs/remotes/origin/`); fall back to `main` then `master` if missing.
   - **Ahead/behind vs default branch:** `git rev-list --left-right --count <default>...HEAD`.
   - **Last commit:** `git log -1 --format='%h%x09%s%x09%an%x09%ar'`.
   - **Working tree:** `git status --porcelain=v1` — count staged (index column non-space, non-`?`), unstaged (worktree column non-space, non-`?`), untracked (`??`). Show `clean` if all zero, otherwise `N staged, M unstaged, K untracked`.
   - **Stashes:** `git stash list` line count.
   - **Remote URL:** `git remote get-url origin`.
   - **Repo root:** `git rev-parse --show-toplevel`.
3. Present the gathered data as a table:

| Field | Value |
|---|---|
| **Branch** | name (or `(detached) <sha>`) |
| **Upstream** | tracking branch or `(none)` |
| **vs Upstream** | `X ahead, Y behind` / `up to date` / `(no upstream)` |
| **Default Branch** | resolved default |
| **vs Default** | `X ahead, Y behind` |
| **Last Commit** | `<short-hash> · <subject> · <author> · <relative time>` |
| **Working Tree** | `clean` or counts |
| **Stashes** | count |
| **Remote** | origin URL or `(none)` |
| **Repo Root** | absolute path |

4. Then output a second table with exactly three columns: **Local**, **Remote**, and **vs Upstream**. Each row pairs a local branch with its tracking remote, so corresponding branches sit on the same row.

   - Collect local branches with their upstream and tracking info:
     ```
     git for-each-ref --sort=-committerdate \
       --format='%(HEAD)|%(refname:short)|%(upstream:short)|%(upstream:track)' refs/heads
     ```
     Prefix the currently checked-out branch with `* `.
     The `upstream:track` field returns one of:
     - empty → render `up to date`
     - `[ahead N]` → render `N ahead`
     - `[behind N]` → render `N behind`
     - `[ahead N, behind M]` → render `N ahead, M behind`
     - `[gone]` → render `gone` (upstream was deleted)

     When the local has no upstream at all, render the vs-upstream cell as `(no upstream)`.
   - Collect remote branches (filtering symrefs like `origin/HEAD`):
     ```
     git for-each-ref --sort=-committerdate \
       --format='%(refname:short)|%(symref)' refs/remotes
     ```
     Skip any row where `symref` is non-empty.
   - **Filter:** before building rows, drop any branch whose short name starts with `archive-` — both locals and remotes. For remotes, this means dropping any ref where the segment after the remote prefix begins with `archive-` (e.g. `origin/archive-old-feature`, `origin/archive-tmp-websocket`).
   - Build the table rows:
     1. For every remaining local branch, emit a row: local name (col 1), its upstream or `(none)` (col 2), vs-upstream value (col 3). If the local's upstream is itself an `[archive]` branch, still emit the row but show that upstream normally — the filter only hides branches as *primary* entries, not as references from a non-archived local.
     2. After all locals, for every remaining remote branch that did **not** appear as the upstream of any local, emit a row with `(none)` in col 1, the remote name in col 2, and `—` in col 3.
   - Cap at 20 rows. If more exist, add a trailing row `… (N more)` showing how many were omitted.

| Local | Remote | vs Upstream |
|---|---|---|
| `* main` | `origin/main` | up to date |
| `feature-x` | `origin/feature-x` | 2 ahead, 1 behind |
| `local-only` | `(none)` | (no upstream) |
| `stale` | `origin/stale` | gone |
| `(none)` | `origin/abandoned` | — |

Output only the two tables. Do not add extra sections, lists, or commentary.
