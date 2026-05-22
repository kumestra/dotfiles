https://github.com/kumestra/kumestra.github.io/blob/main/src/data/blog/2026/05/2026-05-21-whisper-ggml-and-the-local-ai-stack.md



## whisper.cpp

https://github.com/ggml-org/whisper.cpp

## Install

### CMake

check whether cmake install or not:

```bash
cmake --version
```

if not install, install cmake:


```bash
sudo apt install cmake -y
```

### Download repo

```bash
git clone https://github.com/ggml-org/whisper.cpp.git
```

```bash
cd whisper.cpp
```

### Compile the source

```bash
cmake -B build
```

```bash
cmake --build build -j --config Release
```

## Model

https://huggingface.co/ggerganov/whisper.cpp

### ggml-large-v3-turbo-q5_0.bin

```bash
aria2c -x 16 -s 16 https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo-q5_0.bin
```

- `-x 16` (`--max-connection-per-server=16`): open up to 16 parallel connections to the same server.
- `-s 16` (`--split=16`): split the file into 16 segments and download them concurrently.


## Use

### convert mp3 to wav

whisper.cpp requires 16 kHz mono PCM WAV input, so convert the source audio with ffmpeg first:

```bash
ffmpeg -i /tmp/test-bilibili.mp3 -ar 16000 -ac 1 -c:a pcm_s16le /tmp/test-bilibili.wav
```

- `-i <file>`: input file (any format ffmpeg can decode — mp3, m4a, mp4, etc.).
- `-ar 16000` (audio rate): resample to 16 kHz, the sample rate whisper models are trained on.
- `-ac 1` (audio channels): downmix to mono (1 channel).
- `-c:a pcm_s16le` (audio codec): encode as 16-bit little-endian signed PCM — the uncompressed WAV format whisper.cpp expects.
- last positional arg: output `.wav` path.

#### What these flags actually mean

Audio in a computer is just a long list of numbers measuring air pressure (or speaker cone position) over time. Three knobs define that list:

**1. Sample rate (`-ar 16000`)**

How many times per second you measure the sound. 16000 Hz = 16,000 numbers per second of audio.

- Higher rate = captures higher-pitched sounds, bigger file.
- CD audio is 44100 Hz, phone calls are 8000 Hz, whisper uses 16000 Hz.
- Why 16k for whisper? Human speech tops out around 8 kHz, and the [Nyquist theorem](https://en.wikipedia.org/wiki/Nyquist%E2%80%93Shannon_sampling_theorem) says you need to sample at 2× the highest frequency you want to capture → 16 kHz is enough for speech but throws away music-quality detail. Smaller input = faster inference.

**2. Channels (`-ac 1`)**

How many parallel streams of those numbers. Stereo = 2 (left + right speaker), mono = 1.

- Whisper only cares about *what was said*, not where in the room — one channel is plenty. Two channels would just double the data with no benefit.

**3. Sample format (`-c:a pcm_s16le`)**

How each individual number is stored. `pcm_s16le` breaks down as:

- **PCM** (Pulse-Code Modulation): the "raw" uncompressed form — literally just the list of numbers, no tricks. Opposite of mp3/aac which are *compressed* (they throw away inaudible detail to shrink the file). Whisper wants raw because decoding compressed audio is the loader's job, not the model's.
- **s16**: signed 16-bit integer. Each sample is a number from −32768 to +32767 (2^16 values, centered on 0 because sound waves go above and below silence).
- **le**: little-endian — the byte order the number is stored in. CPU-level detail; just the convention WAV uses on x86.

**Container vs codec**

`.mp3`, `.wav`, `.mp4` are *containers* (the box). The codec (mp3, aac, pcm, h264) is *what's inside the box*. A `.wav` file is a container holding PCM samples + a small header saying "16 kHz, mono, 16-bit". That's why whisper.cpp can mmap it and start inferring immediately — no decompression step.

So the whole ffmpeg line is saying: "decode whatever's in the mp3, resample to 16 kHz, mix down to one channel, store as raw 16-bit numbers in a WAV wrapper." It's converting from a *compressed delivery format* to a *raw working format*.

### Transcribe

```bash
./build/bin/whisper-cli -m ./models/ggml-large-v3-turbo-q5_0.bin -f samples/jfk.wav -otxt -osrt -of /tmp/jfk
```

- `-m <file>` (`--model`): path to the ggml model file used for inference.
- `-f <file>` (`--file`): path to the input audio file (must be 16 kHz mono WAV).
- `-otxt` (`--output-txt`): write transcription to a plain `.txt` file.
- `-osrt` (`--output-srt`): write transcription as `.srt` subtitles with timestamps.
- `-of <prefix>` (`--output-file`): output file path prefix; whisper appends the extension (e.g. `/tmp/jfk.txt`, `/tmp/jfk.srt`).
