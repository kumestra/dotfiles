# LobeChat — self-hosted stack

A Docker Compose deployment of [LobeChat](https://github.com/lobehub/lobe-chat),
an open-source ChatGPT-style UI that supports many LLM providers (OpenAI,
Anthropic, OpenRouter, local Ollama, etc.).

This stack is **stateless** — every `docker compose down` wipes all data
(chats, uploads, accounts). Configure it as a throwaway dev/test instance,
not a production deployment.

## What's in the stack

| Service       | Image                       | Role                                   |
| ------------- | --------------------------- | -------------------------------------- |
| `lobe`        | `lobehub/lobehub`           | The chat UI (Next.js app)              |
| `postgresql`  | `paradedb/paradedb:pg17`    | Stores users, conversations, messages  |
| `redis`       | `redis:7-alpine`            | Cache and short-lived session state    |
| `rustfs`      | `rustfs/rustfs:latest`      | S3-compatible blob store for uploads   |
| `rustfs-init` | `minio/mc:latest`           | One-shot bucket + policy bootstrap     |
| `searxng`     | `searxng/searxng`           | Meta-search backend for web-search tool |

## Prerequisites

- Docker Engine 24+ with the `compose` plugin
- The `.env` file in this directory (committed with locally-generated secrets)

## Start

```bash
docker compose up --no-attach searxng
```

`--no-attach searxng` mutes searxng's very chatty logs so lobe's output is
readable. Drop the flag if you want to see every search query.

For background mode:

```bash
docker compose up -d
docker compose logs -f lobe   # follow just lobe's logs
```

## Use it

Open <http://localhost:3210>. Register an account (the first user is the
admin) and start chatting. Configure your LLM provider API keys in
**Settings → Language Model**.

Other exposed ports for poking around:

| Port  | Service                                  |
| ----- | ---------------------------------------- |
| 3210  | LobeChat UI                              |
| 5432  | Postgres (user `postgres`, db `lobechat`) |
| 6379  | Redis                                    |
| 9000  | RustFS S3 endpoint                       |
| 9001  | RustFS admin console                     |

## Stop

```bash
docker compose down
```

This stops and removes the containers and network. Because no volumes are
declared, all data is gone on the next `up` — `rustfs-init` will recreate
the `lobe` bucket and policy automatically.

## Configuration

All knobs live in `.env`:

- `LOBE_PORT`, `RUSTFS_PORT`, `RUSTFS_ADMIN_PORT` — change host ports if they
  conflict with something else on your machine.
- `AUTH_ALLOWED_EMAILS` — comma-separated allowlist for registration. Leave
  empty to let anyone sign up.
- `AUTH_DISABLE_EMAIL_PASSWORD=1` — disable email/password registration
  (SSO-only mode).
- `KEY_VAULTS_SECRET`, `AUTH_SECRET`, `POSTGRES_PASSWORD`, `RUSTFS_SECRET_KEY`,
  `JWKS_KEY` — secrets used internally. Regenerate if exposed.
