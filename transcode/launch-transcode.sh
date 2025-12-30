#!/bin/bash

GIT_ROOT="$(git rev-parse --show-toplevel)"

podman build -t hls-transcoder -f "$GIT_ROOT/transcode/Dockerfile" "$GIT_ROOT/transcode"

podman run --rm \
  --name hls-transcoder \
  --userns=keep-id \
  -v "$GIT_ROOT:/workspace" \
  -w /workspace \
  hls-transcoder
