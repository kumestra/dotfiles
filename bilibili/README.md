# Bilibili Video Summarization

## Download subtitles

```bash
yt-dlp --cookies cookie.txt --write-subs --write-auto-subs --skip-download --sub-langs "zh.*,en.*" <url>
```

### What each flag means

- **`yt-dlp`** — the tool itself.
- **`--cookies cookie.txt`** — pass a logged-in session via a Netscape/Mozilla format cookies file. Many Bilibili videos (member-only, 1080p+, region-locked) require login, or you'll get lower-quality streams or fail entirely.
- **`--write-subs`** — download subtitles that the uploader manually added (human-written, highest quality).
- **`--write-auto-subs`** — also download auto-generated subtitles (machine transcription done by the platform). Used as fallback when no human subs exist.
- **`--skip-download`** — don't download the actual video file. You only want the subtitle text, so skip the big MP4.
- **`--sub-langs "zh.*,en.*"`** — which languages to grab. `zh.*` matches any Chinese variant (`zh`, `zh-CN`, `zh-Hans`, etc.), `en.*` matches English variants. The `.*` is a wildcard pattern.
- **`<url>`** — replace with the actual Bilibili video URL, e.g. `https://www.bilibili.com/video/BV1xx411c7mD`.

### Output

After running, you'll get a file like `VideoTitle.zh-CN.vtt` in the current directory. The `.vtt` format looks like:

```
00:00:01.000 --> 00:00:04.000
大家好，欢迎来到这个视频

00:00:04.000 --> 00:00:07.000
今天我们来聊聊...
```

Strip the timestamps (keep only the text lines) before sending to the LLM.
