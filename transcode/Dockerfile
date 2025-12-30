# HLS Transcoder Container
# Uses Alpine for smallest footprint with ffmpeg from package manager
FROM alpine:3.19

# Install ffmpeg with all standard codecs (includes AAC encoder for HLS)
RUN apk add --no-cache ffmpeg

# Create developer user with UID:GID 1000:1000 for --userns=keep-id compatibility
RUN addgroup -g 1000 developer && adduser -u 1000 -G developer -D developer

USER developer
WORKDIR /workspace

ENTRYPOINT ["/bin/sh", "/workspace/transcode/generate-hls.sh"]
