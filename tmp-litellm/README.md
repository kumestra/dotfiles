## start

```bash
docker exec -u postgres my-postgres createdb -O test litellm
```

```bash
docker pull docker.litellm.ai/berriai/litellm:main-latest
```

```bash
docker run \
    -v $(pwd)/config.yaml:/app/config.yaml \
    -e OPEN_ROUTER_API_KEY=sk-*********** \
    -p 4000:4000 \
    docker.litellm.ai/berriai/litellm:main-latest \
    --config /app/config.yaml --detailed_debug
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
        "content": "You are an LLM named gpt-4o"
      },
      {
        "role": "user",
        "content": "intro harry potter"
      }
    ]
}'
```