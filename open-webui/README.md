
## Download Docker Image

```bash
docker pull ghcr.nju.edu.cn/open-webui/open-webui:main
```

```bash
docker run \
   --name open-webui \
   -d \
   -p 8002:8080 \
   -e WEBUI_AUTH=False \
   -e OPENAI_API_BASE_URL="https://openrouter.ai/api/v1" \
   -e OPENAI_API_KEY="sk-1234" \
   ghcr.nju.edu.cn/open-webui/open-webui:main
```

2 setting `Always Expand Details` and `Follow-Up Auto-Generation`