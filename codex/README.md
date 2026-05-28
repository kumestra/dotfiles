
[Codex Official Site](https://developers.openai.com/codex)

Check if AppArmor restricts unprivileged user namespaces:

```bash
cat /proc/sys/kernel/apparmor_restrict_unprivileged_userns
# 1 = restricted (bwrap will fail)
# 0 = allowed
```

Enable temporarily (resets on reboot):

```bash
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```

Enable permanently:

```bash
echo "kernel.apparmor_restrict_unprivileged_userns=0" | sudo tee /etc/sysctl.d/99-userns.conf
```
