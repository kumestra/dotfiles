## Download subtitle of the video

```bash
yt-dlp --cookies cookie.txt --write-subs --write-auto-subs --skip-download --sub-langs "zh.*,en.*" <url>
```

- **`yt-dlp`** — the tool itself.
- **`--cookies cookie.txt`** — pass a logged-in session via a Netscape/Mozilla format cookies file. Many Bilibili videos (member-only, 1080p+, region-locked) require login, or you'll get lower-quality streams or fail entirely.
- **`--write-subs`** — download subtitles that the uploader manually added (human-written, highest quality).
- **`--write-auto-subs`** — also download auto-generated subtitles (machine transcription done by the platform). Used as fallback when no human subs exist.
- **`--skip-download`** — don't download the actual video file. You only want the subtitle text, so skip the big MP4.
- **`--sub-langs "zh.*,en.*"`** — which languages to grab. `zh.*` matches any Chinese variant (`zh`, `zh-CN`, `zh-Hans`, etc.), `en.*` matches English variants. The `.*` is a wildcard pattern.
- **`<url>`** — replace with the actual Bilibili video URL, e.g. `https://www.bilibili.com/video/BV1xx411c7mD`.


## Download audio of the video

```bash
yt-dlp --cookies cookie.txt -x --audio-format mp3 <url>
```

- **Dropped** `--write-subs --write-auto-subs --skip-download --sub-langs` — no subtitles to fetch.
- **Added** `-x` (short for `--extract-audio`) — after downloading, strip out and keep only the audio stream.
- **Added** `--audio-format mp3` — convert to MP3. You could also use `m4a`, `wav`, `opus`, etc. MP3 is the safest choice for Whisper compatibility.

