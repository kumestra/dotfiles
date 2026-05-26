## start



```bash
docker pull docker.litellm.ai/berriai/litellm:main-latest
```

```bash
docker run \
    --name litellm \
    -v $(pwd)/config.yaml:/app/config.yaml \
    -e OPEN_ROUTER_API_KEY=sk-**** \
    -e LANGFUSE_PUBLIC_KEY="pk-lf-****" \
    -e LANGFUSE_SECRET_KEY="sk-lf-****" \
    -e LANGFUSE_HOST="https://cloud.langfuse.com" \
    -p 4000:4000 \
    docker.litellm.ai/berriai/litellm:main-latest \
    --config /app/config.yaml --detailed_debug
```


## stop

```bash
docker rm -f litellm
```


## test

```bash
curl -X POST 'http://192.168.1.156:4000/chat/completions' \
-H 'Content-Type: application/json' \
-H 'Authorization: Bearer sk-1234' \
-d '{
    "model": "google/gemini-3-flash-preview",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful AI assistant. Answer with emojis."
      },
      {
        "role": "user",
        "content": "Introduce Harry Potter."
      }
    ]
}'
```

base url 

```text
http://192.168.1.156:4000
```


