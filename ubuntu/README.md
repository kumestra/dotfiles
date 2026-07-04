# Ubuntu Environment Setup

## Ubuntu Desktop

### Static IP

配置路由器，让它在遇到虚拟机的 MAC 地址时，给虚拟机分配固定的 IP 地址，虚拟机依然采用 DHCP（意思就是这一步不需要配置虚拟机，配置路由器就行）。

### OpenSSH Server

```bash
sudo apt update
```

```bash
sudo apt install -y openssh-server
```

```bash
sudo systemctl enable --now ssh
```

```bash
systemctl status ssh
```

```bash
ssh test-user@192.168.1.157
```

### Upload Public Key to VM

```powershell
Get-Content C:\Users\hongz\.ssh\id_ed25519.pub | ssh test-user@192.168.1.157 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

### Config APT Mirror

backup

```bash
sudo cp /etc/apt/sources.list.d/ubuntu.sources \
    /etc/apt/sources.list.d/ubuntu.sources.bak
```

switch url

```bash
sudo sed -i 's|http://us.archive.ubuntu.com/ubuntu/|https://mirrors.aliyun.com/ubuntu/|' \
    /etc/apt/sources.list.d/ubuntu.sources
```

verify

```bash
cat /etc/apt/sources.list.d/ubuntu.sources
```

refresh

```bash
sudo apt update
```

### Install Vim

```bash
sudo apt install -y vim
```
```bash
echo -e 'export VISUAL="vim"\nexport EDITOR="vim"' >> ~/.bashrc
```

### Config NTP Server

```bash
sudo sed -i 's/^#NTP=.*/NTP=ntp.aliyun.com ntp.tencent.com ntp.ntsc.ac.cn/' /etc/systemd/timesyncd.conf
```

```bash
sudo sed -i 's/^#PollIntervalMaxSec=.*/PollIntervalMaxSec=64/' /etc/systemd/timesyncd.conf
```

```bash
sudo systemctl restart systemd-timesyncd
```

check

```bash
timedatectl timesync-status
```

```bash
journalctl -u systemd-timesyncd --no-pager -n 10
```

### Install Tmux

```bash
sudo apt install -y tmux
```

8. 配置Git

Install

```bash
sudo apt install -y git
```

Config username

```bash
git config --global user.name "Evanara Kumestra"
```

Check it worked

```bash
git config --global user.name
```

Config email

```bash
git config --global user.email "77485901+kumestra@users.noreply.github.com"
```

Check it worked

```bash
git config --global user.email
```

Config default branch name

```bash
git config --global init.defaultBranch main
```

Check it worked

```bash
git config --global init.defaultBranch
```

Generate key pair，然后在Github上面输入公钥。

```bash
ssh-keygen
```

在`~/.ssh`中创建文件`config`，进行如下配置（解决github.com端口22被屏蔽的问题）：

```text
Host github.com
    HostName ssh.github.com
    Port 443
    User git
```

git commit签名：先按照 [Generating a new GPG key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key) 生成GPG key，然后按照 [Adding a GPG key to your GitHub account](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account) 操作把公钥添加到Github账户，然后参考 [Telling Git about your signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key) 告诉Git使用GPG key。不用参考 [Associating an email with your GPG key](https://docs.github.com/en/authentication/managing-commit-signature-verification/associating-an-email-with-your-gpg-key) ，因为在key创建的时候已经关联了Github Email。

### Turn off Screen Blank(解决一段时间不操作黑屏问题)

### 安装curl

```bash
sudo apt install -y curl
```

### Install Docker

### Install Maple Font

### dotfiles

### nvm

### uv

### Task snapshot

## After snapshot

### tmux session

### VS Code (dotfiles repo)

### bubblewrap

### codex install

### codex skill

### probable guide repo
