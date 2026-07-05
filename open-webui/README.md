
## Download Docker Image

```bash
docker run \
   --name open-webui \
   -d \
   -p 8002:8080 \
   -e OPENAI_API_BASE_URL="https://openrouter.ai/api/v1" \
   -e OPENAI_API_KEY="sk-1234" \
   ghcr.nju.edu.cn/open-webui/open-webui:main
```

Name: `Tmp User`

Email: `tmp@tmp.com`

Password: `tmp123456`

1 setting `Follow-Up Auto-Generation`

Model: `deepseek/deepseek-v4-flash`
