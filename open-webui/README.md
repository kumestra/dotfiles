
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

查看日志，按 `Ctrl + C` 退出：

```bash
docker logs -f --tail 100 open-webui
```

`ghcr.nju.edu.cn` 是南京大学提供的 GitHub Container Registry（`ghcr.io`）缓存代理/加速镜像。

Name: 

```text
Tmp User
```

Email:

```text 
tmp@tmp.com
```

Password: 

```text
tmp123456
```

1 setting `Follow-Up Auto-Generation`

Model: `deepseek/deepseek-v4-flash`
