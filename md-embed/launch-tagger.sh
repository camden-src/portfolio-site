#!/bin/bash

set -e

CONTAINER_NAME="artwork-tagger"
GIT_ROOT="$(git rev-parse --show-toplevel)"

FORCE_REBUILD=false
if [[ "$1" == "--force-rebuild" ]]; then
  FORCE_REBUILD=true
  shift
fi

# Check if container is already running
if podman ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  if [[ "$FORCE_REBUILD" == true ]]; then
    podman stop "$CONTAINER_NAME"
  else
    podman exec -it "$CONTAINER_NAME" /workspace/md-embed/tag-artwork.sh
    exit 0
  fi
fi

# Check if container exists but is stopped
if podman ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  if [[ "$FORCE_REBUILD" == true ]]; then
    podman rm "$CONTAINER_NAME"
  else
    podman start "$CONTAINER_NAME"
    podman exec -it "$CONTAINER_NAME" /workspace/md-embed/tag-artwork.sh
    exit 0
  fi
fi

# Build container image
podman build -t "$CONTAINER_NAME" -f "$GIT_ROOT/md-embed/Dockerfile.tagger" "$GIT_ROOT/md-embed"

# Run tagger
podman run --rm \
  --name "$CONTAINER_NAME" \
  --userns=keep-id \
  -v "$GIT_ROOT:/workspace" \
  -w /workspace \
  "$CONTAINER_NAME"
