# yt-dlp

https://github.com/yt-dlp/yt-dlp

## Install

```bash
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux -o /usr/local/bin/yt-dlp
```

```bash
sudo chmod a+rx /usr/local/bin/yt-dlp
```

```bash
yt-dlp --version
```

## ffmpeg

https://github.com/yt-dlp/FFmpeg-Builds

```bash
curl -L \
  https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz \
  -o ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl.tar.xz
```

```bash
tar -xf ffmpeg-master-latest-linux64-gpl.tar.xz
```

## Deno

https://github.com/denoland/deno

```bash
curl -fsSL https://deno.land/install.sh | sh
```

Verify:

```bash
deno --version
```

## Download (YouTube)

By default, yt-dlp tries to download the best available quality if you don't pass any options.

```bash
yt-dlp \
  --ffmpeg-location ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl/bin \
  --embed-chapters \
  --embed-metadata \
  "https://www.youtube.com/watch?v=XXXXXXXXXXX"
```

List available subtitles of each video:

```bash
yt-dlp \
  --ffmpeg-location ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl/bin \
  --list-subs \
  "https://www.youtube.com/watch?v=XXXXXXXXXXX"
```

List available formats of each video:

```bash
yt-dlp \
  --ffmpeg-location ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl/bin \
  --list-formats \
  "https://www.youtube.com/watch?v=XXXXXXXXXXX"
```

## Download (Bilibili)

### Download subtitle of the video

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


### Download audio of the video

```bash
yt-dlp --cookies cookie.txt -x --audio-format mp3 <url>
```

- **Dropped** `--write-subs --write-auto-subs --skip-download --sub-langs` — no subtitles to fetch.
- **Added** `-x` (short for `--extract-audio`) — after downloading, strip out and keep only the audio stream.
- **Added** `--audio-format mp3` — convert to MP3. You could also use `m4a`, `wav`, `opus`, etc. MP3 is the safest choice for Whisper compatibility.

