




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
  metacubex/subconverter:latest
```

Reference: [从 tindy2013/subconverter 切换到 MetaCubeX/subconverter](https://github.com/kumestra/probable-guide/blob/secret-dairy/blog/2026/06/2026-06-27-subconverter-migration.md)

## convert

```bash
curl --silent --show-error --output "tmp.yml" --get \
    "http://127.0.0.1:25500/sub" \
    --data-urlencode "target=clash" \
    --data-urlencode "url=http://192.168.1.157:8001/tmp.txt" \
    --data-urlencode "insert=false" \
    --data-urlencode "config=https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/config/ACL4SSR_Online_Full_AdblockPlus.ini"
```

## clean

```bash
docker rm -f subconverter
```

## 美国优惠节点

在 `tmp.ini` 的区域节点分组附近新增：

```ini
custom_proxy_group=🇺🇲 美国优惠节点`url-test`(美国.*(0\.1x|0\.01x))`http://www.gstatic.com/generate_204`300,,50
```

其中用于筛选节点名的正则表达式是 `美国.*(0\.1x|0\.01x)`：

- `美国`：名称中必须出现“美国”。
- `.*`：允许其后跟随任意数量的任意字符，例如“圣何塞01-”。
- `(0\.1x|0\.01x)`：匹配 `0.1x` 或 `0.01x` 两种流量倍率；`\.` 表示字面量的小数点。

因此它会匹配 `美国01-0.1x`、`美国圣何塞01-0.1x` 和 `美国01｜合适下载使用-0.01x` 等节点名。

在“🚀 节点选择”分组中、`[]🇺🇲 美国节点` 后新增：

```ini
`[]🇺🇲 美国优惠节点
```
