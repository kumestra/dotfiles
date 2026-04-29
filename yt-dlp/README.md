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

## Download

By default, yt-dlp tries to download the best available quality if you don't pass any options.

```bash
yt-dlp --ffmpeg-location ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl/bin "https://www.youtube.com/watch?v=XXXXXXXXXXX"
```

List available subtitles of each video:

```bash
yt-dlp --ffmpeg-location ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl/bin --list-subs "https://www.youtube.com/watch?v=XXXXXXXXXXX"
```

List available formats of each video:

```bash
yt-dlp --ffmpeg-location ~/yt-dlp-ffmpeg/ffmpeg-master-latest-linux64-gpl/bin --list-formats "https://www.youtube.com/watch?v=XXXXXXXXXXX"
```
