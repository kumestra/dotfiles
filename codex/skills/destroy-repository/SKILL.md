---
name: destroy-repository
description: Archive all branches of a GitHub repository into kumestra/code-graveyard with date-prefixed branch names, then delete the original repository using gh. Use when the user asks to destroy, destory, remove, delete, or graveyard a repository.
---

# Destroy Repository

Use this skill when the user asks to destroy/delete/graveyard a GitHub repository and expects its branches to be preserved in `kumestra/code-graveyard` before deletion.

## Required Behavior

Archive first, delete last. Do not delete the source repository unless every branch has been pushed successfully to `git@github.com:kumestra/code-graveyard.git`.

The archive branch name format is:

```text
YYYY-MM-dd-repo-name-branch-name
```

Example for repo `tmp-repo`, branch `main`, on 2026-07-24:

```text
2026-07-24-tmp-repo-main
```

## Workflow

1. Identify the repository to destroy.
   - Accept `repo`, `owner/repo`, or a GitHub URL.
   - If the owner is omitted, infer it from `gh repo view` or the current GitHub CLI default behavior.
   - Refuse to operate on `kumestra/code-graveyard`.

2. Clone the repository into `/tmp`.
   - Use a unique local path, such as `/tmp/destroy-repository-repo-name`.
   - If the path already exists, choose another path or remove only if it is clearly a previous clone for this exact operation and the user has approved deletion.

3. Fetch all remote branches.

4. Add the archive remote:

```bash
git remote add target git@github.com:kumestra/code-graveyard.git
```

5. For each source branch, push it to `target` using the date-prefixed archive name:

```bash
git push target branch-name:YYYY-MM-dd-repo-name-branch-name
```

Use the current local date for `YYYY-MM-dd`. Preserve the source branch name exactly after the repo-name segment unless Git refuses the destination name. If a destination branch already exists, stop and ask the user how to proceed.

6. Verify that every push succeeded.

7. Delete the original repository with `gh repo delete`.
   - Prefer a non-interactive command only when the repository is fully identified, such as `gh repo delete owner/repo --yes`.
   - Never delete if any archive push failed or was skipped.

8. Report:
   - The repository deleted.
   - The archive remote used.
   - Each source branch and its archived branch name.
   - Any cleanup left in `/tmp`.

## Safety Rules

- Do not destroy `kumestra/code-graveyard`.
- Do not delete the source repository before all branches are archived.
- Stop on push failures, authentication failures, missing repository access, or ambiguous repository names.
- Treat this as destructive. If the user's request is ambiguous about the target repository, ask for clarification before cloning or deleting.
- Do not install this skill unless the user explicitly asks.
