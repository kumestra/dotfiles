# RSSHub

Local [RSSHub](https://docs.rsshub.app/) deployment via Docker Compose. RSSHub is a feed generator — it produces RSS feeds for sites that don't natively expose them (YouTube, Twitter, GitHub, Bilibili, Reddit, etc.).

## Stack

Three services defined in `docker-compose.yml`:

| Service | Image | Purpose |
|---|---|---|
| `rsshub` | `diygod/rsshub` | The app itself, exposed on host port `1200` |
| `browserless` | `browserless/chrome` | Headless Chrome over WebSocket, used by routes that need to scrape JS-rendered pages |
| `redis` | `redis:alpine` | Cache for generated feeds (ephemeral — see below) |

Redis runs **without a persistent volume**, so the cache is wiped on every `docker compose down`. This is intentional: the cache is just a cache, and a fresh start is often desirable.

## Usage

### Start

```bash
cd /home/t/git-repos/dotfiles/rsshub
docker compose up -d
```

`-d` runs detached. First run pulls the images (a few minutes).

### Verify

```bash
docker compose ps                    # service + health status
docker compose logs -f rsshub        # tail rsshub logs
curl http://localhost:1200/healthz   # health endpoint
```

Then open <http://localhost:1200> in a browser for the route directory.

### Stop / restart

```bash
docker compose stop          # stop containers (keep them)
docker compose start         # start them again
docker compose restart rsshub
docker compose down          # stop + remove containers + network (cache wiped)
docker compose pull          # fetch newer image versions
```

## Subscribing to feeds

RSSHub doesn't expose one master feed — each source has its own **route**. Find the route you want in the [docs](https://docs.rsshub.app/) or via the homepage at <http://localhost:1200>, then paste the full URL into your RSS reader.

Examples:

| Source | URL |
|---|---|
| GitHub user's repos | `http://localhost:1200/github/repos/torvalds` |
| YouTube channel | `http://localhost:1200/youtube/channel/UCxxxxxxxxxxxx` |
| Hacker News front page | `http://localhost:1200/hackernews` |
| Reddit subreddit | `http://localhost:1200/reddit/subreddit/programming` |
| Bilibili user videos | `http://localhost:1200/bilibili/user/video/2267573` |

### Reading from another device

`localhost:1200` only resolves on the host running Docker. From a phone or another machine, replace `localhost` with the host's LAN IP — e.g. `http://192.168.1.50:1200/...` — and make sure the host stays up.

## Notes

- **Port 1200 must be free.** To remap, change the left side of `'1200:1200'` in `docker-compose.yml` (e.g. `'1300:1200'`).
- **Some routes need API keys** (Twitter, etc.). The RSSHub docs flag these per-route; add the relevant env vars to the `rsshub` service.
- **Some sites rate-limit or block scrapers.** If a feed is empty or 500s, check `docker compose logs rsshub`.
- **No reverse proxy / auth in front of port 1200** — fine for localhost; add one before exposing this publicly.

## Slim alternative (no separate browser)

If you'd rather run Chrome inside the RSSHub container instead of the separate `browserless` service:

1. Change the image to `diygod/rsshub:chromium-bundled`.
2. Comment out every line marked `# marked` in `docker-compose.yml` (the `browserless` service, the `PUPPETEER_WS_ENDPOINT` env var, and the `browserless` entry in `depends_on`).

Bigger image, more memory in one process, but one less container to manage.
