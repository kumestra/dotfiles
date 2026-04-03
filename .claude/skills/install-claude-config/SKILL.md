---
name: install-claude-config
description: Merge user-level Claude Code config from this dotfiles repo into ~/.claude/
disable-model-invocation: true
---

# Install Claude Code User Config

Merge files from the `claude/` directory in this dotfiles repo into `~/.claude/`.

## Rules — read these carefully

1. **Additive only.** Never change, overwrite, or delete anything already in `~/.claude/`.
2. **Conflict = stop.** If any merge operation would require changing or removing existing content, stop immediately and report the conflict to the user. Do not proceed with remaining files.
3. **Identical = skip.** If a file or key already exists with identical content, skip it silently.

## Procedure

### Step 1: Discover and analyze

Read all files in the `claude/` directory of this repo. For each file, read both the source and the corresponding target in `~/.claude/` (if it exists). Analyze what would happen using the merge rules below.

### Step 2: Present the plan

**Do NOT make any changes yet.** Present a clear plan to the user showing:

- For each file, what action would be taken:
  - **COPY**: target does not exist, will copy source as-is
  - **ADD**: target exists, will add new keys/items (list exactly which keys)
  - **SKIP**: target exists with identical content, nothing to do
  - **CONFLICT**: target exists with different content, cannot merge (show both values)
- If there are any CONFLICTs, state clearly that the merge cannot proceed until conflicts are resolved.

Then ask the user: **"Do you want to proceed with this plan?"**

**Wait for explicit user approval before continuing. Do not proceed without it.**

### Step 3: Execute (only after user approval)

Apply the plan exactly as presented. Follow the merge strategy based on file type:

**JSON files (e.g. `settings.json`):**
- If the target does not exist, copy the source file as-is.
- If the target exists, compare key by key (top-level):
  - **Key does not exist in target:** add it.
  - **Key exists in target with identical value:** skip it.
  - **Key exists in target with a different value:** do not proceed. This should have been caught as a CONFLICT in Step 2.
- For array values: if both source and target have the same key as an array, add only items not already present in the target.
- For nested objects: apply the same additive logic recursively. Never overwrite an existing nested key that has a different value.

**All other files (scripts, configs, etc.):**
- If the target does not exist, copy the source file and preserve executable permissions.
- If the target exists with identical content, skip it.
- If the target exists with different content, do not proceed. This should have been caught as a CONFLICT in Step 2.

### Step 4: Report

After execution, summarize what was done:
- Files/keys added
- Files/keys skipped (already identical)
- Any unexpected issues encountered
