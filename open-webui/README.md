
## Download Docker Image

```bash
docker pull ghcr.nju.edu.cn/open-webui/open-webui:main
```

```bash
docker run \
   --name open-webui \
   -p 3000:8080 \
   -e WEBUI_AUTH=False \
   -e OPENAI_API_BASE_URL="https://openrouter.ai/api/v1" \
   -e OPENAI_API_KEY="你的_OPENAI_API_KEY" \
   ghcr.nju.edu.cn/open-webui/open-webui:main
```
