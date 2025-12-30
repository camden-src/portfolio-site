#!/bin/sh

for input_file in /workspace/transcode/staged/*; do
    [ -f "$input_file" ] || continue

    filename=$(basename "$input_file")
    name="${filename%.*}"
    # kebab-case: lowercase, replace spaces/special chars with hyphens
    name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')

    track_dir="/workspace/site-root/hls/production/${name}"
    mkdir -p "${track_dir}/64k" "${track_dir}/128k" "${track_dir}/192k"

    ffmpeg -y -i "$input_file" \
        -codec:a aac -b:a 64k -ac 2 -ar 44100 \
        -f hls -hls_time 10 -hls_list_size 0 \
        -hls_segment_filename "${track_dir}/64k/seg_%03d.ts" \
        "${track_dir}/64k/stream.m3u8"

    ffmpeg -y -i "$input_file" \
        -codec:a aac -b:a 128k -ac 2 -ar 44100 \
        -f hls -hls_time 10 -hls_list_size 0 \
        -hls_segment_filename "${track_dir}/128k/seg_%03d.ts" \
        "${track_dir}/128k/stream.m3u8"

    ffmpeg -y -i "$input_file" \
        -codec:a aac -b:a 192k -ac 2 -ar 44100 \
        -f hls -hls_time 10 -hls_list_size 0 \
        -hls_segment_filename "${track_dir}/192k/seg_%03d.ts" \
        "${track_dir}/192k/stream.m3u8"

    cat > "${track_dir}/master.m3u8" << EOF
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=64000,CODECS="mp4a.40.2"
64k/stream.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=128000,CODECS="mp4a.40.2"
128k/stream.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=192000,CODECS="mp4a.40.2"
192k/stream.m3u8
EOF

done
