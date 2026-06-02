





[Official Docs](https://hermes-agent.nousresearch.com/docs/)

[OpenRouter Hermes Agent](https://openrouter.ai/apps/hermes-agent)

## Docker

Download Docker image:

```bash
docker pull nousresearch/hermes-agent:latest
```

Package up image:

```bash
docker save -o hermes-agent-latest.tar nousresearch/hermes-agent:latest
```

Move tar file somewhere safe.

Load the image:

```bash
docker load -i hermes-agent-latest.tar
```



Setup

```bash
docker run -it --rm \
  -v /home/t/git-repos/hermes-config/docker-config:/opt/data \
  nousresearch/hermes-agent setup
```

TUI Chat

```bash
docker run -it --rm \
  -v /home/t/git-repos/hermes-config/docker-config:/opt/data \
  nousresearch/hermes-agent
```

Gateway

```bash
docker run \
  --name hermes \
  --restart unless-stopped \
  -v /home/t/git-repos/hermes-config/docker-config:/opt/data \
  -p 8642:8642 \
  nousresearch/hermes-agent gateway run
```

```bash
sudo chown -R t:t /home/t/git-repos/hermes-config/docker-config
```

```bash
chmod -R u+rwX,go-rwx /home/t/git-repos/hermes-config/docker-config
```