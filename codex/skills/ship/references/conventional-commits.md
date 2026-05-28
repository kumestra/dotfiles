# Conventional Commits

Use Conventional Commits 1.0.0 for ship commits.

## Format

```text
<type>[optional scope]: <description>

<body>

[optional footer(s)]
Co-authored-by: Codex <codex@openai.com>
```

For this skill, the body is required even though the base specification makes it optional.

## Subject Rules

- The subject must begin with a type followed by an optional scope, optional `!`, then `: `.
- Use `feat` for user-visible features.
- Use `fix` for bug fixes.
- Other useful types include `build`, `chore`, `ci`, `docs`, `perf`, `refactor`, `style`, and `test`.
- A scope may be added in parentheses, such as `fix(parser): handle empty input`.
- Use `!` before the colon for breaking changes, such as `feat(api)!: remove legacy token format`.
- Keep the description short and imperative when practical.

## Body Rules

- The body begins one blank line after the subject.
- Explain what changed and why it changed.
- Mention important validation or migration notes when relevant.
- Do not repeat the subject as the whole body.

## Footer Rules

- Footers begin one blank line after the body.
- Use git-trailer style: `Token: value`.
- Breaking changes may be written as `BREAKING CHANGE: description`.
- The final trailer must be `Co-authored-by: Codex <codex@openai.com>`.

## Examples

```text
docs: add Codex ship skill

Create a Codex-native ship workflow that stages changes, rejects binaries,
uses Conventional Commits, pushes the result, and reports commit metadata.

Co-authored-by: Codex <codex@openai.com>
```

```text
fix(git): stop ship workflow when binaries are staged

Check cached numstat output before committing so binary files are reported
to the user instead of being included in the pushed commit.

Co-authored-by: Codex <codex@openai.com>
```

```text
feat(api)!: remove legacy token format

Drop support for the old token payload so callers must send the normalized
version accepted by the current authentication flow.

BREAKING CHANGE: legacy token payloads are no longer accepted.
Co-authored-by: Codex <codex@openai.com>
```
