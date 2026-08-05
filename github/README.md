
Create a new repo:

Python

```bash
gh repo create tmp-project-name \
  --private \
  --description "tmp" \
  --add-readme \
  --gitignore Python \
  --clone
```

前端

```bash
gh repo create project-name \
  --public \
  --description "Description here." \
  --add-readme \
  --gitignore Node \
  --license AGPL-3.0 \
  --clone
```

Init repo (Python):

```bash
uv init . --package --vcs none --no-readme --python 3.12
```

Fork a repo:

```bash
gh repo fork OWNER/REPO --clone
```