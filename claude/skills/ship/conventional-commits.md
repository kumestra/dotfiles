# Conventional Commits 1.0.0

## Summary

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

1. **fix:** patches a bug (correlates with `PATCH` in SemVer)
1. **feat:** introduces a new feature (correlates with `MINOR` in SemVer)
1. **BREAKING CHANGE:** a footer `BREAKING CHANGE:`, or `!` after the type/scope, introduces a breaking API change (correlates with `MAJOR` in SemVer). Can be part of any type.
1. Other types are allowed: `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`, etc.

## Examples

```
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

```
feat!: send an email to the customer when a product is shipped
```

```
feat(api)!: send an email to the customer when a product is shipped
```

```
docs: correct spelling of CHANGELOG
```

```
feat(lang): add Polish language
```

```
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from latest request.

Reviewed-by: Z
Refs: #123
```

## Specification

1. Commits MUST be prefixed with a type (noun), followed by optional scope, optional `!`, and REQUIRED terminal colon and space.
1. `feat` MUST be used when a commit adds a new feature.
1. `fix` MUST be used when a commit represents a bug fix.
1. A scope MAY be provided after a type — a noun in parenthesis, e.g. `fix(parser):`.
1. A description MUST immediately follow the colon and space after the type/scope prefix.
1. A longer body MAY be provided after the description, separated by one blank line.
1. One or more footers MAY be provided one blank line after the body.
1. Breaking changes MUST be indicated by `!` before `:`, or as `BREAKING CHANGE:` in the footer.
1. Types other than `feat` and `fix` MAY be used, e.g. `docs: update ref docs`.
