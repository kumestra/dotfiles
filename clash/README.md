




## create http server

```bash
python3 -m http.server 8001
```

## start subconverter

```bash
docker run \
  --name subconverter \
  -d \
  --restart=always \
  -p 25500:25500 \
  tindy2013/subconverter:latest
```

## convert

```bash
curl --silent --show-error --output "tmp-clash-config.yml" --get \
    "http://127.0.0.1:25500/sub" \
    --data-urlencode "target=clash" \
    --data-urlencode "url=http://192.168.1.156:8001/tmp-clash-base64.txt" \
    --data-urlencode "insert=false" \
    --data-urlencode "config=https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/config/ACL4SSR_Online_Full_AdblockPlus.ini"
```

## clean

```bash
docker rm -f subconverter
```
