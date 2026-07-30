
## Download Docker Image

```bash
docker run \
   --name open-webui \
   -d \
   -p 8002:8080 \
   -e OPENAI_API_BASE_URL="https://openrouter.ai/api/v1" \
   -e OPENAI_API_KEY="sk-replace-me" \
   ghcr.nju.edu.cn/open-webui/open-webui:main
```

`ghcr.nju.edu.cn` 是南京大学提供的 GitHub Container Registry（`ghcr.io`）缓存代理/加速镜像。

Name: `Tmp User`

Email: `tmp@tmp.com`

Password: `tmp123456`

1 setting `Follow-Up Auto-Generation`

Model: `deepseek/deepseek-v4-flash`
