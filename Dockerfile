FROM ubuntu:22.04

RUN apt update && apt install -y curl zstd

RUN curl -fsSL https://ollama.com/install.sh | sh

EXPOSE 11434

CMD ["ollama", "serve"]
