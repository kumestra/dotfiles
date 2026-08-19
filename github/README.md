
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

Init repo (Next.js)

[用一条命令初始化现有 Git 仓库中的 Next.js 项目](https://github.com/kumestra/probable-guide/blob/main/blog/2026/08/2026-08-18-create-next-app-command.md)

```bash
npx -y create-next-app@latest . \
  --ts \
  --tailwind \
  --eslint \
  --app \
  --react-compiler \
  --src-dir \
  --empty \
  --use-npm \
  --import-alias "@/*" \
  --agents-md \
  --disable-git
```

Fork a repo:

```bash
gh repo fork OWNER/REPO --clone
```