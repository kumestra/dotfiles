





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
  -v /home/t/git-repos/dotfiles/hermes/hermes-docker-config:/opt/data \
  nousresearch/hermes-agent setup
```

TUI Chat

```bash
docker run -it --rm \
  -v /home/t/git-repos/dotfiles/hermes/hermes-docker-config:/opt/data \
  nousresearch/hermes-agent
```