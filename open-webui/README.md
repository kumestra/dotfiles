
## Download Docker Image

```bash
docker pull ghcr.nju.edu.cn/open-webui/open-webui:main
```

```bash
docker run \
   --name open-webui \
   -p 3000:8080 \
   -e WEBUI_AUTH=False \
   -e OPENAI_API_BASE_URL="http://192.168.1.156:4000" \
   -e OPENAI_API_KEY="sk-1234" \
   ghcr.nju.edu.cn/open-webui/open-webui:main
```
