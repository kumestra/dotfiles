
Extract a sub-folder of a git repo into a standalone repo.

Verify the installation:

```bash
git filter-repo --version
```

Install git-filter-repo:

```bash
sudo apt update
```

```bash
sudo apt install git-filter-repo
```

Clone the origin repo:

```bash
git clone /path/to/project-abc
```

Enter the cloned repo:

```bash
cd project-abc
```

Keep only the history and files associated with folder-abc.

```bash
git filter-repo --subdirectory-filter folder-abc
```

```bash
git remote remove origin
```

```bash
git remote add origin git@github.com:USERNAME/folder-abc.git
```

```bash
git push --set-upstream origin main -f
```