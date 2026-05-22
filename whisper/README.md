https://github.com/kumestra/kumestra.github.io/blob/main/src/data/blog/2026/05/2026-05-21-whisper-ggml-and-the-local-ai-stack.md



## whisper.cpp

https://github.com/ggml-org/whisper.cpp

## Install

### CMake

```bash
sudo apt install cmake -y
```

Verify

```bash
cmake --version
```

### Model

https://huggingface.co/ggerganov/whisper.cpp

#### ggml-large-v3-turbo-q5_0.bin

```bash
aria2c -x 16 -s 16 https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo-q5_0.bin
```

- `-x 16` (`--max-connection-per-server=16`): open up to 16 parallel connections to the same server.
- `-s 16` (`--split=16`): split the file into 16 segments and download them concurrently.

