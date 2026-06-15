
[Codex Official Site](https://developers.openai.com/codex)

Check if AppArmor restricts unprivileged user namespaces:

```bash
cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns
```
1 = restricted (bwrap will fail)

0 = allowed

Enable temporarily (resets on reboot):

```bash
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```

Enable permanently:

```bash
echo "kernel.apparmor_restrict_unprivileged_userns=0" | sudo tee /etc/sysctl.d/99-userns.conf
```

Install bubblewrap

```bash
sudo apt install -y bubblewrap
```

## skill

### Install skill

```text
Please complete the following tasks:

1. Locate the `codex/skills` directory in the root of the current Git repository and read all files within that directory.
2. Analyze and determine where Skills must be placed for Codex to use them.
3. Create symbolic links (symlinks) for all Skills in the `codex/skills` directory so that Codex can use them properly.

Before performing any actions, first restate your understanding of the task. Do not begin execution until I confirm that your understanding is correct.
```

```text
Your understanding of the task you are about to perform is correct. Now, please create a plan to complete this task. While creating the plan, you may perform any read-only operations, such as searching the internet or reading files, but you must not modify any files.
```

```text
I have approved this plan. You may proceed with its execution.
```

### github markdown feature

[Table](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-tables)

[Tasklist](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/about-tasklists)

[Code Block](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks)

[Mermaid Diagram](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams?utm_source=chatgpt.com#creating-mermaid-diagrams)

[Latex](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions)

[Link](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links)

[Heading anchor / Session Link](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#section-links)

[Footnote](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#footnotes)

[Emoji](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#using-emojis)
