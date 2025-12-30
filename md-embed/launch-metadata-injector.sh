#!/bin/bash
# Inject timed ID3 metadata into HLS segments using Bento4

set -e

GIT_ROOT="$(git rev-parse --show-toplevel)"
SCRIPT_DIR="$GIT_ROOT/md-embed"

# Configuration
CONTAINER_IMAGE="localhost/bento4-hls:latest"
METADATA_DIR="${METADATA_DIR:-$SCRIPT_DIR/metadata}"
SEGMENTS_DIR="${SEGMENTS_DIR:-$SCRIPT_DIR/segments}"
OUTPUT_DIR="${OUTPUT_DIR:-$SCRIPT_DIR/output}"

# Validate directories exist
if [[ ! -d "$METADATA_DIR" ]]; then
    echo "Error: Metadata directory not found: $METADATA_DIR"
    echo "Set METADATA_DIR environment variable or create the directory"
    exit 1
fi

if [[ ! -d "$SEGMENTS_DIR" ]]; then
    echo "Error: Segments directory not found: $SEGMENTS_DIR"
    echo "Set SEGMENTS_DIR environment variable or create the directory"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Bento4 HLS Metadata Injection"
echo "=============================="
echo "Metadata: $METADATA_DIR"
echo "Segments: $SEGMENTS_DIR"
echo "Output:   $OUTPUT_DIR"
echo ""

# Check if container image exists
if ! podman image exists "$CONTAINER_IMAGE"; then
    echo "Error: Container image not found: $CONTAINER_IMAGE"
    echo "Build with: podman build -t $CONTAINER_IMAGE -f $SCRIPT_DIR/Dockerfile $SCRIPT_DIR"
    exit 1
fi

# Run Bento4 container with volume mounts
podman run --rm -it \
    -v "$METADATA_DIR:/work/metadata:ro" \
    -v "$SEGMENTS_DIR:/work/segments:ro" \
    -v "$OUTPUT_DIR:/work/output:rw" \
    --userns=keep-id \
    "$CONTAINER_IMAGE" \
    bash -c '
        echo "Bento4 tools available:"
        echo "  mp42hls  - Convert MP4 to HLS with metadata"
        echo "  mp4info  - Display MP4 file information"
        echo "  mp4dump  - Dump MP4 structure"
        echo ""
        echo "Directories mounted:"
        echo "  /work/metadata - Metadata JSON files (read-only)"
        echo "  /work/segments - Source HLS segments (read-only)"
        echo "  /work/output   - Output directory (read-write)"
        echo ""
        echo "Example workflow:"
        echo "  1. Review metadata: cat /work/metadata/mix-metadata.json"
        echo "  2. Process: mp42hls --timed-metadata /work/metadata/mix-metadata.json ..."
        echo ""
        echo "Entering interactive shell..."
        exec bash
    '

echo ""
echo "Container session ended."
