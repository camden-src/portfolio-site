#!/bin/bash

GIT_ROOT="$(git rev-parse --show-toplevel)"
CONTAINER_NAME="portfolio-site-dev-sandbox"

# podman build -t portfolio-site-dev-sandbox "$GIT_ROOT"

podman run -it \
  --name "$CONTAINER_NAME" --replace \
  --userns=keep-id \
  -v "$GIT_ROOT:/workspace" \
  -v "$HOME/.claude-container:/home/developer/.claude" \
  -p 8080:8080 \
  -w /workspace \
  portfolio-site-dev-sandbox
