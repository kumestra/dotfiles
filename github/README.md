
Create a new repo:

```bash
gh repo create project-name \
  --public \
  --description "Description here." \
  --add-readme \
  --gitignore Python \
  --license AGPL-3.0 \
  --clone
```

Init repo (Python):

```bash
uv init . --package --vcs none --no-readme --python 3.12
```
