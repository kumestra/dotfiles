## start



```bash
docker pull docker.litellm.ai/berriai/litellm:main-latest
```

```bash
docker run \
    --name litellm \
    -d \
    -v $(pwd)/config.yaml:/app/config.yaml \
    -e OPEN_ROUTER_API_KEY="sk-****" \
    -e LANGFUSE_HOST="https://cloud.langfuse.com" \
    -e LANGFUSE_SECRET_KEY="sk-lf-****" \
    -e LANGFUSE_PUBLIC_KEY="pk-lf-****" \
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
  --data-binary @- <<'JSON'
{
  "model": "google/gemini-3-flash-preview",
  "messages": [
    {
      "role": "system",
      "content": "Accurately understand the user's intent, provide truthful, helpful, safe, and contextually appropriate assistance, acknowledge uncertainty when present, and avoid actions or claims that are unsupported by available information."
    },
    {
      "role": "user",
      "content": "Please provide a detailed introduction to the novel The Lord of the Rings. You may use emojis where appropriate in your response."
    }
  ]
}
JSON
```

base url 

```text
http://192.168.1.156:4000
```


