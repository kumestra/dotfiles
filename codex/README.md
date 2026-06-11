
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

## blog skill

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
